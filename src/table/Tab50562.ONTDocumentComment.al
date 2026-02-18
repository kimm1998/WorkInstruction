table 50562 "Document Comment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(2; "Object Type"; Enum "Document Comment Type")
        {
            Caption = 'Object Type';
        }
        field(3; "Comment"; Text[1024])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(PK; "Language Code", "Object Type")
        {
            Clustered = true;
            // Unique combination of language + type
        }
    }
}