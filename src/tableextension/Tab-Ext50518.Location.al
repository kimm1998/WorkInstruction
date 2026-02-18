tableextension 50518 "Location" extends Location
{
    fields
    {
        field(80000; "Auto Create Wrhs Recpt"; boolean)
        {
            Caption = 'Auto Create Warehouse Recpt';
            DataClassification = CustomerContent;
        }
        field(80001; "Auto EDI Release"; boolean)
        {
            Caption = 'Auto EDI Release';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Rec.TestField();
            end;
        }
    }
}
