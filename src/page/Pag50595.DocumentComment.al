page 50595 "Document Comments"
{
    PageType = List;
    SourceTable = "Document Comment";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Document Comments';

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Language identifier used to match a customer''s language. The system looks up comments using this value.';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'The document or object type this comment applies to.';
                }
                field(Comment; Rec.Comment)
                {
                    Caption = 'Comment';
                    ApplicationArea = All;
                    ToolTip = 'Localized text to print or show on reports/documents.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // optional import/export actions, if needed later
        }
    }
}