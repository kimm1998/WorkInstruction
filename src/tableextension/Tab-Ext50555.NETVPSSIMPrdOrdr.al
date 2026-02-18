tableextension 50555 POExt extends "NETVPS SIMPrdOrdr"
{
    fields
    {

        field(60101; "ONT Original Due Date"; Date)
        {
            Caption = 'Original Due Date';
            DataClassification = CustomerContent;

        }
        field(60102; "ONT Total Quatity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line".Quantity where("Prod. Order No." = field("No."), Status = field(Status)));
        }
     }
}