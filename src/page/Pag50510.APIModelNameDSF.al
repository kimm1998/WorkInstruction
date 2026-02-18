page 50510 "API ModelNameDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Model name';
    EntitySetCaption = 'Model names';
    EntityName = 'modelname';
    EntitySetName = 'modelnames';
    ODataKeyFields = SystemId;
    SourceTable = "ModelNameDSF";
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
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec."Name")
                {
                    Caption = 'Name';
                }
            }
        }
    }
}
