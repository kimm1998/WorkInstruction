pageextension 50524 "Vendor Item Catalog" extends "Vendor Item Catalog"
{
    layout
    {
        modify("Lead Time Calculation")
        {
            Editable = false;
        }
        addafter("Vendor Item No.")
        {
            field("Manufacturing Lead Time"; Rec."Manufacturing Lead Time")
            {
                ApplicationArea = All;
                ToolTip = 'Manufacturing Lead Time';
            }
            field("Transit Lead Time"; Rec."Transit Lead Time")
            {
                ApplicationArea = All;
                ToolTip = 'Transit Lead Time';
            }
        }
    }
}
