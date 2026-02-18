pageextension 50537 "ONT DemandForecastCard Ext" extends "Demand Forecast Card"
{
    actions
    {
        addlast(processing)
        {
            action(OpenFamilyForecastFromCard)
            {
                ApplicationArea = Planning;
                Caption = 'Edit Family Forecast';
                Image = Forecast;
                ToolTip = 'Switch to the Family Forecast for this forecast name.';
                RunObject = Page "ONT Family Forecast Card";
                RunPageLink = Name = FIELD(Name);
                RunPageMode = Edit;

                Promoted = true;
                PromotedIsBig = false;
                PromotedCategory = Process;
                Visible = false;
            }
        }
    }
}
