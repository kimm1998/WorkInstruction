pageextension 50551 TransferOrderExt extends "Transfer Order"
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