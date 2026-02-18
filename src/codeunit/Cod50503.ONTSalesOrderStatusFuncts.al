codeunit 50503 "ONT Sales Order Status Functs."
{
    SingleInstance = true;

    procedure UpdateProdOrderAvailabilityStatus(ProductionOrder: Record "Production Order")
    var
        FullyAvailable: Enum "ONT Availability Status";
        ProdLastLineUnavailable: Enum "ONT Availability Status";
    begin
        OnBeforeUpdateProdOrderAvailabilityStatus();
        ProdLastLineUnavailable := CheckAvailabilityStatusMaxPlanningLevelCode(ProductionOrder);
        FullyAvailable := CheckFullyAvailable(ProductionOrder, ProdLastLineUnavailable);
        if ProdLastLineUnavailable = ProdLastLineUnavailable::Unavailable then
            ProductionOrder."ONT Availability Status" := ProductionOrder."ONT Availability Status"::Unavailable
        else
            if (ProdLastLineUnavailable <> ProdLastLineUnavailable::"Unavailable") And (FullyAvailable <> FullyAvailable::"Fully Available") then
                ProductionOrder."ONT Availability Status" := ProductionOrder."ONT Availability Status"::"Partially Available"
            else
                if FullyAvailable = FullyAvailable::"Fully Available" then
                    ProductionOrder."ONT Availability Status" := ProductionOrder."ONT Availability Status"::"Fully Available";

        ProductionOrder.Modify(False);
        Commit();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateProdOrderAvailabilityStatus()
    begin
    end;

    local procedure CheckAvailabilityStatusMaxPlanningLevelCode(ProductionOrder: Record "Production Order"): Enum "ONT Availability Status"
    var
        ProdOrderLine: Record "Prod. Order Line";
        MaxRoutingReferenceNo: Integer;
    begin
        MaxRoutingReferenceNo := GetMaxRoutingReferenceNo(ProductionOrder);

        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        ProdOrderLine.SetRange("ONT Availability Status", "ONT Availability Status"::Unavailable);
        ProdOrderLine.SetRange("Routing Reference No.", MaxRoutingReferenceNo);
        IF ProdOrderLine.FindFirst() then
            exit(ProdOrderLine."ONT Availability Status"::Unavailable);

        ProdOrderLine.Reset();
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        ProdOrderLine.SetRange("ONT Availability Status", "ONT Availability Status"::"Partially Available");
        ProdOrderLine.SetRange("Routing Reference No.", MaxRoutingReferenceNo);
        IF ProdOrderLine.FindFirst() then
            exit(ProdOrderLine."ONT Availability Status"::"Partially Available");

        ProdOrderLine.Reset();
        exit(ProdOrderLine."ONT Availability Status"::"Fully Available");
    end;

    local procedure CheckFullyAvailable(ProductionOrder: Record "Production Order";
    ProdLastLineUnavailable: enum "ONT Availability Status"): Enum "ONT Availability Status"
    var
        ProdOrderLine: Record "Prod. Order Line";
        MaxRoutingReferenceNo: Integer;
    begin
        MaxRoutingReferenceNo := GetMaxRoutingReferenceNo(ProductionOrder);
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        If ProdOrderLine.FindSet() then begin
            ProdOrderLine.SetFilter("Routing Reference No.", '<%1', MaxRoutingReferenceNo);
            IF ProdOrderLine.FindSet() then
                repeat
                    IF ProdOrderLine."ONT Availability Status" <> ProdOrderLine."ONT Availability Status"::"Fully Available" then
                        exit(ProdOrderLine."ONT Availability Status"::Unavailable);
                Until ProdOrderLine.Next() = 0
            else
                Exit(ProdLastLineUnavailable);
        end;
        Exit(ProdLastLineUnavailable);
    end;

    local procedure GetMaxRoutingReferenceNo(ProductionOrder: Record "Production Order"): Integer
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        ProdOrderLine.SetFilter("Finished Qty. (Base)", '=%1', 0);
        IF ProdOrderLine.FindLast() then
            exit(ProdOrderLine."Routing Reference No.");
    end;

    // procedure GenerateSalesOrderStatus(DocumentNo: code[20])//recheck
    // var
    //     SalesHeaderBuffer: Record "Sales Order Buffer";
    // begin
    //     if DocumentNo <> '' then
    //         SalesHeaderBuffer.SetRange("Sales Order No.", DocumentNo);
    //     SalesHeaderBuffer.DeleteAll();
    //     ProductionOrderTemp.DeleteAll(); //Ucef
    //     FillFromSalesHeader(DocumentNo);
    // end;
    // Procedure UpdateSalesOrderAvailability(SalesOrderNo: Code[20])//recheck
    // var
    //     SalesHeader: Record "Sales Header";
    //     StartTime: Datetime;
    //     EndTime: Datetime;
    //     Duration: Duration;
    // begin
    //     StartTime := CurrentDateTime;
    //     SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
    //     if SalesOrderNo <> '' then
    //         SalesHeader.SetRange("No.", SalesOrderNo);
    //     SalesHeader.SetRange("ONT Has Outstanding Qty Line", true);
    //     IF SalesHeader.FindSet() then
    //         repeat
    //             UpdateProductionOrderAvailabilityFilterBySalesNo(SalesHeader."No.");
    //             UpdateSalesLineAvailability(SalesHeader."No.");
    //             UpdateSalesBufferAvailability(SalesHeader."No.");
    //         until SalesHeader.Next() = 0;
    //     if SalesOrderNo = '' then
    //         UpdateProductionOrderAvailabilitywithNoSalesOrder;
    //     EndTime := CurrentDateTime;
    //     Duration := EndTime - StartTime;
    //     if GuiAllowed then
    //         Message(Format(Duration));
    // end;


    var
        Item: Record Item;
        ProductionOrderTemp: Record "Production Order" temporary;
        RoutingStatus: option " ",Planned,"In Progress",Finished;
        AvailStatus: enum "ONT Availability Status";
        ProjectID: CODE[20];
}
