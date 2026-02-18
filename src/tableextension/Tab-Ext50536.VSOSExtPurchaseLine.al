tableextension 50536 "VSOSExtPurchaseLine" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "Production Notes"; Text[100])
        {
            Caption = 'Production Notes';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70101; "ONT Sales Order No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order No.';
        }
        field(70102; "ONT Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order Line No.';
        }
        field(70103; "ONT Number of Cartons"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Cartons';
        }
        field(70104; "ONT Country of Origin"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            Caption = 'Country of Origin';
        }
        field(70105; "ONT New ETA"; date)
        {
            DataClassification = ToBeClassified;
            Caption = 'New ETA';
        }
        field(70106; "ONT ETA Notes"; text[2000])
        {
            Caption = 'ETA Notes';
            DataClassification = ToBeClassified;
        }
        field(70114; "ONT Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Warehouse Special Instruction';
        }
        field(70115; PrintLabelReceive; Boolean)
        { }

    }
}
