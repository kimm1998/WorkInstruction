pageextension 50518 "Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    actions
    {
        addafter("&Receipt")
        {
            // action(RawMaterielLabel)
            // {
            //     ApplicationArea = All;
            //     Caption = 'item label';
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     Image = Report;

            //     trigger OnAction()
            //     var
            //         PurchRcptHeader: Record "Purch. Rcpt. Header";
            //         RawMaterielLabel: Report "Raw Materiel Label 01";
            //     // PurchRcptLine: Record "Purch. Rcpt. Line";
            //     begin
            //         PurchRcptHeader.Reset();
            //         PurchRcptHeader.SetRange("No.", rec."No.");
            //         RawMaterielLabel.SetTableView(PurchRcptHeader);
            //         RawMaterielLabel.RunModal();
            //     end;
            // }
        }
    }
}
