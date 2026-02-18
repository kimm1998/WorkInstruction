query 50501 "DemandForecastByMonth"
{

    elements
    {
        dataitem(Production_Forecast_Entry; "Production Forecast Entry")
        {
            column(Item_No_; "Item No.")
            {
            }
            column(Forecast_Quantity__Base_; "Forecast Quantity (Base)")
            {
                Method = Sum;
            }

            column(Variant_Code; "Variant Code")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            filter(Production_Forecast_Name; "Production Forecast Name")
            {
            }
            filter(Forecast_Date; "Forecast Date")
            {
            }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}