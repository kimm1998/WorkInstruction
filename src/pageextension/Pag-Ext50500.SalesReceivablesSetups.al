pageextension 50500 "Sales & Receivables Setups" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ToolTip = 'Specifies the value of the Journal Template Name field.';
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ToolTip = 'Specifies the value of the Journal Batch Name field.';
                ApplicationArea = All;
            }
            field("Azure Account Key"; Rec."Azure Account Key")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Azure Account Key field.';
            }
            field("Azure Account Name"; Rec."Azure Account Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Azure Account Name field.';
            }
            field("Product Folder Location"; Rec."Product Folder Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Product Folder Location field.';
            }
            field("Attribute Folder Location"; Rec."Attribute Folder Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attribute Folder Location field.';
            }
            field("Sales Inv File Network"; Rec."Sales Inv File Network")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Azure Account Name field.';
            }
            field("On Hold Reason Code"; Rec."Block Reason Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Hold Reason Code field.';
            }
            field("Freight Item No."; Rec."Freight Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Item number used for adding calculated shipping charges.';
            }
        }
    }
}
