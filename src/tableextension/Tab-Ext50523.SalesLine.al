tableextension 50523 "Sales Line" extends "Sales Line"
{
    fields
    {
        field(80000; "Requisition No."; Code[30])
        {
            Caption = 'Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "Order Requisition"."Requisition No." where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No."));
        }
        field(80001; "Requested Qty. To Ship"; Decimal)
        {
            Caption = 'Requested Qty. To Ship';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Order Requisition"."Requested Qty. To Ship" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No."), "Requisition No." = field("Requisition No."), "Cancelled" = const(false), "Error" = const(false)));
        }
        field(80002; "Total Req. Qty. To Ship"; Decimal)
        {
            Caption = 'Total Req. Qty. To Ship';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Order Requisition"."Requested Qty. To Ship" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Line No." = field("Line No."), "Cancelled" = const(false), "Error" = const(false)));
        }
        field(80003; "OTG Sales Line On Hold"; boolean)
        {
            Caption = 'On Hold';
            Editable = false;
        }

        field(80004; "ONT Total Freight Amount"; Decimal)
        {
            Caption = 'Total Freight Amount';
            DataClassification = CustomerContent;
            Editable = false; // System calculated
        }
        field(80005; "ONT Freight to Invoice"; Decimal)
        {
            Caption = 'Freight to Invoice Amount';
            DataClassification = CustomerContent;
            Editable = false; // System calculated
        }
    }


}
