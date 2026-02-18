pageextension 50503 "Sales Credit Memo" extends "Sales Credit Memo"
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
