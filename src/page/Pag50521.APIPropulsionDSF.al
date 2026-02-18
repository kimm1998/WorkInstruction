page 50521 "API PropulsionDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Propulsion';
    EntitySetCaption = 'Propulsions';
    EntityName = 'propulsion';
    EntitySetName = 'propulsions';
    ODataKeyFields = SystemId;
    SourceTable = "PropulsionDSF";
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
                field(propulsion; Rec."Propulsion")
                {
                    Caption = 'Propulsion';
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
