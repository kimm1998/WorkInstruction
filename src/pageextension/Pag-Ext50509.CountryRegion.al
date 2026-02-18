pageextension 50509 "CountryRegion" extends "Countries/Regions"
{
    layout
    {
        addafter("County Name")
        {
            field("Market"; Rec."ONT HS Market")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Market field.';
            }
        }
    }
}
