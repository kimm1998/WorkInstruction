table 50502 "SizesDSF"
{
    TableType = Normal;
    Caption = 'Sizes';
    LookupPageId = 50505;

    fields
    {
        field(1; Size; Code[20])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Size)
        {
            Clustered = true;
        }
    }
}
