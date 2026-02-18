page 50524 "API BusinessCaseDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Business case';
    EntitySetCaption = 'Business cases';
    EntityName = 'businesscase';
    EntitySetName = 'businesscases';
    ODataKeyFields = SystemId;
    SourceTable = "BusinessCaseDSF";
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
                field(no; Rec."No")
                {
                    Caption = 'No';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(businessunitno; Rec."BusinessUnitNo")
                {
                    Caption = 'BusinessUnitNo';
                }
                field(status; Rec."Status")
                {
                    Caption = 'Status';
                }
            }
        }
    }
}
