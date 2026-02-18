table 50539 "ONT Shipping Cost"
{
    DataClassification = CustomerContent;
    Caption = 'Shipping Cost Setup';
    LookupPageId = "ONT Shipping Costs";
    DrillDownPageId = "ONT Shipping Costs";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }

        // Updated TableRelation to point to the new Master Table
        field(2; "Country/Region Code"; Code[20])
        {
            Caption = 'Sales Market';
            TableRelation = "Country/Region".Code;
            NotBlank = true;
        }
        field(3; "Province Code"; Code[20])
        {
            Caption = 'Province Code';
        }

        // ... (Keep other fields RMH, Propulsion, etc. exactly as before) ...
        field(4; "Product Type"; code[50])
        {
            TableRelation = "ONT Family Product Type".Code;
        }
        field(5; "RMH Code"; Code[20])
        {
            Caption = 'RMH Code';
            TableRelation = rmhDSF;
        }
        field(6; "Propulsion Code"; Code[20])
        {
            Caption = 'Propulsion Code';
            TableRelation = PropulsionDSF;
        }
        field(7; "Segment Code"; Code[20])
        {
            Caption = 'Segment Code';
            TableRelation = BikeSegmentDSF;
        }
        field(8; "Is Kids Product"; Boolean)
        {
            Caption = 'Is Kids Product';
        }
        field(9; "Unit Shipping Fee"; Decimal)
        {
            Caption = 'Unit Shipping Fee';
            DecimalPlaces = 2 : 5;
            MinValue = 0;
        }
        field(10; "Free Shipping Min. Qty"; Integer)
        {
            Caption = 'Free Shipping Threshold (Qty)';
            MinValue = 0;
        }
        field(11; "Free Shipping Min. Amount"; Decimal)
        {
            Caption = 'Free Shipping Threshold ($)';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SearchKey; "Country/Region Code", "RMH Code", "Propulsion Code", "Segment Code", "Is Kids Product")
        {
        }
    }

    trigger OnInsert()
    begin
        Rec.TestField("Country/Region Code");
        Rec.TestField("Province Code");
    end;

    trigger OnModify()
    begin
        Rec.TestField("Country/Region Code");
        Rec.TestField("Province Code");
    end;
}