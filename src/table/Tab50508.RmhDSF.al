table 50508 "RmhDSF"
{
    TableType = Normal;
    Caption = 'RMH';
    LookupPageId = 50518;

    fields
    {
        field(1; Rmh; Code[20])
        {
            Caption = 'RMH';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
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
        key(PK; Rmh)
        {
            Clustered = true;
        }
    }
}
