page 50558 "Family TRANSFRMDTUBE Card Part"
{
    PageType = CardPart;
    SourceTable = Family;
    Caption = 'Family Transformed Tube';
    
    layout
    {
        area(Content)
        {
            group("TRANSFORMED TUBE")
            {
                ShowCaption = false;
                Caption = 'Family Transformed Tube';
                field(FrameNo; Rec.FrameNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the frame number.';

                }
                
            }
        }
    }
    
    var
        myInt: Integer;
}