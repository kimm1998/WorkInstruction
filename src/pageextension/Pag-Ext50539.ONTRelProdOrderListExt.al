// List page: Released Production Orders
pageextension 50539 "ONT RelProdOrderListExt" extends "Released Production Orders"
{
    layout
    {
        addafter(Quantity)
        {
            field("ONT Total Quatity"; Rec."ONT Total Quatity")
            {
                ApplicationArea = all;
                Caption = 'Total Quantity';
            }
        }

    }
    actions
    {
        addlast(Processing)
        {
            action(ONTCreateShopfloorTransfers)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Create Shopfloor Transfers';
                Image = TransferOrder;
                ToolTip = 'Create transfer orders for the selected released production orders based on component shortages to the shop floor bin.';

                trigger OnAction()
                var
                    TransferMgt: Codeunit "ONT Shopfloor Transfer Mgt";
                    SelectedOrders: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(SelectedOrders);
                    if SelectedOrders.FindSet() then
                        repeat
                            TransferMgt.RunForProductionOrder(SelectedOrders.Status, SelectedOrders."No.");
                        until SelectedOrders.Next() = 0;
                end;
            }
            action(ONTOpenTransferOrders)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Open Transfer Orders';
                Image = TransferOrder;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Open transfer orders that were created for this production order (matched by External Document No.).';

                trigger OnAction()
                var
                    TransferHeader: Record "Transfer Header";
                    recCount: Integer;
                begin
                    // Filter transfer orders by External Document No. = this Prod. Order No.
                    TransferHeader.Reset();
                    TransferHeader.SetRange("External Document No.", Rec."No.");

                    recCount := TransferHeader.Count();
                    if recCount = 0 then begin
                        Message('No transfer orders found for production order %1.', Rec."No.");
                        exit;
                    end;

                    if recCount = 1 then begin
                        TransferHeader.FindFirst();
                        PAGE.Run(PAGE::"Transfer Order", TransferHeader);
                    end else
                        PAGE.Run(PAGE::"Transfer Orders", TransferHeader);
                end;
            }
        }



    }
}
