table 50534 "ONT Forecast Family Loc"
{
    Caption = 'Forecast Family Rows';
    DataClassification = CustomerContent;
    TableType = Temporary;

    fields
    {
        field(60100; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(60101; "Family"; Code[20])
        {
            Caption = 'Family';
            TableRelation = Family."No.";
            DataClassification = CustomerContent;
        }
        field(60102; "Family Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(60103; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(60104; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location.Code;
        }
        field(60105; "Production Forecast Name"; Code[10])
        {
            Caption = 'Forecast Name';
            FieldClass = FlowFilter;
            TableRelation = "Production Forecast Name".Name;
        }
        field(60106; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(60107; "Family Forecast Qty"; Decimal)
        {
            Caption = 'Forecast Quantity';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("ONT Family Forecast Entry".Quantity WHERE(
                                "Production Forecast Name" = FIELD("Production Forecast Name"),
                                "Family" = FIELD("Family"),
                                "Location Code" = FIELD("Location Filter"),
                                Date = FIELD("Date Filter")));
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}