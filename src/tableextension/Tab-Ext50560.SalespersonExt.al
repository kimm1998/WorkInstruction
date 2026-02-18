// 1. Salesperson Extension - Link to Vendor
tableextension 50560 "Salesperson Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50951; "Vendor No."; Code[20])
        {
            Caption = 'Commission Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
    }
}

