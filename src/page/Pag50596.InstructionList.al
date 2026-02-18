page 50596 "Instruction List"
{
    PageType = List;
    SourceTable = Instruction;
    Caption = 'Instructions';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Instruction Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the instruction code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the instruction.';
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
