tableextension 50551 "ONT Lot Maintenance" extends "Lot No. Information"
{
    fields
    {
        field(60100; "ONT Last Maintenance Date"; Date)
        {
            Caption = 'Last Maintenance Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date the lot was last serviced (e.g., battery recharged).';
        }
        field(60101; "ONT Maintenance Interval"; DateFormula)
        {
            Caption = 'Maintenance Interval (Override)';
            ToolTip = 'Overrides the Item default maintenance interval for this lot.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."ONT Maintenance Interval" WHERE(Code = FIELD("ONT Item Tracking Code")));
            Editable = false;
        }
        field(60110; "ONT On Hand (Base)"; Decimal)
        {
            Caption = 'On Hand (Base)';
            FieldClass = FlowField;
            Editable = false;
            DecimalPlaces = 0 : 5;
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity"
                              where("Item No." = field("Item No."),
                                    "Variant Code" = field("Variant Code"),
                                    "Lot No." = field("Lot No."),
                                    "Location Code" = field("Location Filter"),
                                    Open = const(true),
                                    Positive = const(true)));
        }
        field(60102; "ONT Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            ToolTip = 'Expiration date recorded at the lot level.';
            Editable = false;
        }
        field(60103; "ONT Item Tracking Code"; Code[20])
        {
            Caption = 'Item Tracking Code (from Item)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."Item Tracking Code" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }

        field(60104; "ONT Use Expiration Dates"; Boolean)
        {
            Caption = 'Use Expiration Dates (Item Tracking Code)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."Use Expiration Dates" WHERE(Code = FIELD("ONT Item Tracking Code")));
            Editable = false;
        }
        field(60105; "ONT Maintenance Required"; Boolean)
        {
            Caption = 'Maintenance Required (Item Tracking Code)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."ONT Maintenance Required" WHERE(Code = FIELD("ONT Item Tracking Code")));
            Editable = false;
        }
        field(60106; "ONT Next Maintenance Date"; Date)
        {

        }
    }
}
