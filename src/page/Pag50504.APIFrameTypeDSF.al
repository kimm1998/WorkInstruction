page 50504 "API FrameTypeDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Frame type';
    EntitySetCaption = 'Frame types';
    EntityName = 'frametype';
    EntitySetName = 'frametypes';
    ODataKeyFields = SystemId;
    SourceTable = "FrameTypeDSF";
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
                field(type; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(sequence; Rec."Sequence")
                {
                    Caption = 'Sequence';
                }
            }
        }
    }
}
