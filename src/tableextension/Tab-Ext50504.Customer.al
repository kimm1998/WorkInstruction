tableextension 50504 "Customer" extends Customer
{
    fields
    {
        field(80000; "Multiple Payment Code"; Code[10])
        {
            Caption = 'Multiple Payment Code';
            DataClassification = CustomerContent;
            TableRelation = "Multiple Payment Terms"."Code" where("Selected" = const(true));
        }
        field(80001; "B2B Outstanding Orders ($)"; Decimal)
        { }
        field(80002; "B2B In Shipping_Bal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Order Requisition"."Requested Qty. To Ship" where("Sell-to Customer No." = field("No."), "Document Type" = Filter(Order)));
        }
        field(80003; "B2B Code ABC"; Code[20])
        { }
        field(80004; "B2B Cust_Seq"; Integer)
        {
            InitValue = 0;
            Editable = false;
        }
        field(80005; "Surcharge Credit Card"; Text[150])
        { }
        field(80006; State; Text[50])
        {
            Caption = 'State';
        }
        field(80007; "Block Reason Code"; Code[20])
        {
            Caption = 'Block Reason Code';
            TableRelation = "On Hold Reason".Code;
        }
    }
}
