page 50547 "ONT Operation Status FactBox"
{
    Caption = 'Operation Status';
    // Editable = false;
    PageType = ListPart;
    SourceTable = "Prod. Order Routing Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Operations';
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Operation Desc.';
                    ToolTip = 'Specifies the name of operations that are assigned to this production order.';
                    Editable = false;
                }
                // field("SFI Assigned-To No."; Rec."SFI Assigned-To No.")//recheck
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                //     Caption = 'Assigned-To No.';
                // }
                // field("SFI Assigned-To Name"; Rec."SFI Assigned-To Name")//recheck
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Caption = 'Assigned-To Name';
                // }
                field("ONT Remaining Output Qty"; "ONT Remaining Output Qty")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remaining Output Qty';
                    Editable = false;
                    ToolTip = 'Specifies the remaining output qty of the operation that is assigned to this production order.';
                }
                field("Routing Status"; Rec."Routing Status")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Routing Status';
                    Editable = false;
                    ToolTip = 'Specifies the routing status of the operation that is assigned to this production order.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {

            // action("Assign to")//recheck
            // {
            //     ApplicationArea = all;
            //     Visible = rec.Status = rec.Status::Released;
            //     trigger OnAction()
            //     var
            //         SFIEmployee: page "SFI Employee List";
            //         Employee: Record "SFI Employee";
            //     begin
            //         SFIEmployee.LookupMode := true;
            //         if SFIEmployee.RunModal() = Action::LookupOK then begin
            //             SFIEmployee.GetRecord(Employee);
            //             AssignOperation(Employee);
            //         end;
            //     end;
            // }
        }
    }
    // local procedure AssignOperation(Employee: Record "SFI Employee")//recheck
    // var
    //     SFIDocAssign: Record "SFI Document Assignment";
    // begin
    //     SFIDocAssign.SetRange("Document Type", SFIDocAssign."Document Type"::"Prod. Order");
    //     SFIDocAssign.SetRange("Document No.", rec."Prod. Order No.");
    //     SFIDocAssign.SetRange("Document Line No.", rec."Routing Reference No.");
    //     SFIDocAssign.SetRange("Task No.", rec."Operation No.");
    //     if SFIDocAssign.FindFirst() then begin
    //         if SFIDocAssign."Employee No." <> Employee."No." then begin
    //             SFIDocAssign.Validate("Employee No.", Employee."No.");
    //             SFIDocAssign.Modify();
    //         end;
    //     end
    //     else begin
    //         SFIDocAssign.Reset();
    //         SFIDocAssign.Validate("Document Type", SFIDocAssign."Document Type"::"Prod. Order");
    //         SFIDocAssign.Validate("Document No.", rec."Prod. Order No.");
    //         SFIDocAssign.Validate("Document Line No.", rec."Routing Reference No.");
    //         SFIDocAssign.Validate("Task No.", rec."Operation No.");
    //         SFIDocAssign."Task ID No." := 0;
    //         SFIDocAssign.Validate("Employee No.", Employee."No.");
    //         SFIDocAssign.Insert(true);
    //     end;
    // end;

    // trigger OnAfterGetRecord()//recheck

    // begin
    //     REC.CalcFields("ONT Output Qty");
    //     "ONT Remaining Output Qty" := Rec."Input Quantity" - Rec."ONT Output Qty";
    // end;

    var
        "ONT Remaining Output Qty": Integer;
}

