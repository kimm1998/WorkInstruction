tableextension 50524 "Sales Header" extends "Sales Header" //36
{
    fields
    {
        field(80000; "Multiple Payment Code"; Code[10])
        {
            Caption = 'Multiple Payment Code';
            DataClassification = CustomerContent;
            TableRelation = "Multiple Payment Terms"."Code" where("Selected" = const(true));
        }
        field(80001; "Sales Order Type"; Code[50])
        {
            Caption = 'Sales Order Type';
            DataClassification = CustomerContent;
            TableRelation = "ONT Sales Type".Code;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateSalesType;
                CreateDimensionsFromValidateSalesType;
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                GetSalesCommissions();
            end;
        }
        //DO not use 80002
        field(80003; "Shipping Formula"; Enum "ONT Shipping Formula")
        { }
        field(80004; "Salesman commission %"; Decimal)
        { }
        field(80005; "Fixed Shipping Rate"; Decimal)
        { }

    }
    local procedure ValidateSalesType()
    var
        SalesType: Record "ONT Sales Type";
        SalesTypeCommnission: Record "ONT Sales Type Commission";
        CurrentYear: Integer;
        SalesPerson: Record "Salesperson/Purchaser";
    begin
        // CurrentYear := Date2DMY(rec."Order Date", 3);
        if SalesType.Get(rec."Sales Order Type") then begin
            if SalesType."Customer Discount Group" <> '' then
                rec.Validate("Customer Disc. Group", SalesType."Customer Discount Group");
            if SalesType."Customer Price Group" <> '' then
                rec.Validate("Customer Price Group", SalesType."Customer Price Group");
            if SalesType."Payment term" <> '' then
                rec.Validate("Payment Terms Code", SalesType."Payment term");
            rec.Validate("Shipping Formula", SalesType."Shipping Formula");
            rec.Validate("Fixed Shipping Rate", SalesType."Fixed Rate");
            // SalesTypeCommnission.Reset();
            // // SalesTypeCommnission.Setfilter("Starting Date", '<%1', Rec."Order Date");
            // SalesTypeCommnission.SetFilter(Salesperson, rec."Salesperson Code");
            // SalesTypeCommnission.SetFilter("Order Type Code", rec."Sales Order Type");
            // if SalesTypeCommnission.FindLast() then begin
            //     if SalesTypeCommnission."Commission Rate %" <> 0 then
            //         rec.Validate("Salesman commission %", SalesTypeCommnission."Commission Rate %")
            // end
            // else begin
            //     if SalesPerson.get(rec."Salesperson Code") then
            //         if SalesPerson."Commission %" <> 0 then
            //             rec.Validate("Salesman commission %", SalesPerson."Commission %")
            //         else
            //             Rec.Validate("Salesman commission %", 0);
            // end
            GetSalesCommissions();
        end;

    end;


    local procedure GetSalesCommissions()
    var
        SalesPerson: Record "Salesperson/Purchaser";
        SaleTypeCommission: Record "ONT Sales Type Commission";
    begin
        SaleTypeCommission.SetRange(Salesperson, rec."Salesperson Code");
        SaleTypeCommission.SetRange("Order Type Code", rec."Sales Order Type");
        SaleTypeCommission.SetFilter("Commission Rate %", '<>%1', 0);
        if SaleTypeCommission.FindFirst() then begin
            rec.Validate("Salesman commission %", SaleTypeCommission."Commission Rate %");
        end
        else begin
            if SalesPerson.get(rec."Salesperson Code") then begin
                if SalesPerson."Commission %" <> 0 then
                    rec.Validate("Salesman commission %", SalesPerson."Commission %")
                else
                    rec.Validate("Salesman commission %", 0);
            end;

        end;
    end;

    local procedure CreateDimensionsFromValidateSalesType()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        CreateDimFromDefaultDim(Rec.FieldNo("Sales Order Type"));
    end;
}
