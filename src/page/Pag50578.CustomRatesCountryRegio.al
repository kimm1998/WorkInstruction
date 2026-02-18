page 50578 "Custom Rates Country Regio"
{
    ApplicationArea = All;
    Caption = 'Countries/Regions';
    PageType = List;
    SourceTable = "Custom Rate";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Country/Region"; Rec."Country/Region")
                {
                    ToolTip = 'Enter the origin associated with the customs tariff of the item.';
                }
                field(Market; Rec."HS Market")
                {
                    ToolTip = 'Enter the market to which the harmonized code belongs.';
                }
            }
        }
    }
}
