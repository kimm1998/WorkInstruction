table 50513 "StandardCategoryDSF"
{
    TableType = Normal;
    Caption = 'Standard Category';
    LookupPageId = 50529;

    fields
    {
        field(1; StandardCategory; Code[20])
        {
            Caption = 'Standard Category';
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
        field(4; StandardSchema; Blob)
        {
            Caption = 'Standard Schema';
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
    }
    keys
    {
        key(PK; StandardCategory)
        {
            Clustered = true;
        }
    }
}
