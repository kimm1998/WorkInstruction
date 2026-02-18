codeunit 50504 "ONT Update Comp. on Prod Order"
{
    trigger OnRun()
    begin
        RemoveComponentInfoOnProdOrder();
        UpdateComponentOnProdOrder();
    end;

    procedure UpdateComponentOnProdOrder()
    var
        WorkCenter: Record "Work Center";
        ProdOrder: Record "Production Order";
    begin
        WorkCenter.Reset();
        if WorkCenter.FindSet() then
            repeat
                ProdOrder.Reset();
                ProdOrder.SetFilter(Status, '<>%1', ProdOrder.Status::Finished);
                ProdOrder.SetRange("ONT Next Work Center No.", WorkCenter."No.");
                if ProdOrder.FindSet() then
                    repeat
                        ProdOrder."ONT Component No." := GetFirstProdComponentlineItemNo(ProdOrder.Status, ProdOrder."No.");
                        ProdOrder."ONT Component Description" := GetFirstProdComponentlineDescription(ProdOrder.Status, ProdOrder."No.");
                        ProdOrder.Modify(false);
                    until ProdOrder.Next() = 0;
            until WorkCenter.Next() = 0;
    end;

    local procedure GetFirstProdComponentlineItemNo(ProdOrderStatus: Enum "Production Order Status"; ProdOrdeNo: Code[20]): Code[20]
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        ProdOrderComponent.Reset();
        ProdOrderComponent.SetRange(Status, ProdOrderStatus);
        ProdOrderComponent.SetRange("Prod. Order No.", ProdOrdeNo);
        if ProdOrderComponent.FindFirst() then
            exit(ProdOrderComponent."Item No.")
        else
            exit('');
    end;

    local procedure GetFirstProdComponentlineDescription(ProdOrderStatus: Enum "Production Order Status"; ProdOrdeNo: Code[20]): Text[100]
    var
        ProdOrderComponent: Record "Prod. Order Component";
        WorkCenter: Record "Work Center";
    begin
        ProdOrderComponent.Reset();
        ProdOrderComponent.SetRange(Status, ProdOrderStatus);
        ProdOrderComponent.SetRange("Prod. Order No.", ProdOrdeNo);
        if ProdOrderComponent.FindFirst() then
            exit(ProdOrderComponent.Description)
        else
            exit('');
    end;

    local procedure RemoveComponentInfoOnProdOrder()
    var
        ProdOrder: Record "Production Order";
        ProdOrder2: Record "Production Order";
    begin
        ProdOrder.Reset();
        ProdOrder.SetFilter("ONT Component No.", '<>%1', '');
        if ProdOrder.FindSet() then
            ProdOrder.ModifyAll("ONT Component No.", '', false);

        ProdOrder2.Reset();
        ProdOrder2.SetFilter("ONT Component Description", '<>%1', '');
        if ProdOrder2.FindSet() then
            ProdOrder2.ModifyAll("ONT Component Description", '', false);
    end;
}