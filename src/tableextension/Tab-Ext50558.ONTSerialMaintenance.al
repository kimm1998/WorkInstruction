tableextension 50558 "ONT Serial Maintenance" extends "Serial No. Information"
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
                                    "Serial No." = field("Serial No."),
                                    "Location Code" = field("Location Filter"),
                                    Open = const(true),
                                    Positive = const(true)));
        }
        field(60102; "ONT Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            ToolTip = 'Expiration date recorded at the Serial level.';
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
            CalcFormula = Lookup("Item Tracking Code"."Use Expiration Dates" WHERE(Code = FIELD("ONT Child Item Tracking Code")));
            Editable = false;
        }
        field(60105; "ONT Maintenance Required"; Boolean)
        {
            Caption = 'Maintenance Required (Item Tracking Code)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."ONT Maintenance Required" WHERE(Code = FIELD("ONT Child Item Tracking Code")));
            Editable = false;
        }
        field(60106; "ONT Next Maintenance Date"; Date)
        {

        }




        field(60107; "ONT Child Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60108; "ONT Child Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60109; "ONT Child Last maintenace Date"; date)
        {
            Caption = 'Child Last Maintenance Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date the lot was last serviced (e.g., battery recharged).';
        }


        field(60112; "ONT Child Maintenance Interval"; DateFormula)
        {
            Caption = 'Child Maintenance Interval (Override)';
            ToolTip = 'Overrides the Child Item default maintenance interval for this lot.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."ONT Maintenance Interval" WHERE(Code = FIELD("ONT Child Item Tracking Code")));
            Editable = false;
        }

        field(60113; "ONT Child Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            ToolTip = 'Expiration date recorded at the Serial level.';
            Editable = false;
        }
        field(60114; "ONT Child Item Tracking Code"; Code[20])
        {
            Caption = 'Item Tracking Code (from Item)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."Item Tracking Code" WHERE("No." = FIELD("ONT Child Item No.")));
            Editable = false;
        }

        field(60115; "ONT Use Child Expiration Dates"; Boolean)
        {
            Caption = 'Use Expiration Dates (Item Tracking Code)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."Use Expiration Dates" WHERE(Code = FIELD("ONT Child Item Tracking Code")));
            Editable = false;
        }
        field(60116; "ONT Child Maintenance Required"; Boolean)
        {
            Caption = 'Maintenance Required (Item Tracking Code)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."ONT Maintenance Required" WHERE(Code = FIELD("ONT Child Item Tracking Code")));
            Editable = false;
        }
        field(60117; "ONT Child Next Maint. Date"; Date)
        {

        }
    }
}
