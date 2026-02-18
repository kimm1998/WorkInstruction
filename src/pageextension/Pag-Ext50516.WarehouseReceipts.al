pageextension 50516 "Warehouse Receipts" extends "Warehouse Receipts"
{
    layout
    {
        addlast(Control1)
        {
            field("Balanced"; Rec."Balanced")
            {
                ApplicationArea = All;
            }
            field("Cleared"; Rec."Cleared")
            {
                ApplicationArea = All;
            }
            field("Route"; Rec."Route")
            {
                ApplicationArea = All;
            }
            field("Container Shipping Agent"; Rec."Container Shipping Agent")
            {
                ApplicationArea = All;
            }
            field("Cargo Control No."; Rec."Cargo Control No.")
            {
                ApplicationArea = All;
            }
            field("Transit Warehouse"; Rec."Transit Warehouse")
            {
                ApplicationArea = All;
            }
            field("Expected Delivery Date"; Rec."Expected Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Delivery Date"; Rec."Delivery Date")
            {
                ApplicationArea = All;
            }
            field("Number of Pallets"; Rec."Number of Pallets")
            {
                ApplicationArea = All;
            }
            field("Storage Date"; Rec."Storage Date")
            {
                ApplicationArea = All;
            }
            field("Pickup Shipping Agent"; Rec."Pickup Shipping Agent")
            {
                ApplicationArea = All;
            }
            field("Pickup Confirmation No."; Rec."Pickup Confirmation No.")
            {
                ApplicationArea = All;
            }
            field("Release Date"; Rec."Release Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Pickup Date"; Rec."Pickup Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Pickup Tracking No."; Rec."Pickup Tracking No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
