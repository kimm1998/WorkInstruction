codeunit 50563 "ONT Carry Out By Family"
{
    procedure RunForBatch(WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10]; TargetOrderStatus: Enum "Production Order Status")
    var
        FamilyList: List of [Code[20]];
        ItemfamilyList: List of [Code[20]];
        LocationList: List of [Code[10]];
        DueDateList: List of [Date];
        ItemsList: list of [code[20]];
        i: Integer;
    begin
        CollectGroups(WorksheetTemplateName, WorksheetBatchName, FamilyList, ItemfamilyList, LocationList, DueDateList, ItemsList);

        for i := 1 to FamilyList.Count() do
            CreateProductionOrderForGroup(
                WorksheetTemplateName,
                WorksheetBatchName,
                TargetOrderStatus,
                FamilyList.Get(i),
                LocationList.Get(i),
                DueDateList.Get(i),
                ItemfamilyList,
                ItemsList
                );
    end;

    local procedure CollectGroups(WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        var FamilyList: List of [Code[20]]; var ItemfamilyList: List of [Code[20]]; var LocationList: List of [Code[10]]; var DueDateList: List of [Date]; var ItemsList: list of [code[20]])
    var
        ReqLine: Record "Requisition Line";
    begin
        Clear(FamilyList);
        Clear(ItemfamilyList);
        Clear(LocationList);
        Clear(ItemsList);
        Clear(DueDateList);

        ReqLine.SetRange("Worksheet Template Name", WorksheetTemplateName);
        ReqLine.SetRange("Journal Batch Name", WorksheetBatchName);
        ReqLine.SetRange(Type, ReqLine.Type::Item);
        ReqLine.SetRange("Ref. Order Type", ReqLine."Ref. Order Type"::"Prod. Order");
        ReqLine.SetRange("Accept Action Message", true);
        ReqLine.SetRange("Action Message", ReqLine."Action Message"::New);
        ReqLine.SetFilter("ONT Family No.", '<>%1', '');

        if ReqLine.IsEmpty then
            exit;

        if ReqLine.FindSet() then
            repeat
                addItemIfMissing(ItemsList, ReqLine."No.", ItemfamilyList, ReqLine."ONT Family No.");
                AddGroupIfMissing(
                    FamilyList, LocationList, DueDateList,
                    ReqLine."ONT Family No.", ReqLine."Location Code", ReqLine."Due Date", ItemsList, ReqLine."No.");
            until ReqLine.Next() = 0;
    end;

    local procedure addItemIfMissing(var ItemsList: list of [code[20]]; ItemNo: Code[20]; var FamilyList: list of [code[20]]; FamilyNo: Code[20])
    begin
        if not itemFamilyExists(ItemsList, ItemNo, FamilyList, FamilyNo) then begin
            ItemsList.Add(ItemNo);
            FamilyList.add(FamilyNo);
        end;
    end;

    local procedure itemFamilyExists(ItemsList: list of [code[20]]; ItemNo: Code[20]; FamilyList: List of [Code[20]]; FamilyNo: Code[20]): Boolean
    var
        i: Integer;
    begin
        for i := 1 to ItemsList.Count() do
            if (ItemsList.Get(i) = ItemNo) and
               (FamilyList.Get(i) = FamilyNo) then
                exit(true);

        exit(false);
    end;


    local procedure AddGroupIfMissing(var FamilyList: list of [code[20]]; var LocationList: List of [Code[10]];
        var DueDateList: List of [Date]; FamilyNo: Code[20]; LocationCode: Code[10]; DueDate: Date; var ItemsList: list of [code[20]]; ItemNo: code[20])
    begin
        // Check full combination (Family + Location + Due Date)
        if not GroupExists(FamilyList, LocationList, DueDateList, FamilyNo, LocationCode, DueDate, ItemsList, ItemNo) then begin
            FamilyList.Add(FamilyNo);
            LocationList.Add(LocationCode);
            DueDateList.Add(DueDate);
        end;
    end;

    local procedure GroupExists(FamilyList: list of [code[20]]; LocationList: List of [Code[10]];
        DueDateList: List of [Date]; FamilyNo: Code[20]; LocationCode: Code[10]; DueDate: Date; ItemsList: list of [code[20]]; ItemNo: code[20]): Boolean
    var
        i: Integer;
    begin
        for i := 1 to FamilyList.Count() do
            if (FamilyList.get(i) = FamilyNo) and
               (LocationList.Get(i) = LocationCode) and
               (DueDateList.Get(i) = DueDate) then
                exit(true);

        exit(false);
    end;

    local procedure CreateProductionOrderForGroup(WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        TargetOrderStatus: Enum "Production Order Status"; OriginalFamilyNo: Code[20];
                               LocationCode: Code[10];
                               DueDate: Date; ItemfamilyList: List of [Code[20]]; ItemsList: list of [code[20]])
    var
        ProdOrder: Record "Production Order";
        OriginalFamily: Record "Family";
        NewFamily: Record "Family";
        NewFamilyNo: Code[20];
        NewFamilyName: text;
        StartingDT: DateTime;
        EndingDT: DateTime;
        ForecastName: Code[20];
        invSetup: Record "Inventory Setup";
    begin
        invSetup.Get();
        GetGroupDatesAndForecast(
            WorksheetTemplateName, WorksheetBatchName,
            OriginalFamilyNo, LocationCode, DueDate,
            StartingDT, EndingDT, ForecastName);

        if not OriginalFamily.Get(OriginalFamilyNo) then
            Error('Family %1 does not exist.', OriginalFamilyNo);

        // 1. Try to reuse an existing Family variant with matching quantities
        NewFamilyNo := FindMatchingFamilyForGroup(
            OriginalFamilyNo, WorksheetTemplateName, WorksheetBatchName, LocationCode, DueDate);

        if NewFamilyNo = '' then begin
            // 1.a No match found → create a new Family variant
            NewFamilyNo := GetNextFamilyVariantNo(OriginalFamilyNo);

            NewFamily.Init();
            NewFamily.TransferFields(OriginalFamily, false);
            NewFamily."No." := NewFamilyNo;
            NewFamily."Product Type" := invSetup."Family Product Type Code";
            NewFamily.Description :=
                CopyStr(OriginalFamily.Description, 1, MaxStrLen(NewFamily.Description));
            NewFamily.Insert(true);

            // Copy & adjust Family lines from planning worksheet
            CopyAndAdjustFamilyLines(
                OriginalFamily."No.", NewFamily."No.",
                WorksheetTemplateName, WorksheetBatchName, LocationCode, DueDate, ItemfamilyList, ItemsList);
        end else begin
            // 1.b Matching Family found → reuse it
            NewFamily.Get(NewFamilyNo);
        end;

        // 2. Create Production Order
        ProdOrder.Init();
        ProdOrder.Validate(Status, TargetOrderStatus);
        ProdOrder.Validate("Source Type", ProdOrder."Source Type"::Family);
        ProdOrder.Validate("Source No.", NewFamily."No.");
        ProdOrder.Validate("Location Code", LocationCode);
        ProdOrder.Validate(Quantity, 1);
        ProdOrder.Validate("Due Date", DueDate);
        ProdOrder."Starting Date-Time" := StartingDT;
        ProdOrder."Ending Date-Time" := EndingDT;

        if (ForecastName <> '') and (ProdOrder.FieldNo("ONT Demand Forecast") <> 0) then
            ProdOrder.Validate("ONT Demand Forecast", ForecastName);

        // ProdOrder.Description := CopyStr(StrSubstNo('Family %1 → %2', OriginalFamilyNo, NewFamilyNo), 1, MaxStrLen(ProdOrder.Description));//rename
        ProdOrder.Description := NewFamily.Description;//rename
        ProdOrder.Insert(true);

        // Store Prod Order No. on family (existing or new)
        if NewFamily.FieldNo("ONT Prod. Order No.") <> 0 then begin
            NewFamily."ONT Prod. Order No." := ProdOrder."No.";
            NewFamily.Modify();
        end;

        Commit();

        // 3. Refresh production order using standard report (no dialog)
        ProdOrder.SetRecFilter(); // filter to the newly created order
        Report.RunModal(Report::"Refresh Production Order", false, false, ProdOrder);

        // 4. Delete processed req lines
        DeleteProcessedReqLines(WorksheetTemplateName, WorksheetBatchName, OriginalFamilyNo, LocationCode, DueDate);
    end;

    local procedure FindMatchingFamilyForGroup(OriginalFamilyNo: Code[20]; WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        LocationCode: Code[10]; DueDate: Date): Code[20]
    var
        CandidateFamily: Record "Family";
    begin
        // 1. Check the original Family itself
        if CandidateFamily.Get(OriginalFamilyNo) then
            if FamilyMatchesGroup(
                CandidateFamily."No.", OriginalFamilyNo,
                WorksheetTemplateName, WorksheetBatchName, LocationCode, DueDate)
            then
                exit(CandidateFamily."No.");

        // 2. Check any variants like FAM_1, FAM_2, ...
        CandidateFamily.Reset();
        CandidateFamily.SetFilter("No.", OriginalFamilyNo + '_*');

        if CandidateFamily.FindSet() then
            repeat
                if FamilyMatchesGroup(
                    CandidateFamily."No.", OriginalFamilyNo,
                    WorksheetTemplateName, WorksheetBatchName, LocationCode, DueDate)
                then
                    exit(CandidateFamily."No.");
            until CandidateFamily.Next() = 0;

        exit(''); // No match
    end;

    local procedure FamilyMatchesGroup(CandidateFamilyNo: Code[20]; OriginalFamilyNo: Code[20];
        WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        LocationCode: Code[10]; DueDate: Date): Boolean
    var
        OrigLine: Record "Family Line";
        CandidateLine: Record "Family Line";
        GroupReqLine: Record "Requisition Line";
        ExpectedQty: Decimal;
    begin
        // Req. lines for this group (based on ORIGINAL Family No.)
        FilterReqLinesForGroup(
            GroupReqLine, WorksheetTemplateName, WorksheetBatchName,
            OriginalFamilyNo, LocationCode, DueDate);

        // 1. Every original Family line must exist in candidate with expected quantity
        OrigLine.SetRange("Family No.", OriginalFamilyNo);
        if OrigLine.FindSet() then
            repeat
                ExpectedQty := OrigLine.Quantity;

                // Override from requisition line if present
                GroupReqLine.SetRange("No.", OrigLine."Item No.");
                if GroupReqLine.FindFirst() then
                    ExpectedQty := GroupReqLine.Quantity;
                GroupReqLine.SetRange("No."); // clear item filter

                CandidateLine.Reset();
                CandidateLine.SetRange("Family No.", CandidateFamilyNo);
                CandidateLine.SetRange("Item No.", OrigLine."Item No.");
                if not CandidateLine.FindFirst() then
                    exit(false);

                if CandidateLine.Quantity <> ExpectedQty then
                    exit(false);
            until OrigLine.Next() = 0;

        // 2. Candidate must not have extra items not in original
        CandidateLine.Reset();
        CandidateLine.SetRange("Family No.", CandidateFamilyNo);
        if CandidateLine.FindSet() then
            repeat
                OrigLine.Reset();
                OrigLine.SetRange("Family No.", OriginalFamilyNo);
                OrigLine.SetRange("Item No.", CandidateLine."Item No.");
                if not OrigLine.FindFirst() then
                    exit(false);
            until CandidateLine.Next() = 0;

        exit(true);
    end;

    local procedure GetNextFamilyVariantNo(OriginalFamilyNo: Code[20]): Code[20]
    var
        Family: Record "Family";
        Suffix: Integer;
        Candidate: Text;
    begin
        Suffix := 1;
        repeat
            Candidate := OriginalFamilyNo + '_' + Format(Suffix);
            Suffix += 1;
        until not Family.Get(CopyStr(Candidate, 1, MaxStrLen(Family."No.")));
        exit(CopyStr(Candidate, 1, MaxStrLen(Family."No.")));
    end;

    local procedure GetGroupDatesAndForecast(WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        FamilyNo: Code[20]; LocationCode: Code[10]; DueDate: Date;
        var StartingDT: DateTime; var EndingDT: DateTime; var ForecastName: Code[20])
    var
        ReqLine: Record "Requisition Line";
    begin
        Clear(StartingDT);
        Clear(EndingDT);
        ForecastName := '';

        FilterReqLinesForGroup(
            ReqLine, WorksheetTemplateName, WorksheetBatchName,
            FamilyNo, LocationCode, DueDate);

        if ReqLine.FindSet() then
            repeat
                if (StartingDT = 0DT) or (ReqLine."Starting Date-Time" < StartingDT) then
                    StartingDT := ReqLine."Starting Date-Time";

                if ReqLine."Ending Date-Time" > EndingDT then
                    EndingDT := ReqLine."Ending Date-Time";

                if (ForecastName = '') and (ReqLine."ONT Demand Forecast" <> '') then
                    ForecastName := ReqLine."ONT Demand Forecast";
            until ReqLine.Next() = 0;
    end;

    local procedure CopyAndAdjustFamilyLines(OriginalFamilyNo: Code[20]; NewFamilyNo: Code[20];
        WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        LocationCode: Code[10]; DueDate: Date; ItemfamilyList: List of [Code[20]]; ItemsList: list of [code[20]])
    var
        OriginalFamLine: Record "Family Line";
        NewFamLine: Record "Family Line";
        ReqLine: Record "Requisition Line";
    begin
        // Copy all lines from original Family
        OriginalFamLine.SetRange("Family No.", OriginalFamilyNo);
        if OriginalFamLine.FindSet() then
            repeat
                if ItemfamilyList.Contains(OriginalFamLine."Family No.") then
                    if ItemsList.Contains(OriginalFamLine."Item No.") then begin
                        NewFamLine := OriginalFamLine;
                        NewFamLine."Family No." := NewFamilyNo;
                        NewFamLine.Insert(true);
                    end;
            until OriginalFamLine.Next() = 0;

        // Override quantities based on requisition lines in this group
        FilterReqLinesForGroup(
            ReqLine, WorksheetTemplateName, WorksheetBatchName,
            OriginalFamilyNo, LocationCode, DueDate);

        if ReqLine.FindSet() then
            repeat
                NewFamLine.Reset();
                NewFamLine.SetRange("Family No.", NewFamilyNo);
                NewFamLine.SetRange("Item No.", ReqLine."No.");
                if NewFamLine.FindFirst() then begin
                    NewFamLine.Validate(Quantity, ReqLine.Quantity);
                    NewFamLine.Modify(true);
                end;
            until ReqLine.Next() = 0;
    end;

    local procedure FilterReqLinesForGroup(var ReqLine: Record "Requisition Line";
        WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        FamilyNo: Code[20]; LocationCode: Code[10]; DueDate: Date)
    begin
        ReqLine.Reset();
        ReqLine.SetRange("Worksheet Template Name", WorksheetTemplateName);
        ReqLine.SetRange("Journal Batch Name", WorksheetBatchName);
        ReqLine.SetRange(Type, ReqLine.Type::Item);
        ReqLine.SetRange("Ref. Order Type", ReqLine."Ref. Order Type"::"Prod. Order");
        ReqLine.SetRange("Accept Action Message", true);
        ReqLine.SetRange("Action Message", ReqLine."Action Message"::New);
        ReqLine.SetRange("Location Code", LocationCode);
        ReqLine.SetRange("Due Date", DueDate);
        ReqLine.SetRange("ONT Family No.", FamilyNo);
    end;

    local procedure DeleteProcessedReqLines(WorksheetTemplateName: Code[10]; WorksheetBatchName: Code[10];
        FamilyNo: Code[20]; LocationCode: Code[10]; DueDate: Date)
    var
        ReqLine: Record "Requisition Line";
    begin
        FilterReqLinesForGroup(
            ReqLine, WorksheetTemplateName, WorksheetBatchName,
            FamilyNo, LocationCode, DueDate);
        ReqLine.DeleteAll(true);
    end;
}
