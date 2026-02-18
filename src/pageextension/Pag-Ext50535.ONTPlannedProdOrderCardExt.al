pageextension 50535 "ONT Planned ProdOrder Card Ext" extends "Planned Production Order"
{
    layout
    {
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
        addafter("Due Date")
        {
            field("ONT Original Due Date"; Rec."ONT Original Due Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
