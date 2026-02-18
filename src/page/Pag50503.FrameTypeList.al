page 50503 "FrameTypeList"
{
    PageType = List;
    SourceTable = "FrameTypeDSF";
    Caption = 'Frame type';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Brief definition of the frame type.';
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
