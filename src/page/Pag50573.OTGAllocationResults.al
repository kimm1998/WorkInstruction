page 50573 "OTG Allocation Results"
{
    PageType = List;
    SourceTable = "OTG Allocation Result";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Allocation Results';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Demand Entry No."; rec."Demand Entry No.") { ApplicationArea = All; }
                field("Item Ledger Entry No."; rec."Item Ledger Entry No.") { ApplicationArea = All; }
                field("Allocated Qty (Base)"; rec."Allocated Qty (Base)") { ApplicationArea = All; }
                field("Supply Avail. Date"; rec."Supply Avail. Date") { ApplicationArea = All; }
                field("Allocation DateTime"; rec."Allocation DateTime") { ApplicationArea = All; }
                field("Source Type"; rec."Source Type") { ApplicationArea = All; }
                field("Document Type Int"; rec."Document Type Int") { ApplicationArea = All; }
                field("Document No."; rec."Document No.") { ApplicationArea = All; }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenSource)
            {
                Caption = 'Open Source';
                ApplicationArea = All;
                Image = Navigate;

                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    TransHeader: Record "Transfer Header";
                    ILE: Record "Item Ledger Entry";
                    ProdOrder: Record "Production Order";
                begin
                    case Rec."Source Type" of
                        Rec."Source Type"::OnHandILE:
                            if Rec."Item Ledger Entry No." <> 0 then begin
                                ILE.Get(Rec."Item Ledger Entry No.");
                                PAGE.Run(Page::"Item Ledger Entries", ILE);
                            end;

                        Rec."Source Type"::PurchaseLine:
                            if Rec."Document No." <> '' then begin
                                PurchHeader.Reset();
                                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                                PurchHeader.SetRange("No.", Rec."Document No.");
                                if PurchHeader.FindFirst() then
                                    PAGE.Run(Page::"Purchase Order", PurchHeader);
                            end;

                        Rec."Source Type"::TransferInboundLine:
                            if Rec."Document No." <> '' then begin
                                TransHeader.Reset();
                                TransHeader.SetRange("No.", Rec."Document No.");
                                if TransHeader.FindFirst() then
                                    PAGE.Run(Page::"Transfer Order", TransHeader);
                            end;

                        Rec."Source Type"::ProdOrderOutput:
                            if Rec."Document No." <> '' then begin
                                ProdOrder.Reset();
                                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                                ProdOrder.SetRange("No.", Rec."Document No.");
                                if ProdOrder.FindFirst() then
                                    PAGE.Run(Page::"Released Production Order", ProdOrder);
                            end;
                    end;
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Category4)
            {
                Caption = 'Navigate';
                actionref(OpenSource_Promoted; OpenSource) { }
            }
        }
    }
}
