page 50566 "ONT Shortage KPIs"
{
    Caption = 'Shortage KPIs';
    PageType = CardPart;
    SourceTable = "Prod. Order Component";
    ApplicationArea = Planning;
    Editable = false;

    layout
    {
        area(content)
        {
            group(Summary)
            {
                Caption = 'Summary (Current Filter)';
                field(TotalCount; TotalCount) { Caption = 'Total'; ApplicationArea = Planning; }
                field(LateCount; LateCount) { Caption = 'Late (>0)'; ApplicationArea = Planning; Style = Unfavorable; }
                field(OnTimeCount; OnTimeCount) { Caption = 'On Time'; ApplicationArea = Planning; }
                field(EarlyCount; EarlyCount) { Caption = 'Early'; ApplicationArea = Planning; Style = Favorable; }
            }
            group(Extrema)
            {
                Caption = 'Extremes';
                field(MaxDaysLate; MaxDaysLate) { Caption = 'Max Days Late'; ApplicationArea = Planning; Style = Unfavorable; }
                field(EarliestReq; EarliestReq) { Caption = 'Earliest Required'; ApplicationArea = Planning; }
                field(LatestReq; LatestReq) { Caption = 'Latest Required'; ApplicationArea = Planning; }
            }
        }
    }

    var
        WorkRec: Record "Prod. Order Component";
        TotalCount: Integer;
        LateCount: Integer;
        OnTimeCount: Integer;
        EarlyCount: Integer;
        MaxDaysLate: Integer;
        EarliestReq: Date;
        LatestReq: Date;

    procedure LoadFromView(ViewText: Text)
    var
        r: Record "Prod. Order Component";
        tmp: Record "Prod. Order Component";
        d: Integer;
        req: Date;
    begin
        Clear(TotalCount);
        Clear(LateCount);
        Clear(OnTimeCount);
        Clear(EarlyCount);
        Clear(MaxDaysLate);
        Clear(EarliestReq);
        Clear(LatestReq);

        r.SetView(ViewText);
        // Count totals
        TotalCount := r.Count();

        // Late
        tmp.SetView(ViewText);
        tmp.SetFilter("ONT Days Late", '>%1', 0);
        LateCount := tmp.Count();

        // Early
        tmp.SetView(ViewText);
        tmp.SetFilter("ONT Days Early", '>%1', 0);
        EarlyCount := tmp.Count();

        // On Time (neither early nor late)
        tmp.SetView(ViewText);
        tmp.SetRange("ONT Days Late", 0);
        tmp.SetRange("ONT Days Early", 0);
        OnTimeCount := tmp.Count();

        // Max Days Late
        tmp.SetView(ViewText);
        tmp.SetFilter("ONT Days Late", '>%1', 0);
        if tmp.FindSet() then
            repeat
                d := tmp."ONT Days Late";
                if d > MaxDaysLate then
                    MaxDaysLate := d;
            until tmp.Next() = 0;

        // Earliest / Latest Required (use ONT Required Date fallback to Due Date)
        tmp.SetView(ViewText);
        if tmp.FindSet() then
            repeat
                req := tmp."ONT Required Date";
                if req = 0D then
                    req := tmp."Due Date";
                if (req <> 0D) then begin
                    if (EarliestReq = 0D) or (req < EarliestReq) then
                        EarliestReq := req;
                    if (LatestReq = 0D) or (req > LatestReq) then
                        LatestReq := req;
                end;
            until tmp.Next() = 0;

        CurrPage.Update(false);
    end;
}
