page 50597 "Instruction Card"
{
    PageType = Card;
    SourceTable = Instruction;
    Caption = 'Instruction Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
