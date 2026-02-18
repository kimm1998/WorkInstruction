tableextension 50502 "DSFRequisition_Line" extends "Requisition Line"
{
    fields
    {
        field(50510; "EraItemStatusDesc"; Text[200])
        {
            Caption = 'Item status desc.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Item."Item Status Desc." where("No." = field("No.")));
        }
        field(50511; "BuAssignment"; Code[20])
        {
            Caption = 'BuAssignment';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Item.BuAssignment where("No." = field("No.")));
        }
        field(50512; "FactoryDepartment"; Option)
        {
            Caption = 'FactoryDepartment';
            FieldClass = FlowField;
            OptionMembers = " ","Painting"," Manufacturing"," Assembly"," Supply";
            Editable = false;
            CalcFormula = lookup(Item.FactoryDepartment where("No." = field("No.")));
        }
    }
}
