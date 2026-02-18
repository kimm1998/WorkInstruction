pageextension 50548 JobCardExt extends "Job Card"
{
    layout
    {
        addafter("No. of Archived Versions")
        {
            field(RSDECategory; Rec.RSDECategory)
            {
                Caption = 'RS & DE Category';
                ApplicationArea = all;
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