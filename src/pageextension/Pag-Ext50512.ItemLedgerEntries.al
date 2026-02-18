pageextension 50512 "Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Revision No."; Rec."Revision No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Revision No. field.';
            }
        }
    }
}
