page 50502 "API FrameDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Frame';
    EntitySetCaption = 'Frames';
    EntityName = 'frame';
    EntitySetName = 'frames';
    ODataKeyFields = SystemId;
    SourceTable = "FrameDSF";
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
                field(frameno; Rec."FrameNo")
                {
                    Caption = 'Frame No';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(referencename; Rec."ReferenceName")
                {
                    Caption = 'Reference Name';
                }
                field(generation_mk; Rec."Generation_MK")
                {
                    Caption = 'Generation MK';
                }
                field(projectno; Rec."ProjectNo")
                {
                    Caption = 'Project No';
                }
                field(frametypecode; Rec."FrameTypeCode")
                {
                    Caption = 'Frame Type Code';
                }
                field(framemaker; Rec."FrameMaker")
                {
                    Caption = 'Frame Maker';
                }
                field(material; Rec."Material")
                {
                    Caption = 'Material';
                }
                field(wheelsizedesign; Rec."WheelSizeDesign")
                {
                    Caption = 'Wheel Size Design';
                }
                field(sizes; Rec."Sizes")
                {
                    Caption = 'Sizes';
                }
                field(fyintroduction; Rec."FyIntroduction")
                {
                    Caption = 'FY Introduction';
                }
                field(fyexit; Rec."FyExit")
                {
                    Caption = 'FY Exit';
                }
                field(actif; Rec."Actif")
                {
                    Caption = 'Actif';
                }
            }
        }
    }
}
