table 50538 "ONT HS Market"
{
    DataClassification = CustomerContent;
    Caption = 'HS Market';
    LookupPageId = "ONT HS Markets";
    DrillDownPageId = "ONT HS Markets";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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
