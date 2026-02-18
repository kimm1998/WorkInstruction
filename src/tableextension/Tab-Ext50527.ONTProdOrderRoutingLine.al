tableextension 50527 "ONT Prod. Order Routing Line" extends "Prod. Order Routing Line"
{
    fields
    {
        field(90200; "ONT Total Posted Setup Time"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Capacity Ledger Entry"."Setup Time" where("No." = field("Prod. Order No.")));
        }
        field(90201; "ONT Total Posted Run Time"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Capacity Ledger Entry"."Run Time" where("No." = field("Prod. Order No.")));
        }
        field(90202; "ONT Output Qty"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Capacity Ledger Entry"."Output Quantity" where("Order No." = FIELD("Prod. Order No."), "Order Type" = CONST(Production),
                                                                                "Operation No." = FIELD("Operation No."), "Work Center No." = FIELD("Work Center No.")));
        }
        field(90203; "ONT Priority"; Enum "ONT Order Priority")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."ONT Priority" where(Status = field(Status), "No." = field("Prod. Order No.")));
            Editable = false;
        }
    }

}