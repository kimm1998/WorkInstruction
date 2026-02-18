tableextension 50561 "ONT Purchase Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(70100; "ONT Sales Order No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70101; "ONT Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70102; "ONT Carrier"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }
        field(70103; "ONT Tracking Code"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70104; "ONT Reference"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70105; "ONT Comm. Sales Inv. No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}