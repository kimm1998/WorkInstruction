table 50518 "Multiple Payment Terms"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "TTC %"; Decimal)
        {
            Caption = 'TTC %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                MultiplePaymentTerms: Record "Multiple Payment Terms";
                TotTTCPerctError: Label 'Tot TTC %1 cannot be more then 100%', Comment = '%1 = Tot TTC';
            begin
                MultiplePaymentTerms.Reset();
                MultiplePaymentTerms.SetRange("Code", "Code");
                MultiplePaymentTerms.CalcSums("TTC %");
                "Total TTC %" := MultiplePaymentTerms."TTC %" + "TTC %";
                if "Total TTC %" > 100 then Error(TotTTCPerctError, "Total TTC %");
            end;
        }
        field(5; "Due Date Calculation"; DateFormula)
        {
            Caption = 'Due Date Calculation';
            DataClassification = CustomerContent;
        }
        field(6; "Total TTC %"; Decimal)
        {
            Caption = 'Total TTC %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            Editable = false;
        }
        field(7; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;
        }
        field(8; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(9; "Discount Date Calc."; DateFormula)
        {
            Caption = 'Discount Date Calculation';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(pk; "Entry No.", "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Description", "TTC %", "Due Date Calculation")
        {
        }
        fieldgroup(Brick; "Code", "Description", "TTC %", "Due Date Calculation")
        {
        }
    }
}
