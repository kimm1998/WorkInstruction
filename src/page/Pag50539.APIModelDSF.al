page 50539 "API ModelDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Model';
    EntitySetCaption = 'Models';
    EntityName = 'model';
    EntitySetName = 'models';
    ODataKeyFields = SystemId;
    SourceTable = "ModelDSF";
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
                field(no; Rec."No.")
                {
                    Caption = 'No';
                }
                field(frameno; Rec."FrameNo")
                {
                    Caption = 'Frame No';
                }
                field(modelnameno; Rec."ModelNameNo")
                {
                    Caption = 'Name No';
                }
                field(modelname; Rec."ModelName")
                {
                    Caption = 'Model Name';
                }
                field(buildkitname; Rec."BuildKitName")
                {
                    Caption = 'Build Kit Name';
                }
                field(graphicdesignno; Rec."GraphicDesignNo")
                {
                    Caption = 'Graphic Design No';
                }
                field(graphicdesigndesc; Rec."GraphicDesignDesc")
                {
                    Caption = 'Graphic Design Description';
                }
                field(rmh; Rec."Rmh")
                {
                    Caption = 'RMH';
                }
                field(propulsion; Rec."Propulsion")
                {
                    Caption = 'Propulsion';
                }
                field(segment; Rec."Segment")
                {
                    Caption = 'Segment';
                }
                field(kidsproduct; Rec."KidsProduct")
                {
                    Caption = 'Kids Product';
                }
                field(modelyear; Rec."ModelYear")
                {
                    Caption = 'Model Year';
                }
                field(businesscase; Rec."BusinessCase")
                {
                    Caption = 'Business Case';
                }
                field(businessunit; Rec."BusinessUnit")
                {
                    Caption = 'Business Unit';
                }
                field(vlscity; Rec."VlsCity")
                {
                    Caption = 'VLS City No';
                }
                field(vlscitydescription; Rec."VlsCityDescription")
                {
                    Caption = 'VLS City Description';
                }
                field(embargodate; Rec."EmbargoDate")
                {
                    Caption = 'Embargo Date';
                }
                field(releasedate; Rec."ReleaseDate")
                {
                    Caption = 'Release Date';
                }
                field(matcosttarget; Rec."MatCostTarget")
                {
                    Caption = 'Material Cost Target (CAD)';
                }
                field(matcosttargetdesc; Rec."MatCostTargetDesc")
                {
                    Caption = 'Material Cost Target Description';
                }
                field(cpsccertificationno; Rec."CpscCertificationNo")
                {
                    Caption = 'CPSC Certification No';
                }
                field(cpsccertificationdescription; Rec."CpscCertificationDescription")
                {
                    Caption = 'CPSC Certification Description';
                }
                field(cusmacertificationno; Rec."CusmaCertificationNo")
                {
                    Caption = 'CUSMA Certification No';
                }
                field(cusmacertificationdescription; Rec."CusmaCertificationDescription")
                {
                    Caption = 'CUSMA Certification Description';
                }
            }
        }
    }
}
