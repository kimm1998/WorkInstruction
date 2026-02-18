codeunit 50519 "ONT Maintenance Calc"
{
    SingleInstance = false;

    procedure CalcNextDueDate(var LotInfo: Record "Lot No. Information"): Date
    var
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        BaseDate: Date;
        Interval: DateFormula;
        NextDue: Date;
    begin
        // 1) Determine interval: lot override > item default
        CLEAR(Interval);
        LotInfo.CalcFields("ONT Maintenance Interval");
        if FORMAT(LotInfo."ONT Maintenance Interval") <> '' then
            Interval := LotInfo."ONT Maintenance Interval"
        else begin
            if Item.Get(LotInfo."Item No.") then
                if FORMAT(Item."ONT Maintenance Interval") <> '' then
                    Interval := Item."ONT Maintenance Interval";
        end;

        if FORMAT(Interval) = '' then
            exit(0D); // Not applicable

        // 2) Base date: last maintenance date, else first inbound posting date for this lot
        if LotInfo."ONT Last Maintenance Date" <> 0D then
            BaseDate := LotInfo."ONT Last Maintenance Date"
        else begin
            ILE.Reset();
            ILE.SetCurrentKey("Posting Date");
            ILE.SetRange("Item No.", LotInfo."Item No.");
            ILE.SetRange("Variant Code", LotInfo."Variant Code");
            ILE.SetRange("Lot No.", LotInfo."Lot No.");
            ILE.SetFilter(Quantity, '>0'); // inbound entries
            if ILE.FindFirst() then
                BaseDate := ILE."Posting Date";
        end;

        if BaseDate = 0D then
            exit(0D); // No base to calculate from

        NextDue := CalcDate(Interval, BaseDate);
        exit(NextDue);
    end;

    procedure IsDueInWindow(LotInfo: Record "Lot No. Information"; Window: Enum "ONT Maintenance Window"): Boolean
    var
        Today: Date;
        DueDate: Date;
        FromDate: Date;
        ToDate: Date;
    begin
        Today := WorkDate();
        DueDate := CalcNextDueDate(LotInfo);
        if DueDate = 0D then
            exit(false); // Not applicable

        case Window of
            Window::All:
                exit(true);
            Window::DueNow:
                exit(DueDate <= Today);
            Window::Next7:
                begin
                    FromDate := Today + 1;
                    ToDate := Today + 7;
                    exit((DueDate >= FromDate) and (DueDate <= ToDate));
                end;
            Window::Next30:
                begin
                    FromDate := Today + 1;
                    ToDate := Today + 30;
                    exit((DueDate >= FromDate) and (DueDate <= ToDate));
                end;
            Window::Next60:
                begin
                    FromDate := Today + 1;
                    ToDate := Today + 60;
                    exit((DueDate >= FromDate) and (DueDate <= ToDate));
                end;
        end;
    end;






    procedure SerialCalcNextDueDate(var MaintenanceBuffer: Record "ONT.Main. Workbench Buff."): Date
    var
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        BaseDate: Date;
        Interval: DateFormula;
        NextDue: Date;
    begin
        // 1) Determine interval: lot override > item default
        CLEAR(Interval);
        // MaintenanceBuffer.CalcFields("Maintenance Interval");
        if FORMAT(MaintenanceBuffer."Maintenance Interval") <> '' then
            Interval := MaintenanceBuffer."Maintenance Interval"
        else begin
            if Item.Get(MaintenanceBuffer."Item No.") then
                if FORMAT(Item."ONT Maintenance Interval") <> '' then
                    Interval := Item."ONT Maintenance Interval";
        end;

        if FORMAT(Interval) = '' then
            exit(0D); // Not applicable

        // 2) Base date: last maintenance date, else first inbound posting date for this lot
        if MaintenanceBuffer."Last Maintenance Date" <> 0D then
            BaseDate := MaintenanceBuffer."Last Maintenance Date"
        else begin
            ILE.Reset();
            ILE.SetCurrentKey("Posting Date");
            ILE.SetRange("Item No.", MaintenanceBuffer."Item No.");
            ILE.SetRange("Variant Code", MaintenanceBuffer."Variant Code");
            if MaintenanceBuffer."Is Lot Tracked" then
                ILE.SetRange("Lot No.", MaintenanceBuffer."Lot No.")
            else
                ILE.SetRange("Serial No.", MaintenanceBuffer."Serial No.");
            ILE.SetFilter(Quantity, '>0'); // inbound entries
            if ILE.FindFirst() then
                BaseDate := ILE."Posting Date";
        end;

        if BaseDate = 0D then
            exit(0D); // No base to calculate from

        NextDue := CalcDate(Interval, BaseDate);
        exit(NextDue);
    end;

    procedure SerialIsDueInWindow(LotInfo: Record "ONT.Main. Workbench Buff."; Window: Enum "ONT Maintenance Window"): Boolean
    var
        Today: Date;
        DueDate: Date;
        FromDate: Date;
        ToDate: Date;
    begin
        Today := WorkDate();
        DueDate := SerialCalcNextDueDate(LotInfo);
        if DueDate = 0D then
            exit(false); // Not applicable

        case Window of
            Window::All:
                exit(true);
            Window::DueNow:
                exit(DueDate <= Today);
            Window::Next7:
                begin
                    FromDate := Today + 1;
                    ToDate := Today + 7;
                    exit((DueDate >= FromDate) and (DueDate <= ToDate));
                end;
            Window::Next30:
                begin
                    FromDate := Today + 1;
                    ToDate := Today + 30;
                    exit((DueDate >= FromDate) and (DueDate <= ToDate));
                end;
            Window::Next60:
                begin
                    FromDate := Today + 1;
                    ToDate := Today + 60;
                    exit((DueDate >= FromDate) and (DueDate <= ToDate));
                end;
        end;
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterPostOutput, '', False, False)]
    local procedure FillSerialNoMaintenanceInfo(var ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ConsumptionILE: Record "Item Ledger Entry";
        SourceComponentLotInfo: Record "Lot No. Information";

        s: page "Production Journal";
        TargetParentSerialInfo: Record "Serial No. Information";
    begin
        if ItemLedgerEntry.IsTemporary then exit;
        if ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Output then exit;
        if ItemLedgerEntry."Order Type" <> ItemLedgerEntry."Order Type"::Production then exit;
        // We only care if the produced parent item (bicycle) has a Serial No.
        if ItemLedgerEntry."Serial No." = '' then exit;
        ConsumptionILE.Reset();
        // Use a key that supports searching by Order No. and Entry Type efficiently.
        ConsumptionILE.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Entry Type");
        ConsumptionILE.SetRange("Order Type", ItemLedgerEntry."Order Type"); // Production

        ConsumptionILE.SetRange("Order No.", ItemLedgerEntry."Order No.");   // Same Order Nbr
        ConsumptionILE.SetRange("Order Line No.", ItemLedgerEntry."Order Line No."); // Same BOM Line linkage
        ConsumptionILE.SetRange("Entry Type", ConsumptionILE."Entry Type"::Consumption);
        // Crucial: Only look for components that had a specific Lot No assigned during consumption.
        ConsumptionILE.SetFilter("Lot No.", '<>%1', '');


        if ConsumptionILE.FindSet() then
            repeat
                // Try to get the Lot Information record for this consumed component's specific Lot No.
                if SourceComponentLotInfo.Get(ConsumptionILE."Item No.", ConsumptionILE."Variant Code", ConsumptionILE."Lot No.") then begin

                    // CHECK: Does this battery actually have a future maintenance date set?
                    if SourceComponentLotInfo."ONT Next Maintenance Date" <> 0D then begin

                        // YES - It has data. Now apply it to the Parent Bicycle.

                        // Find or Create the Serial Info record for the bicycle just produced.
                        if not TargetParentSerialInfo.Get(ItemLedgerEntry."Item No.", ItemLedgerEntry."Variant Code", ItemLedgerEntry."Serial No.") then begin
                            TargetParentSerialInfo.Init();
                            TargetParentSerialInfo."Item No." := ItemLedgerEntry."Item No.";
                            TargetParentSerialInfo."Variant Code" := ItemLedgerEntry."Variant Code";
                            TargetParentSerialInfo."Serial No." := ItemLedgerEntry."Serial No.";
                            TargetParentSerialInfo.Insert();
                        end;

                        // COPY THE DATA: Set the bicycle's next date to the battery's next date.
                        TargetParentSerialInfo.Validate("ONT Next Maintenance Date", SourceComponentLotInfo."ONT Next Maintenance Date");
                        TargetParentSerialInfo."ONT Child Item No." := SourceComponentLotInfo."Item No.";
                        TargetParentSerialInfo."ONT Last Maintenance Date" := SourceComponentLotInfo."ONT Last Maintenance Date";
                        TargetParentSerialInfo."ONT Child Last maintenace Date" := SourceComponentLotInfo."ONT Last Maintenance Date";
                        TargetParentSerialInfo."ONT Child Lot No." := SourceComponentLotInfo."Lot No.";
                        TargetParentSerialInfo."ONT Last Maintenance Date" := SourceComponentLotInfo."ONT Last Maintenance Date";
                        TargetParentSerialInfo.Modify();

                        // Optional: Since it was just produced today, set Last Maintenance Date to today.
                        // if TargetParentSerialInfo."ONT Last Maintenance Date" = 0D then
                        //     TargetParentSerialInfo.Validate("ONT Last Maintenance Date", Today());

                        // TargetParentSerialInfo.Modify(true);

                        // SIMPLE APPROACH: We found one component with data and applied it. 
                        // Stop searching to keep things simple.
                        break;
                    end;
                end;
            until ConsumptionILE.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterPostItemJnlLine, '', false, false)]
    local procedure "Item Tracking Management_OnAfterCreateSNInformation"(ItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    var
        Item: Record Item;
    begin
        if ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Output then begin
            FillSerialNoMaintenanceInfo(ItemLedgerEntry);
        end;

        if ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Consumption then begin
            if item.get(ItemLedgerEntry."Item No.") then;
            if ItemLedgerEntry."Lot No." <> '' then
                RegisterLotInformationMaintenance(ItemLedgerEntry."Lot No.", ItemLedgerEntry, Item);
        end;

    end;


    local procedure RegisterLotInformationMaintenance(LotNo: code[20]; ItemLedgerEntry: Record "Item Ledger Entry"; Item: Record Item)
    var
        LotNoInfo: Record "Lot No. Information";
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        if ItemTrackingCode.Get(Item."Item Tracking Code") then
            if ItemTrackingCode."ONT Maintenance Required" then begin

                if LotNoInfo.get(ItemLedgerEntry."Item No.", ItemLedgerEntry."Variant Code", LotNo) then begin

                    LotNoInfo."ONT Next Maintenance Date" := CalcDate(ItemTrackingCode."ONT Maintenance Interval", ItemLedgerEntry."Posting Date");
                    LotNoInfo.Modify();
                end;
            end;
    end;

    // local procedure RegisterSerialInformationMaintenance(SerialNo: code[20]; ItemLedgerEntry: Record "Item Ledger Entry"; Item: Record Item)
    // var
    //     SerialNoINfo: Record "Serial No. Information";
    //     ItemTrackingCode: Record "Item Tracking Code";
    // begin
    //     if ItemTrackingCode.Get(Item."Item Tracking Code") then
    //         if ItemTrackingCode."ONT Maintenance Required" then begin
    //             SerialNoINfo."ONT Next Maintenance Date" := CalcDate(ItemTrackingCode."ONT Maintenance Interval", ItemLedgerEntry."Posting Date");
    //             SerialNoINfo.Modify();
    //         end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnAfterCreateLotInformation, '', false, false)]
    local procedure "Item Tracking Management_OnAfterCreateLotInformation"(var LotNoInfo: Record "Lot No. Information"; var TrackingSpecification: Record "Tracking Specification")

    begin
        if 1 = 1 then;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterInsertEvent', '', true, true)]
    // local procedure CopyMaintenanceDateOnProductionOutput(var Rec: Record "Item Ledger Entry"; RunTrigger: Boolean)
    // var
    //     ConsumptionILE: Record "Item Ledger Entry";
    //     SourceComponentLotInfo: Record "Lot No. Information";

    //     s: page "Production Journal";
    //     TargetParentSerialInfo: Record "Serial No. Information";
    // begin
    //     // --- 1. Safety Checks ---
    //     // Ensure this is a real record insert, not a temporary calculation.
    //     if Rec.IsTemporary() then exit;
    //     // We only care about Production Output entries.
    //     if Rec."Entry Type" <> Rec."Entry Type"::Output then exit;
    //     if Rec."Order Type" <> Rec."Order Type"::Production then exit;
    //     // We only care if the produced parent item (bicycle) has a Serial No.
    //     if Rec."Serial No." = '' then exit;


    //     // --- 2. Find the Component ---
    //     // We need to find consumption entries linked to the exact same Production Order Line
    //     // that generated this output.
    //     ConsumptionILE.Reset();
    //     // Use a key that supports searching by Order No. and Entry Type efficiently.
    //     ConsumptionILE.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Entry Type");
    //     ConsumptionILE.SetRange("Order Type", Rec."Order Type"); // Production
    //     ConsumptionILE.SetRange("Order No.", Rec."Order No.");   // Same Order Nbr
    //     ConsumptionILE.SetRange("Order Line No.", Rec."Order Line No."); // Same BOM Line linkage
    //     ConsumptionILE.SetRange("Entry Type", ConsumptionILE."Entry Type"::Consumption);
    //     // Crucial: Only look for components that had a specific Lot No assigned during consumption.
    //     ConsumptionILE.SetFilter("Lot No.", '<>%1', '');

    //     // --- 3. Get Source Info and Write Target Info ---
    //     // We loop through found components. To keep it simple, we take data from the FIRST
    //     // component we find that has valid maintenance info defined.
    //     if ConsumptionILE.FindSet() then
    //         repeat
    //             // Try to get the Lot Information record for this consumed component's specific Lot No.
    //             if SourceComponentLotInfo.Get(ConsumptionILE."Item No.", ConsumptionILE."Variant Code", ConsumptionILE."Lot No.") then begin

    //                 // CHECK: Does this battery actually have a future maintenance date set?
    //                 if SourceComponentLotInfo."ONT Next Maintenance Date" <> 0D then begin

    //                     // YES - It has data. Now apply it to the Parent Bicycle.

    //                     // Find or Create the Serial Info record for the bicycle just produced.
    //                     if not TargetParentSerialInfo.Get(Rec."Item No.", Rec."Variant Code", Rec."Serial No.") then begin
    //                         TargetParentSerialInfo.Init();
    //                         TargetParentSerialInfo."Item No." := Rec."Item No.";
    //                         TargetParentSerialInfo."Variant Code" := Rec."Variant Code";
    //                         TargetParentSerialInfo."Serial No." := Rec."Serial No.";
    //                         TargetParentSerialInfo.Insert();
    //                     end;

    //                     // COPY THE DATA: Set the bicycle's next date to the battery's next date.
    //                     TargetParentSerialInfo.Validate("ONT Next Maintenance Date", SourceComponentLotInfo."ONT Next Maintenance Date");
    //                     TargetParentSerialInfo."ONT Child Item No." := SourceComponentLotInfo."Item No.";
    //                     TargetParentSerialInfo."ONT Child Last maintenace Date" := SourceComponentLotInfo."ONT Last Maintenance Date";
    //                     TargetParentSerialInfo."ONT Child Lot No." := SourceComponentLotInfo."Lot No.";
    //                     TargetParentSerialInfo."ONT Last Maintenance Date" := SourceComponentLotInfo."ONT Last Maintenance Date";
    //                     TargetParentSerialInfo.Modify();

    //                     // Optional: Since it was just produced today, set Last Maintenance Date to today.
    //                     // if TargetParentSerialInfo."ONT Last Maintenance Date" = 0D then
    //                     //     TargetParentSerialInfo.Validate("ONT Last Maintenance Date", Today());

    //                     // TargetParentSerialInfo.Modify(true);

    //                     // SIMPLE APPROACH: We found one component with data and applied it. 
    //                     // Stop searching to keep things simple.
    //                     break;
    //                 end;
    //             end;
    //         until ConsumptionILE.Next() = 0;
    // end;
}