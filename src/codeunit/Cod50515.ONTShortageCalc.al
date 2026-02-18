codeunit 50515 "ONT Shortage Calc"
{
    Subtype = Normal;

    procedure ComputeForComponent(var ProdComp: Record "Prod. Order Component"; Persist: Boolean)
    var
        requiredDate: Date;
        effectiveSupply: Date;
        confirmedDate: Date;
        daysLate: Integer;
        daysEarly: Integer;
        statusOpt: Option "A Temps","Trop Tard","Trop Tôt";
        today: Date;
    begin
        today := WorkDate;

        // Required date
        requiredDate := ProdComp."ONT Required Date";
        if requiredDate = 0D then
            requiredDate := ProdComp."Due Date";

        // Supply (prefer confirmed, else planned)
        confirmedDate := ProdComp."ONT Confirmed Date";
        if confirmedDate <> 0D then
            effectiveSupply := confirmedDate
        else
            effectiveSupply := ProdComp."ONT Supply Due Date";

        if effectiveSupply = 0D then
            effectiveSupply := today;

        // Deltas
        daysLate := 0;
        daysEarly := 0;
        if (requiredDate <> 0D) and (effectiveSupply <> 0D) then begin
            if effectiveSupply > requiredDate then
                daysLate := effectiveSupply - requiredDate
            else
                daysEarly := requiredDate - effectiveSupply;
        end;

        if daysLate > 0 then
            statusOpt := statusOpt::"Trop Tard"
        else if daysEarly > 0 then
            statusOpt := statusOpt::"Trop Tôt"
        else
            statusOpt := statusOpt::"A Temps";

        if Persist then begin
            if ProdComp.FieldNo("ONT Days Late") <> 0 then
                ProdComp.Validate("ONT Days Late", daysLate);
            if ProdComp.FieldNo("ONT Days Early") <> 0 then
                ProdComp.Validate("ONT Days Early", daysEarly);
            if ProdComp.FieldNo("ONT Availability Status") <> 0 then
                ProdComp.Validate("ONT Availability Status", statusOpt);
            ProdComp.Modify(true);
        end;
    end;

    procedure RecalculateForFilter(var FilteredComponents: Record "Prod. Order Component"; Persist: Boolean)
    var
        comp: Record "Prod. Order Component";
    begin
        comp.Copy(FilteredComponents, true);
        if comp.FindSet() then
            repeat
                ComputeForComponent(comp, Persist);
            until comp.Next() = 0;
    end;
}
