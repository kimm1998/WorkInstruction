table 50526 "ONT Registration Header"
{
    Access = Internal;
    Caption = 'OnTarget Group Registration';

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; "License ID"; Text[2048])
        {
            Caption = 'License ID';
            DataClassification = SystemMetadata;
        }
        field(3; "Authorization Key"; Text[250])
        {
            Caption = 'Authorization Key';
            DataClassification = CustomerContent;
        }
        field(4; "Implementation Partner"; Text[250])
        {
            Caption = 'Implementation Partner';
            DataClassification = CustomerContent;
        }
        field(5; "Contact Website"; Text[50])
        {
            Caption = 'Contact Website';
            DataClassification = CustomerContent;
        }
        field(6; "Contact First Name"; Text[50])
        {
            Caption = 'Contact First Name';
            DataClassification = CustomerContent;
        }
        field(7; "Contact Last Name"; Text[50])
        {
            Caption = 'Contact Last Name';
            DataClassification = CustomerContent;
        }
        field(8; "Contact E-Mail"; Text[50])
        {
            Caption = 'Contact E-Mail';
            DataClassification = CustomerContent;
        }
        field(9; "Contact Phone"; Text[50])
        {
            Caption = 'Contact Phone';
            DataClassification = CustomerContent;
        }
        field(10; "Contact Company"; Text[100])
        {
            Caption = 'Contact Company';
            DataClassification = CustomerContent;
        }
        field(11; "Account ID"; Text[80])
        {
            Caption = 'Account ID';
            DataClassification = CustomerContent;
        }
        field(12; "Client tenant ID"; Text[250])
        {
            Caption = 'Contact tenant ID';
            DataClassification = SystemMetadata;
        }
        field(13; "License Registration URL"; Text[250])
        {
            Caption = 'Registration URL';
            DataClassification = SystemMetadata;
        }
        field(14; "Token URL"; Text[250])
        {
            Caption = 'Token URL';
            DataClassification = SystemMetadata;
        }
        field(15; "Client ID"; Text[250])
        {
            Caption = 'Token URL';
            DataClassification = SystemMetadata;
        }
        field(16; "Access Token"; Text[2048])
        {
            Caption = 'Access Token';
            DataClassification = SystemMetadata;
        }
        field(17; "Token tenant ID"; Text[250])
        {
            Caption = 'Token tenant ID';
            DataClassification = SystemMetadata;
        }
        field(18; "Active Users"; Integer)
        {
            Caption = 'Active Users';
            FieldClass = FlowField;
            CalcFormula = count(User where(State = const(Enabled)));
        }
        field(20; "License Response"; Text[250])
        {
            Caption = 'License Response';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; ID)
        {
        }
    }

}