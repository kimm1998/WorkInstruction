enum 50554 "Document Comment Type"
{
    Caption = 'Document Comment Type';
    Extensible = true; // allow other extensions to add types later

    value(0; EcoFees)
    {
        Caption = 'EcoFees';
    }
    value(1; Interest)
    {
        Caption = 'Interest';
    }
    // Add more as business needs grow
}