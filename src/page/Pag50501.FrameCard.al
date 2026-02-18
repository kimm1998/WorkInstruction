page 50501 "FrameCard"
{
    PageType = Card;
    SourceTable = "FrameDSF";
    Caption = 'Frame Card';

    layout
    {
        area(content)
        {
            group(GeneralGrp)
            {
                Caption = 'General';

                field(FrameNo; Rec.FrameNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that identifies frame No and its version. Each frame No refers to a design version.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'General frame description, version and/or usage description. ';
                }
                field(ReferenceName; Rec.ReferenceName)
                {
                    ApplicationArea = All;
                }
                field(Generation_MK; Rec.Generation_MK)
                {
                    ApplicationArea = All;
                }
                field(ProjectNo; Rec.ProjectNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Design project reference of the frame.';
                }
                field(FrameTypeCode; Rec.FrameTypeCode)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(FrameMaker; Rec.FrameMaker)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Material; Rec.Material)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Defines the main material of the frame assembly (Front triangle, seatstays, chainstays, etc.)';
                }
                field(WheelSizeDesign; Rec.WheelSizeDesign)
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the wheel size the frame is mainly designed for.';
                }
                field(Sizes; Rec.Sizes)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Actif; Rec.Actif)
                {
                    ApplicationArea = All;
                    ToolTip = 'When desactivated, it can''t be selected to the Graphic Design card and Model table.';
                }
            }
            group(MarketingGrp)
            {
                Caption = 'Marketing';

                field(FyIntroduction; Rec.FyIntroduction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fiscal year (FY) in which the chassis was introduced to the market.';
                }
                field(FyExit; Rec.FyExit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fiscal year (FY) in which the chassis was discontinued from the market.';
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID"=CONST(50500), "No."=FIELD(FrameNo);
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
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
