page 50512 "GraphicDesignCard"
{
    PageType = Card;
    SourceTable = "GraphicDesignDSF";
    Caption = 'Graphic design Card';

    layout
    {
        area(content)
        {
            group(GeneralGrp)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code identifying the graphic design number. Each Graphic Design No refers to a chassis No, a color/design theme and a paint manufacturer.';
                }
                field(FrameNo; Rec.FrameNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code identifying the graphic design number. Each Graphic Design No refers to a chassis No, a color/design theme and a paint manufacturer.';
                }
                field(PaintMaker; Rec.PaintMaker)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Write who applies the graphic design and painting.';
                }
                field(DescColorMkt; Rec.DescColorMkt)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Unique marketing name that defines graphic design.';
                }
                field(StatusNo; Rec.StatusNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Select the graphic design development status. Allows development monitoring of all graphic design.';
                }
                field(StatusName; Rec.StatusName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CyRelease; Rec.CyRelease)
                {
                    ApplicationArea = All;
                    ToolTip = 'The targeted calendar year (CY) in which the graphic design will be marketed for the first time. The objective is to aim for its beginning of the growth cycle, and represents the moment when the perception of this graphic design will be at its best.';
                }
                field(ColorSwatch; Rec.ColorSwatch)
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
