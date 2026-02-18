tableextension 50506 "Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(80006; "Multiple Payment Code"; Code[10])
        {
            Caption = 'Multiple Payment Code';
            DataClassification = CustomerContent;
            TableRelation = "Multiple Payment Terms";
        }
    }
}
