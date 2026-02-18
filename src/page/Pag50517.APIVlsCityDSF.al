page 50517 "API VlsCityDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'VLS City';
    EntitySetCaption = 'VLS Citys';
    EntityName = 'vlscity';
    EntitySetName = 'vlscitys';
    ODataKeyFields = SystemId;
    SourceTable = "VlsCityDSF";
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
                field(cityno; Rec."CityNo")
                {
                    Caption = 'City No';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
            }
        }
    }
}
