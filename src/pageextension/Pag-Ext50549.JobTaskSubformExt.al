pageextension 50549 JobTaskSubformExt extends "Job Task Lines Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Job Task Type")
        {

            field(Admissible; Rec."Admissible")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Admissible field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}