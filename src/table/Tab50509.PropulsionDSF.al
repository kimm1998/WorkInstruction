table 50509 "PropulsionDSF"
{
    TableType = Normal;
    Caption = 'Propulsion';
    LookupPageId = 50520;

    fields
    {
        field(1; Propulsion; Code[20])
        {
            Caption = 'Propulsion';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[100])
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
        key(PK; Propulsion)
        {
            Clustered = true;
        }
    }
}
