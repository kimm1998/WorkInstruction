table 50532 "ONT Family Forecast Entry"
{
    Caption = 'Family Forecast Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(60100; "Production Forecast Name"; Code[10])
        {
            Caption = 'Forecast Name';
            TableRelation = "Production Forecast Name".Name;
            NotBlank = true;
        }
        field(60101; "Family"; Code[20])
        {
            Caption = 'Family';
            TableRelation = Family."No.";
            NotBlank = true;
        }
        field(60102; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(60103; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            // Optional – generally blank for family forecasts
        }
        field(60104; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;
        }
        field(60105; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(60106; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(60107; "Family Name"; Text[100])
        {
            Caption = 'Family Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Family.Description WHERE("No." = FIELD("Family")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Production Forecast Name", Family, "Location Code", "Variant Code", Date)
        {
            Clustered = true;
        }
        key(ByDate; Date) { }
    }
}