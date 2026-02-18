page 50546 "ONT Shipping Costs"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ONT Shipping Cost";
    Caption = 'Shipping Costs';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Sales Market"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales market.';
                }
                field("Province Code"; Rec."Province Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the province code.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the product type.';
                }
                field("RMH Code"; Rec."RMH Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RMH code.';
                }
                field("Propulsion Code"; Rec."Propulsion Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the propulsion code.';
                }
                field("Segment Code"; Rec."Segment Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the segment code.';
                }
                field("Is Kids Product"; Rec."Is Kids Product")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is a kids product.';
                }
                field("Unit Shipping Fee"; Rec."Unit Shipping Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit shipping fee.';
                }
                field("Free Shipping Min. Qty"; Rec."Free Shipping Min. Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum quantity for free shipping.';
                }
                field("Free Shipping Min. Amount"; Rec."Free Shipping Min. Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum amount for free shipping.';
                }
            }
        }
    }
}