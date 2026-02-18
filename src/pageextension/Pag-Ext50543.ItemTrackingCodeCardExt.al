pageextension 50543 ItemTrackingCodeCardExt extends "Item Tracking Code Card"
{
    layout
    {
        addafter("Use Expiration Dates")
        {
            field("ONT Maintenance Required"; Rec."ONT Maintenance Required")
            {
                ApplicationArea = all;
            }
            field("ONT Maintenance Interval"; Rec."ONT Maintenance Interval")
            {
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