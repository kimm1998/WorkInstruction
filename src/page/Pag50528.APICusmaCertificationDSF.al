page 50528 "API CusmaCertificationDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'CUSMA Certification';
    EntitySetCaption = 'CUSMA Certifications';
    EntityName = 'cusmacertification';
    EntitySetName = 'cusmacertifications';
    ODataKeyFields = SystemId;
    SourceTable = "CusmaCertificationDSF";
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
                field(status; Rec."Status")
                {
                    Caption = 'Status';
                }
            }
        }
    }
}
