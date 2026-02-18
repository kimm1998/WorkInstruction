codeunit 50560 "OTG Demand Loader"
{


    procedure LoadFromSalesOrders(DateFrom: Date; DateTo: Date; LocationFilter: Code[10]; OnlyReleased: Boolean; DefaultPriority: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        QtyBase: Decimal;
        DemandDate: Date;
    begin
        // Sales Orders -> confirmed demand: Outstanding Qty. (Base) with Shipment Date in range
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if OnlyReleased then
            SalesHeader.SetRange(Status, SalesHeader.Status::Released);

        if SalesHeader.FindSet() then
            repeat
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetFilter("Outstanding Qty. (Base)", '>0');

                if LocationFilter <> '' then
                    SalesLine.SetRange("Location Code", LocationFilter);

                // Date filters on Shipment Date (line); fallback later to header if line date = 0D
                if (DateFrom <> 0D) and (DateTo <> 0D) then
                    SalesLine.SetRange("Shipment Date", DateFrom, DateTo)
                else begin
                    if DateFrom <> 0D then
                        SalesLine.SetFilter("Shipment Date", '>=%1', DateFrom);
                    if DateTo <> 0D then
                        SalesLine.SetFilter("Shipment Date", '<=%1', DateTo);
                end;

                if SalesLine.FindSet() then
                    repeat
                        QtyBase := SalesLine."Outstanding Qty. (Base)";
                        if QtyBase > 0 then begin
                            DemandDate := SalesLine."Shipment Date";
                            if DemandDate = 0D then
                                DemandDate := SalesHeader."Shipment Date";

                            UpsertDemand(
                                Database::"Sales Line",
                                SalesLine."Document Type".AsInteger(),
                                "OTG Demand Source"::"Sales Line",
                                SalesLine."Document No.", SalesLine."Line No.", 0,
                                SalesLine."No.", SalesLine."Variant Code", SalesLine."Location Code",
                                '', '', // Lot/Serial unknown at this stage
                                DemandDate,
                                QtyBase,
                                DefaultPriority);
                        end;
                    until SalesLine.Next() = 0;
            until SalesHeader.Next() = 0;
    end;

    procedure LoadFromProdOrderComponents(IncludePlanned: Boolean; IncludeFirmPlanned: Boolean; IncludeReleased: Boolean; LocationFilter: Code[10]; DefaultPriority: Integer)
    var
        ProdOrderComponent: Record "Prod. Order Component";
        StatusFilter: Text;
        QtyBase: Decimal;
        DemandDate: Date;
        FirstToken: Boolean;
        int: Integer;
    begin
        ProdOrderComponent.Reset();

        // Build an option filter for Status like '%1|%2|%3'
        StatusFilter := '';
        FirstToken := true;

        if IncludePlanned then begin
            if not FirstToken then StatusFilter += '|';
            StatusFilter += Format(ProdOrderComponent.Status::Planned);
            FirstToken := false;
        end;

        if IncludeFirmPlanned then begin
            if not FirstToken then StatusFilter += '|';
            StatusFilter += Format(ProdOrderComponent.Status::"Firm Planned");
            FirstToken := false;
        end;

        if IncludeReleased then begin
            if not FirstToken then StatusFilter += '|';
            StatusFilter += Format(ProdOrderComponent.Status::Released);
            FirstToken := false;
        end;

        if StatusFilter = '' then
            exit; // nothing chosen

        ProdOrderComponent.SetFilter(Status, StatusFilter);
        ProdOrderComponent.SetFilter("Remaining Qty. (Base)", '>0');

        if LocationFilter <> '' then
            ProdOrderComponent.SetRange("Location Code", LocationFilter);

        if ProdOrderComponent.FindSet() then
            repeat
                QtyBase := ProdOrderComponent."Remaining Qty. (Base)";
                if QtyBase > 0 then begin
                    // Use ProdOrderComponentonent Due Date as demand date; fallback to WorkDate
                    DemandDate := ProdOrderComponent."Due Date";
                    if DemandDate = 0D then
                        DemandDate := WorkDate;
                    // Prod. Order Component does NOT have Lot/Serial fields → pass blanks
                    ProdOrderComponent."Demand Entry No." := UpsertDemand(
                        Database::"Prod. Order Component",
                        ProdOrderComponent.Status.AsInteger(),
                        "OTG Demand Source"::"Prod. Order Comp.",
                        ProdOrderComponent."Prod. Order No.",
                        ProdOrderComponent."Line No.",
                        ProdOrderComponent."Prod. Order Line No.",
                        ProdOrderComponent."Item No.", ProdOrderComponent."Variant Code", ProdOrderComponent."Location Code",
                        '', '', // no lot/serial on component record
                        DemandDate,
                        QtyBase,
                        DefaultPriority);
                    ProdOrderComponent.Modify();
                end;
            until ProdOrderComponent.Next() = 0;
    end;

    procedure ClearBuffer()
    var
        DemandBufer: Record "OTG Demand Buffer";
    begin
        DemandBufer.DeleteAll();
    end;

    local procedure UpsertDemand(SourceTypeTableID: Integer; SourceSubtype: Option; SourceType: Enum "OTG Demand Source"; SourceNo: Code[20]; SourceLineNo: Integer; ProLineNO: Integer; ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; LotNo: Code[50]; SerialNo: Code[50]; DemandDate: Date; QtyBase: Decimal; Priority: Integer): Integer
    var
        DemandBufer: Record "OTG Demand Buffer";
        Found: Boolean;
    begin
        // Upsert keyed by (Source Type, Source No., Source Line No.)
        DemandBufer.Reset();
        DemandBufer.SetRange("Source Type", SourceType);
        DemandBufer.SetRange("Source No.", SourceNo);
        DemandBufer.SetRange("Source Line No.", SourceLineNo);
        DemandBufer.SetRange("Prod. Order Line No.", ProLineNO);
        Found := DemandBufer.FindFirst();

        if not Found then begin
            DemandBufer.Init();
            DemandBufer."Item No." := ItemNo;
            DemandBufer."Variant Code" := VariantCode;
            DemandBufer."Location Code" := LocationCode;
            DemandBufer."Lot No." := LotNo;
            DemandBufer."Serial No." := SerialNo;
            DemandBufer."Demand Date" := DemandDate;
            DemandBufer."Quantity (Base)" := Round(QtyBase, 0.00001, '=');
            DemandBufer."Source Subtype" := SourceSubtype;
            DemandBufer."Source Type Table ID" := SourceTypeTableID;
            DemandBufer."Source Type" := SourceType;
            DemandBufer."Source No." := SourceNo;
            DemandBufer."Source Line No." := SourceLineNo;
            DemandBufer."Prod. Order Line No." := ProLineNO;
            DemandBufer.Priority := Priority;
            DemandBufer.Insert(true);
        end else begin
            DemandBufer."Item No." := ItemNo;
            DemandBufer."Variant Code" := VariantCode;
            DemandBufer."Location Code" := LocationCode;
            DemandBufer."Lot No." := LotNo;
            DemandBufer."Serial No." := SerialNo;
            DemandBufer."Demand Date" := DemandDate;
            DemandBufer."Quantity (Base)" := Round(QtyBase, 0.00001, '=');
            if Priority <> 0 then
                DemandBufer.Priority := Priority;
            DemandBufer.Modify(true);
        end;
        exit(DemandBufer."Entry No.");
    end;
}
