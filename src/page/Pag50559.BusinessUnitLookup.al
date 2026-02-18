page 50559 "Business Unit Lookup"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Business Unit Lookup";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code;Rec.Code)
                {
                    
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
           
        }
    }
    
    var
        myInt: Integer;
}