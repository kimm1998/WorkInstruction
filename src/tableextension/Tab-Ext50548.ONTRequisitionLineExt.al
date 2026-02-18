
tableextension 50548 "ONT Requisition Line Ext" extends "Requisition Line"
{
    fields
    {
        field(60102; "ONT Demand Forecast"; Code[10])
        {
            Caption = 'From Demand Forecast';
            DataClassification = CustomerContent;
            tablerelation = "Production Forecast Name";
        }
        field(60100; "ONT Family No."; Code[20])
        {
            Caption = 'Family No.';
            DataClassification = CustomerContent;
            TableRelation = "Family"."No.";

            trigger OnValidate()
            begin
                RecalcFamilyQuantity();
            end;
        }

        field(60101; "ONT Family Quantity"; Decimal)
        {
            Caption = 'Family Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false; // calculated automatically; flip to true if you want manual override
        }
        // field(60103; "Model No."; Code[20])
        // {
        //     Caption = 'Model No.';
        //     // FieldClass = FlowField;
        //     //CalcFormula = Lookup(Item."ModelNo" WHERE("No." = FIELD("No.")));
        //     Editable = false;
        // }
        field(60104; "Item Category Description"; Text[100])
        {
            Caption = 'Item Category Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Category".Description where(Code = field("Item Category Code")));
        }


        // React when base fields change
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                SuggestFamily();
                RecalcFamilyQuantity();
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                // "Quantity (Base)" has been updated by base app by now
                RecalcFamilyQuantity();
            end;
        }

        // Also catch direct changes to "Quantity (Base)" if someone modifies it via code
        modify("Quantity (Base)")
        {
            trigger OnAfterValidate()
            begin
                RecalcFamilyQuantity();
            end;
        }
    }

    trigger OnAfterInsert()
    begin
        SuggestFamily();
        RecalcFamilyQuantity();
    end;

    trigger OnAfterModify()
    begin
        // Safety: if something else changed quantities, keep the calc consistent
        RecalcFamilyQuantity();
    end;

    local procedure SuggestFamily()
    var
        FamLine: Record "Family Line";
    begin
        if "ONT Family No." <> '' then
            exit;

        if "No." = '' then
            exit;

        FamLine.Reset();
        FamLine.SetRange("Item No.", "No.");
        if FamLine.FindFirst() then
            Validate("ONT Family No.", FamLine."Family No.");
    end;

    local procedure RecalcFamilyQuantity()
    var
        FamLine: Record "Family Line";
        PerFamilyQty: Decimal;
        ResultQty: Decimal;
    begin
        // Default to zero
        ResultQty := 0;

        if ("No." = '') or ("ONT Family No." = '') then begin
            if "ONT Family Quantity" <> ResultQty then begin
                "ONT Family Quantity" := ResultQty;
                Modify(false);
            end;
            exit;
        end;

        // Find the family line that ties this item to the current Family No.
        FamLine.Reset();
        FamLine.SetRange("Family No.", "ONT Family No.");
        FamLine.SetRange("Item No.", "No.");
        if FamLine.FindFirst() then begin
            PerFamilyQty := FamLine.Quantity;
            if PerFamilyQty > 0 then
                ResultQty := "Quantity (Base)" / PerFamilyQty;
        end;

        if "ONT Family Quantity" <> ResultQty then begin
            "ONT Family Quantity" := ResultQty;
            //Modify(false);
        end;
    end;
}
