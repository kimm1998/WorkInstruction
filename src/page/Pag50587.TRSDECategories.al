page 50587 "T_RSDECategories"
{
    PageType = List;
    ApplicationArea = All;
Caption = 'RSDE Categories';
    UsageCategory = Administration;
    SourceTable = T_RSDECategory;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
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
