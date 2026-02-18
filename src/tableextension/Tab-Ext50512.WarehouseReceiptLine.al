tableextension 50512 "Warehouse Receipt Line" extends "Warehouse Receipt Line"
{
    fields
    {
        field(80000; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Direct Unit Cost" where("Document No." = field("Source No."), "Line No." = field("Source Line No."), "Document Type" = filter('Order')));
        }
        field(80001; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Currency Code" where("Document No." = field("Source No."), "Line No." = field("Source Line No."), "Document Type" = filter('Order')));
        }
        field(80002; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Buy-from Vendor No." where("Document No." = field("Source No."), "Line No." = field("Source Line No."), "Document Type" = filter('Order')));
        }
        field(80003; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Item Category Code" where("Document No." = field("Source No."), "Line No." = field("Source Line No."), "Document Type" = filter('Order')));
        }
        field(80004; "Container ID"; Code[30])
        {
            Caption = 'Container ID';
            Editable = false;
            // Enabled = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", "Source No.");
                PurchaseLine.SetRange("Line No.", "Source Line No.");
                if PurchaseLine.FindFirst() then begin
                    PurchaseLine."Container ID" := "Container ID";
                    PurchaseLine.Modify(true);
                end;
            end;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            var
                Text000: Text;
            begin
                Text000 := 'You have modified %1. Do you want to update the lines?'
            end;
        }
    }
}
