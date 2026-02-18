tableextension 50531 "ONT Sales Line" extends "Sales Line"
{
    fields
    {
        field(70100; "ONT Avilable At Location"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Location Code" = FIELD("Location Code")));
        }
        field(70101; "ONT Production Orders"; Integer)
        {
            Caption = 'Production Orders';
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where("ONT Sales Order No." = field("Document No."), "ONT Sales Line No." = field("Line No.")));
        }
        field(70102; "ONT Item Reordering Policy"; enum "Reordering Policy")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Reordering Policy" where("No." = field("No.")));
        }
        field(70103; "ONT Auto Reserve DateFormula"; DateFormula)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Location."ONT Auto Reserve DateFormula" where("Code" = field("Location Code")));
        }
        field(70104; "ONT Reserved From Inventory"; Decimal)
        {
        }
        field(70105; "Avilable Quantity"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No.")));
        }
        field(70106; "Item Category"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" where("No." = field("No.")));
        }
        field(70107; "Qty. on Purch. Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No."),
                                                                               "Location Code" = FIELD("Location Code"),
                                                                               "Variant Code" = FIELD("Variant Code")));
            Caption = 'Qty. on Purch. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70108; "Qty. on Prod. Order"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE(Status = FILTER(Planned .. Released),
                                                                                "Item No." = FIELD("No."),
                                                                                "Location Code" = FIELD("Location Code"),
                                                                                "Variant Code" = FIELD("Variant Code")));
            Caption = 'Qty. on Prod. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70109; "Avilable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70110; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Variant Code" = FIELD("Variant Code")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

        }
        field(70111; "ONT Sales Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "ONT Purchasing Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "ONT Planning Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70114; "ONT Whse. Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Warehouse Special Instruction';
        }
        field(70115; "ONT Purch. Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Special Instruction';
        }
        field(70116; "ONT Prod. Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Special Instruction';
        }
    }

}