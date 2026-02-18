table 50559 "On Hold Reason"
{
    Caption = 'On Hold Reason';
    DataClassification = ToBeClassified;
    LookupPageId = "On Hold Reasons";
    DrillDownPageId = "On Hold Reasons";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
