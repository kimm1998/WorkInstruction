codeunit 50516 "ONT Shopfloor Transfer Mgt"
{
    SingleInstance = false;

    /// <summary>
    /// Creates ONE Transfer Order per Production Order for component shortages to the shopfloor bin.
    /// Groups by Item/Variant. Marks components to avoid duplicates.
    /// </summary>
    procedure RunForProductionOrder(ProdOrderStatus: Enum "Production Order Status"; ProdOrderNo: Code[20])
    var
        ProdOrder: Record "Production Order";
        MfgSetup: Record "Manufacturing Setup";
        ShortQtyByKey: Dictionary of [Text, Decimal];
        ShortDateByKey: Dictionary of [Text, Date];
        ItemKeys: List of [Text];
        TransferHeader: Record "Transfer Header";
        Comp: Record "Prod. Order Component";
    begin
        if not LoadManufacturingSetup(MfgSetup) then
            Error('Manufacturing Setup is not configured. Please fill From/Shopfloor locations and Shopfloor bin.');

        if not ProdOrder.Get(ProdOrderStatus, ProdOrderNo) then
            Error('Production Order %1 (%2) not found.', ProdOrderNo, Format(ProdOrderStatus));

        Clear(ShortQtyByKey);
        Clear(ShortDateByKey);
        Clear(ItemKeys);

        BuildShortageForOrder(ProdOrder, MfgSetup, ShortQtyByKey, ShortDateByKey, ItemKeys);
        if ItemKeys.Count() = 0 then
            exit; // nothing to move

        TransferHeader := CreateTransferHeader(ProdOrder, MfgSetup);
        CreateTransferLines(TransferHeader, MfgSetup, ShortQtyByKey, ShortDateByKey, ItemKeys);
        ShowTransferCreatedMessage(ProdOrderNo, TransferHeader."No.");
        // Mark only the components that contributed to shortages
        MarkComponentsTransferred(ProdOrder, ShortQtyByKey, TransferHeader."No.");

        // You can auto-release or leave as is; by default we leave it Open so WH can pick/ship.
    end;

    local procedure ShowTransferCreatedMessage(ProdOrderNo: Code[20]; TransferNo: Code[20])
    var
        Text001: Label 'A transfer order %1 has been created for production order %2.';
    begin
        Message(Text001, TransferNo, ProdOrderNo);
    end;

    //========================
    // Setup & Validation
    //========================

    local procedure LoadManufacturingSetup(var MfgSetup: Record "Manufacturing Setup"): Boolean
    begin
        if not MfgSetup.Get() then
            exit(false);

        if (MfgSetup."ONT From Location Code" = '') or
           (MfgSetup."ONT Shopfloor Location Code" = '') then
            exit(false);

        exit(true);
    end;

    //========================
    // Shortage calculation
    //========================

    local procedure BuildShortageForOrder(var ProdOrder: Record "Production Order";
                                          var MfgSetup: Record "Manufacturing Setup";
                                          var ShortQtyByKey: Dictionary of [Text, Decimal];
                                          var ShortDateByKey: Dictionary of [Text, date];
                                          var ItemKeys: List of [Text])
    var
        Comp: Record "Prod. Order Component";
        NeededByKey: Dictionary of [Text, Decimal];
        DateByKey: Dictionary of [Text, date];
        NeededKeys: List of [Text];
        NeededKey: Text;
        NeededQtyBase: Decimal;
        AvailableBase: Decimal;
        MissingBase: Decimal;
        DueDate: Date;
        i: Integer;
    begin
        Clear(NeededByKey);
        Clear(DateByKey);
        Clear(NeededKeys);

        // 1) Aggregate remaining requirement (base) by Item/Variant for this order, excluding already marked components
        AggregateRemainingByItem(ProdOrder, NeededByKey, DateByKey, NeededKeys);

        // 2) For each key, subtract what is already in the shopfloor bin to find the shortage
        for i := 1 to NeededKeys.Count() do begin
            NeededKey := NeededKeys.Get(i);
            if NeededByKey.Get(NeededKey, NeededQtyBase) then begin
                AvailableBase := GetAvailableInShopfloorBin(MfgSetup, NeededKey);
                MissingBase := NeededQtyBase - AvailableBase;
                if MissingBase > 0 then begin
                    ShortQtyByKey.Add(NeededKey, MissingBase);
                    if DateByKey.Get(NeededKey, DueDate) then
                        ShortDateByKey.Add(NeededKey, DueDate);
                    ItemKeys.Add(NeededKey);
                end;
            end;
        end;
    end;

    local procedure AggregateRemainingByItem(var ProdOrder: Record "Production Order";
                                             var NeededByKey: Dictionary of [Text, Decimal];
                                             var DateByKey: Dictionary of [Text, date];
                                             var NeededKeys: List of [Text])
    var
        Comp: Record "Prod. Order Component";
        ItemKey: Text;
        RemainingBase: Decimal;
        Running: Decimal;
        DueDate: date;
        CurrDueDate: date;
    begin
        Clear(NeededByKey);
        Clear(NeededKeys);

        Comp.Reset();
        Comp.SetRange(Status, ProdOrder.Status);
        Comp.SetRange("Prod. Order No.", ProdOrder."No.");
        Comp.SetRange("ONT Transfer Created", false);
        Comp.SetFilter("Flushing Method", '%1|%2|%3|%4', Comp."Flushing Method"::Manual, Comp."Flushing Method"::"Pick + Backward", Comp."Flushing Method"::"Pick + Forward", Comp."Flushing Method"::"Pick + Manual");
        if not Comp.FindSet() then
            exit;

        repeat
            // Use Remaining Qty. (Base) as what we still need for this order line
            RemainingBase := Comp."Remaining Qty. (Base)";
            if RemainingBase > 0 then begin
                ItemKey := BuildItemKey(Comp."Item No.", Comp."Variant Code");
                if NeededByKey.ContainsKey(ItemKey) then begin
                    NeededByKey.Get(ItemKey, Running);
                    Running := Running + RemainingBase;
                    NeededByKey.Set(ItemKey, Running);
                end else begin
                    NeededByKey.Add(ItemKey, RemainingBase);
                    NeededKeys.Add(ItemKey);
                end;

                CurrDueDate := comp."Due Date";
                if DateByKey.ContainsKey(ItemKey) then begin
                    DateByKey.Get(ItemKey, DueDate);
                    if DueDate > CurrDueDate then begin
                        DueDate := CurrDueDate;
                        DateByKey.Set(ItemKey, DueDate);
                    end;
                end else begin
                    DateByKey.Add(ItemKey, CurrDueDate);
                end;
            end;
        until Comp.Next() = 0;
    end;

    local procedure GetAvailableInShopfloorBin(var MfgSetup: Record "Manufacturing Setup"; ItemKey: Text): Decimal
    var
        BinContent: Record "Bin Content";
        ItemNo: Code[20];
        VariantCode: Code[10];
        QtyBase: Decimal;
    begin
        ParseItemKey(ItemKey, ItemNo, VariantCode);
        QtyBase := 0;

        BinContent.Reset();
        BinContent.SetRange("Location Code", MfgSetup."ONT Shopfloor Location Code");
        BinContent.SetRange("Bin Code", MfgSetup."ONT Shopfloor Bin Code");
        BinContent.SetRange("Item No.", ItemNo);
        if VariantCode <> '' then
            BinContent.SetRange("Variant Code", VariantCode);

        if BinContent.FindSet() then
            repeat
                // Bin Content.Quantity is in base UOM
                QtyBase := QtyBase + BinContent.Quantity;
            until BinContent.Next() = 0;

        exit(QtyBase);
    end;

    //========================
    // Transfer creation
    //========================

    local procedure CreateTransferHeader(var ProdOrder: Record "Production Order";
                                         var MfgSetup: Record "Manufacturing Setup"): Record "Transfer Header"
    var
        TH: Record "Transfer Header";
    begin
        TH.Init();
        TH.Validate("Transfer-from Code", MfgSetup."ONT From Location Code");
        TH.Insert(true);
        TH.Validate("Transfer-to Code", MfgSetup."ONT Shopfloor Location Code");
        TH."External Document No." := ProdOrder."No.";
        if MfgSetup."ONT In-Transit Location Code" <> '' then
            TH.Validate("In-Transit Code", MfgSetup."ONT In-Transit Location Code");

        TH.Validate("Shipment Date", WorkDate());
        TH.Validate("Receipt Date", WorkDate());
        TH.Validate("Posting Date", WorkDate());


        // Nice description for users
        //TH.Validate(Description, StrSubstNo('To Shopfloor for Prod. Order %1 (%2)', ProdOrder."No.", Format(ProdOrder.Status)));
        TH.Modify(true);

        exit(TH);
    end;

    local procedure CreateTransferLines(var TH: Record "Transfer Header";
                                        var MfgSetup: Record "Manufacturing Setup";
                                        var ShortQtyByKey: Dictionary of [Text, Decimal];
                                        var ShortDateByKey: Dictionary of [Text, date];
                                        var ItemKeys: List of [Text])
    var
        TL: Record "Transfer Line";
        ItemRec: Record Item;
        ItemKey: Text;
        ItemNo: Code[20];
        VariantCode: Code[10];
        QtyBase: Decimal;
        DueDate: Date;
        Location: Record Location;
        OutboundHandlingTime: DateFormula;
        i: Integer;
    begin
        for i := 1 to ItemKeys.Count() do begin
            ItemKey := ItemKeys.Get(i);
            if ShortQtyByKey.Get(ItemKey, QtyBase) then begin
                ParseItemKey(ItemKey, ItemNo, VariantCode);
                if not ItemRec.Get(ItemNo) then
                    Error('Item %1 not found.', ItemNo);

                TL.Init();
                TL.Validate("Document No.", TH."No.");
                TL.Validate("Line No.", GetNextLineNo(TL, TH."No."));
                // TL.Validate("Qty. Rounding Precision",0.0001); // to avoid rounding issues
                TL.Validate("Item No.", ItemNo);
                if VariantCode <> '' then
                    TL.Validate("Variant Code", VariantCode);

                // Ensure base unit UOM and set Quantity in base
                if ItemRec."Base Unit of Measure" <> '' then
                    TL.Validate("Unit of Measure Code", ItemRec."Base Unit of Measure");
                TL.Validate(Quantity, QtyBase);

                // Locations (inherit from header) + bin
                TL.Validate("Transfer-from Code", TH."Transfer-from Code");
                TL.Validate("Transfer-to Code", TH."Transfer-to Code");
                if TH."In-Transit Code" <> '' then
                    TL.Validate("In-Transit Code", TH."In-Transit Code");

                // Destination bin (shopfloor)
                //TL.Validate("Transfer-to Bin Code", MfgSetup."ONT Shopfloor Bin Code");
                TL.Insert(true);
                if ShortDateByKey.Get(ItemKey, DueDate) then begin
                    Location.Reset();
                    if Location.get(TL."Transfer-to Code") then;
                    OutboundHandlingTime := Location."Outbound Whse. Handling Time";
                    if Format(OutboundHandlingTime) <> '' then
                        TL.validate("Shipment Date", CalcDate('-' + Format(OutboundHandlingTime), DueDate))
                    else
                        TL.validate("Shipment Date", DueDate);
                    tl."Receipt Date" := DueDate;

                    TL.Modify();
                end
            end;
        end;
    end;

    local procedure GetNextLineNo(var TL: Record "Transfer Line"; DocNo: Code[20]): Integer
    var
        MaxLine: Integer;
    begin
        MaxLine := 0;
        TL.Reset();
        TL.SetRange("Document No.", DocNo);
        if TL.FindLast() then
            MaxLine := TL."Line No.";
        exit(MaxLine + 10000);
    end;

    //========================
    // Mark components
    //========================

    local procedure MarkComponentsTransferred(var ProdOrder: Record "Production Order";
                                              var ShortQtyByKey: Dictionary of [Text, Decimal];
                                              TransferNo: Code[20])
    var
        Comp: Record "Prod. Order Component";
        ItemKey: Text;
        UnusedDecimal: Decimal;
    begin
        Comp.Reset();
        Comp.SetRange(Status, ProdOrder.Status);
        Comp.SetRange("Prod. Order No.", ProdOrder."No.");
        Comp.SetRange("ONT Transfer Created", false);
        Comp.SetFilter("Flushing Method", '%1|%2|%3|%4', Comp."Flushing Method"::Manual, Comp."Flushing Method"::"Pick + Backward", Comp."Flushing Method"::"Pick + Forward", Comp."Flushing Method"::"Pick + Manual");
        if not Comp.FindSet(true) then
            exit;

        repeat
            ItemKey := BuildItemKey(Comp."Item No.", Comp."Variant Code");
            if ShortQtyByKey.Get(ItemKey, UnusedDecimal) then begin
                Comp.Validate("ONT Transfer Created", true);
                Comp.Validate("ONT Transfer No.", TransferNo);
                // Optionally store a synthetic line no. if you want; otherwise leave blank
                Comp.Modify(true);
            end;
        until Comp.Next() = 0;
    end;

    //========================
    // Key helpers
    //========================

    local procedure BuildItemKey(ItemNo: Code[20]; VariantCode: Code[10]): Text
    begin
        exit(Format(ItemNo) + '|' + Format(VariantCode));
    end;

    local procedure ParseItemKey(KeyText: Text; var ItemNo: Code[20]; var VariantCode: Code[10])
    var
        SepPos: Integer;
        LeftLen: Integer;
        RightLen: Integer;
        TotalLen: Integer;
    begin
        SepPos := StrPos(KeyText, '|');
        if SepPos <= 0 then begin
            ItemNo := CopyStr(KeyText, 1, MaxStrLen(ItemNo));
            VariantCode := '';
            exit;
        end;

        // Left part
        LeftLen := SepPos - 1;
        if LeftLen < 0 then
            LeftLen := 0;
        if LeftLen > MaxStrLen(ItemNo) then
            LeftLen := MaxStrLen(ItemNo);
        ItemNo := CopyStr(KeyText, 1, LeftLen);

        // Right part
        TotalLen := StrLen(KeyText);
        RightLen := TotalLen - SepPos;
        if RightLen < 0 then
            RightLen := 0;
        if RightLen > MaxStrLen(VariantCode) then
            RightLen := MaxStrLen(VariantCode);
        VariantCode := CopyStr(KeyText, SepPos + 1, RightLen);
    end;

    [EventSubscriber(ObjectType::Table, database::"Transfer Header", OnAfterDeleteEvent, '', false, false)]
    local procedure OnAfterDeleteTransferEvent(var Rec: Record "Transfer Header")
    var
        Comp: Record "Prod. Order Component";
    begin
        Comp.reset;
        Comp.SetRange("ONT Transfer No.", Rec."No.");
        Comp.SetRange("ONT Transfer Created", true);
        Comp.SetFilter("Flushing Method",'%1|%2|%3|%4',Comp."Flushing Method"::Manual,Comp."Flushing Method"::"Pick + Backward",Comp."Flushing Method"::"Pick + Forward",Comp."Flushing Method"::"Pick + Manual");
        if Comp.FindSet() then
            repeat
                Comp.Validate("ONT Transfer No.", '');
                Comp.Validate("ONT Transfer Created", false);
                Comp.Modify();
            until Comp.next = 0;
    end;
}
