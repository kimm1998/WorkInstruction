page 50564 "ONT Shortage Workbench"
{
    Caption = 'Shortage Workbench';
    PageType = List;
    SourceTable = "Prod. Order Component";
    UsageCategory = Tasks;
    ApplicationArea = Planning;

    // Allow editing on the page so the filter fields work
    Editable = true;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    // Default: released/firm planned, with remaining qty
    SourceTableView = WHERE(Status = FILTER("Firm Planned" | Released),
                            "Remaining Quantity" = FILTER(> 0));

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';

                field(FilterFamilyNo; FilterFamilyNo)
                {
                    Caption = 'Family No.';
                    ApplicationArea = Planning;
                    ToolTip = 'Filter by Family No. (derived from the order Source No.).';
                    Editable = true; // keep filter input enabled

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Fam: Record "Family";
                    begin
                        if PAGE.RunModal(PAGE::"Family List", Fam) = Action::LookupOK then begin
                            Text := Fam."No.";
                            exit(true);
                        end;
                        exit(false);
                    end;

                    trigger OnValidate()
                    begin
                        ApplyTopFilters();
                    end;
                }

                field(FilterDateFrom; FilterDateFrom)
                {
                    Caption = 'Required From';
                    ApplicationArea = Planning;
                    Editable = true; // keep filter input enabled
                    trigger OnValidate()
                    begin
                        ApplyTopFilters();
                    end;
                }

                field(FilterDateTo; FilterDateTo)
                {
                    Caption = 'Required To';
                    ApplicationArea = Planning;
                    Editable = true; // keep filter input enabled
                    trigger OnValidate()
                    begin
                        ApplyTopFilters();
                    end;
                }

                field(UseRequiredDate; UseRequiredDate)
                {
                    Caption = 'Filter on Required Date (else Due Date)';
                    ApplicationArea = Planning;
                    Editable = true; // keep filter input enabled
                    trigger OnValidate()
                    begin
                        ApplyTopFilters();
                    end;
                }
            }

            repeater(Lines)
            {
                ShowCaption = false;

                // All record-bound fields are read-only
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("ONT Demand Forecast"; Rec."ONT Demand Forecast")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the value of the Demand Forecast field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Planning;
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                    Visible = false;
                }

                field("ONT Family No."; Rec."ONT Family No.")
                {
                    Caption = 'Family No.';
                    ApplicationArea = Planning;
                    Editable = false;
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("ONT Bike Model No."; Rec."ONT Bike Model No.")
                {
                    ApplicationArea = All;
                }
                field("Bike Model Name"; Rec."Bike Model Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("Business Unit"; Rec."ONT Business Unit")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = Planning;
                    BlankZero = true;
                    Editable = false;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Allocated Qty (Base)"; Rec."Allocated Qty (Base)")
                {
                    ApplicationArea = All;
                }
                // Dates (stored)
                field("ONT Required Date"; Rec."ONT Required Date")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("ONT Supply Due Date"; Rec."ONT Supply Due Date")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("Earliest Avail. Date"; Rec."Earliest Avail. Date")
                {
                    ApplicationArea = All;
                }
                // Metrics (stored)
                field("ONT Days Late"; Rec."ONT Days Late")
                {
                    ApplicationArea = Planning;
                    StyleExpr = LateStyle;
                    Editable = false;
                }
                field("ONT Days Early"; Rec."ONT Days Early")
                {
                    ApplicationArea = Planning;
                    StyleExpr = EarlyStyle;
                    Editable = false;
                }
                field("ONT Availability Status"; Rec."ONT Availability Status")
                {
                    ApplicationArea = Planning;
                    StyleExpr = StatStyle;
                    Editable = false;
                }

                // Supply references
                field("ONT Supply Ref Number"; Rec."ONT Supply Reference No.")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("ONT Supply Ref Line"; Rec."ONT Supply Reference Line No.")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("ONT Shipment Date"; Rec."ONT Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("ONT Confirmed Date"; Rec."ONT Confirmed Date")
                {
                    ApplicationArea = All;
                }
                // Optional purchasing / costing cues
                field("ONT Vendor No."; Rec."ONT Vendor No.")
                {
                    ApplicationArea = Planning;
                    Caption = 'Vendor No.';
                    Editable = false;
                }
                field("ONT Ext Vendor Name"; Rec."ONT Vendor Name")
                {
                    ApplicationArea = Planning;
                    Caption = 'Vendor Name';
                    Editable = false;
                }
                field("ONT Receipt No."; Rec."ONT Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("ONT Receipt Description"; Rec."ONT Receipt Description")
                {
                    ApplicationArea = All;
                }
                field("ONT Route Name"; Rec."ONT Route Name")
                {
                    ApplicationArea = All;
                }
                field("ONT ETD"; Rec."ONT ETD")
                {
                    ApplicationArea = All;
                }
                field("ONT ETA"; Rec."ONT ETA")
                {
                    ApplicationArea = All;
                }
                field("ONT ATD"; Rec."ONT ATD")
                {
                    ApplicationArea = All;
                }
                field("ONT ATA"; Rec."ONT ATA")
                {
                    ApplicationArea = All;
                }
                field("ONT Container Shipping Agent"; Rec."ONT Container Shipping Agent")
                {
                    ApplicationArea = All;
                }
                field("ONT Vessel"; Rec."ONT Vessel")
                {
                    ApplicationArea = All;
                }
                field("ONT Reference"; Rec."ONT Reference")
                {
                    ApplicationArea = All;
                }
                field("ONT Status"; Rec."ONT Status")
                {
                    ApplicationArea = All;
                }
                field("Release Date"; Rec."Release Date")
                {
                    ApplicationArea = All;
                }
                field("Pickup Date"; Rec."Pickup Date")
                {
                    ApplicationArea = All;
                }
                field("ONT Delivery Date"; Rec."ONT Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item Status"; Rec."Item Status")
                {
                    ApplicationArea = All;
                }
                field("ONT Maker Lead Time"; Rec."ONT Maker Lead Time")
                {
                    ApplicationArea = All;
                }
                field("ONT Transit Lead Time"; Rec."ONT Transit Lead Time")
                {
                    ApplicationArea = All;
                }
                field("ONT Unit Cost (CAD)"; Rec."ONT Unit Cost (CAD)")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
                field("ONT Ext Cost CAD"; Rec."ONT Ext Cost CAD")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                }
            }
        }

        area(factboxes)
        {
            part(KPIs; "ONT Shortage KPIs")
            {
                ApplicationArea = Planning;
                Caption = 'KPIs';
            }
            part(OrderHeader; "ONT Order Header Info")
            {
                ApplicationArea = Planning;
                Caption = 'Order';
                SubPageLink = Status = field(Status),
                              "No." = field("Prod. Order No.");
            }
            part(CostSummary; "ONT Shortage Cost Summary")
            {
                ApplicationArea = Planning;
                Caption = 'Cost Summary (by Commitment)';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RecalculateView)
            {
                ApplicationArea = Planning;
                Caption = 'Recalculate (this view)';
                Image = Calculate;
                ToolTip = 'Compute lateness/earliness for all components in the current filtered set and store results.';
                trigger OnAction()
                var
                    RecalculateShortageWorkbench: Codeunit "Recalculate Shortage Workbench";
                begin
                    RecalculateShortageWorkbench.Run();
                    CurrPage.Update(false);
                    PushViewToKPI();
                end;
            }

            action(LateOnly)
            {
                ApplicationArea = Planning;
                Caption = 'Show Late Only';
                Image = Filter;
                trigger OnAction()
                begin
                    Rec.SetFilter("ONT Days Late", '>%1', 0);
                    CurrPage.Update(false);
                    PushViewToKPI();
                end;
            }

            action(ThisMonth)
            {
                ApplicationArea = Planning;
                Caption = 'Required This Month';
                Image = Calendar;
                trigger OnAction()
                var
                    firstD: Date;
                    lastD: Date;
                begin
                    firstD := DMY2DATE(1, DATE2DMY(WorkDate, 2), DATE2DMY(WorkDate, 3));
                    lastD := CALCDATE('<CM>', firstD) - 1;
                    FilterDateFrom := firstD;
                    FilterDateTo := lastD;
                    ApplyTopFilters();
                end;
            }

            action(Next30)
            {
                ApplicationArea = Planning;
                Caption = 'Required Next 30 Days';
                Image = Calendar;
                trigger OnAction()
                begin
                    FilterDateFrom := WorkDate;
                    FilterDateTo := WorkDate + 30;
                    ApplyTopFilters();
                end;
            }

            action(ClearFilters)
            {
                ApplicationArea = Planning;
                Caption = 'Clear Family/Date Filters';
                Image = ClearFilter;
                trigger OnAction()
                begin
                    FilterFamilyNo := '';
                    FilterDateFrom := 0D;
                    FilterDateTo := 0D;
                    ApplyTopFilters();
                end;
            }

            action(OpenProductionOrder)
            {
                ApplicationArea = Planning;
                Caption = 'Open Production Order';
                Image = Document;
                trigger OnAction()
                var
                    Poh: Record "Production Order";
                begin
                    if Poh.Get(Rec.Status, Rec."Prod. Order No.") then begin
                        case Poh.Status of
                            Poh.Status::"Firm Planned":
                                Page.Run(Page::"Firm Planned Prod. Order", Poh);
                            Poh.Status::Released:
                                Page.Run(Page::"Released Production Order", Poh);
                            else
                                Page.Run(Page::"Released Production Order", Poh);
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UseRequiredDate := true; // default
        ApplyTopFilters();       // apply initial filters and push view to KPIs
    end;

    trigger OnAfterGetRecord()
    begin
        // Styles
        LateStyle := '';
        EarlyStyle := '';
        StatStyle := '';
        if Rec."ONT Days Late" > 0 then begin
            LateStyle := 'Unfavorable';
            StatStyle := 'Unfavorable';
        end else if Rec."ONT Days Early" > 0 then begin
            EarlyStyle := 'Favorable';
            StatStyle := 'Favorable';
        end else
            StatStyle := 'Standard';

        // Keep KPIs in sync while user navigates
        PushViewToKPI();
    end;

    local procedure ApplyTopFilters()
    var
        dtFrom: Date;
        dtTo: Date;
    begin
        // Family filter
        if FilterFamilyNo <> '' then
            Rec.SetFilter("ONT Family No.", FilterFamilyNo)
        else
            Rec.SetRange("ONT Family No.");

        // Date window
        dtFrom := FilterDateFrom;
        dtTo := FilterDateTo;

        if UseRequiredDate then begin
            if (dtFrom <> 0D) and (dtTo <> 0D) then
                Rec.SetRange("ONT Required Date", dtFrom, dtTo)
            else if (dtFrom <> 0D) then
                Rec.SetFilter("ONT Required Date", '>=%1', dtFrom)
            else if (dtTo <> 0D) then
                Rec.SetFilter("ONT Required Date", '<=%1', dtTo)
            else
                Rec.SetRange("ONT Required Date");
        end else begin
            if (dtFrom <> 0D) and (dtTo <> 0D) then
                Rec.SetRange("Due Date", dtFrom, dtTo)
            else if (dtFrom <> 0D) then
                Rec.SetFilter("Due Date", '>=%1', dtFrom)
            else if (dtTo <> 0D) then
                Rec.SetFilter("Due Date", '<=%1', dtTo)
            else
                Rec.SetRange("Due Date");
        end;

        CurrPage.CostSummary.PAGE.LoadFromView(Rec.GetView());
        CurrPage.Update(false);
        PushViewToKPI();
    end;

    local procedure PushViewToKPI()
    begin
        CurrPage.KPIs.PAGE.LoadFromView(Rec.GetView());
    end;

    var
        // Top filter controls
        FilterFamilyNo: Text;
        FilterDateFrom: Date;
        FilterDateTo: Date;
        UseRequiredDate: Boolean;

        // style expr
        LateStyle: Text;
        EarlyStyle: Text;
        StatStyle: Text;
}
