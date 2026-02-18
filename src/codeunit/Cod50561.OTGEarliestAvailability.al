codeunit 50561 "OTG Earliest Availability"
{


    procedure RunForAllDemand()
    var
        Demand: Record "OTG Demand Buffer";
    begin
        ClearPreviousResults();

        Demand.Reset();
        Demand.SetCurrentKey(Priority, "Demand Date");
        Demand.Ascending(true);
        if Demand.FindSet() then
            repeat
                CalculateDemandLine(Demand);
            until Demand.Next() = 0;
    end;

    local procedure CalculateDemandLine(var Demand: Record "OTG Demand Buffer")
    var
        NeedQty: Decimal;
        EarliestDate: Date;
        int: Integer;
    begin
        if Demand."Item No." = '2453-0500' then
            int := 1;
        BuildSupplyBuffer(Demand);
        Demand.CalcFields("Allocated Qty (Base)", "Reserved Qty. (Base)");
        if Demand."Reserved Qty. (Base)" <> 0 then
            GetResData(Demand);
        NeedQty := Demand."Quantity (Base)" - Demand."Allocated Qty (Base)" - Demand."Reserved Qty. (Base)";
        EarliestDate := 0D;

        if NeedQty <= 0 then begin
            Demand."Fully Allocated" := true;
            exit;
        end;

        SupplyBuf.Reset();
        SupplyBuf.SetCurrentKey("Avail. Date");
        SupplyBuf.SetRange("Item No.", Demand."Item No.");
        SupplyBuf.SetRange("Variant Code", Demand."Variant Code");
        SupplyBuf.SetFilter("Avail. Date", '<=%1', Demand."Demand Date");
        // SupplyBuf.SetRange("Location Code", Demand."Location Code");
        SupplyBuf.Ascending(true);//recheck

        if SupplyBuf.FindSet() then begin
            repeat
                if SupplyBuf."Item No." = '2453-0500' then
                    int := 1;
                if NeedQty <= 0 then
                    break;
                if SupplyBuf."Available Qty (Base)" > 0 then
                    AllocateFromSupply(Demand, NeedQty, EarliestDate)
                else begin
                    SupplyBuf.Reset();
                    SupplyBuf.SetCurrentKey("Avail. Date");
                    SupplyBuf.SetRange("Item No.", Demand."Item No.");
                    SupplyBuf.SetRange("Variant Code", Demand."Variant Code");
                    SupplyBuf.SetFilter("Avail. Date", '>%1', Demand."Demand Date");
                    SupplyBuf.SetFilter("Available Qty (Base)",'>0'); 
                    SupplyBuf.Ascending(true);
                    if SupplyBuf.FindFirst() then
                        EarliestDate := SupplyBuf."Avail. Date";
                end;
            until SupplyBuf.Next() = 0;
        end
        else begin
            SupplyBuf.Reset();
            SupplyBuf.SetCurrentKey("Avail. Date");
            SupplyBuf.SetRange("Item No.", Demand."Item No.");
            SupplyBuf.SetRange("Variant Code", Demand."Variant Code");
            SupplyBuf.Ascending(true);
            if SupplyBuf.FindFirst() then
                EarliestDate := SupplyBuf."Avail. Date";
        end;
        Demand.CalcFields("Allocated Qty (Base)", "Reserved Qty. (Base)");
        NeedQty := Demand."Quantity (Base)" - Demand."Allocated Qty (Base)" - Demand."Reserved Qty. (Base)";
        if Demand."Earliest Avail. Date" < EarliestDate then
            Demand."Earliest Avail. Date" := EarliestDate;
        Demand."Fully Allocated" := NeedQty <= 0;
        Demand.Modify(true);
    end;

    local procedure GetResData(var Demand: Record "OTG Demand Buffer")
    var
        ReservationEntry: Record "Reservation Entry";
        DocReservationEntry: Record "Reservation Entry";
        NeedQty: Decimal;
    begin
        ReservationEntry.SetRange("Source ID", Demand."Source No.");
        ReservationEntry.SetRange("Source Ref. No.", Demand."Source Line No.");
        ReservationEntry.SetRange("Source Type", Demand."Source Type Table ID");
        ReservationEntry.SetRange("Source Subtype", Demand."Source Subtype");
        ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        if ReservationEntry.FindSet() then
            repeat
                if DocReservationEntry.Get(ReservationEntry."Entry No.", not ReservationEntry.Positive) then begin
                    Demand.CalcFields("Allocated Qty (Base)", "Reserved Qty. (Base)");
                    NeedQty := Demand."Quantity (Base)" - Demand."Allocated Qty (Base)" - Demand."Reserved Qty. (Base)";
                    Demand."Earliest Avail. Date" := DocReservationEntry."Expected Receipt Date";
                    Demand."Fully Allocated" := NeedQty <= 0;
                    Demand.Modify(true);
                end;
            until ReservationEntry.Next() = 0;
    end;

    local procedure BuildSupplyBuffer(Demand: Record "OTG Demand Buffer")
    var
        ItemLGEntry: Record "Item Ledger Entry";
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
        AvailQty: Decimal;
        AvailPO: Decimal;
    begin
        LineNo := 0;
        Clear(SupplyBuf);
        if SupplyBuf.FindLast() then
            LineNo := SupplyBuf."Line No.";

        // -------- On-hand (Item Ledger Entry) --------
        ItemLGEntry.Reset();
        ItemLGEntry.SetRange("Item No.", Demand."Item No.");
        ItemLGEntry.SetRange("Variant Code", Demand."Variant Code");
        // ItemLGEntry.SetRange("Location Code", Demand."Location Code");
        ItemLGEntry.SetFilter("Remaining Quantity", '>%1', 0);

        if Demand."Lot No." <> '' then
            ItemLGEntry.SetRange("Lot No.", Demand."Lot No.");
        if Demand."Serial No." <> '' then
            ItemLGEntry.SetRange("Serial No.", Demand."Serial No.");

        ItemLGEntry.SetFilter("Entry Type", '%1|%2|%3|%4',
            ItemLGEntry."Entry Type"::Purchase,
            ItemLGEntry."Entry Type"::Output,
            ItemLGEntry."Entry Type"::"Positive Adjmt.",
            ItemLGEntry."Entry Type"::Transfer);

        if ItemLGEntry.FindSet() then
            repeat
                AvailQty := CalcAvailableOnILE(ItemLGEntry);
                if AvailQty > 0 then begin
                    LineNo += 10000;
                    Clear(SupplyBuf);
                    SupplyBuf.SetRange("Source Type", SupplyBuf."Source Type"::OnHandILE);
                    SupplyBuf.SetRange("Item Ledger Entry No.", ItemLGEntry."Entry No.");
                    if SupplyBuf.IsEmpty then begin
                        SupplyBuf.Init();
                        SupplyBuf."Line No." := LineNo;
                        SupplyBuf."Item No." := ItemLGEntry."Item No.";
                        SupplyBuf."Variant Code" := ItemLGEntry."Variant Code";
                        SupplyBuf."Location Code" := ItemLGEntry."Location Code";
                        SupplyBuf."Lot No." := ItemLGEntry."Lot No.";
                        SupplyBuf."Serial No." := ItemLGEntry."Serial No.";
                        SupplyBuf."Item Ledger Entry No." := ItemLGEntry."Entry No.";
                        SupplyBuf."Available Qty (Base)" := AvailQty;
                        SupplyBuf."Avail. Date" := WorkDate; // available now
                        SupplyBuf."Source Type" := SupplyBuf."Source Type"::OnHandILE;
                        SupplyBuf."Source Table ID" := DATABASE::"Item Ledger Entry";
                        SupplyBuf."Document Type Int" := 0;
                        SupplyBuf."Document No." := Format(ItemLGEntry."Document No.");
                        SupplyBuf."Document Line No." := 0;
                        SupplyBuf.Insert();
                    end;
                end;
            until ItemLGEntry.Next() = 0;

        // -------- Purchase Orders (inbound) --------
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        PurchLine.SetRange("No.", Demand."Item No.");
        if Demand."Variant Code" <> '' then
            PurchLine.SetRange("Variant Code", Demand."Variant Code");
        // if Demand."Location Code" <> '' then
        //     PurchLine.SetRange("Location Code", Demand."Location Code");
        PurchLine.SetFilter("Outstanding Qty. (Base)", '>0');

        if PurchLine.FindSet() then
            repeat
                AvailPO := CalcAvailableOnPurchLine(PurchLine);
                if AvailPO > 0 then begin
                    LineNo += 10000;
                    Clear(SupplyBuf);
                    SupplyBuf.SetRange("Source Type", SupplyBuf."Source Type"::PurchaseLine);
                    SupplyBuf.SetRange("Document No.", PurchLine."Document No.");
                    SupplyBuf.SetRange("Document Line No.", PurchLine."Line No.");
                    if SupplyBuf.IsEmpty then begin
                        SupplyBuf.Init();
                        SupplyBuf."Line No." := LineNo;
                        SupplyBuf."Item No." := PurchLine."No.";
                        SupplyBuf."Variant Code" := PurchLine."Variant Code";
                        SupplyBuf."Location Code" := PurchLine."Location Code";
                        SupplyBuf."Item Ledger Entry No." := 0;
                        SupplyBuf."Available Qty (Base)" := AvailPO;
                        SupplyBuf."Avail. Date" := PurchLine."Expected Receipt Date";
                        SupplyBuf."Source Type" := SupplyBuf."Source Type"::PurchaseLine;
                        SupplyBuf."Source Table ID" := DATABASE::"Purchase Line";
                        SupplyBuf."Document Type Int" := PurchLine."Document Type".AsInteger();
                        SupplyBuf."Document No." := PurchLine."Document No.";
                        SupplyBuf."Document Line No." := PurchLine."Line No.";
                        SupplyBuf.Insert();
                    end;
                end;
            until PurchLine.Next() = 0;
    end;


    local procedure AllocateFromSupply(var Demand: Record "OTG Demand Buffer"; var NeedQty: Decimal; var EarliestDate: Date)
    var
        TakeQty: Decimal;
        AvailQty: Decimal;
        NeedLeft: Decimal;
    begin
        // Normalize quantities to avoid tiny precision artifacts
        AvailQty := Round(SupplyBuf."Available Qty (Base)", 0.00001, '=');
        NeedLeft := Round(NeedQty, 0.00001, '=');

        // Nothing to do if no supply or no remaining need
        if (AvailQty <= 0) or (NeedLeft <= 0) then
            exit;

        // Take the lesser of available vs. need
        TakeQty := AvailQty;
        if TakeQty > NeedLeft then
            TakeQty := NeedLeft;

        // Persist allocation (with drill-down metadata from SupplyBuf)
        WriteAllocationFromSupply(Demand."Entry No.", SupplyBuf, TakeQty);

        // Reduce supply (never below zero) and commit change
        AvailQty := AvailQty - TakeQty;
        if AvailQty < 0 then
            AvailQty := 0;
        SupplyBuf."Available Qty (Base)" := AvailQty;
        SupplyBuf.Modify();

        // Reduce remaining need returned to caller
        NeedLeft := NeedLeft - TakeQty;
        if NeedLeft < 0 then
            NeedLeft := 0;
        NeedQty := NeedLeft;

        // Set earliest availability date the first time we allocate, or if this supply is earlier
        if (EarliestDate = 0D) or (SupplyBuf."Avail. Date" < EarliestDate) then
            EarliestDate := SupplyBuf."Avail. Date";
    end;


    local procedure WriteAllocationFromSupply(DemandEntryNo: Integer; SupplyBuf: Record "OTG Supply Buffer"; AllocQty: Decimal)
    var
        Alloc: Record "OTG Allocation Result";
    begin
        Alloc.Init();
        Alloc."Demand Entry No." := DemandEntryNo;
        Alloc."Item Ledger Entry No." := SupplyBuf."Item Ledger Entry No.";
        Alloc."Allocated Qty (Base)" := AllocQty;
        Alloc."Supply Avail. Date" := SupplyBuf."Avail. Date";
        Alloc."Allocation DateTime" := CurrentDateTime();

        Alloc."Source Type" := SupplyBuf."Source Type";
        Alloc."Source Table ID" := SupplyBuf."Source Table ID";
        Alloc."Document Type Int" := SupplyBuf."Document Type Int";
        Alloc."Document No." := SupplyBuf."Document No.";
        Alloc."Document Line No." := SupplyBuf."Document Line No.";

        Alloc.Insert(true);
    end;

    local procedure CalcAvailableOnILE(ItemLGEntry: Record "Item Ledger Entry"): Decimal
    begin
        ItemLGEntry.CalcFields("Reserved Quantity");
        exit(ItemLGEntry."Remaining Quantity" - ItemLGEntry."Reserved Quantity");
    end;

    local procedure CalcAvailableOnPurchLine(PurchLine: Record "Purchase Line"): Decimal
    var
        ReservedBase: Decimal;
    begin
        PurchLine.CalcFields("Reserved Qty. (Base)");
        exit(PurchLine."Outstanding Qty. (Base)" - PurchLine."Reserved Qty. (Base)");
    end;

    local procedure ClearPreviousResults()
    var
        Demand: Record "OTG Demand Buffer";
        Alloc: Record "OTG Allocation Result";
    begin
        // reset computed fields on demand
        if Demand.FindSet() then
            repeat
                //Demand."Allocated Qty (Base)" := 0;
                Demand."Earliest Avail. Date" := 0D;
                Demand."Fully Allocated" := false;
                Demand.Modify(true);
            until Demand.Next() = 0;

        Alloc.DeleteAll();
        SupplyBuf.DeleteAll();

    end;

    var
        SupplyBuf: Record "OTG Supply Buffer" temporary;

}
