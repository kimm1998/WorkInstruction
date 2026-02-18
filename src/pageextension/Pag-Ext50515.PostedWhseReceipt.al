pageextension 50515 "Posted Whse. Receipt" extends "Posted Whse. Receipt"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(7318), "No." = field("No.");
            }
        }
    }
}
