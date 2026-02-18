page 50551 "User Table Filters"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "User Table Filter";
    Caption = 'User Table Filters';
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User ID.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Table ID.';
                }
                field("Filter Code"; Rec."Filter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Filter Code.';
                }
            }
        }
    }
 
}