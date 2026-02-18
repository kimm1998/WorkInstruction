page 50544 "Import Routes"
{
    ApplicationArea = All;
    Caption = 'Import Routes';
    PageType = List;
    SourceTable = "Import Route";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Transit Delay"; Rec."Transit Delay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transit time of the local carrier to bring the goods to the final warehouse of planned reception. Does NOT include the time from the point of departure to the destination (Sea or rail end) Transit time = End of sea or rail journey until receiving warehouse.';
                }
            }
        }
    }
}
