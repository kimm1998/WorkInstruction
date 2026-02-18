page 50515 "API BikeSegmentDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Bike Segment';
    EntitySetCaption = 'Bike Segments';
    EntityName = 'bikesegment';
    EntitySetName = 'bikesegments';
    ODataKeyFields = SystemId;
    SourceTable = "BikeSegmentDSF";
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
                field(segment; Rec."Segment")
                {
                    Caption = 'Segment';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(sequence; Rec."Sequence")
                {
                    Caption = 'Sequence';
                }
                field(actif; Rec."Actif")
                {
                    Caption = 'Actif';
                }
            }
        }
    }
}
