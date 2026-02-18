tableextension 50538 FamilyLines extends "Family Line"
{
    fields
    {
        field(90200; "Business Unit"; Code[20])
        {
            TableRelation = "Business Unit Lookup";
            FieldClass = FlowField;
            CalcFormula = lookup(item.BuAssignment where("No." = field("Item No.")));
            editable = false;
            trigger OnLookup()
            var
                myInt: Integer;
            begin
                exit;
            end;
        }
        field(90201; "Distribution %"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Lines: Record "Family Line";
                TotalDistribution: Decimal;
            begin
                CalcTotalDistribution();
                Rec.Quantity := rec."Distribution %" / 100;
                rec.Modify();

            end;
        }
        field(90202; "Product Type"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Family."Product Type" where("No." = field("Family No.")));
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                Item: Record item;
            begin
                ValidateItemUnique(Rec."Item No.");

            end;
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
    local procedure CalcTotalDistribution()
    var
        myInt: Integer;
        Lines: Record "Family Line";
        TotalDistribution: Decimal;
    begin
        TotalDistribution := 0;
        lines.Reset();
        Lines.SetRange("Family No.", rec."Family No.");
        Lines.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if lines.FindFirst() then begin
            repeat
                TotalDistribution += Lines."Distribution %";
            until lines.next = 0;
            TotalDistribution += rec."Distribution %";
            if TotalDistribution > 100 then
                Error('Total Distribution Shouldn''t exeed 100');
        end;
    end;

    procedure ValidateItemUnique(ItemNo: Code[20])
    var
        myInt: Integer;
        Lines: Record "Family Line";
        Family: Record "Family";
        FamilyProductType: Record "ONT Family Product Type";
    begin
        if Family.get(rec."Family No.") then begin
            if FamilyProductType.get(Family."Product Type") then
                if not FamilyProductType."Unique Item Line" then
                    exit
                else begin
                    Lines.Reset();
                    Lines.SetRange("Product Type", Family."Product Type");
                    Lines.SetFilter("Item No.", '%1', ItemNo);
                    if Lines.FindFirst() then
                        Error('Item NO. %1 with Product Type %2 already exists in family %3. Item must be unique for this product type.', ItemNo, Family."Product Type", Lines."Family No.");
                end;
        end;

    end;

    var
        myInt: Integer;
}