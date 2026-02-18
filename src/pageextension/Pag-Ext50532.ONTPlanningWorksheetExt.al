pageextension 50532 "ONT Planning Worksheet Ext" extends "Planning Worksheet"
{
    layout
    {
        // Add in the lines repeater after a safe anchor that exists on this page.
        addafter("Action Message")
        {
            field("ONT From Demand Forecast"; Rec."ONT Demand Forecast")
            {
                ApplicationArea = All;
                Caption = 'Demand Forecast';
                ToolTip = 'Indicates this planning line is influenced by Demand Forecast.';
                Editable = false;
            }
            field("ONT Family No."; Rec."ONT Family No.")
            {
                ApplicationArea = Planning;
                ToolTip = 'Family code derived from the item''s family lines.';
            }
            field("ONT Family Quantity"; Rec."ONT Family Quantity")
            {
                ApplicationArea = Planning;
                ToolTip = 'Calculated as Quantity (Base) divided by the Family Line quantity for this item.';
            }
        }
        addafter(Description)
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Code field.', Comment = '%';
            }
            field("Item Category Description"; Rec."Item Category Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Description field.', Comment = '%';
            }
            
        }
    }
}
