pageextension 50527 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field.';
            }
            field("Requested Qty. To Ship"; Rec."Requested Qty. To Ship")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requested Qty. To Ship field.';
            }
            field("Total Req. Qty. To Ship"; Rec."Total Req. Qty. To Ship")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Req. Qty. To Ship field.';
            }
            field("OTG Sales Line On Hold"; Rec."OTG Sales Line On Hold")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Hold field.';
            }
        }

        addafter("Unit Price")
        {
            field("ONT Total Freight Amount"; Rec."ONT Total Freight Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Freight Amount field.';
            }
            field("ONT Freight to Invoice"; Rec."ONT Freight to Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Freight to Invoice Amount field.';
            }
        }
    }
}
