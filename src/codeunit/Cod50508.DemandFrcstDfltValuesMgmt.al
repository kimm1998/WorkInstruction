codeunit 50508 "Demand Frcst Dflt Values Mgmt"
{
    SingleInstance = true;

    var
        CurrentlyRunningForecastOnly: Boolean;
        CurrentDemandForecast: Code[20];


    [EventSubscriber(ObjectType::Table, Database::"Production Forecast Name", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertProductionForecastName(var Rec: Record "Production Forecast Name")
    begin
        ApplyDefaultValuesToProductionForcastName(Rec);
    end;


    local procedure ApplyDefaultValuesToProductionForcastName(var Rec: Record "Production Forecast Name")

    var
        ManSetup: Record "Manufacturing Setup";
    begin
        ManSetup.Get();

        Rec."Forecast Type" := ManSetup."Demand Forecast Type";

        Rec."View By" := ManSetup."Demand Forecast View By";

        if ManSetup."Demand Forecast Loction Filter".HasValue then
            CopyLocationFilterBlob(ManSetup, Rec);

        if ManSetup."Demand Forecast Item Filter".HasValue then
            CopyItemFilterBlob(ManSetup, Rec);
    end;



    procedure CopyLocationFilterBlob(var SourceRec: Record "Manufacturing Setup"; var DestinationRec: Record "Production Forecast Name")
    var
        InStream: InStream;
        OutStream: OutStream;
    begin
        SourceRec.CalcFields("Demand Forecast Loction Filter");
        SourceRec."Demand Forecast Loction Filter".CreateInStream(InStream);

        // Create InStream for the source BLOB field
        DestinationRec."Location Filter".CreateOutStream(OutStream);

        // Write the content of the InStream to the OutStream
        CopyStream(OutStream, InStream);
    end;

    procedure CopyItemFilterBlob(var SourceRec: Record "Manufacturing Setup"; var DestinationRec: Record "Production Forecast Name")
    var
        InStream: InStream;
        OutStream: OutStream;
    begin
        SourceRec.CalcFields("Demand Forecast Item Filter");
        SourceRec."Demand Forecast Item Filter".CreateInStream(InStream);

        // Create InStream for the source BLOB field
        DestinationRec."Item Filter".CreateOutStream(OutStream);

        // Write the content of the InStream to the OutStream
        CopyStream(OutStream, InStream);
    end;




}