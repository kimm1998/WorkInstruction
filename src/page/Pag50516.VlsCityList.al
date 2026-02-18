page 50516 "VlsCityList"
{
    PageType = List;
    SourceTable = "VlsCityDSF";
    Caption = 'VLS City';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(CityNo; Rec.CityNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each City/Customer.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Text area to define the City/Customer.';
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
