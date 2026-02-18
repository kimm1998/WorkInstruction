tableextension 50563 "Planning Routing Line" extends "Planning Routing Line"
{
    fields
    {
        field(80751; "ONT Subcontractor No."; Code[20])
        {
            Caption = 'Subcontractor No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Work Center"."Subcontractor No." where("No." = field("Work Center No.")));
        }
    }
}