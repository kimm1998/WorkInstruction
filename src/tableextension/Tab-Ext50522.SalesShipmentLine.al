tableextension 50522 "Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(80000; "Requisition No."; Code[30])
        {
            Caption = 'Requisition No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
