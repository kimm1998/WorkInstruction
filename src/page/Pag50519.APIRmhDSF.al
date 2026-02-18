page 50519 "API RmhDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'RMH';
    EntitySetCaption = 'RMHs';
    EntityName = 'rmh';
    EntitySetName = 'rmhs';
    ODataKeyFields = SystemId;
    SourceTable = "RmhDSF";
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
                field(rmh; Rec."Rmh")
                {
                    Caption = 'RMH';
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
