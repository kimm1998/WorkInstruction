tableextension 50530 "ONT Sales Header" extends "Sales Header"
{
    fields
    {
        field(70100; "ONT Has Outstanding Qty Line"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Outstanding Quantity" = filter('<>0')));
        }
        field(70101; AvailabilityStatusIcon; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "Availability Status"; Enum "ONT Availability Status")
        {
        }
        field(70103; "Avialable Exist"; Boolean)
        {
            Caption = 'Avialable Exist';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), Type = CONST(Item), Avilable = CONST(true)));
        }
        field(70104; "Unavialable Exist"; Boolean)
        {
            Caption = 'Unavialable Exist';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), Type = CONST(Item), Avilable = CONST(false)));
        }
        field(70105; "Shipping Instructions"; Text[200])
        {
            Caption = 'Shipping Instructions';
            DataClassification = ToBeClassified;
        }
        field(70106; "Shipping Notes"; Text[200])
        {
            Caption = 'Shipping Notes';
            DataClassification = ToBeClassified;
        }
        field(70107; "Sell-to Mobile No."; Text[30])
        {
            Caption = 'Sell-to Mobile No.';
            ExtendedDatatype = PhoneNo;
        }
        field(70108; "Ship-to Mobile No."; Text[30])
        {
            Caption = 'Ship-to Mobile No.';
            ExtendedDatatype = PhoneNo;
        }

        field(70110; "ONT Sales Notes"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70111; "ONT Planning Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70112; "ONT Purchasing Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(70113; "ONT Cancelled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70114; "ONT Delayed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70129; "ONT Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Special Instruction';
        }
        field(70130; "Sales Order Blocked"; boolean)
        {
            Caption = 'Blocked';
            Editable = false;
        }
        field(70131; "ONT Block Reason"; Code[20])
        {
            Caption = 'Block Reason';
            TableRelation = "On Hold Reason".Code;
            DataClassification = ToBeClassified;
        }
        field(70132; "ONT No overright"; Boolean)
        {
            DataClassification = ToBeClassified;
            caption = 'No Over right';
        }

        modify("Sell-to County")
        {
            TableRelation = Territory;
        }
        modify("Bill-to County")
        {
            TableRelation = Territory;
        }
        modify("Ship-to County")
        {
            TableRelation = Territory;
        }


    }
}