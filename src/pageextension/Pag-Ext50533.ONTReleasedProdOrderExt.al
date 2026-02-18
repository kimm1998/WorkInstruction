pageextension 50533 "ONT Released ProdOrder Ext" extends "Released Production Order"
{
    layout
    {
        // Add to the header after No.
        addafter("No.")
        {
            field("ONT From Demand Forecast"; Rec."ONT Demand Forecast")
            {
                ApplicationArea = All;
                Caption = 'Demand Forecast';
                ToolTip = 'True when the order was created from a planning line influenced by Demand Forecast.';
                Editable = false;
            }
        }
        addafter(Quantity)
        {
            field("ONT Total Quatity"; Rec."ONT Total Quatity")
            {
                ApplicationArea = all;
                Caption = 'Total Quantity';
            }
        }
        addafter("Due Date")
        {
            field("ONT Original Due Date"; Rec."ONT Original Due Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
