pageextension 50554 "Salesperson Card Ext" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("Commission %")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Caption = 'Commission Vendor';
                ToolTip = 'Specifies the Vendor account linked to this salesperson for payment.';
                DrillDown = true;
            }

        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("OTG.Commission Vendors")
            {
                ApplicationArea = all;
                Caption = 'Commission Vendors';
                RunObject = page "Sales Type Commission";
                RunPageLink = Salesperson = field(Code);
                RunPageMode = Edit;
                // trigger OnAction()
                // begin

                // end;
            }
        }
        addafter(Dimensions_Promoted)
        {
            actionref(Commission__Vendors; "OTG.Commission Vendors") { }
        }
    }
}

