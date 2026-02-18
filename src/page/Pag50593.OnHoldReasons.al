page 50593 "On Hold Reasons"
{
    PageType = List;
    SourceTable = "On Hold Reason";
    Caption = 'On Hold Reasons';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
