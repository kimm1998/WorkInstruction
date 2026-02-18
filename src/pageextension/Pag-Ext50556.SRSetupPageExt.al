// 2. S&R Setup - Add G/L Config
pageextension 50556 "S&R Setup Page Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Commission Expense Acc."; Rec."Commission Expense Acc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the G/L Account used for creating Commission Purchase Invoices.';
            }
        }
    }
}