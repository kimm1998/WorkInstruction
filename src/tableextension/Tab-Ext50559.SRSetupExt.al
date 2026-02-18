tableextension 50559 "S&R Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50951; "Commission Expense Acc."; Code[20])
        {
            Caption = 'Commission Expense Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
    }
}