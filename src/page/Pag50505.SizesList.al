page 50505 "SizesList"
{
    PageType = List;
    SourceTable = "SizesDSF";
    Caption = 'Sizes';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
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
