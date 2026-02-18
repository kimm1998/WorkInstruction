codeunit 50501 "ONT Update Availability-Ops"
{
    trigger OnRun()
    begin
        UpdateAvailabilityOps();
    end;

    local procedure UpdateAvailabilityOps()
    var
        UpdateProdOrderAvailability: codeunit "ONT Update Prod Order Availab.";
        SalesOrderStatusFunctions: codeunit "ONT Sales Order Status Functs.";
        // PurchaseStatusMgt: Codeunit "ONT Purchase Mgt";//recheck
    begin
        UpdateProdOrderAvailability.UpdateProductionComponentShortages('', 0, '');
        UpdateProdOrderAvailability.UpdateProdOrderLineAvailabilityStatusforAllProductionOrders('');
        UpdateProdOrderAvailability.UpdateOperationNoforAllProductionOrders();
        // SalesOrderStatusFunctions.GenerateSalesOrderStatus('');//recheck
        Commit();
        // SalesOrderStatusFunctions.UpdateSalesOrderAvailability('');//recheck
        // PurchaseStatusMgt.CreatePurchaseStatusFromHeader();//recheck
        // PurchaseStatusMgt.FillInTransitWsht();
        CODEUNIT.Run(CODEUNIT::"ONT Update Comp. on Prod Order");
    end;

}