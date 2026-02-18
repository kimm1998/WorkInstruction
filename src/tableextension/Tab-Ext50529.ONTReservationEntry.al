tableextension 50529 "ONT Reservation Entry" extends "Reservation Entry"
{
    fields
    {
        field(70100; "ONT Unit of Measure Code"; CODE[10])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Unit of Measure Code" where("Entry No." = FIELD("Source Ref. No.")));
        }
        field(70101; "ONT Related Source Type"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Reservation Entry"."Source Type" where("Entry No." = FIELD("Entry No."), Positive = const(false)));
        }
        field(70102; "ONT Related Source Subtype"; Option)
        {
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
            FieldClass = FlowField;
            CalcFormula = lookup("Reservation Entry"."Source Subtype" where("Entry No." = FIELD("Entry No."), Positive = const(false)));
        }
        field(70103; "ONT Related Source ID"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Reservation Entry"."Source ID" where("Entry No." = FIELD("Entry No."), Positive = const(false)));
        }
        field(70104; "ONT Related Source Ref. No."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Reservation Entry"."Source Ref. No." where("Entry No." = FIELD("Entry No."), Positive = const(false)));
        }
        field(70105; "ONT Related Src Prod Ord. Line"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Reservation Entry"."Source Prod. Order Line" where("Entry No." = FIELD("Entry No."), Positive = const(false)));
        }
    }
}
