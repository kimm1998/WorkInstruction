table 50533 "ONT Family Forecast Setup"
{
    Caption = 'Family Forecast Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(60100; "Primary Key"; Integer) { AutoIncrement = true; }
        field(60101; "Distribution Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionMembers = Equal,WeightByItem;
            OptionCaption = 'Equal Share,Weight by Item';
        }
        field(60102; "Include Blocked Items"; Boolean)
        {
            Caption = 'Include Blocked Items';
        }
        field(60103; "Filter to Inventory Items"; Boolean)
        {
            Caption = 'Only Type = Inventory';
            InitValue = true;
        }
    }

    keys { key(PK; "Primary Key") { Clustered = true; } }
}