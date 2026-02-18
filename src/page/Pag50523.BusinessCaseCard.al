page 50523 "BusinessCaseCard"
{
    PageType = Card;
    SourceTable = "BusinessCaseDSF";
    Caption = 'Business case Card';

    layout
    {
        area(content)
        {
            group(GeneralGrp)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Text area to define the Business case.';
                }
                field(BusinessUnitNo; Rec.BusinessUnitNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that categorizes each business case according to the business unit of the company.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'It is about the state of the Business Case, its evolution of study/analysis.';
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
