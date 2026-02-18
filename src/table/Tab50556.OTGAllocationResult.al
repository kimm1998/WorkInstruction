table 50556 "OTG Allocation Result"
{
    Caption = 'OTG Allocation Result';
    DataClassification = CustomerContent;
    DrillDownPageId = "OTG Allocation Results";
    LookupPageId = "OTG Allocation Results";

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(10; "Demand Entry No."; Integer)
        {
            TableRelation = "OTG Demand Buffer"."Entry No.";
        }
        field(20; "Item Ledger Entry No."; Integer) { TableRelation = "Item Ledger Entry"."Entry No."; }
        field(30; "Allocated Qty (Base)"; Decimal) { DecimalPlaces = 0 : 5; }
        field(40; "Allocation DateTime"; DateTime) { }
        field(50; "Supply Avail. Date"; Date) { Caption = 'Supply Available Date'; }

        // Drill-down keys
        field(90; "Source Type"; Enum "OTG Supply Source") { }
        field(91; "Source Table ID"; Integer) { }
        field(92; "Document Type Int"; Integer) { Caption = 'Document Type (Int)'; }
        field(93; "Document No."; Code[20]) { }
        field(94; "Document Line No."; Integer) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(DemandKey; "Demand Entry No.") { }
        key(DemandSrc; "Demand Entry No.", "Source Type") { }
    }
}
