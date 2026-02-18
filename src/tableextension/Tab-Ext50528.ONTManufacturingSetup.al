tableextension 50528 "ONT Manufacturing Setup" extends "Manufacturing Setup"
{
    fields
    {
        field(70100; "ONT Rele. Ord Print Batch Nos."; Code[20])
        {
            Caption = 'Released Order Print Batch Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70101; "ONT Release Shortages"; Boolean)
        {
            Caption = 'Release Orders with Shortages';
            DataClassification = CustomerContent;
        }
    }
}