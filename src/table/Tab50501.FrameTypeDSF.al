table 50501 "FrameTypeDSF"
{
    TableType = Normal;
    Caption = 'Frame type';
    LookupPageId = 50503;

    fields
    {
        field(1; Type; Code[20])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[60])
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
        key(PK; Type)
        {
            Clustered = true;
        }
    }
}
