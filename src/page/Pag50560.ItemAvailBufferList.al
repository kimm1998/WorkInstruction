page 50560 "ONT.Item Avail. Buffer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ONT_ItemAvailabilityBuffer;
    Caption = 'Item Availability Projection Buffer';
    Editable = false; // Prevent manual editing

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unique entry number.';
                    Visible = false; // Hidden by default, useful for debugging
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The date of the supply or demand event.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source type (Purchase, Sale, etc.).';
                }
                field("Document No."; Rec."Source ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'The document number (e.g., PO1001).';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of the event.';
                }
                field("Qty. In"; Rec."Qty. In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Supply quantity (Positive adjustment to inventory).';
                    Style = Favorable; // Green color for supply
                }
                field("Qty. Out"; Rec."Qty. Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Demand quantity (Negative adjustment to inventory).';
                    Style = Attention; // Red color for demand
                }
                field("Availability"; Rec."Availability")
                {
                    ApplicationArea = All;
                    Caption = 'Availability at Date';
                    ToolTip = 'The running balance of inventory at this specific date.';
                    Style = Strong;
                }
                field("Min. Avail. Next In"; Rec."Min. Avail. Next In")
                {
                    ApplicationArea = All;
                    Caption = 'Min Available until Next IN';
                    ToolTip = 'The lowest inventory level reached between this date and the next supply event.';
                }
                field("Min. Avail. End"; Rec."Min. Avail. End")
                {
                    ApplicationArea = All;
                    Caption = 'Min Available to End';
                    ToolTip = 'The lowest inventory level reached from this date until the end of the projection horizon.';
                }
            }
        }
    }
}