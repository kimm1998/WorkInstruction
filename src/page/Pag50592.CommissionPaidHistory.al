page 50592 "Commission Paid History"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Commission Paid History';
    SourceTable = "Sales Invoice Header";
    SourceTableView = where("Commission Amount Paid" = filter(<> 0)); // Only show paid ones
    UsageCategory = History;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoice No.';
                    ToolTip = 'The original sales invoice number.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Commission Amount Paid"; Rec."Commission Amount Paid")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Caption = 'Commission Paid';
                }
                field("Comm. Purch. Inv. No."; Rec."Comm. Purch. Inv. No.")
                {
                    ApplicationArea = All;
                    Caption = 'Generated Purchase Inv.';

                    // Click to open the Purchase Invoice
                    trigger OnDrillDown()
                    var
                        PurchHeader: Record "Purchase Header";
                    begin
                        if PurchHeader.Get(PurchHeader."Document Type"::Invoice, Rec."Comm. Purch. Inv. No.") then
                            Page.Run(Page::"Purchase Invoice", PurchHeader)
                        else
                            Message('The Purchase Invoice %1 has likely been posted to the Archives.', Rec."Comm. Purch. Inv. No.");
                    end;
                }
                field("Sales Order Type"; Rec."Sales Order Type")
                {
                    ApplicationArea = all;
                }
                field(SalesTypeDescription; SalesTypeDescription)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Sales Type Description';
                }
                field("Order No."; Rec."Order No.") { ApplicationArea = all; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenInvoice)
            {
                Caption = 'Open Sales Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Sales Invoice";
                RunPageLink = "No." = field("No.");
            }
        }
    }


    trigger OnAfterGetRecord()
    var

    begin
        if SalesOrderType.get(rec."Sales Order Type") then
            SalesTypeDescription := SalesOrderType.Description;
    end;

    var
        SalesTypeDescription: text[200];
        SalesOrderType: Record "ONT Sales Type";
}