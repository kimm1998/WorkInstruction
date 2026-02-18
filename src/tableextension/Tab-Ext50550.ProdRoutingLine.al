tableextension 50550 "Prod Routing Line" extends "Prod. Order Routing Line"
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
        // field(80752; "ONT Output Quantity"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = sum("Capacity Ledger Entry"."Output Quantity" where("Order Type" = const(Production), "Order No." = field("Prod. Order No."), "Order Line No." = field("Routing Reference No."), "Operation No." = field("Operation No."), Type = field(Type), "No." = field("No.")));
        //     Editable = false;
        // }
    }
}
