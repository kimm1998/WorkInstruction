page 50554 "Family WARRANTYPART Card Part"
{
    PageType = CardPart;
    SourceTable = Family;
    Caption = 'Family Warranty Part';

    layout
    {
        area(Content)
        {
            group("WARRANTY PART")
            {
                ShowCaption = false;
                Caption = 'Family Warranty Part';
                field(FrameNo; Rec.FrameNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the frame number.';

                }
                field(ModelName; Rec.ModelName)
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field(Rmh; Rec.Rmh)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RMH code.';
                }
                field(Propulsion; Rec.Propulsion)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the propulsion type.';
                }
                field(Segment; Rec.Segment)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bike segment.';
                }
                field(KidsProduct; Rec.KidsProduct)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is a kids product.';
                }
                field(ModelYear; Rec.ModelYear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the model year.';
                }
                field(MatCostTarget; Rec.MatCostTarget)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material cost target in CAD.';

                }
                field(MatCostTargetDesc; Rec.MatCostTargetDesc)
                {
                    Visible = false;
                    MultiLine = true;
                    rowspan = 3;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material cost target description.';
                }
                field(CpscCertificationNo; Rec.CpscCertificationNo)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CPSC certification number.';
                }
                field("CpscCertificationDescription"; Rec."CpscCertificationDescription")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CPSC certification description.';
                    // Editable = false;
                }
                field(CusmaCertificationNo; Rec.CusmaCertificationNo)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CUSMA certification number.';
                }
                field("CusmaCertificationDescription"; Rec."CusmaCertificationDescription")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CUSMA certification description.';
                }
                field(EmbargoDate; Rec.EmbargoDate)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the embargo date.';
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the release date.';
                }
                field(VlsCity; Rec.VlsCity)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the VLS city number.';
                }
                field(VlsCityDescription; Rec.VlsCityDescription)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VLS city description.';
                }
            }
        }
    }



    var
        myInt: Integer;
}