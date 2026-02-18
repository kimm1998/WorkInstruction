table 50507 "VlsCityDSF"
{
    TableType = Normal;
    Caption = 'VLS City';
    LookupPageId = 50516;

    fields
    {
        field(1; CityNo; Code[4])
        {
            Caption = 'City No';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; CityNo)
        {
            Clustered = true;
        }
    }
}
