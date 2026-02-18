pageextension 50502 "Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Payment Terms Code")
        {
            field("Multiple Payment Code"; Rec."Multiple Payment Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Sales Order Type"; Rec."Sales Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order Type field.';
                ShowMandatory = true;
            }
            field("Salesman commission %"; Rec."Salesman commission %")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesman commission % field.', Comment = '%';
            }
            field("Shipping Formula"; Rec."Shipping Formula")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping fees field.', Comment = '%';
            }
            field("Fixed Shipping Rate"; Rec."Fixed Shipping Rate")
            {
                ApplicationArea = All; 
            }
            field("Sales Order On Hold"; rec."Sales Order Blocked")
            {
                ApplicationArea = all;
                ToolTip = 'Set the sales ordr on hold, this will prevent users from posting the order';
            }
            field("ONT Block Reason"; Rec."ONT Block Reason")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the reason for putting the order on hold.';
            }
            field("ONT No overright"; Rec."ONT No overright")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("LAX EDI Send Whse. Ship Order")
        {
            trigger OnAfterAction()
            var
                OrderRequisition: Record "Order Requisition";
            begin
                if Rec."LAX EDI WHSE Shp. Gen" then begin
                    OrderRequisition.SetRange("Document No.", Rec."No.");
                    OrderRequisition.SetRange("Document Type", Rec."Document Type");
                    OrderRequisition.SetRange("Cancelled", false);
                    if OrderRequisition.FindSet() then
                        repeat
                            if not OrderRequisition."EDI Whse Shp. Gen" then begin
                                OrderRequisition."EDI Whse Shp. Gen" := Rec."LAX EDI WHSE Shp. Gen";
                                OrderRequisition."EDI Whse Shp. Gen Date" := Rec."LAX EDI WHSE Shp. Gen Date";
                                OrderRequisition.Modify();
                            end;
                        until OrderRequisition.Next() = 0;
                end;
            end;
        }
        addlast(Action21)
        {
            action("Set On Hold")
            {
                ApplicationArea = all;
                Image = Stop;
                Enabled = Rec."Sales Order Blocked" = false;

                trigger OnAction()
                begin
                    rec."Sales Order Blocked" := True;
                end;
            }

            action("Unhold")
            {
                ApplicationArea = all;
                Image = ReOpen;
                Enabled = Rec."Sales Order Blocked" = true;


                trigger OnAction()
                begin
                    rec."Sales Order Blocked" := false;

                end;
            }
        }
        addafter(Reopen_Promoted)
        {
            actionref(Set__OnHold__Ref; "Set On Hold") { }
            actionref(UnHold__Ref; Unhold) { }
        }
    }
}
