pageextension 50513 "Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Revision No."; Rec."Revision No.")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Revision No.';
            }
        }
        addlast(Control1)
        {
            field("Whse Receipt No."; Rec."Whse Receipt No.")
            {
                ApplicationArea = All;
                ToolTip = 'Whse. Receipt No.';
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Item Category Code';
            }
            field("Container ID"; Rec."Container ID")
            {
                ApplicationArea = All;
            }
            field("Import Custom Rate %"; Rec."Import Custom Rate %")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Modified field behavior by Cycles Devinci: originally used to specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item. Now used only to manage the import custom fees, by lookup with Custom Rate table using article no., Tariff no. and article origin.';
            }
        }
        addbefore("Lead Time Calculation")
        {
            field("Manufacturing Lead Time"; Rec."Manufacturing Lead Time")
            {
                ApplicationArea = All;
                ToolTip = 'Manufacturing Lead Time';
            }
            field("Transit Lead Time"; Rec."Transit Lead Time")
            {
                ApplicationArea = All;
                ToolTip = 'Transit Lead Time';
            }
        }
        modify("Lead Time Calculation")
        {
            Editable = false;
            Visible = true;
        }
        addafter("Lead Time Calculation")
        {
            field("Requested Ship Date"; Rec."Requested Ship Date")
            {
                ApplicationArea = All;
                ToolTip = 'Requested Ship Date';
                Editable = dateEditable;
            }
            field("Promised Ship Date"; Rec."Promised Ship Date")
            {
                ApplicationArea = All;
                ToolTip = 'Promised Ship Date';
                Editable = dateEditable;
            }
            field("Planned Ship Date"; Rec."Planned Ship Date")
            {
                ApplicationArea = All;
                ToolTip = 'Planned Ship Date';
                Editable = dateEditable;
            }
        }
        modify("Promised Receipt Date")
        {
            Editable = dateEditable;
        }
        modify("Planned Receipt Date")
        {
            Editable = dateEditable;
        }
        modify("Expected Receipt Date")
        {
            Editable = dateEditable;
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CheckIfWhseReceiptExist();
    end;

    Procedure CheckIfWhseReceiptExist()
    var
    begin
        if rec."Whse Receipt No." = '' then
            dateEditable := true
        else
            dateEditable := false;
    end;

    var
        dateEditable: Boolean;
}
