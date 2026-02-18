tableextension 50544 "ONT Prod. Order Header Ext" extends "Production Order"
{
    fields
    {
        field(60100; "ONT Demand Forecast"; Code[10])
        {
            Caption = 'From Demand Forecast';
            DataClassification = CustomerContent;
            tablerelation = "Production Forecast Name";
        }
        field(60101; "ONT Original Due Date"; Date)
        {
            Caption = 'Original Due Date';
            ToolTip = 'Specifies the due date of the production order at the moment it has been created. If the production order had been created from the planification worksheet, the original due date is based on the Demand Forecast due date.';
        }
        field(60102; "Total Quatity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line".Quantity where("Prod. Order No." = field("No."), Status = field(Status)));
        }
    }
}
