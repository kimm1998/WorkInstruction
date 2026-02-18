table 50540 ONT_ItemAvailabilityBuffer
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer) { Caption = 'Entry No.'; }
        field(2; "Item No."; Code[20]) { Caption = 'Item No.'; }
        field(3; "Date"; Date) { Caption = 'Date'; }

        // 1) Type of line details
        field(4; "Source Type"; Option) { Caption = 'Source Type'; OptionMembers = "Inventory","Purchase","Sales","Production"; }
        field(5; "Source ID"; Code[20]) { Caption = 'Document No.'; }
        field(6; "Description"; Text[100]) { Caption = 'Description'; }

        // 3) & 4) Supply and Demand
        field(10; "Qty. In"; Decimal) { Caption = 'In (Supply)'; }
        field(11; "Qty. Out"; Decimal) { Caption = 'Out (Demand)'; }

        // 5) Availability at Date (Running Balance)
        field(12; "Availability"; Decimal) { Caption = 'Availability at Date'; }

        // 6) Min Available until Next IN
        field(13; "Min. Avail. Next In"; Decimal) { Caption = 'Min Available until Next IN'; }

        // 7) Min Available until End
        field(14; "Min. Avail. End"; Decimal) { Caption = 'Min Available to End'; }
    }

    keys
    {
        key(PK; "Item No.", "Entry No.") { Clustered = true; }
        key(Sort; "Item No.", Date) { } // Crucial for sorting by date
    }
}