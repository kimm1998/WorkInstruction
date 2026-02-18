pageextension 50545 "ONT Sales Order Ext" extends "Sales Order"
{
    actions
    {
        addlast(Processing)
        {
            action(CalculateFreight)
            {
                ApplicationArea = All;
                Caption = 'Calculate Freight';
                Image = CalculateShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Calculates shipping charges based on the Sales Type and Item criteria.';

                trigger OnAction()
                var
                    ShippingCalc: Codeunit "ONT Shipping Calculator";
                begin
                    ShippingCalc.CalculateShippingOnOrder(Rec);
                end;
            }
        }
    }
}