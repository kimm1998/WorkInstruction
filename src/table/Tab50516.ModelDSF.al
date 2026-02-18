table 50516 "ModelDSF"
{
    TableType = Normal;
    Caption = 'Model';
    LookupPageId = 50537;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; FrameNo; Code[20])
        {
            Caption = 'Frame No';
            DataClassification = ToBeClassified;
            TableRelation = FrameDSF.FrameNo where(Actif = const(true));
        }
        field(3; ModelNameNo; Code[20])
        {
            Caption = 'Name No.';
            DataClassification = ToBeClassified;
            TableRelation = ModelNameDSF."No.";


        }
        field(4; ModelName; Text[50])
        {
            Caption = 'Model Name';
            FieldClass = FlowField;
            CalcFormula = lookup(ModelNameDSF.Name where("No." = field(ModelNameNo)));
            Editable = false;
        }

        field(5; BuildKitName; Text[50])
        {
            Caption = 'Build Kit Name';
            DataClassification = ToBeClassified;
        }
        field(6; GraphicDesignNo; Code[12])
        {
            Caption = 'Graphic Design No';
            DataClassification = ToBeClassified;
            TableRelation = GraphicDesignDSF.No;

            trigger OnValidate()
            var
                RelRec: Record "GraphicDesignDSF";
            begin
                RelRec.Setrange("No", Rec.GraphicDesignNo);
                RelRec.FindFirst();
                Rec.Validate(GraphicDesignDesc, RelRec."DescColorMkt");
            end;
        }
        field(7; GraphicDesignDesc; Text[60])
        {
            Caption = 'Graphic Design Description';
            DataClassification = ToBeClassified;
        }
        field(8; Rmh; Code[20])
        {
            Caption = 'RMH';
            DataClassification = ToBeClassified;
            TableRelation = RmhDSF.Rmh;
        }
        field(9; Propulsion; Code[20])
        {
            Caption = 'Propulsion';
            DataClassification = ToBeClassified;
            TableRelation = PropulsionDSF.Propulsion;
        }
        field(10; Segment; Code[20])
        {
            Caption = 'Segment';
            DataClassification = ToBeClassified;
            TableRelation = BikeSegmentDSF.Segment;
        }
        field(11; KidsProduct; Boolean)
        {
            Caption = 'Kids Product';
            DataClassification = ToBeClassified;
        }
        field(12; ModelYear; Integer)
        {
            Caption = 'Model Year';
            DataClassification = ToBeClassified;
        }
        field(13; BusinessCase; Code[20])
        {
            Caption = 'Business Case';
            DataClassification = ToBeClassified;
            TableRelation = BusinessCaseDSF.No;

            trigger OnValidate()
            var
                RelRec: Record "BusinessCaseDSF";
            begin
                RelRec.Setrange("No", Rec.BusinessCase);
                RelRec.FindFirst();
                Rec.Validate(BusinessUnit, RelRec."BusinessUnitNo");
            end;
        }
        field(14; BusinessUnit; Code[20])
        {
            Caption = 'Business Unit';
            DataClassification = ToBeClassified;
        }
        field(15; VlsCity; Code[4])
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
        field(16; VlsCityDescription; Text[50])
        {
            Caption = 'VLS City Description';
            DataClassification = ToBeClassified;
        }
        field(17; EmbargoDate; Date)
        {
            Caption = 'Embargo Date';
            DataClassification = ToBeClassified;
        }
        field(18; ReleaseDate; Date)
        {
            Caption = 'Release Date';
            DataClassification = ToBeClassified;
        }
        field(19; MatCostTarget; Decimal)
        {
            Caption = 'Material Cost Target (CAD)';
            DataClassification = ToBeClassified;
        }
        field(20; MatCostTargetDesc; Text[255])
        {
            Caption = 'Material Cost Target Description';
            DataClassification = ToBeClassified;
        }
        field(21; CpscCertificationNo; Code[20])
        {
            Caption = 'CPSC Certification No';
            DataClassification = ToBeClassified;
            TableRelation = CpscCertificationDSF.No;
        }
        field(22; "CpscCertificationDescription"; Text[50])
        {
            Caption = 'CPSC Certification Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(CpscCertificationDSF.Description where(No = field(CpscCertificationNo)));
        }
        field(23; CusmaCertificationNo; Code[20])
        {
            Caption = 'CUSMA Certification No';
            DataClassification = ToBeClassified;
            TableRelation = CusmaCertificationDSF.No;
        }
        field(24; "CusmaCertificationDescription"; Text[60])
        {
            Caption = 'CUSMA Certification Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(CusmaCertificationDSF.Description where(No = field(CusmaCertificationNo)));
        }
        field(25; "Life Cycle Code"; Option)
        {
            OptionMembers = "New Product","Current","Last time prod","While stock last","Obsolete";
            FieldClass = FlowField;
            CalcFormula = lookup(Family."Life Cycle Code" where("No." = field("No.")));
        }
        field(26; "Created From Family"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
