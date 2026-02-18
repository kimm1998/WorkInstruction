table 50561 "ONT Family Product Type"
{
    DataClassification = ToBeClassified;
    Caption = 'Family Product Type';
    LookupPageId = 50594;
    fields
    {
        field(1; Code; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Unique Item Line"; Boolean)
        {
            Caption = 'Unique Item Line';
            DataClassification = ToBeClassified;
        }
        field(4; "Bicycle Fields Display"; boolean)
        {
            Caption = 'Bicycle Fields Display';
            DataClassification = CustomerContent;
        }

        field(5; "Frameset Fields Display"; boolean)
        {
            Caption = 'Frameset Fields Display';
            DataClassification = CustomerContent;
        }

        field(6; "Service Part Fields Display"; boolean)
        {
            Caption = 'Service Part Fields Display';
            DataClassification = CustomerContent;
        }

        field(7; "Warranty Part Fields Display"; boolean)
        {
            Caption = 'Warranty Part Fields Display';
            DataClassification = CustomerContent;
        }

        field(8; "Forecast Item Fields Display"; boolean)
        {
            Caption = 'Forecast Item Fields Display';
            DataClassification = CustomerContent;
        }

        field(9; "Raw Frame Fields Display"; boolean)
        {
            Caption = 'Raw Frame Fields Display';
            DataClassification = CustomerContent;
        }

        field(10; "Painted Frame Fields Display"; boolean)
        {
            Caption = 'Painted Frame Fields Display';
            DataClassification = CustomerContent;
        }

        field(11; "Fshd Pntd Frame Fields Display"; boolean)
        {
            Caption = 'Finished Painted Frame Fields Display';
            DataClassification = CustomerContent;
        }

        field(12; "Trnsfrmd Tube Fields Display"; boolean)
        {
            Caption = 'Transformed Tube Fields Display';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}