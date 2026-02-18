pageextension 50546 WarehouseSetup extends "Warehouse Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {

            field("Enable Default on Bin Creation"; Rec."Enable Default on Bin Creation")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Default on Bin Creation field.', Comment = '%';
            }
        }
        addafter(General)
        {
            
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}