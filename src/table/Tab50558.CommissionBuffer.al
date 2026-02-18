table 50558 "Commission Buffer"
{
    TableType = Temporary;
    Caption = 'Commission Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type") { Caption = 'Doc Type'; }
        field(2; "Document No."; Code[20]) { Caption = 'Document No.'; }
        field(3; "Posting Date"; Date) { Caption = 'Posting Date'; }
        field(4; "Salesperson Code"; Code[20]) { Caption = 'Salesperson'; }
        field(5; "Customer No."; Code[20]) { Caption = 'Customer'; }
        field(6; "Customer Name"; Text[100]) { Caption = 'Customer Name'; }

        field(10; "Sales Amount (LCY)"; Decimal) { Caption = 'Sales Amount'; }
        field(11; "Collected Amount (LCY)"; Decimal) { Caption = 'Collected Amount'; }

        field(12; "Commission %"; Decimal)
        {
            Caption = 'Commission %';

            // Recalculate Amount immediately when % is changed
            trigger OnValidate()
            begin
                if "Collected Amount (LCY)" <> 0 then
                    "Commission Amount" := "Collected Amount (LCY)" * ("Commission %" / 100);
            end;
        }
        field(13; "Commission Amount"; Decimal)
        {
            Caption = 'Commission Amount';
            ToolTip = 'Defines the commission amount to pay';

            trigger OnValidate()
            var

            begin
                if "Collected Amount (LCY)" <> 0 then
                    rec."Commission %" := ("Commission Amount" / "Collected Amount (LCY)") * 100;
            end;
        }

        field(14; "Vendor No."; Code[20]) { Caption = 'Vendor Link'; }
        field(15; "Is Fully Paid"; Boolean) { Caption = 'Invoice Fully Paid'; }

        // NEW FIELD: Checkbox
        field(16; "Approved"; Boolean)
        {
            Caption = 'Approve';
            DataClassification = CustomerContent;
        }
        field(17; "Sales Order Type"; Code[50])
        {
            Caption = 'Sales Order Type';
            DataClassification = CustomerContent;
            TableRelation = "ONT Sales Type".Code;
        }
        field(18; "Sales Order Type Desc."; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order Type Description';
        }
        field(19; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Commission Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Defines the paid commission amount';
        }
        
        field(21; "Commission to Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Defines the remaining commission amount to pay';
        }
        field(22; "Document Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the Due Date of the document';
        }
        field(23; "Commission Paid Not Posted"; Decimal)
        {
            DataClassification = ToBeClassified;
            ToolTip = 'Defines the commission amount to Pay in Purchase Invoice (Not Posted)';
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.") { Clustered = true; }
        key(VendorKey; "Vendor No.") { }
    }
}