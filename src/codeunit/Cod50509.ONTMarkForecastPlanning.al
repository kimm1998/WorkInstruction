codeunit 50509 "ONT Mark Forecast Planning"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Planning Transparency", 'OnAfterPublishSurplus', '', false, false)]
    local procedure OnAfterPublishSurplus(
        var InventoryProfile: Record "Inventory Profile";
        var StockkeepingUnit: Record "Stockkeeping Unit";
        var RequisitionLine: Record "Requisition Line";
        var ReservationEntry: Record "Reservation Entry")
    var
        UntrackedPlanningElement: Record "Untracked Planning Element";
        ForecastName: Code[10];
    begin
        // Scope UntrackedPlanningElement to this planning line
        UntrackedPlanningElement.SetRange("Worksheet Template Name", RequisitionLine."Worksheet Template Name");
        UntrackedPlanningElement.SetRange("Worksheet Batch Name", RequisitionLine."Journal Batch Name");
        UntrackedPlanningElement.SetRange("Worksheet Line No.", RequisitionLine."Line No.");

        // Keep only entries originating from a Production Forecast
        UntrackedPlanningElement.SetRange("Source Type", Database::"Production Forecast Entry");

        if UntrackedPlanningElement.FindFirst() then begin
            // For forecast-driven entries, Source ID holds the Production Forecast Name
            ForecastName := CopyStr(UntrackedPlanningElement."Source ID", 1, MaxStrLen(ForecastName));
            if (ForecastName <> '') and (RequisitionLine."ONT Demand Forecast" <> ForecastName) then begin
                RequisitionLine.Validate("ONT Demand Forecast", ForecastName);
                RequisitionLine.Modify(true);
            end;
        end
        else begin
            // Optional: clear the field if this line is not influenced by any forecast
            // if RequisitionLine."ONT Demand Forecast" <> '' then begin
            //     RequisitionLine.Validate("ONT Demand Forecast", '');
            //     RequisitionLine.Modify(true);
            // end;
        end;
    end;
}
