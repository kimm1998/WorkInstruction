table 50557 "Auto Receive Location Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "From Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(2; "To Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(3; "Auto Receive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Override Bin"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("To Location"));
        }
        field(5; "Receipt Bin Policy"; Enum "Auto Receive Bin Policy")
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Bin Policy';
        }
    }

    keys
    {
        key(Key1; "From Location", "To Location")
        {
            Clustered = true;
        }
    }
}