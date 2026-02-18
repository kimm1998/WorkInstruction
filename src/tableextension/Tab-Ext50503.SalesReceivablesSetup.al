tableextension 50503 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(80000; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }
        field(80001; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
            DataClassification = CustomerContent;
        }
        field(80005; "Azure Account Key"; Text[1024])
        {
            DataClassification = CustomerContent;
            Caption = 'Azure Account Key';
        }
        field(80006; "Product Folder Location"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Folder Location';
        }
        field(80007; "Attribute Folder Location"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Attribute Folder Location';
        }
        field(80008; "Azure Account Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Azure Account Name';
        }
        field(80009; "Sales Inv File Network"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales invoices File Network';
        }
        field(80010; "Block Reason Code"; Code[20])
        {
            Caption = 'Block Reason Code';
            TableRelation = "On Hold Reason".Code;
            DataClassification = CustomerContent;
        }
        field(80011; "Freight Item No."; Code[20])
        {
            Caption = 'Freight Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
    }
}
