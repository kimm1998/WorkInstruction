pageextension 50520 "Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Multiple Payment Code"; Rec."Multiple Payment Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order Type field.';
            }
        }
    }
}
