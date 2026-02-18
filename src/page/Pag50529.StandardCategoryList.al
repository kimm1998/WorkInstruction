page 50529 "StandardCategoryList"
{
    PageType = List;
    SourceTable = "StandardCategoryDSF";
    Caption = 'Standard Category List';
    CardPageId = "StandardCategoryCard";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(StandardCategory; Rec.StandardCategory)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each standard.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Text area to define the category of the standard.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Sequence number used to schedule the display of the records of this table.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}
