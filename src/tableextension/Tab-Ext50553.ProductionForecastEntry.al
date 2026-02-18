tableextension 50553 ProductionForecastEntry extends "Production Forecast Entry"
{
    fields
    {
        modify("Forecast Date")
        {
            trigger OnAfterValidate()
            begin
                while Date2DWY("Forecast Date", 1) in [6, 7] do
                    "Forecast Date" := CalcDate('<1D>', "Forecast Date");
            end;
        }
    }
    var
    p:Report "Refresh Production Order";
}