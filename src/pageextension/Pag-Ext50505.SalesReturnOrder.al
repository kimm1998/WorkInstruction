pageextension 50505 "Sales Return Order" extends "Sales Return Order"
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
        }
    }
}
