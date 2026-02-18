pageextension 50550 TransferOrdersExt extends "Transfer Orders"
{
    layout
    {
        addafter(Status)
        {
            field("External Document No."; Rec."External Document No.")
            {
                applicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}