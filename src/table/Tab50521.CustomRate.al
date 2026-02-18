table 50521 "Custom Rate"
{
    Caption = 'Custom Rate';
    DataClassification = ToBeClassified;
    LookupPageId = "Cust Rates";
    DrillDownPageId = "Cust Rates";

    fields
    {
        field(1; "HS Market"; Code[10])
        {
            Caption = 'HS Market';
            DataClassification = CustomerContent;
            TableRelation = "ONT HS Market";
        }
        field(2; "Country/Region"; Code[10])
        {
            Caption = 'Country/Region';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(3; "Tariff No."; Code[20])
        {
            Caption = 'Tariff No.';
            DataClassification = CustomerContent;
            TableRelation = "Tariff Number";
        }
        field(4; "HS Code"; Code[20])
        {
            Caption = 'HS Code';
            DataClassification = CustomerContent;
        }
        field(5; "Custom Rate"; Decimal)
        {
            Caption = 'Custom Rate';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDate();
            end;
        }
        field(7; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckDate();
            end;
        }
        field(8; "Trade Agreement"; Text[100])
        {
            Caption = 'Trade Agreement';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
    }
    keys
    {
        key(PK; "HS Market", "Country/Region", "Tariff No.", "HS Code", "Item No.")
        {
            Clustered = true;
        }
    }
    local procedure CheckDate()
    var
        DateErr: Label '%1 cannot be greater than %2', Comment = '%1, %2 are field captions.';
    begin
        if ("Ending Date" <> 0D) AND ("Starting Date" <> 0D) then if "Starting Date" > "Ending Date" then Error(DateErr, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
    end;
}
