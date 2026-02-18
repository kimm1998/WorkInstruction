table 50554 "OTG Demand Buffer"
{
    Caption = 'OTG Demand Buffer';
    DataClassification = CustomerContent;
    DrillDownPageId = "OTG Confirmed Demand";
    LookupPageId = "OTG Confirmed Demand";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(11; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(12; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(13; "Lot No."; Code[50]) { }
        field(14; "Serial No."; Code[50]) { }

        field(20; "Demand Date"; Date) { }
        field(21; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(28; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(29; "Source Type Table ID"; Integer) { }
        field(30; "Source Type"; Enum "OTG Demand Source") { }
        field(31; "Source No."; Code[20]) { }
        field(32; "Source Line No."; Integer) { }
        field(33; "Prod. Order Line No."; Integer) { }
        field(40; Priority; Integer)
        {
            Caption = 'Priority (1 = Highest)';
            InitValue = 100;
        }

        field(50; "Earliest Avail. Date"; Date)
        {
            Editable = false;
        }
        field(51; "Allocated Qty (Base)"; Decimal)
        {
            Editable = false;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("OTG Allocation Result"."Allocated Qty (Base)" where("Demand Entry No." = field("Entry No.")));
        }
        field(52; "Fully Allocated"; Boolean)
        {
            Editable = false;
        }
        field(53; "Reserved Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = - sum("Reservation Entry"."Quantity (Base)" where("Source ID" = field("Source No."),
                                                                            "Source Ref. No." = field("Source Line No."),
                                                                            "Source Type" = field("Source Type Table ID"),
                                                                            "Source Subtype" = field("Source Subtype"),
                                                                            "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(ItemKey; "Item No.", "Variant Code", "Location Code", "Demand Date") { }
        key(PriorityKey; Priority, "Demand Date") { }
    }
    trigger OnDelete()
    var
        AllocationResult: Record "OTG Allocation Result";
    begin
        AllocationResult.SetRange("Demand Entry No.", "Entry No.");
        AllocationResult.DeleteAll(true);
    end;
}
