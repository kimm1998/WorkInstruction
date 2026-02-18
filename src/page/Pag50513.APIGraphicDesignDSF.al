page 50513 "API GraphicDesignDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Graphic design';
    EntitySetCaption = 'Graphic designs';
    EntityName = 'graphicdesign';
    EntitySetName = 'graphicdesigns';
    ODataKeyFields = SystemId;
    SourceTable = "GraphicDesignDSF";
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
                field(frameno; Rec."FrameNo")
                {
                    Caption = 'Frame No';
                }
                field(paintmaker; Rec."PaintMaker")
                {
                    Caption = 'Paint Maker';
                }
                field(desccolormkt; Rec."DescColorMkt")
                {
                    Caption = 'Description Color Mkt';
                }
                field(statusno; Rec."StatusNo")
                {
                    Caption = 'Status No';
                }
                field(statusname; Rec."StatusName")
                {
                    Caption = 'StatusName';
                }
                field(cyrelease; Rec."CyRelease")
                {
                    Caption = 'CY Release';
                }
                field(colorswatch; Rec."ColorSwatch")
                {
                    Caption = 'Color Swatch';
                }
            }
        }
    }
}
