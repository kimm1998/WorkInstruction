page 50531 "API StandardCategoryDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Standard Category';
    EntitySetCaption = 'Standard Categorys';
    EntityName = 'standardcategory';
    EntitySetName = 'standardcategorys';
    ODataKeyFields = SystemId;
    SourceTable = "StandardCategoryDSF";
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
                field(standardcategory; Rec."StandardCategory")
                {
                    Caption = 'Standard Category';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(sequence; Rec."Sequence")
                {
                    Caption = 'Sequence';
                }
                field(standardschema; Rec."StandardSchema")
                {
                    Caption = 'Standard Schema';
                }
            }
        }
    }
}
