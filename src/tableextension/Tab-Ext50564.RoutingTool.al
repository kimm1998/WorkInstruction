tableextension 50564 "Routing Tool Extension" extends "Routing Tool"
{
    fields
    {
        field(50500; "Type"; Enum "Routing Tool Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            InitValue = Item;

            trigger OnValidate()
            begin
                // Clear the No. field when Type changes to avoid invalid references
                if "Type" <> xRec."Type" then
                    "No." := '';
            end;
        }

        modify("No.")
        {
            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const(Instruction)) Instruction;
        }
    }
}
