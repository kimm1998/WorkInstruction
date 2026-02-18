table 50523 "Import Route"
{
    Caption = 'Import Route';
    DataClassification = CustomerContent;
    LookupPageId = "Import Routes";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Transit Delay"; DateFormula)
        {
            Caption = 'Transit Delay';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                FixedDate: Date;
                CalculatedDate: Date;
                TransitDelayErr: Label 'must be positive.';
            begin
                FixedDate := 20230101D;
                CalculatedDate := CalcDate("Transit Delay", FixedDate);
                if FixedDate > CalculatedDate then FieldError("Transit Delay", TransitDelayErr);
            end;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
