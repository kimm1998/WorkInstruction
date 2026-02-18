codeunit 50511 "ONT Family Forecast Mgt"
{
    SingleInstance = false;

    procedure ApplyToItemForecast(ForecastName: Code[10]; ClearExisting: Boolean)
    var
        Fam: Record "ONT Family Forecast Entry";
        FamLine: Record "Family Line";                 // Items & quantities per family
        Item: Record Item;
        Setup: Record "ONT Family Forecast Setup";

        // Per-bucket aggregation
        ItemNos: List of [Code[20]];                   // unique items to touch
        ItemQtyMap: Dictionary of [Code[20], Decimal]; // Item -> total qty for this bucket

        FamilyQty: Decimal;
        LineQty: Decimal;
        ItemNo: Code[20];
        AccumQty: Decimal;
        i: Integer;

        VariantCodeForBucket: Code[10];
    begin
        // Sanity: forecast name must exist
        if not ExistsProdForecastName(ForecastName) then
            Error('Production Forecast Name ''%1'' does not exist.', ForecastName);

        // Ensure setup exists
        if not Setup.Get() then begin
            Setup.Init();
            Setup.Insert(true);
        end;

        // Process all family buckets for the given forecast
        Fam.Reset();
        Fam.SetRange("Production Forecast Name", ForecastName);
        if not Fam.FindSet() then
            exit;

        repeat
            Clear(ItemNos);
            Clear(ItemQtyMap);

            FamilyQty := Fam.Quantity;

            // If your Family Forecast Entry does NOT have Variant Code, set '' here:
            VariantCodeForBucket := Fam."Variant Code"; // or: VariantCodeForBucket := '';

            // Get items from family lines & accumulate per item
            FamLine.Reset();
            FamLine.SetRange("Family No.", Fam."Family"); // change to "Family Code" if that's your field
            if FamLine.FindSet() then
                repeat
                    ItemNo := FamLine."Item No.";
                    if Item.Get(ItemNo) then begin
                        // Respect setup filters
                        if not Item.Blocked then
                            LineQty := FamLine.Quantity; // multiplier per line

                        if not ItemQtyMap.ContainsKey(ItemNo) then begin
                            ItemNos.Add(ItemNo);
                            ItemQtyMap.Add(ItemNo, 0);
                        end;

                        // item share = family qty × line qty (sum if multiple lines)
                        ItemQtyMap.Get(ItemNo, AccumQty);
                        AccumQty += (FamilyQty * LineQty);
                        ItemQtyMap.Set(ItemNo, AccumQty);
                    end;

                until FamLine.Next() = 0;

            // Optionally clear existing entries for this bucket (date+loc+variant) for touched items
            if ClearExisting and (ItemNos.Count() > 0) then
                ClearExistingBucket(ForecastName, Fam."Location Code", VariantCodeForBucket, Fam.Date, ItemNos);

            // Write/accumulate Production Forecast Entry per item
            for i := 1 to ItemNos.Count() do begin
                ItemNo := ItemNos.Get(i);
                if ItemQtyMap.Get(ItemNo, AccumQty) then
                    if AccumQty <> 0 then
                        InsertOrAccumulatePFE(
                          ForecastName, ItemNo, Fam."Location Code", VariantCodeForBucket, Fam.Date, AccumQty);
            end;

        until Fam.Next() = 0;
    end;

    // --------- helpers ---------

    local procedure ExistsProdForecastName(ForecastName: Code[10]): Boolean
    var
        PFN: Record "Production Forecast Name";
    begin
        PFN.SetRange(Name, ForecastName);
        exit(not PFN.IsEmpty());
    end;

    local procedure ClearExistingBucket(ForecastName: Code[10]; LocationCode: Code[10]; VariantCode: Code[10]; Dt: Date; ItemNos: List of [Code[20]])
    var
        PFE: Record "Production Forecast Entry";
        ItemNo: Code[20];
        idx: Integer;
    begin
        for idx := 1 to ItemNos.Count() do begin
            ItemNo := ItemNos.Get(idx);
            PFE.Reset();
            PFE.SetRange("Component Forecast", false); // Sales forecast
            PFE.SetRange("Production Forecast Name", ForecastName);
            PFE.SetRange("Item No.", ItemNo);
            PFE.SetRange("Location Code", LocationCode);
            PFE.SetRange("Variant Code", VariantCode);
            PFE.SetRange("Forecast Date", Dt);
            if not PFE.IsEmpty() then
                PFE.DeleteAll();
        end;
    end;

    local procedure InsertOrAccumulatePFE(ForecastName: Code[10]; ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]; Dt: Date; QtyBase: Decimal)
    var
        PFE: Record "Production Forecast Entry";
    begin
        if QtyBase = 0 then
            exit;

        PFE.Reset();
        PFE.SetRange("Component Forecast", false); // Sales forecast
        PFE.SetRange("Production Forecast Name", ForecastName);
        PFE.SetRange("Item No.", ItemNo);
        PFE.SetRange("Location Code", LocationCode);
        PFE.SetRange("Variant Code", VariantCode);
        PFE.SetRange("Forecast Date", Dt);

        if PFE.FindFirst() then begin
            // Write BASE quantity to match your matrix FlowField (Forecast Quantity (Base))
            PFE.Validate("Forecast Quantity (Base)", PFE."Forecast Quantity (Base)" + QtyBase);
            PFE.Modify(true);
        end else begin
            PFE.Init();
            PFE.Validate("Component Forecast", false);
            PFE.Validate("Production Forecast Name", ForecastName);
            PFE.Validate("Item No.", ItemNo);
            PFE.Validate("Location Code", LocationCode);
            PFE.Validate("Variant Code", VariantCode);
            PFE.Validate("Forecast Date", Dt);
            PFE.Validate("Forecast Quantity (Base)", QtyBase);
            PFE.Insert(true);
        end;
    end;
}
