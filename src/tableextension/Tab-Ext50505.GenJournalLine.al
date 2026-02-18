tableextension 50505 "Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(80006; "Multiple Payment Code"; Code[10])
        {
            Caption = 'Multiple Payment Code';
            DataClassification = CustomerContent;
            TableRelation = "Multiple Payment Terms";
        }
    }
}
