pageextension 50542 "ONT Lot Info Card Ext" extends "Lot No. Information Card"
{
    layout
    {
        addlast(General)
        {
            field("ONT Expiration Date";Rec."ONT Expiration Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maintenance Interval (Override) field.', Comment = '%';
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