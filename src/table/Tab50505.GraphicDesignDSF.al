table 50505 "GraphicDesignDSF"
{
    TableType = Normal;
    Caption = 'Graphic design';
    LookupPageId = 50511;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; FrameNo; Code[20])
        {
            Caption = 'Frame No';
            DataClassification = ToBeClassified;
            TableRelation = FrameDSF.FrameNo where(Actif = const(true));
        }
        field(3; PaintMaker; Text[100])
        {
            Caption = 'Paint Maker';
            DataClassification = ToBeClassified;
        }
        field(5; DescColorMkt; Text[60])
        {
            Caption = 'Description Color Mkt';
            DataClassification = ToBeClassified;
        }
        field(6; StatusNo; Code[20])
        {
            Caption = 'Status No';
            DataClassification = ToBeClassified;
            TableRelation = "Item Status"."Code" where("Type" = filter('Graphic Design'));

            trigger OnValidate()
            var
                RelRec: Record "Item Status";
            begin
                RelRec.Setrange("Code", Rec.StatusNo);
                RelRec.FindFirst();
                Rec.Validate(StatusName, RelRec."Description");
            end;
        }
        field(7; StatusName; Text[200])
        {
            Caption = 'StatusName';
            DataClassification = ToBeClassified;
        }
        field(8; CyRelease; Integer)
        {
            Caption = 'CY Release';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if CyRelease <> 0 then
                    if (CyRelease < 1987) or (CyRelease > 2099) then
                        Error('CY Release must be Between 1987 and 2099.');
            end;
        }
        field(9; ColorSwatch; Blob)
        {
            Caption = 'Color Swatch';
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; No, DescColorMkt)
        {

        }

    }
}
