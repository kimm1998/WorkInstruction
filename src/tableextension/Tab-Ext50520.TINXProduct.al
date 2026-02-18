tableextension 50520 "TINX Product" extends "TINX Product"
{
    fields
    {
        field(80000; "Available Inventory"; Decimal)
        {
            Caption = 'Available Inventory';
            DataClassification = SystemMetadata;
        }
        field(80001; "Next Replenishment Date"; Date)
        {
            Caption = 'Next Replenishment Date';
            DataClassification = SystemMetadata;
        }
    }
}
