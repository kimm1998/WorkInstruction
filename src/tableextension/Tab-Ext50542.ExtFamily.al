tableextension 50542 "Ext Family" extends Family
{
    fields
    {
        field(60100; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(60101; "Distrubution Type"; Option)
        {
            OptionCaption = 'Quantity,Percentage';
            OptionMembers = "Quantity","Percentage";
        }
    }
}
