page 50536 "API SalesPeriodDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Sales period';
    EntitySetCaption = 'Sales periods';
    EntityName = 'salesperiod';
    EntitySetName = 'salesperiods';
    ODataKeyFields = SystemId;
    SourceTable = "SalesPeriodDSF";
    Extensible = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(RepeaterGroup)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'SystemId';
                    Editable = false;
                }
                field(period; Rec."Period")
                {
                    Caption = 'Period';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(actif; Rec."Actif")
                {
                    Caption = 'Actif';
                }
            }
        }
    }
}
