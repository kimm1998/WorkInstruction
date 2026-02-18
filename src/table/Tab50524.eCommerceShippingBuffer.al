table 50524 "eCommerce Shipping Buffer"
{
    Caption = 'eCommerce Shipping Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Days to shipping"; integer)
        {
            Caption = 'Days to shipping';
            DataClassification = CustomerContent;
        }
        field(2; "Buffer Days"; integer)
        {
            Caption = 'Buffer Days';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Days to shipping")
        {
            Clustered = true;
        }
    }
}
