pageextension 50541 "ONT Lot Info List Ext" extends "Lot No. Information List"
{
    layout
    {
        addafter("Lot No.")
        {
            field("ONT Last Maintenance Date"; Rec."ONT Last Maintenance Date")
            {
                ApplicationArea = All;
                ToolTip = 'Date last serviced/recharged.';
            }
            field("ONT On Hand (Base)"; Rec."ONT On Hand (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Hand (Base) field.', Comment = '%';
            }
            field("ONT Expiration Date"; Rec."ONT Expiration Date")
            {
                ApplicationArea = All;
                ToolTip = 'Expiration date recorded at the lot level.';
            }
        }
    }
}
