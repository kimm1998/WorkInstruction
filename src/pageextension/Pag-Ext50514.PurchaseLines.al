pageextension 50514 "Purchase Lines" extends "Purchase Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Whse Receipt No."; Rec."Whse Receipt No.")
            {
                ApplicationArea = All;
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field("Container ID"; Rec."Container ID")
            {
                ApplicationArea = All;
            }
        }
    }
}
