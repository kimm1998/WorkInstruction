table 50555 "OTG Supply Buffer"
{
    Caption = 'OTG Supply Buffer (Temp)';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer) { }
        field(10; "Item No."; Code[20]) { }
        field(11; "Variant Code"; Code[10]) { }
        field(12; "Location Code"; Code[10]) { }
        field(13; "Lot No."; Code[50]) { }
        field(14; "Serial No."; Code[50]) { }

        field(20; "Item Ledger Entry No."; Integer) { }
        field(30; "Available Qty (Base)"; Decimal) { DecimalPlaces = 0 : 5; }
        field(40; "Avail. Date"; Date) { }

        // Drill-down metadata
        field(90; "Source Type"; Enum "OTG Supply Source") { }
        field(91; "Source Table ID"; Integer) { }
        field(92; "Document Type Int"; Integer) { Caption = 'Document Type (Int)'; }
        field(93; "Document No."; Code[20]) { }
        field(94; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }

    keys
    {
        key(PK; "Line No.") { Clustered = true; }
        key(ItemKey; "Item No.", "Variant Code", "Location Code", "Lot No.", "Serial No.") { }
        key(AvailDateKey; "Avail. Date") { } // used by SetCurrentKey("Avail. Date")
    }
}
