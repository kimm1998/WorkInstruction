page 50526 "CusmaCertificationList"
{
    PageType = List;
    SourceTable = "CusmaCertificationDSF";
    Caption = 'CUSMA Certification List';
    CardPageId = "CusmaCertificationCard";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Text area to define the certification.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
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
