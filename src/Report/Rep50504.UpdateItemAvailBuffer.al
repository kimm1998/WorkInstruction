report 50504 "ONT.Update Item Avail. Buffer"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Item Availability Buffer';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Location Filter";

            trigger OnAfterGetRecord()
            begin
                // 1. Setup Dates (Global logic)
                if Format(CalculationPeriod) = '' then
                    Evaluate(CalculationPeriod, '<6M>');

                if AnalysisStartDate = 0D then
                    AnalysisStartDate := WorkDate();

                AnalysisEndDate := CalcDate(CalculationPeriod, AnalysisStartDate);

                // 2. Hand over completely to the function
                GenerateBuffer(Item);
            end;

            trigger OnPreDataItem()
            begin
                // Step 0: Cleanup Real Table (Scoped to this Item)
                Step0_CleanupOldData();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Calculation Options';
                    field(AnalysisStart; AnalysisStartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(CalcPeriod; CalculationPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Calculation Period';
                    }
                }
            }
        }
    }

    var
        BufferTable: Record ONT_ItemAvailabilityBuffer;
        TempInfo: Record ONT_ItemAvailabilityBuffer temporary;
        AnalysisStartDate: Date;
        AnalysisEndDate: Date;
        CalculationPeriod: DateFormula;
        EntryCounter: Integer;

    // --- MAIN CONTROLLER ---
    local procedure GenerateBuffer(var Item: Record Item)
    begin
        // Reset Temporary Memory
        TempInfo.Reset();
        TempInfo.DeleteAll();
        EntryCounter := 0;

        // Step 1: Gather Data
        Step1A_GetInventory(Item);
        Step1B_GetPurchaseOrders(Item);
        Step1C_GetProductionOrders(Item);
        Step1D_GetSalesOrders(Item);

        // Step 2: Calculate Running Balance (Column E)
        Step2_CalculateRunningBalance();

        // Step 4: Calculate Min Available until Next IN (Column F)
        Step3_CalculateMinNextIn();

        // Step 3: Calculate Min Available to End (Column G)
        Step4_CalculateMinToEnd();

        // Step 5: Save to Real Table
        Step5_SaveToRealTable();
    end;

    // --- STEP 0: CLEANUP ---
    local procedure Step0_CleanupOldData()
    begin
        // We delete ONLY the lines for the item currently being processed.
        BufferTable.Reset();
        BufferTable.DeleteAll();

        // Reset the entry counter for this item so we start from Entry No. 1
    end;

    // --- STEP 1: GATHERING SUB-FUNCTIONS ---

    local procedure Step1A_GetInventory(var Item: Record Item)
    var
        StartInvQty: Decimal;
    begin
        // Inventory UP TO (StartDate - 1)
        Item.SetRange("Date Filter", 0D, AnalysisStartDate - 1);
        if Item.GetFilter("Location Filter") <> '' then
            Item.SetFilter("Location Filter", Item.GetFilter("Location Filter"));

        Item.CalcFields("Net Change");
        StartInvQty := Item."Net Change";

        CreateEntry(Item."No.", AnalysisStartDate, 'Inventory', '', StartInvQty, 0, Item."Base Unit of Measure", TempInfo."Source Type"::Inventory);

        // Clean up filter so it doesn't affect the loop
        Item.SetRange("Date Filter");
    end;

    local procedure Step1B_GetPurchaseOrders(var Item: Record Item)
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetRange("Type", PurchLine."Type"::Item);
        PurchLine.SetRange("No.", Item."No.");
        PurchLine.SetRange("Expected Receipt Date", AnalysisStartDate, AnalysisEndDate);
        PurchLine.SetFilter("Outstanding Qty. (Base)", '>%1', 0);

        if Item.GetFilter("Location Filter") <> '' then
            PurchLine.SetFilter("Location Code", Item.GetFilter("Location Filter"));

        if PurchLine.FindSet() then
            repeat
                CreateEntry(Item."No.", PurchLine."Expected Receipt Date", 'Purchase Order', PurchLine."Document No.", PurchLine."Outstanding Qty. (Base)", 0, PurchLine."Unit of Measure Code", TempInfo."Source Type"::Purchase);
            until PurchLine.Next() = 0;
    end;

    local procedure Step1C_GetProductionOrders(var Item: Record Item)
    var
        ProdLine: Record "Prod. Order Line";
    begin
        ProdLine.SetRange("Item No.", Item."No.");
        ProdLine.SetRange(Status, ProdLine.Status::Released);
        ProdLine.SetRange("Due Date", AnalysisStartDate, AnalysisEndDate);
        ProdLine.SetFilter("Remaining Qty. (Base)", '>%1', 0);

        if Item.GetFilter("Location Filter") <> '' then
            ProdLine.SetFilter("Location Code", Item.GetFilter("Location Filter"));

        if ProdLine.FindSet() then
            repeat
                CreateEntry(Item."No.", ProdLine."Due Date", 'Production Order', ProdLine."Prod. Order No.", ProdLine."Remaining Qty. (Base)", 0, ProdLine."Unit of Measure Code", TempInfo."Source Type"::Production);
            until ProdLine.Next() = 0;
    end;

    local procedure Step1D_GetSalesOrders(var Item: Record Item)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Type", SalesLine."Type"::Item);
        SalesLine.SetRange("No.", Item."No.");
        SalesLine.SetRange("Shipment Date", AnalysisStartDate, AnalysisEndDate);
        SalesLine.SetFilter("Outstanding Qty. (Base)", '>%1', 0);

        if Item.GetFilter("Location Filter") <> '' then
            SalesLine.SetFilter("Location Code", Item.GetFilter("Location Filter"));

        if SalesLine.FindSet() then
            repeat
                CreateEntry(Item."No.", SalesLine."Shipment Date", 'Sales Order', SalesLine."Document No.", 0, SalesLine."Outstanding Qty. (Base)", SalesLine."Unit of Measure Code", TempInfo."Source Type"::Sales);
            until SalesLine.Next() = 0;
    end;

    // --- STEP 2: RUNNING BALANCE ---
    local procedure Step2_CalculateRunningBalance()
    var
        RunningBalance: Decimal;
    begin
        TempInfo.SetCurrentKey("Item No.", Date); // Sort by Date

        RunningBalance := 0;
        if TempInfo.FindSet() then
            repeat
                RunningBalance += (TempInfo."Qty. In" - TempInfo."Qty. Out");
                TempInfo.Availability := RunningBalance;
                TempInfo.Modify();
            until TempInfo.Next() = 0;
    end;

    // --- STEP 3: MIN TO END (Backward Loop) ---
    local procedure Step4_CalculateMinToEnd()
    var
        RunningMin: Decimal;
    begin
        // Initialize with a high number so the first comparison always works
        RunningMin := 999999999;

        // Start at the LAST record and move UP
        if TempInfo.FindLast() then
            repeat
                if (TempInfo."Source Type" in [TempInfo."Source Type"::Inventory, TempInfo."Source Type"::Production, TempInfo."Source Type"::Purchase]) then begin
                    if TempInfo."Min. Avail. Next In" < RunningMin then
                        RunningMin := TempInfo."Min. Avail. Next In";

                    // 2. Set the value
                    TempInfo."Min. Avail. End" := RunningMin;
                    TempInfo.Modify();
                end;
            until TempInfo.Next(-1) = 0;
    end;

    // --- STEP 3: MIN NEXT IN (Forward Nested Loop) ---
    local procedure Step3_CalculateMinNextIn()
    var
        LocalMin: Decimal;
        MaxInt: Decimal;
    begin
        // Ensure we iterate in Date order
        TempInfo.SetCurrentKey("Item No.", Date);

        MaxInt := 999999999;
        LocalMin := MaxInt;

        if TempInfo.FindLast() then
            repeat
                if TempInfo.Availability < LocalMin then
                    LocalMin := TempInfo.Availability;
                if (TempInfo."Source Type" in [TempInfo."Source Type"::Inventory, TempInfo."Source Type"::Production, TempInfo."Source Type"::Purchase]) then begin
                    TempInfo."Min. Avail. Next In" := LocalMin;
                    TempInfo.Modify();
                    LocalMin := MaxInt; // Reset for next segment until next IN
                end;
            until TempInfo.Next(-1) = 0;
    end;

    // --- STEP 5: SAVE ---
    local procedure Step5_SaveToRealTable()
    begin
        if TempInfo.FindSet() then
            repeat
                BufferTable.Init();
                BufferTable.TransferFields(TempInfo);
                BufferTable.Insert();
            until TempInfo.Next() = 0;
    end;

    // --- HELPER ---
    local procedure CreateEntry(ItemNo: Code[20]; EntryDate: Date; Desc: Text[100]; DocNo: Code[20]; QtyIn: Decimal; QtyOut: Decimal; UOM: Code[10]; SourceType: Option)
    begin
        EntryCounter += 1;
        TempInfo.Init();
        TempInfo."Entry No." := EntryCounter;
        TempInfo."Item No." := ItemNo;
        TempInfo.Date := EntryDate;
        TempInfo.Description := Desc;
        TempInfo."Source ID" := DocNo;
        TempInfo."Qty. In" := QtyIn;
        TempInfo."Qty. Out" := QtyOut;
        TempInfo."Source Type" := SourceType;
        TempInfo.Insert();
    end;
}