pageextension 50521 "LocationCard" extends "Location Card"
{
    layout
    {
        addafter("Provincial Tax Area Code")
        {
            field("Auto Create Warehouse Recpt"; Rec."Auto Create Wrhs Recpt")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto Create Warehouse Recpt field.';
            }
        }
        addlast(ElectronicDocument)
        {
            field("Auto EDI Release"; Rec."Auto EDI Release")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto EDI Release field.';
            }
        }
    }
}
