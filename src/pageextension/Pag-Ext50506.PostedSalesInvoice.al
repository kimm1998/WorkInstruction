pageextension 50506 "Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order Type field.';
            }
            field("Shipping Formula"; Rec."Shipping Formula")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Formula field.';
            }
            field("Salesman commission %"; Rec."Salesman commission %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesman commission % field.', Comment = '%';
            }
        }
    }
}
