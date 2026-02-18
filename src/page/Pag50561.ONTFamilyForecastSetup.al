page 50561 "ONT Family Forecast Setup"
{
    Caption = 'Family Forecast Setup';
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "ONT Family Forecast Setup";

    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Distribution Method"; Rec."Distribution Method") { ApplicationArea = All; }
                field("Include Blocked Items"; Rec."Include Blocked Items") { ApplicationArea = All; }
                field("Filter to Inventory Items"; Rec."Filter to Inventory Items") { ApplicationArea = All; }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;
}