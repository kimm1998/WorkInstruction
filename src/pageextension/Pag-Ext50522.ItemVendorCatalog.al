pageextension 50522 "Item Vendor Catalog" extends "Item Vendor Catalog"
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
