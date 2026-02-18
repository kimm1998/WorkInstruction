page 50575 "Sales Order Lines"
{
    ApplicationArea = All;
    Caption = 'Sales Order Lines';
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type"=filter(Order));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Document_No; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Planned_Shipment_Date; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
