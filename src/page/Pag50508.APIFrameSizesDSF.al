page 50508 "API FrameSizesDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Frame sizes';
    EntitySetCaption = 'Frame sizess';
    EntityName = 'framesizes';
    EntitySetName = 'framesizess';
    ODataKeyFields = SystemId;
    SourceTable = "FrameSizesDSF";
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
                field(frame; Rec."Frame")
                {
                    Caption = 'Frame';
                }
                field(size; Rec."Size")
                {
                    Caption = 'Size';
                }
            }
        }
    }
}
