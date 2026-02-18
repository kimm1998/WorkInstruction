page 50572 "Multiple Payment Terms"
{
    ApplicationArea = All;
    Caption = 'Multiple Payment Terms';
    PageType = List;
    SourceTable = "Multiple Payment Terms";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("TTC %"; Rec."TTC %")
                {
                    ToolTip = 'Specifies the value of the TTC % field.';
                    ApplicationArea = All;
                }
                field("Total TTC %"; Rec."Total TTC %")
                {
                    ToolTip = 'Specifies the value of the Due Date Calculation field.';
                    ApplicationArea = All;
                }
                field("Due Date Calculation"; Rec."Due Date Calculation")
                {
                    ToolTip = 'Specifies the value of the Due Date Calculation field.';
                    ApplicationArea = All;
                }
                field("Selected"; Rec."Selected")
                {
                    ToolTip = 'Specifies the value of the Selected field.';
                    ApplicationArea = All;
                }
                field("Discount %"; Rec."Discount %")
                {
                    ApplicationArea = All;
                    Caption = 'Discount %';
                }
                field("Discount Date Calc."; Rec."Discount Date Calc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Discount Date Calculation field.';
                }
            }
        }
    }
}
