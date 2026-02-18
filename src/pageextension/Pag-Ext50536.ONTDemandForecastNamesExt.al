pageextension 50536 "ONT DemandForecastNames Ext" extends "Demand Forecast Names"
{
    actions
    {
        addlast(processing)
        {
            action(OpenFamilyForecastFromList)
            {
                ApplicationArea = Planning;
                Caption = 'Edit Family Forecast';
                Image = Forecast;
                ToolTip = 'Open the Family Forecast (by Item Category) for this forecast name.';
                RunObject = Page "ONT Family Forecast Card";
                RunPageLink = Name = FIELD(Name);
                RunPageMode = Edit;

                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;
            }
        }
    }
}
