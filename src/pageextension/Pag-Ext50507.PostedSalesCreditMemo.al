pageextension 50507 "Posted Sales Credit Memo" extends "Posted Sales Credit Memo"
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
