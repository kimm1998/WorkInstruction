table 50506 "BikeSegmentDSF"
{
    TableType = Normal;
    Caption = 'Bike Segment';
    LookupPageId = 50514;

    fields
    {
        field(1; Segment; Code[20])
        {
            Caption = 'Segment';
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
        field(4; Actif; Boolean)
        {
            Caption = 'Actif';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Segment)
        {
            Clustered = true;
        }
    }
}
