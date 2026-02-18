pageextension 50519 "Bins" extends Bins
{
    actions
    {
        addafter("&Contents")
        {
            action(BinLabel)
            {
                ApplicationArea = All;
                Caption = 'Bin label';
                Image = Report;

                trigger OnAction()
                var
                    Bin: Record Bin;
                    BinLabel: Report "Bin Label";
                begin
                    Bin := rec;
                    CurrPage.SetSelectionFilter(Bin);
                    BinLabel.SetTableView(Bin);
                    BinLabel.RunModal();
                end;
            }
        }
    }
}
