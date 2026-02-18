tableextension 50533 "ONT Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(60103; "Model No."; Code[20])
        {
            Caption = 'Model No.';
            // FieldClass = FlowField;
            //CalcFormula = Lookup(Item."ModelNo" WHERE("No." = FIELD("No.")));
            Editable = false;
        }
        field(70100; "ONT Ref. Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = CustomerContent;
        }

        field(70101; "ONT Ref. Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.';
            DataClassification = CustomerContent;
        }
        field(70102; "ONT Item Reordering Policy"; enum "Reordering Policy")
        {
            Caption = 'Reordering Policy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(item."Reordering Policy" where("No." = field("No.")));
        }
        field(70103; "ONT Item Manufacturing Policy"; enum "Manufacturing Policy")
        {
            Caption = 'Manufacturing Policy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Manufacturing Policy" where("No." = field("No.")));
        }
        field(70104; "Planning Warning"; enum "Planning Warning")
        {
            DataClassification = ToBeClassified;
        }
        field(70105; "Main Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            Editable = false;
        }
        // field(90203; "Is Main Item"; Boolean)
        // {
        //     Caption = 'Is Main Item';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = exist("Item Components Variant" where("Main Item No." = field("No."), "Variant Code" = filter('<>''''')));
        // }
        field(90200; "Has Variant"; Boolean)
        {
            Caption = 'Has Variant';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Prod. Order Line" where("Prod. Order No." = field("Ref. Order No."), Status = field("Ref. Order Status"), "Variant Code" = filter('<>'''''), "Item No." = field("No.")));
        }
        field(90201; "Has Description2"; Boolean)
        {
            Caption = 'Has Description2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Prod. Order Line" where("Prod. Order No." = field("Ref. Order No.") /*, Status=field("Ref. Order Status")*/, "Description 2" = filter('<>'''''), "Item No." = field("No.")));
        }

        field(90204; "Production Order Line No."; Integer)
        {
            Caption = 'Production Order Line No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Prod. Order Line"."Line No." where("Prod. Order No." = field("Ref. Order No."), "Item No." = field("No."), "Variant Code" = field("Variant Code")));
        }
        field(90205; "Item Has Variant"; Boolean)
        {
            Caption = 'Item Has Variant';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Item Variant" where("Item No." = field("No."), Blocked = filter(false)));
        }
        field(90206; "Temp Variant Code"; Code[10])
        {
            Caption = 'Temp Variant Code';
            DataClassification = ToBeClassified;
        }
        // field(90207; "Ref. Sales Order No."; Code[20])
        // {
        //     Caption = 'Sales Order No.';
        //     DataClassification = ToBeClassified;
        // }

        // field(90209; "Ref. Sales Line No."; Integer)
        // {
        //     Caption = 'Sales Line No.';
        // }
        field(90210; "Item Reordering Policy"; enum "Reordering Policy")
        {
            Caption = 'Reordering Policy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(item."Reordering Policy" where("No." = field("No.")));
        }
        field(90211; "Item Manufacturing Policy"; enum "Manufacturing Policy")
        {
            Caption = 'Manufacturing Policy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(item."Manufacturing Policy" where("No." = field("No.")));
        }
        field(90213; "Order Tracking Lines"; Integer)
        {
            Caption = 'Order Tracking Lines';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Reservation Entry" where("Source ID" = field("Worksheet Template Name"), "Source Batch Name" = field("Journal Batch Name"), "Source Ref. No." = field("Line No."), "Item No." = field("No."), "Variant Code" = field("Variant Code")));
        }
        field(90214; "Projected Availability"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(90216; "Planning QTY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(90218; "Sales Order Line Item No."; Code[20])
        {
            Caption = 'Sales Order Line Item No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line"."No." where("Document No." = field("ONT Ref. Sales Order No."), "Line No." = field("ONT Ref. Sales Line No.")));
        }
        field(90219; "Unreserved Inventory"; Decimal)
        {
            Caption = 'Unreserved Inventory';
            Editable = false;
        }

        field(90220; "Unreserved Prod. Orders"; Decimal)
        {
            Caption = 'Unreserved Prod. Orders';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line".Quantity where("Item No." = field("No."),
                                    "Location Code" = field("Location Code"),
                                    "Variant Code" = field("Variant Code"),
                                    "Unit of Measure Code" = field("Unit of Measure Code"),
                                    "Reserved Quantity" = const(0),
                                    Status = filter(<> Finished),
                                    "Remaining Quantity" = filter(> 0)));
        }

        field(90223; "Reserved Inventory"; Decimal)
        {

        }
        field(90224; "Purchase Order Status"; Enum "Purchase Document Status")
        {
            Caption = 'Purchase Order Status';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header".Status where("No." = field("Ref. Order No.")));
        }

        field(90225; "Item Type"; enum "Item Type")
        {
            Caption = 'Item Type';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(item.Type where("No." = field("No.")));
        }
        field(90226; "Reschedule Direction"; enum "Reschedule Direction")
        {
            Caption = 'Reschedule Direction';
        }

        field(90227; "Order Multiple"; Decimal)
        {
            Caption = 'Order Multiple';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Order Multiple" where("No." = field("No.")));
        }

        field(90228; "Safety Stock Quantity"; Decimal)
        {
            Caption = 'Safety Stock Quantity';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Safety Stock Quantity" where("No." = field("No.")));
        }
        field(90232; "Item Reorder Quantity"; Decimal)
        {
            Caption = 'Reorder Quantity';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Reorder Quantity" where("No." = field("No.")));
        }
        field(90233; "SKU Reordering Policy"; enum "Reordering Policy")
        {
            Caption = ' SKUReordering Policy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Stockkeeping Unit"."Reordering Policy" where("Item No." = field("No."), "Location Code" = field("Location Code"), "Variant Code" = field("Variant Code")));
        }
        field(90234; "SKU Manufacturing Policy"; enum "Manufacturing Policy")
        {
            Caption = 'SKU Manufacturing Policy';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Stockkeeping Unit"."Manufacturing Policy" where("Item No." = field("No."), "Location Code" = field("Location Code"), "Variant Code" = field("Variant Code")));
        }
    }

}