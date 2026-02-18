tableextension 50532 "ONT Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(70100; "ONT Availability Status"; Enum "ONT Availability Status")
        {
            InitValue = " ";
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70101; "ONT Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."ONT Sales Order No." Where(Status = field(Status), "No." = field("Prod. Order No.")));
        }
        field(70102; "ONT Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."ONT Sales Line No." Where(Status = field(Status), "No." = field("Prod. Order No.")));
        }
        field(70103; "ONT Current Operation"; Text[100])
        {
            Caption = 'Current Operation';
            FieldClass = FlowField;
            CalcFormula = lookup("Prod. Order Routing Line".Description where("Prod. Order No." = field("Prod. Order No."), Status = field("Status"), "Routing Status" = const(2)));
        }
        field(70104; "ONT Remaining Consumption"; Decimal)
        {
            Caption = 'Remaining Consumption';
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Component"."Remaining Quantity" where("Prod. Order No." = field("Prod. Order No."), Status = field(Status), "Prod. Order Line No." = field("Line No.")));
        }
        field(70105; "Shortcut Dimension 3 Code_1"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Project Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), Blocked = CONST(false));
            CalcFormula = Lookup("Dimension Set Entry"."Dimension Value Code" WHERE("Dimension Set ID" = FIELD("Dimension Set ID"), "Global Dimension No." = const(3)));
        }
        field(70106; "ONT Prod Order Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70107; "ONT Planning Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70108; "ONT Purchasing Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70109; "ONT Yield"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70110; "ONT Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Special Instruction';
        }
    }
}