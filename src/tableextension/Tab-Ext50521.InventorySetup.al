tableextension 50521 "Inventory Setup" extends "Inventory Setup"
{
    fields
    {
        field(80000; "Web Inventory Location"; code[10])
        {
            Caption = 'Web Inventory Location';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(80001; "ONT Family Nos."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Family Nos';
        }
        field(80002;"Family Product Type Code";Code[50])
        {
            Caption = 'Family Product Type Code';
            DataClassification = CustomerContent;
            TableRelation = "ONT Family Product Type".Code;
        }
    }
}
