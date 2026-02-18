page 50579 "Order Requisitions"
{
    PageType = List;
    Caption = 'Order Requisitions';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Order Requisition";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Requisition No."; Rec."Requisition No.")
                {
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    ToolTip = 'Specifies the value of the Ordered Qty field.';
                }
                field("Requested Qty. To Ship"; Rec."Requested Qty. To Ship")
                {
                    ToolTip = 'Specifies the value of the Requested Qty. To Ship field.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Shipment Date field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Ship. Agent Service Code"; Rec."Ship. Agent Service Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field("Qty Shipped"; Rec."Qty Shipped")
                {
                    ToolTip = 'Specifies the value of the Qty Shipped field.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field("EDI Order"; Rec."EDI Order")
                {
                    ToolTip = 'Specifies the value of the EDI Order field.';
                }
                field("EDI Whse Shp. Gen"; Rec."EDI Whse Shp. Gen")
                {
                    ToolTip = 'Specifies the value of the EDI Whse Shp. Gen field.';
                }
                field("EDI Whse Shp. Gen Date"; Rec."EDI Whse Shp. Gen Date")
                {
                    ToolTip = 'Specifies the value of the EDI Whse Shp. Gen Date field.';
                }
                field("Cancelled"; Rec."Cancelled")
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field("Error"; Rec."Error")
                {
                    ToolTip = 'Specifies the value of the Error field.';
                }
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field.';
                }
                field("Processed"; Rec."Processed")
                {
                    ToolTip = 'Specifies the value of the Processed field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportRequisition)
            {
                Caption = 'Process Requisition';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ImportExcel;

                trigger OnAction()
                begin
                    Rec.ReadExcelSheet();
                    Rec.ImportExcelData();
                end;
            }
        }
    }
}
