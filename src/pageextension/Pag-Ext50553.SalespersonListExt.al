// 1. Salesperson List - Add Vendor Column
pageextension 50553 "Salesperson List Ext" extends "Salespersons/Purchasers"
{
    layout
    {
        addafter(Name)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Caption = 'Commission Vendor';
                ToolTip = 'Specifies the Vendor account linked to this salesperson for payment.';
                DrillDown = true;
            }
        }
    }
}