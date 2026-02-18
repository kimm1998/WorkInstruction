page 50514 "BikeSegmentList"
{
    PageType = List;
    SourceTable = "BikeSegmentDSF";
    Caption = 'Bike Segment';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Segment; Rec.Segment)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each Bicycle model.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Text area to define the bicycle segment.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Sequence number used to schedule the display of the records of this table.';
                }
                field(Actif; Rec.Actif)
                {
                    ApplicationArea = All;
                    ToolTip = 'When desactivated, it can''t be selected to the Customer Forecast line.';
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
