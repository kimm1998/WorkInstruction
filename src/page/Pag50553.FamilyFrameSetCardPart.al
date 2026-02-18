page 50553 "Family FrameSet Card Part"
{
    PageType = CardPart;
    SourceTable = Family;
    Caption = 'Family FrameSet';

    layout
    {
        area(Content)
        {
            group(FrameSet)
            {
                ShowCaption = false;
                Caption = 'Family FrameSet';
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RMH code.';
                }
                field(Propulsion; Rec.Propulsion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the propulsion type.';
                }
                field(Segment; Rec.Segment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bike segment.';
                }
                field(KidsProduct; Rec.KidsProduct)
                {
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material cost target in CAD.';

                }
                field(MatCostTargetDesc; Rec.MatCostTargetDesc)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material cost target description.';
                }
                field(CpscCertificationNo; Rec.CpscCertificationNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CPSC certification number.';
                }
                field("CpscCertificationDescription"; Rec."CpscCertificationDescription")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    rowspan = 3;
                    ToolTip = 'Specifies the CPSC certification description.';
                    // Editable = false;
                }
                field(CusmaCertificationNo; Rec.CusmaCertificationNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CUSMA certification number.';
                }
                field("CusmaCertificationDescription"; Rec."CusmaCertificationDescription")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CUSMA certification description.';
                    // Editable = false;
                }
                field(EmbargoDate; Rec.EmbargoDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the embargo date.';
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the release date.';
                }
                field(VlsCity; Rec.VlsCity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VLS city number.';
                }
                field(VlsCityDescription; Rec.VlsCityDescription)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the VLS city description.';
                }
            }
        }
    }



    var
        myInt: Integer;
}