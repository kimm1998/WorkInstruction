page 50543 "Item Status"
{
    PageType = List;
    Caption = 'Item Status';
    ApplicationArea = Basic, Suite;
    SourceTable = "Item Status";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Blocked (Any transaction)"; Rec."Blocked (Any transaction)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked (Any transaction) field.';
                }
                field("Blocked Purchase"; Rec."Blocked Purchase")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked Purchase field.';
                }
                field("Blocked Sales"; Rec."Blocked Sales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked Sales field.';
                }
            }
        }
    }
}
