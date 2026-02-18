table 50536 "ONT Sales Type Commission"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Sales Type Commission";

    fields
    {
        // field(1; "Starting Date"; Date)
        // {
        //     Caption = 'Starting Date';
        //     NotBlank = true;

        //     trigger OnValidate()
        //     begin
        //         // if Rec."Starting Date" <> 0 then
        //         //     if ("Starting Date" < 1754) or ("Starting Date" > 2199) then
        //         //         Error('Fiscal Year must be Between 1754 and 2199.');
        //     end;
        // }
        field(2; "Salesperson"; Code[50])
        {
            NotBlank = true;
            Caption = 'Salesman';
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Order Type Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Order Type Code';
            TableRelation = "ONT Sales Type".Code;
        }
        field(4; "Order Type Description"; Text[100])
        {
            Caption = 'Order Type Description';
            FieldClass = FlowField;
            CalcFormula = lookup("ONT Sales Type".Description where(Code = field("Order Type Code")));
            // Editable = false;
        }
        field(5; "Commission Rate %"; Decimal)
        {
            Caption = 'Commission Rate %';
            DecimalPlaces = 0 : 2;
        }
        field(6; "Salesperson Name"; Text[50])
        {
            NotBlank = true;
            Caption = 'Salesman Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field(Salesperson)));
            // trigger OnValidate()
            // var
            //     myInt: Integer;
            //     Salesperson: Record "Salesperson/Purchaser";
            // begin
            //     Salesperson.Reset();
            //     Salesperson.SetRange(Name, rec."Salesperson Name");
            //     if Salesperson.FindFirst() then
            //         Rec.Salesperson := Salesperson.Code;
            //         rec.Modify();

            // end;
        }
    }

    keys
    {
        key(PK; "Salesperson", "Order Type Code")
        {
            Clustered = true;
        }
    }
}