pageextension 50511 "Posted Purch Rcpt. Subform" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Revision No."; Rec."Revision No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Revision No. field.';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter(ItemInvoiceLines)
        {
            // action(RawMaterielLabel)
            // {
            //     ApplicationArea = All;
            //     Caption = 'item label';
            //     Image = Report;

            //     trigger OnAction()
            //     var
            //         LItem: Record Item;
            //         RawMaterielLabel: Report "Raw Materiel Label";
            //     begin
            //         LItem.SetRange("No.", rec."No.");
            //         LItem.SetRange("Vendor No.", rec."Pay-to Vendor No.");
            //         LItem.SetRange("Variant Filter", rec."Variant Code");
            //         if LItem.FindFirst() then begin
            //             RawMaterielLabel.SetTableView(LItem);
            //             RawMaterielLabel.RunModal();
            //         end;
            //     end;
            // }
        }
    }
}
