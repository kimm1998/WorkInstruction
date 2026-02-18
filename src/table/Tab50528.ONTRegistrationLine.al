table 50528 "ONT Registration Line"
{
    Caption = 'OnTarget Group Apps';
    Access = Internal;

    fields
    {
        field(1; "Client tenant ID"; Text[2048])
        {
            Caption = 'Client tenant ID';
            DataClassification = SystemMetadata;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(3; "ID"; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        field(4; Name; Enum "ONT Products")
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(5; "App ID"; Guid)
        {
            Caption = 'Application ID';
            DataClassification = SystemMetadata;
        }
        field(6; Status; Enum "ONT License Status")
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
        }
        field(7; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = SystemMetadata;
        }
        field(8; "Status Updated"; Date)
        {
            Caption = 'Status Updated';
            DataClassification = SystemMetadata;
        }
        field(9; "Registration Done"; Boolean)
        {
            Caption = 'Registration Done';
            DataClassification = SystemMetadata;
        }
        field(10; "Client Secret"; Text[250])
        {
            Caption = 'Client Secret';
            DataClassification = SystemMetadata;
            ExtendedDatatype = Masked;
        }
        field(11; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }
    keys
    {
        key(PK; ID, "Client tenant ID", "Line No.")
        {
        }
    }
    var
        ffrere: Record "Purchase Line";
}