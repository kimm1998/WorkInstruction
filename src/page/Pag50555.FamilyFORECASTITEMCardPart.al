page 50555 "Family FORECASTITEM Card Part"
{
    PageType = CardPart;
    SourceTable = Family;
    Caption = 'Family Forcast Item';

    layout
    {
        area(Content)
        {
            group("FORECAST ITEM")
            {
                ShowCaption = false;
                Caption = 'Family Forcast Item';
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
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the graphic design number.';
                }
                field(GraphicDesignDesc; Rec.GraphicDesignDesc)
                {
                    Visible = false;
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
                    Visible = false;
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
                    ApplicationArea = All;
                    MultiLine = true;
                    rowspan = 3;
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
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the embargo date.';
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the release date.';
                }
                field(VlsCity; Rec.VlsCity)
                {
                    Visible = false;
                    ApplicationArea = All;
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