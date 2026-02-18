codeunit 50517 "ONT Shopfloor Transfer Job"
{
    Subtype = Normal;

    trigger OnRun()
    var
        TransferMgt: Codeunit "ONT Shopfloor Transfer Mgt";
        ProdOrder: Record "Production Order";
    begin
        // Process Firm Planned and Released orders.
        // No UI (Message/Confirm) here so it’s safe for Job Queue execution.
        ProdOrder.Reset();
        ProdOrder.SetFilter(Status, '%1', ProdOrder.Status::Released);

        if ProdOrder.FindSet() then
            repeat
                TransferMgt.RunForProductionOrder(ProdOrder.Status, ProdOrder."No.");
            until ProdOrder.Next() = 0;
    end;
}
