tableextension 50540 ExtDFEManufacturingSetup extends "Manufacturing Setup"
{
    fields
    {

        field(60110; "Demand Forecast View By"; Enum "Analysis Period Type")
        {
            Caption = 'Default View By';
        }
        field(60111; "Demand Forecast Type"; Enum "Demand Forecast Type")
        {
            Caption = 'Default Forecast Type';
        }
        field(60112; "Demand Forecast Loction Filter"; Blob)
        {
            Caption = 'Demand Forecast Location Filter';
        }
        field(60113; "Demand Forecast Item Filter"; Blob)
        {
            Caption = 'Demand Forecast Item Filter';
        }
        field(60114; "Demand Forecast Name"; Code[20])
        {
            TableRelation = "Production Forecast Name";
        }
        field(60115; "Demand Forecast Location Code"; Code[10])
        {
            Caption = 'Demand Forecast Location Code';
            TableRelation = Location.Code;
        }
        field(60116; "Starting Time Calculation"; DateFormula)
        {
            caption = 'Demand Forecast Starting Time Calculation';
        }
        field(60117; "Ending Time Calculation"; DateFormula)
        {
            caption = 'Demand Forecast Ending Time Calculation';
        }

        field(60100; "ONT From Location Code"; Code[10])
        {
            Caption = 'From Location Code (Supply)';
            TableRelation = Location.Code;
        }
        field(60102; "ONT Shopfloor Location Code"; Code[10])
        {
            Caption = 'Shopfloor Location Code (Destination)';
            TableRelation = Location.Code;
        }

        field(60106; "ONT In-Transit Location Code"; Code[10])
        {
            Caption = 'In-Transit Location Code (Optional)';
            TableRelation = Location.Code where("Use As In-Transit" = const(true));
        }


        field(60105; "ONT Default From Bin Code"; Code[20])
        {
            Caption = 'Shopfloor Transfer - Default From Bin';
            // Constrain to the configured From Location
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("ONT From Location Code"));
            DataClassification = CustomerContent;
        }
        field(60107; "ONT Default To Bin Code"; Code[20])
        {
            Caption = 'Shopfloor Transfer - Default To Bin (Shopfloor)';
            // If a single shopfloor bin is used across locations, leave without Location filter.
            // If you want to constrain it, swap to WHERE("Location Code" = FIELD("Location Code")) and
            // set a destination location on header when you know it.
            TableRelation = Bin.Code;
            DataClassification = CustomerContent;
        }
        field(60108; "ONT Shopfloor Bin Code"; Code[20])
        {
            Caption = 'Shopfloor Open Bin';
            TableRelation = Bin.Code;
            DataClassification = CustomerContent;
        }
        field(60109; "ONT Use In-Transit"; Boolean)
        {
            Caption = 'Use In-Transit Location on Transfers';
            DataClassification = CustomerContent;
        }

    }

    procedure SetTextFilterToLocationBlob(TextFilter: Text)
    var
        FiltersOutStream: OutStream;
    begin
        Clear("Demand Forecast Loction Filter");
        "Demand Forecast Loction Filter".CreateOutStream(FiltersOutStream);
        FiltersOutStream.WriteText(TextFilter);
    end;


    procedure GetItemFilterBlobAsText(): Text
    var
        FiltersInStream: InStream;
        ItemFilterText: Text;
    begin
        CalcFields("Demand Forecast Item Filter");
        "Demand Forecast Item Filter".CreateInStream(FiltersInStream);
        FiltersInStream.ReadText(ItemFilterText);
        exit(ItemFilterText);
    end;

    procedure SetTextFilterToItemFilterBlob(TextFilter: Text)
    var
        FiltersOutStream: OutStream;
    begin
        Clear("Demand Forecast Item Filter");
        "Demand Forecast Item Filter".CreateOutStream(FiltersOutStream);
        FiltersOutStream.WriteText(TextFilter);
    end;

    procedure GetItemFilterAsDisplayText(): Text
    begin
        exit(GetItemFilterBlobAsRecordRef().GetFilters);
    end;

    local procedure GetItemFilterBlobAsRecordRef(): RecordRef
    var
        Item: Record Item;
        TempBlob: Codeunit "Temp Blob";
        RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
        FiltersRecordRef: RecordRef;
    begin
        FiltersRecordRef.GetTable(Item);
        CalcFields("Demand Forecast Item Filter");
        TempBlob.FromRecord(Rec, FieldNo("Demand Forecast Item Filter"));

        RequestPageParametersHelper.ConvertParametersToFilters(FiltersRecordRef, TempBlob);
        exit(FiltersRecordRef);
    end;

    procedure GetLocationFilterBlobAsText(): Text
    var
        FiltersInStream: InStream;
        LocationFilterText: Text;
    begin
        CalcFields("Demand Forecast Loction Filter");
        "Demand Forecast Loction Filter".CreateInStream(FiltersInStream);
        FiltersInStream.ReadText(LocationFilterText);
        exit(LocationFilterText);
    end;

}