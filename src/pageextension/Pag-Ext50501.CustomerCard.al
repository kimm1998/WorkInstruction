pageextension 50501 "Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("On Hold Reason Code"; Rec."Block Reason Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Payment Terms Code")
        {
            field("Multiple Payment Code"; Rec."Multiple Payment Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
