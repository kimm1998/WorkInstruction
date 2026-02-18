pageextension 50534 "ONT FirmPln ProdOrder Card Ext" extends "Firm Planned Prod. Order"
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
            field("ONT Total Quatity"; Rec."ONT Total Quatity")
            {
                ApplicationArea = all;
            }
        }
    }
}
