pageextension 50544 LicensePlate extends "IWX License Plate"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(miPrintLabel)
        {
            Action("Print New label")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = PrintForm;
                trigger OnAction()
                var
                    myInt: Integer;
                    LPHeader: Record "IWX LP Header";
                begin
                    LPHeader.SetRange("No.", rec."No.");
                    if LPHeader.FindFirst() then
                        report.run(report::"LP Label", false, false, LPHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}