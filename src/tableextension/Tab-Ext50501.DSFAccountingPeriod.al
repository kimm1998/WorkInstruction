tableextension 50501 "DSFAccounting_Period" extends "Accounting Period"
{
    fields
    {
        field(50500; "SalesPeriod"; Code[7])
        {
            Caption = 'Sales Period';
            DataClassification = ToBeClassified;
            TableRelation = SalesPeriodDSF.Period;
        }
    }
}
