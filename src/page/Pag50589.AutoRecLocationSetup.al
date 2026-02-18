page 50589 "Auto Rec. Location Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Receive Location Setup";
    Caption = 'Auto Receive Location Setup';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = all;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = all;
                }
                field("Receipt Bin Policy"; Rec."Receipt Bin Policy")
                {
                    ApplicationArea = all;
                }
                field("Override Bin"; Rec."Override Bin")
                {
                    ApplicationArea = all;

                }
                field("Auto Receive"; Rec."Auto Receive")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


}