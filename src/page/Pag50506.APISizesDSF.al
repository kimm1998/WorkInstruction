page 50506 "API SizesDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Sizes';
    EntitySetCaption = 'Sizess';
    EntityName = 'sizes';
    EntitySetName = 'sizess';
    ODataKeyFields = SystemId;
    SourceTable = "SizesDSF";
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
                field(size; Rec."Size")
                {
                    Caption = 'Size';
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
