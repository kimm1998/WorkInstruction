page 50557 "Family PAINTEDFRAME Card Part"
{
    PageType = CardPart;
    SourceTable = Family;
    Caption = 'Family Painted Frame';
    
    layout
    {
        area(Content)
        {
            group("PAINTED FRAME")
            {
                ShowCaption = false;
                Caption = 'Family Painted Frame';
                field(FrameNo; Rec.FrameNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the frame number.';

                }
                field(ModelName; Rec.ModelName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the model name.';
                }

                field(BuildKitName; Rec.BuildKitName)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the build kit name.';
                }
                field(GraphicDesignNo; Rec.GraphicDesignNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the graphic design number.';
                }
                field(GraphicDesignDesc; Rec.GraphicDesignDesc)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the graphic design description.';
                }
                
            }
        }
    }
    
    var
        myInt: Integer;
}