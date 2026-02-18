page 50549 "ONT Job Queue FactBox"
{
    Caption = 'Job Queue';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Job Queue Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Job Queue Log Entries';
                field("Object Caption to Run"; Rec."Object Caption to Run")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Queue Desc.';
                    ToolTip = 'Specifies the job queue description.';
                    Lookup = true;
                }
                field("ONT Last Succ. Run"; Rec."ONT Last Succ. Run")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Last Success Run';
                    ToolTip = 'Specifies the last date/time the job queue ran successfully.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Object ID to Run", '=50111|50101');
        Rec.FindLast();
    end;
}