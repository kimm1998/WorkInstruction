codeunit 50564 "ONTCreateSubcontractTransfers"
{
    Permissions = TableData "Prod. Order Component" = rimd,
                  TableData "Manufacturing Setup" = r,
                  TableData "Transfer Header" = rimd,
                  TableData "Transfer Line" = rimd;

    // trigger OnRun()
    // begin
    //     CreateTransfersForAllProdOrders();
    // end;

    procedure CreateTransfersForAllProdOrders(OrderNo: Code[20])
    var
        ProdOrderComponent: Record "Prod. Order Component";

    begin
        ProdOrderComponent.Reset();
        ProdOrderComponent.SetRange("Prod. Order No.", OrderNo);
        ProdOrderComponent.SetRange("ONT Component Transferred", false);
        if not ProdOrderComponent.FindSet() then
            exit;
        repeat
            ProcessProdOrderComponent(ProdOrderComponent);
        until ProdOrderComponent.Next() = 0;
    end;

    local procedure ProcessProdOrderComponent(var ProdOrderComponent: Record "Prod. Order Component")
    var
        WorkCenterLocation: Code[20];
        WorkCenter: Code[20];
        ManufacturingSetup: Record "Manufacturing Setup";
        FromLocationCode: Code[10];
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        QtyToTransfer: Decimal;
        DocumentNo: Code[20];
        ProdOrderNo: Code[20];
    begin
        ProdOrderNo := ProdOrderComponent."Prod. Order No.";

        WorkCenter := GetSubcontractorWorkCenterNo(
            ProdOrderComponent."Prod. Order No.",
            ProdOrderComponent.Status,
            ProdOrderComponent."Prod. Order Line No.",
            ProdOrderComponent."Routing Link Code");
        If WorkCenter <> '' then begin

            SetSubcontractWorkCenterLocation(WorkCenter, WorkCenterLocation);
        end;

        if WorkCenterLocation = '' then
            exit;

        if not ManufacturingSetup.Get() then
            Error('Manufacturing Setup not configured.');

        FromLocationCode := ManufacturingSetup."ONT From Location Code";
        if FromLocationCode = '' then
            Error('Manufacturing Setup field "ONT From Location Code" is not filled.');

        QtyToTransfer := ProdOrderComponent."Remaining Qty. (Base)";
        if QtyToTransfer <= 0 then
            exit;

        // Find existing open transfer header for the same From/To locations (reuse if found)
        TransferHeader.Reset();
        TransferHeader.SetRange("Transfer-from Code", FromLocationCode);
        TransferHeader.SetRange("Transfer-to Code", WorkCenterLocation);
        TransferHeader.SetRange("External Document No.", ProdOrderNo);
        if TransferHeader.FindFirst() then begin
            DocumentNo := TransferHeader."No.";
        end else begin
            // Create a new Transfer Header
            TransferHeader.Init();
            TransferHeader.Validate("Transfer-from Code", FromLocationCode);
            TransferHeader.Insert(true);
            TransferHeader.Validate("Transfer-to Code", WorkCenterLocation);
            if ManufacturingSetup."ONT In-Transit Location Code" <> '' then
                TransferHeader.Validate("In-Transit Code", ManufacturingSetup."ONT In-Transit Location Code");
            TransferHeader.Validate("External Document No.", ProdOrderNo);
            TransferHeader.Modify(true);
            DocumentNo := TransferHeader."No.";
        end;

        if DocumentNo = '' then
            Error('Unable to create or find Transfer Header.');
        TransferLine.Init();
        TransferLine.Validate("Document No.", DocumentNo);
        TransferLine.Validate("Item No.", ProdOrderComponent."Item No.");
        TransferLine.Validate("Quantity", QtyToTransfer);
        TransferLine.Validate("Line No.", GetlastLineNo(DocumentNo) + 10000);
        TransferLine.Validate("Transfer-To Bin Code", ProdOrderComponent."Bin Code");
        TransferLine.Insert(true);
        ProdOrderComponent."ONT Component Transferred" := true;
        ProdOrderComponent.Modify();
    end;

    local procedure GetSubcontractorWorkCenterNo(ProductionOrderNo: Code[20]; Status: Enum "Production Order Status"; ProductionOrderLineNo: Integer; RoutingLinkCode: Code[10]): Code[20]
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRoutingLine.SetRange(Status, Status);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrderNo);
        ProdOrderRoutingLine.SetRange("Routing Reference No.", ProductionOrderLineNo);
        ProdOrderRoutingLine.SetRange("Routing Link Code", RoutingLinkCode);
        ProdOrderRoutingLine.SetFilter("ONT Subcontractor No.", '<>%1', '');
        if ProdOrderRoutingLine.FindFirst() then
            exit(ProdOrderRoutingLine."Work Center No.");
        exit('');
    end;

    local procedure SetSubcontractWorkCenterLocation(WorkCenterNo: Code[20];
        var LocationCode: Code[20])
    var

        WorkCenter: Record "Work Center";

    begin

        if WorkCenter.get(WorkCenterNo) then begin
            LocationCode := WorkCenter."Location Code";
        end;

    end;

    local procedure GetlastLineNo(TransferNo: Code[20]): Integer
    var

        TransferLine: Record "Transfer Line";
    begin
        TransferLine.SetRange("Document No.", TransferNo);
        if TransferLine.FindLast() then
            exit(TransferLine."Line No.");
        exit(0);
    end;
}