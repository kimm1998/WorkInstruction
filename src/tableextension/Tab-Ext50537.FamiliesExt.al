tableextension 50537 FamiliesExt extends Family
{
    fields
    {



        field(90200; "Product Type"; Code[50])
        {
            // OptionMembers = " ",Bicycle,Frameset,"Service Part","Warranty Part","Forecast Item","Raw Frame","Painted Frame","Finished Painted Frame","Transformed Tube";
            TableRelation = "ONT Family Product Type".Code;
        }
        field(90201; "Life Cycle Code"; Option)
        {
            OptionMembers = " ","New Product","Current","Last time prod","While stock last","Obsolete";
        }
        field(90202; FrameNo; Code[20])
        {
            Caption = 'Frame No';
            DataClassification = ToBeClassified;
            TableRelation = FrameDSF.FrameNo where(Actif = const(true));
        }
        field(90203; ModelNameNo; Code[20])
        {
            Caption = 'Name No';
            DataClassification = ToBeClassified;
            TableRelation = ModelNameDSF."No.";
            trigger OnValidate()
            var
                RelRec: Record "ModelNameDSF";
            begin
                RelRec.Setrange("No.", Rec.ModelName);
                if RelRec.FindFirst() then
                    Rec.Validate(ModelNameNo, RelRec."No.");
                rec.Modify();
            end;
        }
        field(90204; ModelName; Text[50])
        {
            Caption = 'Model Name';
            DataClassification = ToBeClassified;
            TableRelation = ModelNameDSF.name;
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                RelRec: Record "ModelNameDSF";
            begin
                RelRec.Setrange(name, Rec.ModelName);
                if RelRec.FindFirst() then
                    Rec.Validate(ModelNameNo, RelRec."No.");
                rec.Modify();
            end;
        }

        field(90205; BuildKitName; Text[50])
        {
            Caption = 'Build Kit Name';
            DataClassification = ToBeClassified;
        }
        field(90206; GraphicDesignNo; Code[12])
        {
            Caption = 'Graphic Design No';
            DataClassification = ToBeClassified;
            ValidateTableRelation = false;
            TableRelation = if (FrameNo = const('')) GraphicDesignDSF.No
            else
            GraphicDesignDSF.No where(FrameNo = field(FrameNo));
            trigger OnValidate()
            var
                RelRec: Record "GraphicDesignDSF";
            begin
                RelRec.Setrange("No", Rec.GraphicDesignNo);
                RelRec.FindFirst();
                Rec.Validate(GraphicDesignDesc, RelRec."DescColorMkt");
            end;
        }
        field(90207; GraphicDesignDesc; Text[60])
        {
            Caption = 'Graphic Design Description';
            DataClassification = ToBeClassified;
        }
        field(90208; Rmh; Code[20])
        {
            Caption = 'RMH';
            DataClassification = ToBeClassified;
            TableRelation = RmhDSF.Rmh;
        }
        field(90209; Propulsion; Code[20])
        {
            Caption = 'Propulsion';
            DataClassification = ToBeClassified;
            TableRelation = PropulsionDSF.Propulsion;
        }
        field(90210; Segment; Code[20])
        {
            Caption = 'Segment';
            DataClassification = ToBeClassified;
            TableRelation = BikeSegmentDSF.Segment;
        }
        field(90211; KidsProduct; Boolean)
        {
            Caption = 'Kids Product';
            DataClassification = ToBeClassified;
        }
        field(90212; ModelYear; Integer)
        {
            Caption = 'Model Year';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ModelYear <> 0 then
                    if (ModelYear < 1987) or (ModelYear > 2099) then
                        Error('Model Year must be Between 1987 and 2099.');
            end;
        }
        field(90213; BusinessCase; Code[20])
        {
            Caption = 'Business Case';
            DataClassification = ToBeClassified;
            TableRelation = BusinessCaseDSF.No;

            // trigger OnValidate()
            // var
            //     RelRec: Record "BusinessCaseDSF";
            // begin
            //     RelRec.Setrange("No", Rec.BusinessCase);
            //     RelRec.FindFirst();
            //     Rec.Validate(BusinessUnit, RelRec."BusinessUnitNo");
            // end;
        }
        field(90214; BusinessUnit; Code[20])
        {
            Caption = 'Business Unit';
            DataClassification = ToBeClassified;
        }
        field(90215; VlsCity; Code[4])
        {
            Caption = 'VLS City No';
            DataClassification = ToBeClassified;
            TableRelation = VlsCityDSF.CityNo;

            trigger OnValidate()
            var
                RelRec: Record "VlsCityDSF";
            begin
                RelRec.Setrange("CityNo", Rec.VlsCity);
                RelRec.FindFirst();
                Rec.Validate(VlsCityDescription, RelRec."Description");
            end;
        }
        field(90216; VlsCityDescription; Text[50])
        {
            Caption = 'VLS City Description';
            DataClassification = ToBeClassified;
        }
        field(90217; EmbargoDate; Date)
        {
            Caption = 'Embargo Date';
            DataClassification = ToBeClassified;
        }
        field(90218; ReleaseDate; Date)
        {
            Caption = 'Release Date';
            DataClassification = ToBeClassified;
        }
        field(90219; MatCostTarget; Decimal)
        {
            Caption = 'Material Cost Target (CAD)';
            DataClassification = ToBeClassified;
        }
        field(90220; MatCostTargetDesc; Text[255])
        {
            Caption = 'Material Cost Target Description';
            DataClassification = ToBeClassified;
        }
        field(90221; CpscCertificationNo; Code[20])
        {
            Caption = 'CPSC Certification No';
            DataClassification = ToBeClassified;
            TableRelation = CpscCertificationDSF.No;
        }
        field(90222; "CpscCertificationDescription"; Text[50])
        {
            Caption = 'CPSC Certification Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(CpscCertificationDSF.Description where(No = field(CpscCertificationNo)));
        }
        field(90223; CusmaCertificationNo; Code[20])
        {
            Caption = 'CUSMA Certification No';
            DataClassification = ToBeClassified;
            TableRelation = CusmaCertificationDSF.No;
        }
        field(90224; "CusmaCertificationDescription"; Text[60])
        {
            Caption = 'CUSMA Certification Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(CusmaCertificationDSF.Description where(No = field(CusmaCertificationNo)));
        }
        field(90225; "ONT Prod. Order No."; Code[20])
        {
            Caption = 'Production Order Reference';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(90226; "No. Series"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    // procedure InitInsert()
    // var
    //     Family: Record Family;
    // begin
    //     if "No." = '' then begin
    //         InvSetup.Get();
    //         InvSetup.TestField("ONT Family Nos.");
    //         "No. Series" := InvSetup."ONT Family Nos.";
    //         if NoSeries.AreRelated("No. Series", xRec."No. Series") then
    //             "No. Series" := xRec."No. Series";
    //         "No." := NoSeries.GetNextNo("No. Series");


    //     end;

    // end;

    // local procedure TestNoSeries()
    // var
    //     Family: Record Family;
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     if IsHandled then
    //         exit;

    //     if "No." <> xRec."No." then
    //         if not Family.Get(Rec."No.") then begin
    //             InvSetup.Get();
    //             NoSeries.TestManual(InvSetup."ONT Family Nos.");
    //             "No. Series" := '';
    //         end;
    // end;

    var

        InvSetup: Record "Inventory Setup";
        NoSeries: Codeunit "No. Series";
}