page 50571 "OTG Confirmed Demand"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "OTG Demand Buffer";
    Caption = 'Confirmed Demand';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Demand Date"; Rec."Demand Date")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = '1 = highest priority';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ApplicationArea = All;
                }
                field("Allocated Qty (Base)"; Rec."Allocated Qty (Base)")
                {
                    ApplicationArea = All;
                }
                field("Earliest Avail. Date"; Rec."Earliest Avail. Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Fully Allocated"; Rec."Fully Allocated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LoadDemand)
            {
                Caption = 'Load Demand';
                ApplicationArea = All;
                Image = Import;
                trigger OnAction()
                begin
                    REPORT.RunModal(REPORT::"OTG Load Demand");
                    CurrPage.Update(false);
                end;
            }

            action(CalculateAvailability)
            {
                Caption = 'Calculate Earliest Material Availability';
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                var
                    Calc: Codeunit "OTG Earliest Availability";
                begin
                    Calc.RunForAllDemand();
                    CurrPage.Update(false);
                end;
            }

            action(ViewAllocations)
            {
                Caption = 'View Allocations';
                ApplicationArea = All;
                Image = View;

                trigger OnAction()
                var
                    Alloc: Record "OTG Allocation Result";
                begin
                    Alloc.Reset();
                    Alloc.SetRange("Demand Entry No.", Rec."Entry No.");
                    PAGE.RunModal(Page::"OTG Allocation Results", Alloc);
                end;
            }
        }
        area(Navigation)
        {
            action("ShowDocument")
            {
                Caption = 'Show Document';
                ApplicationArea = All;
                Image = Open;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    ProductionOrder: Record "Production Order";
                begin
                    case Rec."Source Type" of
                        Rec."Source Type"::"Sales Line":
                            begin
                                SalesHeader.SetRange("No.", Rec."Source No.");
                                Page.Run(0, SalesHeader);
                            end;
                        Rec."Source Type"::"Prod. Order Comp.":
                            begin
                                ProductionOrder.SetRange("No.", Rec."Source No.");
                                Page.Run(0, ProductionOrder);
                            end;
                    end;
                end;
            }

        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';
                actionref(LoadDemand_Promoted; LoadDemand) { }
                actionref(CalculateAvailability_Promoted; CalculateAvailability) { }
                actionref(ViewAllocations_Promoted; ViewAllocations) { }
            }
            group(Category_Category4)
            {
                Caption = 'Navigate';
                actionref(ShowDocument_Promoted; ShowDocument) { }
            }
        }

    }
}
