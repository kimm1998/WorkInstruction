page 50535 "SalesPeriodList"
{
    PageType = List;
    SourceTable = "SalesPeriodDSF";
    Caption = 'Sales period';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Describe with start and end date this period last.';
                }
                field(Actif; Rec.Actif)
                {
                    ApplicationArea = All;
                    ToolTip = 'When desactivated, it can''t be selected to the Customer Forecast card.';
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
