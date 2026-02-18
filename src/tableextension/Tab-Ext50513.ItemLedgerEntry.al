tableextension 50513 "Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(80000; "Revision No."; Code[3])
        {
            Caption = 'Revision No.';
            DataClassification = CustomerContent;
        }
        field(60103; "ONT Item Tracking Code"; Code[20])
        {
            Caption = 'Item Tracking Code (from Item)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."Item Tracking Code" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }


        field(60105; "ONT Child Maintenance Required"; Boolean)
        {
            Caption = 'Maintenance Required (Item Tracking Code)';
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Tracking Code"."ONT Maintenance Required" WHERE(Code = FIELD("ONT Item Tracking Code")));
            Editable = false;
        }
    }
}
