table 50515 "SalesPeriodDSF"
{
    TableType = Normal;
    Caption = 'Sales period';
    LookupPageId = 50535;

    fields
    {
        field(1; Period; Code[7])
        {
            Caption = 'Period';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Actif; Boolean)
        {
            Caption = 'Actif';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Period)
        {
            Clustered = true;
        }
    }
}
