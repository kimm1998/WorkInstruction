page 50591 "Commission Worksheet"
{
    PageType = Worksheet;
    ApplicationArea = All;
    Caption = 'Salesperson Commission Worksheet';
    UsageCategory = Tasks;
    SourceTable = "Commission Buffer";
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field(FilterSalesperson; SalespersonFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Salesperson Code';
                    TableRelation = "Salesperson/Purchaser";
                    trigger OnValidate()
                    begin
                        LoadData();
                    end;
                }
                field(FilterDate; DateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Date Filter';
                    trigger OnValidate()
                    var
                        FilterTokens: Codeunit "Filter Tokens";
                    begin
                        FilterTokens.MakeDateFilter(DateFilter);
                    end;
                }
            }

            repeater(Group)
            {
                // New Checkbox Column
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    ToolTip = 'Check to include this line in the Purchase Invoice generation.';
                }

                field("Document Type"; Rec."Document Type") { ApplicationArea = All; Editable = false; }
                field("Document No."; Rec."Document No.") { ApplicationArea = All; Editable = false; }
                field("Sales Order Type"; Rec."Sales Order Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sales Order No."; Rec."Order No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; Editable = false; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; Editable = false; }
                field("Customer Name"; Rec."Customer Name") { ApplicationArea = All; Editable = false; }

                field("Sales Amount"; Rec."Sales Amount (LCY)") { ApplicationArea = All; Editable = false; }

                field("Collected Amount"; Rec."Collected Amount (LCY)")
                {
                    ApplicationArea = All;
                    StyleExpr = PaymentStyle;
                    Editable = false;
                    ToolTip = 'Defines the amount paid by the customer on this order';
                }

                field("Commission Paid"; Rec."Commission Paid")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Commission Paid Not Posted"; Rec."Commission Paid Not Posted")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Commission to Pay"; Rec."Commission to Pay")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // Editable Field
                field("Commission %"; Rec."Commission %")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ToolTip = 'You can edit the percentage manually. The Amount will update automatically.';

                    trigger OnValidate()
                    begin
                        Rec.Modify(); // Save the calculation to the temp table immediately
                        CurrPage.Update(false);
                    end;
                }

                // Calculated Field (updated by trigger in table)
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ToolTip = 'You can edit the Amount manually. The Percentage will update automatically.';
                    trigger OnValidate()
                    begin
                        Rec.Modify(); // Save the calculation to the temp table immediately
                        CurrPage.Update(false);
                    end;
                    // Editable = false; // User edits % to change this, or you can make this editable too if you prefer
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LoadCommissionData)
            {
                Caption = 'Calculate Commissions';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    LoadData();
                end;
            }

            group(Selection)
            {
                Caption = 'Selection';
                Image = Select;

                action(SelectAll)
                {
                    Caption = 'Select All';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        TempCopy: Record "Commission Buffer" temporary;
                    begin
                        // Copy to avoid iterating on the view while modifying
                        TempCopy.Copy(Rec, true);
                        if TempCopy.FindSet() then
                            repeat
                                TempCopy.Approved := true;
                                TempCopy.Modify();
                            until TempCopy.Next() = 0;
                        CurrPage.Update(false);
                    end;
                }
                action(DeselectAll)
                {
                    Caption = 'Unselect All';
                    Image = CancelLine;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        TempCopy: Record "Commission Buffer" temporary;
                    begin
                        TempCopy.Copy(Rec, true);
                        if TempCopy.FindSet() then
                            repeat
                                TempCopy.Approved := false;
                                TempCopy.Modify();
                            until TempCopy.Next() = 0;
                        CurrPage.Update(false);
                    end;
                }
            }

            action(CreateInvoice)
            {
                Caption = 'Create Purchase Invoice';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CommEngine: Codeunit "Commission Engine";
                    ApprovedRows: Record "Commission Buffer" temporary;
                begin
                    // 1. Filter the record set to only show Approved lines
                    Rec.SetRange(Approved, true);

                    // 2. Check if anything is selected
                    if Rec.IsEmpty then begin
                        Rec.SetRange(Approved); // Reset filter
                        Error('No lines are approved. Please check the "Approve" box for the lines you want to process.');
                    end;

                    // 3. Pass the filtered view to the Engine
                    // We copy to a new variable to pass to the Codeunit to avoid messing up the Page View permanently
                    ApprovedRows.Copy(Rec, true);

                    if Confirm('Create Purchase Invoice(s) for the %1 approved line(s)?', true, ApprovedRows.Count) then begin
                        CommEngine.CreatePurchaseInvoice(ApprovedRows);

                        // 4. Reset filters and Reload
                        Rec.SetRange(Approved);
                        LoadData();
                    end else begin
                        // If canceled, reset the filter so user sees all lines again
                        Rec.SetRange(Approved);
                    end;
                end;
            }
        }
    }

    var
        SalespersonFilter: Code[20];
        DateFilter: Text;
        PaymentStyle: Text;

    local procedure LoadData()
    var
        CommEngine: Codeunit "Commission Engine";
    begin
        CommEngine.LoadCommissionLines(Rec, SalespersonFilter, DateFilter);
        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Is Fully Paid" then
            PaymentStyle := 'Favorable'
        else
            PaymentStyle := 'Standard';
    end;
}