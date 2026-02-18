table 50500 "FrameDSF"
{
    TableType = Normal;
    Caption = 'Frame';
    LookupPageId = 50500;

    fields
    {
        field(1; FrameNo; Code[20])
        {
            Caption = 'Frame No';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; ReferenceName; Text[50])
        {
            Caption = 'Reference Name';
            DataClassification = ToBeClassified;
        }
        field(4; Generation_MK; Option)
        {
            Caption = 'Generation MK';
            DataClassification = ToBeClassified;
            OptionMembers = "-","MK1","MK2","MK3","MK4","MK5","MK6","MK7","MK8","MK9","MK10";
        }
        field(5; ProjectNo; Code[20])
        {
            Caption = 'Project No';
            DataClassification = ToBeClassified;
            TableRelation = Job."No.";
        }
        field(6; FrameTypeCode; Code[20])
        {
            Caption = 'Frame Type Code';
            DataClassification = ToBeClassified;
            TableRelation = FrameTypeDSF.Type;
        }
        field(7; FrameMaker; Text[50])
        {
            Caption = 'Frame Maker';
            DataClassification = ToBeClassified;
        }
        field(8; Material; Option)
        {
            Caption = 'Material';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Aluminum"," Carbon";
        }
        field(9; WheelSizeDesign; Option)
        {
            Caption = 'Wheel Size Design';
            DataClassification = ToBeClassified;
            OptionMembers = " ","12","16","18","20","24","26","27.5","29","36","700c","29/27.5 (mullet)";
        }
        field(10; "Sizes"; Integer)
        {
            Caption = 'Sizes';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count(FrameSizesDSF where(Frame = field(FrameNo)));
        }
        field(11; FyIntroduction; Integer)
        {
            Caption = 'FY Introduction';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if FyIntroduction <> 0 then
                    if (FyIntroduction < 1987) or (FyIntroduction > 2099) then
                        Error('FY Introduction must be Between 1987 and 2099.');
            end;
        }
        field(12; FyExit; Integer)
        {
            Caption = 'FY Exit';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if FyExit <> 0 then
                if (FyExit < 1987) or (FyExit > 2099) then
                    Error('FY Exit must be Between 1987 and 2099.');
            end;

        }
        field(13; Actif; Boolean)
        {
            Caption = 'Actif';
            DataClassification = ToBeClassified;

        }

    }
    keys
    {
        key(PK; FrameNo)
        {
            Clustered = true;
        }
    }
}
