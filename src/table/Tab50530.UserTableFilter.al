table 50530 "User Table Filter"
{
    DataClassification = ToBeClassified;
    Caption = 'User Table Filter';
 
    fields
    {
 
 
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
 
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(3; "Filter Code"; Code[20])
        {
            Caption = 'Filter Code';
            TableRelation = "List Filter"."Filter Code" WHERE("Table ID" = FIELD("Table ID"));
        }
    }
 
    keys
    {
        key(PK; "User ID", "Table ID")
        {
            Clustered = true;
        }
    }
}