table 50529 "List Filter"
{
    Caption = 'List Filter';
    DataClassification = ToBeClassified;
 
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            trigger OnValidate()
            begin
                rec."Table Name" := GetTableName("Table ID");
            end;
        }
        field(2; "Filter Code"; Code[20])
        {
            Caption = 'Filter Code';
        }
        field(3; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(4; Filter; Text[2048])
        {
            Caption = 'Filter';
        }
        field(6; "Table Name"; Text[100])
        {
            Caption = 'Table Name';
            Editable = false;
        }
    }
 
    keys
    {
        key(PK; "Table ID", "Filter Code")
        {
            Clustered = true;
        }
    }
 
    procedure GetTableName(TableID: Integer): Text[100]
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        if AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Table, TableID) then
            exit(AllObjWithCaption."Object Name");
        exit(''); // Return empty if Table ID is not found
    end;
}