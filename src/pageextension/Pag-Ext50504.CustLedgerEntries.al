pageextension 50504 "Cust. Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Payment Method Code")
        {
            field("Multiple Payment Code"; Rec."Multiple Payment Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
