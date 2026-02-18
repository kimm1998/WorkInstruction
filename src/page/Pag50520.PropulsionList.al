page 50520 "PropulsionList"
{
    PageType = List;
    SourceTable = "PropulsionDSF";
    Caption = 'Propulsion';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Propulsion; Rec.Propulsion)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each Bicycle model.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Text area to define the category.';
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
