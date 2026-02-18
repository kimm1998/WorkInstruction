page 50530 "StandardCategoryCard"
{
    PageType = Card;
    SourceTable = "StandardCategoryDSF";
    Caption = 'Standard Category Card';

    layout
    {
        area(content)
        {
            group(GeneralGrp)
            {
                Caption = 'General';

                field(StandardSchema; Rec.StandardSchema)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}
