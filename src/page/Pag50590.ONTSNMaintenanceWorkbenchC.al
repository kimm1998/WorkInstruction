page 50590 "ONT SN Maintenance WorkbenchC"
{
    Caption = 'Maintenance Workbench';
    PageType = List;
    SourceTable = "ONT.Main. Workbench Buff.";
    // SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;

    // Only lots with stock on hand (custom FlowField on Lot No. Information)
    // Requires: tableextension defining "ONT On Hand (Base)" (Sum of ILE Remaining Quantity)
    SourceTableView = where("Qty On Hand" = filter(> 0));

    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';

                field(ItemNoFilter; ItemNoFilter)
                {
                    Caption = 'Item No. Filter';
                    ApplicationArea = All;
                    ToolTip = 'Type an Item No. or pattern (e.g., 10*, 1000..1999) and press Enter.';
                    TableRelation = Item;
                    trigger OnValidate()
                    begin
                        ApplyItemNoFilter();
                        CurrPage.Update(false);
                    end;
                }

                field("Location Filter"; Rec."Location Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Limit results to a specific location.';
                    TableRelation = Location;
                    trigger OnValidate()
                    begin
                        if Rec.GetFilter("Location Filter") <> '' then
                            Rec.SetFilter("Expired Inventory", '>0')
                        else
                            Rec.SetRange("Expired Inventory");
                        CurrPage.Update(false);
                    end;
                }

                // Expose Date Filter for ad-hoc windows; "Expired Inventory" respects this FlowFilter
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Custom expiry window used by the "Expired Inventory" FlowField.';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        if Rec.GetFilter("Date Filter") <> '' then
                            Rec.SetFilter("Expired Inventory", '>0')
                        else
                            Rec.SetRange("Expired Inventory");
                        CurrPage.Update(false);
                    end;
                }

                field(ExpiryQuickFilter; ExpiryQuickFilter)
                {
                    Caption = 'Expiry';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Show expired, next 7/30/60 days, or all (drives Date Filter).';
                    trigger OnValidate()
                    begin
                        ApplyExpiryQuickFilter();
                        CurrPage.Update(false);
                    end;
                }

                field(MaintQuickFilter; MaintQuickFilter)
                {
                    Caption = 'Maintenance';
                    ApplicationArea = All;
                    ToolTip = 'Filter by maintenance due window (e.g., battery recharge).';
                    trigger OnValidate()
                    begin
                        ApplyMaintenanceQuickFilter();
                        CurrPage.Update(false);
                    end;
                }
            }

            repeater(Lines)
            {
                Caption = 'Lots In Stock';

                field("Item No."; Rec."Item No.") { ApplicationArea = All; }
                field("Variant Code"; Rec."Variant Code") { ApplicationArea = All; }

                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LotNoInfo: Record "Lot No. Information";
                    begin
                        if LotNoInfo.Get(Rec."Item No.", Rec."Variant Code", Rec."Lot No.") then begin
                            LotNoInfo.SetRecFilter();
                            PAGE.RunModal(Page::"Lot No. Information Card", LotNoInfo);
                        end;

                    end;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        LotNoInfo: Record "Serial No. Information";
                    begin
                        if LotNoInfo.Get(Rec."Item No.", Rec."Variant Code", Rec."Serial No.") then begin
                            LotNoInfo.SetRecFilter();
                            PAGE.RunModal(Page::"Serial No. Information Card", LotNoInfo);
                        end;

                    end;
                }

                // Lot-level expiration date you added via tableextension
                field("ONT Expiration Date"; Rec."ONT Expiration Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Expiration date recorded at the lot level.';
                }

                // Custom FlowField: Sum of ILE Remaining Qty (Open, Positive)
                field("ONT On Hand (Base)"; Rec."Qty On Hand")
                {
                    ApplicationArea = All;
                    ToolTip = 'On-hand quantity for this lot (base units).';
                }

                // Your existing FlowField: sums ILE within "Date Filter" by Expiration Date
                field(ExpiredInvWindow; Rec."Expired Inventory")
                {
                    ApplicationArea = All;
                    Caption = 'Qty in Date Filter';
                    ToolTip = 'Quantity expiring within the current Date Filter window.';
                    StyleExpr = ExpirationStyleTxt; // visual cue
                }

                // Maintenance fields/derived values
                field("ONT Last Maintenance Date"; Rec."Last Maintenance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date last serviced/recharged.';
                }
                field("Next Maintenance Due"; rec."Next Maintenance Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Calculated due date from last maintenance (or first receipt) + interval.';
                    StyleExpr = MaintenanceStyleTxt;
                }
                field("Requires Maintenance"; RequiresMaintenance)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'True if maintenance is due now or overdue.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // Expiry quick actions (set Date Filter and keep only lots with qty in that window)
            action(SetAllExpiry)
            {
                Caption = 'Expiry: All';
                ApplicationArea = All;
                Visible = false;
                Image = ClearFilter;
                trigger OnAction()
                begin
                    ExpiryQuickFilter := "ONT Expiry Quick Filter"::All;
                    ApplyExpiryQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(SetExpired)
            {
                Caption = 'Expired';
                Visible = false;
                ApplicationArea = All;
                Image = StatusCritical;
                trigger OnAction()
                begin
                    ExpiryQuickFilter := "ONT Expiry Quick Filter"::Expired;
                    ApplyExpiryQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(SetNextWeek)
            {
                Caption = 'Expiry: Next 7 days';
                Visible = false;
                ApplicationArea = All;
                Image = Calendar;
                trigger OnAction()
                begin
                    ExpiryQuickFilter := "ONT Expiry Quick Filter"::NextWeek;
                    ApplyExpiryQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(SetNextMonth)
            {
                Caption = 'Expiry: Next 30 days';
                Visible = false;
                ApplicationArea = All;
                Image = Calendar;
                trigger OnAction()
                begin
                    ExpiryQuickFilter := "ONT Expiry Quick Filter"::NextMonth;
                    ApplyExpiryQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(SetNext60)
            {
                Caption = 'Expiry: Next 60 days';
                Visible = false;
                ApplicationArea = All;
                Image = Calendar;
                trigger OnAction()
                begin
                    ExpiryQuickFilter := "ONT Expiry Quick Filter"::Next60;
                    ApplyExpiryQuickFilter();
                    CurrPage.Update(false);
                end;
            }

            // Maintenance quick actions
            action(MaintAll)
            {
                Caption = 'Maint: All';
                ApplicationArea = All;
                Image = ClearFilter;
                trigger OnAction()
                begin
                    MaintQuickFilter := "ONT Maintenance Window"::All;
                    ApplyMaintenanceQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(MaintDueNow)
            {
                Caption = 'Maint: Due Now';
                ApplicationArea = All;
                Image = StatusCritical;
                trigger OnAction()
                begin
                    MaintQuickFilter := "ONT Maintenance Window"::DueNow;
                    ApplyMaintenanceQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(MaintNext7)
            {
                Caption = 'Maint: Next 7 days';
                ApplicationArea = All;
                Image = Calendar;
                trigger OnAction()
                begin
                    MaintQuickFilter := "ONT Maintenance Window"::Next7;
                    ApplyMaintenanceQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(MaintNext30)
            {
                Caption = 'Maint: Next 30 days';
                ApplicationArea = All;
                Image = Calendar;
                trigger OnAction()
                begin
                    MaintQuickFilter := "ONT Maintenance Window"::Next30;
                    ApplyMaintenanceQuickFilter();
                    CurrPage.Update(false);
                end;
            }
            action(MaintNext60)
            {
                Caption = 'Maint: Next 60 days';
                ApplicationArea = All;
                Image = Calendar;
                trigger OnAction()
                begin
                    MaintQuickFilter := "ONT Maintenance Window"::Next60;
                    ApplyMaintenanceQuickFilter();
                    CurrPage.Update(false);
                end;
            }

            // Convenience: set last maintenance to today for selected lots
            action(MarkMaintDoneToday)
            {
                Caption = 'Set Last Maintenance = Today';
                ApplicationArea = All;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Sel: Record "ONT.Main. Workbench Buff.";
                begin
                    CurrPage.SetSelectionFilter(Sel);
                    if Sel.FindSet(true) then
                        repeat
                            Sel.Validate("Last Maintenance Date", WorkDate());
                            Sel.Modify(true);
                        until Sel.Next() = 0;
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        ItemNoFilter: Text[50];
        ExpiryQuickFilter: Enum "ONT Expiry Quick Filter";
        MaintQuickFilter: Enum "ONT Maintenance Window";
        ExpirationStyleTxt: Text[30];
        MaintenanceStyleTxt: Text[30];
        NextMaintenanceDue: Date;
        RequiresMaintenance: Boolean;
        MaintCalc: Codeunit "ONT Maintenance Calc";

        c: page "Config. Package Records";

    trigger OnOpenPage()
    begin
        // Defaults
        // ExpiryQuickFilter := "ONT Expiry Quick Filter"::NextMonth;
        // ApplyExpiryQuickFilter();
        LoadData();
        rec.SetRange("Maintenance Required", true);

        MaintQuickFilter := "ONT Maintenance Window"::All; // no restriction
        ApplyItemNoFilter();
    end;

    trigger OnAfterGetRecord()
    begin
        SetExpirationStyle();

        // Maintenance values (uses codeunit logic with lot override / item default)
        NextMaintenanceDue := MaintCalc.SerialCalcNextDueDate(Rec);
        RequiresMaintenance := (NextMaintenanceDue <> 0D) and (NextMaintenanceDue <= WorkDate());
        SetMaintenanceStyle();
    end;

    local procedure ApplyItemNoFilter()
    begin
        if ItemNoFilter = '' then
            Rec.SetRange("Item No.")
        else
            Rec.SetFilter("Item No.", ItemNoFilter);
    end;


    procedure LoadData()
    var
        LotNoInfo: Record "Lot No. Information";
        SerialNoInfo: Record "Serial No. Information";
        MaintenanceBuffer: Record "ONT.Main. Workbench Buff.";
    begin
        LotNoInfo.SetAutoCalcFields("ONT On Hand (Base)", "Expired Inventory", "ONT Maintenance Required", "ONT Maintenance Interval");
        MaintenanceBuffer.DeleteAll();
        LotNoInfo.SetFilter("ONT On Hand (Base)", '<>%1', 0);
        LotNoInfo.SetRange("ONT Maintenance Required", true);
        if LotNoInfo.FindSet(false) then
            repeat

                MaintenanceBuffer.Init();
                MaintenanceBuffer."Item No." := LotNoInfo."Item No.";
                MaintenanceBuffer."ONT Expiration Date" := LotNoInfo."ONT Expiration Date";
                MaintenanceBuffer."Qty On Hand" := LotNoInfo."ONT On Hand (Base)";
                MaintenanceBuffer."Serial No." := '';
                MaintenanceBuffer."Variant Code" := LotNoInfo."Variant Code";
                MaintenanceBuffer."Is Lot Tracked" := true;
                MaintenanceBuffer.Description := LotNoInfo.Description;
                MaintenanceBuffer."Last Maintenance Date" := LotNoInfo."ONT Last Maintenance Date";
                MaintenanceBuffer."Lot No." := LotNoInfo."Lot No.";
                MaintenanceBuffer."Expired Inventory" := LotNoInfo."Expired Inventory";
                MaintenanceBuffer."Maintenance Interval" := LotNoInfo."ONT Maintenance Interval";
                MaintenanceBuffer."Maintenance Required" := LotNoInfo."ONT Maintenance Required";
                MaintenanceBuffer."Next Maintenance Date" := LotNoInfo."ONT Next Maintenance Date";
                MaintenanceBuffer.Insert();

            until LotNoInfo.next = 0;

        SerialNoInfo.SetAutoCalcFields("ONT On Hand (Base)", "Expired Inventory", "ONT Maintenance Required", "ONT Maintenance Interval");
        SerialNoInfo.SetFilter("ONT On Hand (Base)", '<>%1', 0);
        SerialNoInfo.SetRange("ONT Maintenance Required", true);
        if SerialNoInfo.Findset(false) then
            repeat

                MaintenanceBuffer.Init();
                MaintenanceBuffer."Item No." := SerialNoInfo."Item No.";
                MaintenanceBuffer."Serial No." := SerialNoInfo."Serial No.";
                MaintenanceBuffer."Lot No." := SerialNoInfo."ONT Child Lot No.";
                MaintenanceBuffer."Last Maintenance Date" := SerialNoInfo."ONT Last Maintenance Date";
                MaintenanceBuffer."Variant Code" := SerialNoInfo."Variant Code";
                MaintenanceBuffer."ONT Expiration Date" := SerialNoInfo."ONT Expiration Date";
                MaintenanceBuffer."Qty On Hand" := SerialNoInfo."ONT On Hand (Base)";
                MaintenanceBuffer."Expired Inventory" := SerialNoInfo."Expired Inventory";
                MaintenanceBuffer."Is Lot Tracked" := false;
                MaintenanceBuffer."Maintenance Interval" := SerialNoInfo."ONT Maintenance Interval";
                MaintenanceBuffer."Maintenance Required" := SerialNoInfo."ONT Maintenance Required";
                MaintenanceBuffer."Next Maintenance Date" := SerialNoInfo."ONT Next Maintenance Date";
                MaintenanceBuffer.Description := SerialNoInfo.Description;
                MaintenanceBuffer.Insert();

            until SerialNoInfo.Next() = 0;
    end;

    local procedure ApplyExpiryQuickFilter()
    var
        Today: Date;
        FromDate: Date;
        ToDate: Date;
        HasWindow: Boolean;
    begin
        Today := WorkDate();
        HasWindow := true;

        case ExpiryQuickFilter of
            "ONT Expiry Quick Filter"::All:
                begin
                    Rec.SetRange("Date Filter");
                    Rec.SetRange("Expired Inventory");
                    HasWindow := false;
                end;

            "ONT Expiry Quick Filter"::Expired:
                Rec.SetFilter("Date Filter", '..%1', Today - 1);

            "ONT Expiry Quick Filter"::NextWeek:
                begin
                    FromDate := Today;
                    ToDate := Today + 7;
                    Rec.SetFilter("Date Filter", '%1..%2', FromDate, ToDate);
                end;

            "ONT Expiry Quick Filter"::NextMonth:
                begin
                    FromDate := Today;
                    ToDate := Today + 30;
                    Rec.SetFilter("Date Filter", '%1..%2', FromDate, ToDate);
                end;

            "ONT Expiry Quick Filter"::Next60:
                begin
                    FromDate := Today;
                    ToDate := Today + 60;
                    Rec.SetFilter("Date Filter", '%1..%2', FromDate, ToDate);
                end;
        end;

        // Only show lots that have quantity within the chosen window
        // if HasWindow then
        // Rec.SetFilter("Expired Inventory", '>0');
    end;

    local procedure ApplyMaintenanceQuickFilter()
    var
        ViewTxt: Text;
        Lot: Record "ONT.Main. Workbench Buff.";
    begin
        // If "All" -> clear any MARK filtering
        if MaintQuickFilter = "ONT Maintenance Window"::All then begin
            Rec.MarkedOnly(false);
            exit;
        end;

        // Preserve the current list filters (item, location, date, in-stock, etc.)
        ViewTxt := Rec.GetView();
        Lot.Reset();
        Lot.SetView(ViewTxt);
        Lot.MarkedOnly(false);

        // Clear previous marks within the current filtered set
        Rec.MarkedOnly(false);
        if Rec.FindSet() then
            repeat
                Rec.Mark(false);
            until Rec.Next() = 0;

        // Mark records that match the maintenance window
        if Rec.FindSet() then
            repeat
                if MaintCalc.SerialIsDueInWindow(Rec, MaintQuickFilter) then
                    Rec.Mark(true)
            until Rec.Next() = 0;

        // Restrict the page to marked records
        Rec.MarkedOnly(true);
    end;

    local procedure SetExpirationStyle()
    var
        Today: Date;
        HasQtyInWindow: Boolean;
    begin
        Today := WorkDate();

        // Prefer explicit lot-level expiration date if present
        if Rec."ONT Expiration Date" <> 0D then begin
            if Rec."ONT Expiration Date" < Today then
                ExpirationStyleTxt := 'Unfavorable' // expired
            else if Rec."ONT Expiration Date" <= (Today + 7) then
                ExpirationStyleTxt := 'Attention'   // near-expiry
            else
                ExpirationStyleTxt := 'Standard';
            exit;
        end;

        // Fallback: highlight rows that have qty in the active Date Filter window
        // Rec.CalcFields("Expired Inventory");
        HasQtyInWindow := (Rec.GetFilter("Date Filter") <> '') and (Rec."Expired Inventory" > 0);

        case ExpiryQuickFilter of
            "ONT Expiry Quick Filter"::Expired:
                ExpirationStyleTxt := SelectStyle(HasQtyInWindow, 'Unfavorable', 'Standard');
            "ONT Expiry Quick Filter"::NextWeek,
            "ONT Expiry Quick Filter"::NextMonth,
            "ONT Expiry Quick Filter"::Next60:
                ExpirationStyleTxt := SelectStyle(HasQtyInWindow, 'Attention', 'Standard');
            else
                ExpirationStyleTxt := 'Standard';
        end;
    end;

    local procedure SelectStyle(Condition: Boolean; TrueStyle: Text[30]; FalseStyle: Text[30]): Text[30]
    begin
        if Condition then
            exit(TrueStyle);
        exit(FalseStyle);
    end;

    local procedure SetMaintenanceStyle()
    begin
        if (NextMaintenanceDue <> 0D) and (NextMaintenanceDue < WorkDate()) then
            MaintenanceStyleTxt := 'Unfavorable' // overdue
        else if (NextMaintenanceDue <> 0D) and (NextMaintenanceDue <= WorkDate() + 7) then
            MaintenanceStyleTxt := 'Attention'
        else
            MaintenanceStyleTxt := 'Standard';
    end;
}
