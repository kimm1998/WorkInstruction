tableextension 50507 "Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(80001; "Sales Order Type"; Text[250])
        {
            Caption = 'Sales Order Type';
            DataClassification = CustomerContent;
        }
        field(80002; "Sent By Email"; Boolean)
        {
            Caption = 'Sent By Email';
            DataClassification = CustomerContent;
        }
        field(80003; "Shipping Formula"; Enum "ONT Shipping Formula")
        { }
        field(80004; "Salesman commission %"; Decimal)
        {
        }
        field(50951; "Commission Paid"; Boolean)
        {
            Caption = 'Commission Paid';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50952; "Comm. Purch. Inv. No."; Code[20])
        {
            Caption = 'Commission Purchase Inv. No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50953; "Commission Amount Paid"; Decimal)
        {
            Caption = 'Commission Amount Paid';
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
}
