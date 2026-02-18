page 50509 "ModelNameList"
{
    PageType = List;
    SourceTable = "ModelNameDSF";
    Caption = 'Model name';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code identifying the model name number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
