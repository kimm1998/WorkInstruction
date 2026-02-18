page 50538 "ModelCard"
{
    PageType = Card;
    SourceTable = "ModelDSF";
    Caption = 'Model Card';

    layout
    {
        area(content)
        {
            group(GeneralGrp)
            {
                Caption = 'General';

                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(ModelNameNo; Rec.ModelNameNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code identifying the model name number.';
                }
                field(ModelName; Rec.ModelName)
                {
                    ApplicationArea = All;
                }
                field(BuildKitName; Rec.BuildKitName)
                {
                    ApplicationArea = All;
                }
                field(GraphicDesignNo; Rec.GraphicDesignNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code identifying the graphic design number. Each Graphic Design No refers to a chassis No, a color/design theme and a paint manufacturer.';
                }
                field(GraphicDesignDesc; Rec.GraphicDesignDesc)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Rmh; Rec.Rmh)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each Bicycle model.';
                }
                field(Propulsion; Rec.Propulsion)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each Bicycle model.';
                }
                field(Segment; Rec.Segment)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Code that allows you to categorize each Bicycle model.';
                }
                field(KidsProduct; Rec.KidsProduct)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code that allows you to categorize each Bicycle model.';
                }
                field(ModelYear; Rec.ModelYear)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Model year (MY) in which the model was introduced to the market. The value must be greater than or equal to 1900.';
                }
                field(BusinessCase; Rec.BusinessCase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code that allows you to categorize each Bicycle model according to the Business Case.';
                }
                field(BusinessUnit; Rec.BusinessUnit)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Life Cycle Code"; Rec."Life Cycle Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Life Cycle Code field.', Comment = '%';
                }

            }
            group(CertificationsGrp)
            {
                Caption = 'Certifications';

                field(CpscCertificationNo; Rec.CpscCertificationNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fill in a CPSC certification number if applicable to this bike model.';
                }
                field(CpscCertificationDescription; Rec.CpscCertificationDescription)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CusmaCertificationNo; Rec.CusmaCertificationNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fill in a CUSMA certification number if applicable to this bike model.';
                }
                field(CusmaCertificationDescription; Rec.CusmaCertificationDescription)
                {
                    ApplicationArea = All;
                }
            }
            group(MarketingGrp)
            {
                Caption = 'Marketing';

                field(EmbargoDate; Rec.EmbargoDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Early date when launch information is shared with the media and/or our distribution network. The information must remain confidential to the public, until the release date.';
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Date on which the product information is released to the public for the first time.';
                }
                field(MatCostTarget; Rec.MatCostTarget)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the maximum cost target (landed cost) of the sum of the components for this bike model. This is for objective reference only. For more details, refer to the Business case.';
                }
                field(MatCostTargetDesc; Rec.MatCostTargetDesc)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Notes about the cost target.';
                }
            }
            group(VLSGrp)
            {
                Caption = 'VLS';

                field(VlsCity; Rec.VlsCity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code that allows you to categorize each City/Customer.';
                }
                field(VlsCityDescription; Rec.VlsCityDescription)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control13; "Family Lines")
            {
                ApplicationArea = Manufacturing;
                SubPageLink = "Family No." = field("No.");
                SubPageView = sorting("Family No.", "Line No.");
                Visible = FromFamily;
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        FromFamily := rec."Created From Family";

    end;

    var
        FromFamily: Boolean;

}
