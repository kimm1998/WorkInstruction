table 50519 "Item Status"
{
    DataClassification = CustomerContent;
    Caption = 'Item Status';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Blocked (Any transaction)"; Boolean)
        {
            Caption = 'Blocked (Any transaction)';
            DataClassification = CustomerContent;
        }
        field(4; "Blocked Purchase"; Boolean)
        {
            Caption = 'Blocked Purchase';
            DataClassification = CustomerContent;
        }
        field(5; "Blocked Sales"; Boolean)
        {
            Caption = 'Blocked Sales';
            DataClassification = CustomerContent;
        }
        field(6; "Type"; Text[20])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(pk; "Code")
        {
            Clustered = true;
        }
    }
}
