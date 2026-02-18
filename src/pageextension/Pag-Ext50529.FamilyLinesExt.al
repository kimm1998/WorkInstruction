pageextension 50529 FamilyLinesExt extends "Family Lines"
{
    layout
    {
        addafter(Description)
        {
            
            field("Business Unit"; Rec."Business Unit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Business Unit field.', Comment = '%';
                trigger OnDrillDown()
                var
                    myInt: Integer;
                begin
                   exit; 
                end;
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