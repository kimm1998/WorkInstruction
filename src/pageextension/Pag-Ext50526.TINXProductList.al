pageextension 50526 "TINX Product List" extends "TINX Product List"
{
    layout
    {
        addlast(Control11205258)
        {
            field("Available Inventory"; Rec."Available Inventory")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inventory field.';
            }
            field("Next Replenishment Date"; Rec."Next Replenishment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Next Replenishment Date field.';
            }
        }
    }
}
