codeunit 50518 "ONT Shipping Calculator"
{
    // =========================================================================
    // SECTION 1: PUBLIC ACTION (The Only Trigger)
    // =========================================================================

    procedure CalculateShippingOnOrder(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesType: Record "ONT Sales Type";
        OrderTotalQty, OrderTotalAmt : Decimal;
        LineFreightCost, LineFreightToInvoice : Decimal;
        TotalFreightToInvoice: Decimal;
        HasQtyToInvoice: Boolean;
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Freight Item No.");
        if SalesHeader."Shipping Formula" = SalesHeader."Shipping Formula"::Fixed then
            SalesHeader.TestField("Fixed Shipping Rate");

        if SalesHeader."Sales Order Type" = '' then exit;
        SalesType.Get(SalesHeader."Sales Order Type");

        // 1. Snapshot Order Totals (Used for Thresholds)
        CalculateOrderTotals(SalesHeader, SalesSetup."Freight Item No.", OrderTotalQty, OrderTotalAmt);

        // 2. Prepare to Loop
        TotalFreightToInvoice := 0;
        HasQtyToInvoice := false;


        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', SalesSetup."Freight Item No.");

        // 3. Loop EVERY line to update "Per Line" info
        if SalesLine.FindSet(true) then
            repeat
                if SalesLine."Qty. to Invoice" <> 0 then
                    HasQtyToInvoice := true;

                // A. Calculate Cost (Handles Fixed vs Calculated + Thresholds)
                LineFreightCost := CalculateUnitShippingCost(
                    SalesLine,
                    SalesHeader,
                    SalesType,
                    OrderTotalQty,
                    OrderTotalAmt
                );

                // B. Calculate Invoice Portion (What needs to be billed NOW)
                if (SalesLine.Quantity <> 0) and (LineFreightCost <> 0) then
                    LineFreightToInvoice := (SalesLine."Qty. to Invoice" / SalesLine.Quantity) * LineFreightCost
                else
                    LineFreightToInvoice := 0;

                // C. Update the Sales Line (Write back to DB)
                SalesLine."ONT Total Freight Amount" := LineFreightCost;
                SalesLine."ONT Freight to Invoice" := LineFreightToInvoice;
                SalesLine.Modify(false);

                // D. Add to Header Total
                TotalFreightToInvoice += LineFreightToInvoice;

            until SalesLine.Next() = 0;

        // Fixed shipping is charged once per shipment/invoice run (not per line)
        if SalesHeader."Shipping Formula" = SalesHeader."Shipping Formula"::Fixed then begin
            if HasQtyToInvoice then
                TotalFreightToInvoice := SalesHeader."Fixed Shipping Rate"
            else
                TotalFreightToInvoice := 0;
        end;

        // 4. Finalize: Create or Update the Freight Line
        if TotalFreightToInvoice > 0 then begin
            CreateOrUpdateFreightLine(SalesHeader, TotalFreightToInvoice);
            Message('Shipping Calculated.\Total Freight to Invoice: %1', TotalFreightToInvoice);
        end else begin
            // If total is 0, remove UNPOSTED freight lines only
            DeleteExistingFreightLine(SalesHeader);
            Message('Shipping is Free (or zero). Unposted freight lines removed.');
        end;
    end;

    // =========================================================================
    // SECTION 2: POSTING VALIDATION (Integrity Check)
    // =========================================================================

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure CheckFreightIntegrityOnPost(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesType: Record "ONT Sales Type";
        OrderTotalQty, OrderTotalAmt : Decimal;
        FreshLineFreightCost, FreshLineFreightToInvoice : Decimal;
        ExpectedTotalFreight, CurrentFreightLineAmt : Decimal;
        HasQtyToInvoice: Boolean;
    begin
        // 1. Scope Checks
        if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) or PreviewMode then exit;

        // Only validate if we are actually posting an Invoice
        if not SalesHeader.Invoice then exit;

        SalesSetup.Get();
        if SalesHeader."Sales Order Type" = '' then exit;
        if not SalesType.Get(SalesHeader."Sales Order Type") then exit;

        // Special handling: Fixed shipping is per-shipment, not per line
        if SalesHeader."Shipping Formula" = SalesHeader."Shipping Formula"::Fixed then begin
            SalesHeader.TestField("Fixed Shipping Rate");

            // Loop item lines (excluding freight item) to ensure line fields were reset by Calculate Shipping
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetFilter("No.", '<>%1', SalesSetup."Freight Item No.");

            if SalesLine.FindSet() then
                repeat
                    if SalesLine."Qty. to Invoice" <> 0 then
                        HasQtyToInvoice := true;

                    // Under Fixed, these must be zero (we don't use them)
                    if Abs(SalesLine."ONT Total Freight Amount") > 0.01 then
                        Error('Freight Data Mismatch on Line %1 (%2).\Current Saved Freight: %3\Expected Freight: %4\Please run "Calculate Shipping" to update.',
                              SalesLine."Line No.", SalesLine.Description, SalesLine."ONT Total Freight Amount", 0);

                    if Abs(SalesLine."ONT Freight to Invoice") > 0.01 then
                        Error('Freight To Invoice Mismatch on Line %1 (%2).\Current Saved Value: %3\Expected Value: %4\Please run "Calculate Shipping".',
                              SalesLine."Line No.", SalesLine.Description, SalesLine."ONT Freight to Invoice", 0);

                until SalesLine.Next() = 0;

            if HasQtyToInvoice then
                ExpectedTotalFreight := SalesHeader."Fixed Shipping Rate"
            else
                ExpectedTotalFreight := 0;

            // Validate the Freight Line Total (same logic as existing)
            CurrentFreightLineAmt := 0;
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange("No.", SalesSetup."Freight Item No.");
            SalesLine.SetRange("Quantity Shipped", 0);
            SalesLine.SetRange("Quantity Invoiced", 0);

            if SalesLine.FindSet() then
                repeat
                    CurrentFreightLineAmt += SalesLine.Amount;
                until SalesLine.Next() = 0;

            if Abs(ExpectedTotalFreight - CurrentFreightLineAmt) > 0.01 then
                Error('Total Shipping Cost mismatch.\The expected fixed freight (%1) does not match the active Freight Line (%2).\Please run "Calculate Shipping" before posting.',
                      ExpectedTotalFreight, CurrentFreightLineAmt);

            exit;
        end;


        // 2. Prepare for Fresh Calculation
        CalculateOrderTotals(SalesHeader, SalesSetup."Freight Item No.", OrderTotalQty, OrderTotalAmt);

        ExpectedTotalFreight := 0;

        // 3. Loop Lines to Validate Columns
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', SalesSetup."Freight Item No.");

        if SalesLine.FindSet() then
            repeat
                // A. Re-Calculate Cost
                FreshLineFreightCost := CalculateUnitShippingCost(
                    SalesLine,
                    SalesHeader,
                    SalesType,
                    OrderTotalQty,
                    OrderTotalAmt
                );

                // B. Validate "Total Freight Amount"
                if Abs(SalesLine."ONT Total Freight Amount" - FreshLineFreightCost) > 0.01 then
                    Error('Freight Data Mismatch on Line %1 (%2).\Current Saved Freight: %3\Expected Freight: %4\Please run "Calculate Shipping" to update.',
                          SalesLine."Line No.", SalesLine.Description, SalesLine."ONT Total Freight Amount", FreshLineFreightCost);

                // C. Re-Calculate Invoice Portion
                if (SalesLine.Quantity <> 0) and (FreshLineFreightCost <> 0) then
                    FreshLineFreightToInvoice := (SalesLine."Qty. to Invoice" / SalesLine.Quantity) * FreshLineFreightCost
                else
                    FreshLineFreightToInvoice := 0;

                // D. Validate "Freight to Invoice"
                if Abs(SalesLine."ONT Freight to Invoice" - FreshLineFreightToInvoice) > 0.01 then
                    Error('Freight To Invoice Mismatch on Line %1 (%2).\Current Saved Value: %3\Expected Value: %4\Qty. to Invoice may have changed. Please run "Calculate Shipping".',
                         SalesLine."Line No.", SalesLine.Description, SalesLine."ONT Freight to Invoice", FreshLineFreightToInvoice);

                // E. Accumulate Expected Total
                ExpectedTotalFreight += FreshLineFreightToInvoice;

            until SalesLine.Next() = 0;

        // 4. Validate the Freight Line Total
        CurrentFreightLineAmt := 0;
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("No.", SalesSetup."Freight Item No.");

        // IMPORTANT: Only sum up UNPOSTED freight lines for validation
        SalesLine.SetRange("Quantity Shipped", 0);
        SalesLine.SetRange("Quantity Invoiced", 0);

        if SalesLine.FindSet() then
            repeat
                CurrentFreightLineAmt += SalesLine.Amount;
            until SalesLine.Next() = 0;

        if Abs(ExpectedTotalFreight - CurrentFreightLineAmt) > 0.01 then
            Error('Total Shipping Cost mismatch.\The sum of valid lines (%1) does not match the active Freight Line (%2).\Please run "Calculate Shipping" before posting.',
                  ExpectedTotalFreight, CurrentFreightLineAmt);
    end;

    // =========================================================================
    // SECTION 3: CALCULATION LOGIC (Pure Math)
    // =========================================================================

    local procedure CalculateUnitShippingCost(
        var SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        SalesType: Record "ONT Sales Type";
        OrderTotalQty: Decimal;
        OrderTotalAmt: Decimal
    ): Decimal
    var
        Item: Record Item;
        Family: Record Family;
        ShippingCostRule: Record "ONT Shipping Cost";
        CountryRegionCode: Code[20];
        ProvinceCode: Code[20];
        MissingCountryError: Label 'Missing Country/Region or Province Code on Sales Header %1. Please ensure these fields are populated to calculate shipping.';
    begin
        if SalesHeader."Shipping Formula" = SalesHeader."Shipping Formula"::Free then
            exit(0);
        if SalesHeader."Shipping Formula" = SalesHeader."Shipping Formula"::Fixed then
            exit(0);

        if SalesHeader."Shipping Formula" = SalesHeader."Shipping Formula"::Calculated then begin
            if not Item.Get(SalesLine."No.") then exit(0);
            if (Item."ONT Family Code" = '') or (not Family.Get(Item."ONT Family Code")) then exit(0);

            GetCountryRegionCode(SalesHeader, CountryRegionCode, ProvinceCode);
            if (CountryRegionCode = '') or (ProvinceCode = '') then
                Error(MissingCountryError, SalesHeader."No.");

            ShippingCostRule := FindBestShippingCost(CountryRegionCode, ProvinceCode, Family);

            if (ShippingCostRule."Free Shipping Min. Qty" > 0) and (OrderTotalQty >= ShippingCostRule."Free Shipping Min. Qty") then exit(0);
            if (ShippingCostRule."Free Shipping Min. Amount" > 0) and (OrderTotalAmt >= ShippingCostRule."Free Shipping Min. Amount") then exit(0);

            exit(SalesLine.Quantity * ShippingCostRule."Unit Shipping Fee");
        end;
        exit(0);
    end;

    // =========================================================================
    // SECTION 4: HELPERS (Search, Totals, DB Ops)
    // =========================================================================

    procedure FindBestShippingCost(pCountryRegionCode: Code[20]; pProvinceCode: Code[20]; pFamily: Record Family): Record "ONT Shipping Cost"
    var
        CandidateRule, BestRule : Record "ONT Shipping Cost";
        CurrentWeight, BestWeight : Integer;
    begin
        CandidateRule.SetRange("Country/Region Code", pCountryRegionCode);
        CandidateRule.SetRange("Province Code", pProvinceCode);
        CandidateRule.SetRange("Is Kids Product", pFamily.KidsProduct);
        CandidateRule.SetFilter("Product Type", '%1|%2', pFamily."Product Type", '');
        CandidateRule.SetFilter("RMH Code", '%1|%2', pFamily.Rmh, '');
        CandidateRule.SetFilter("Propulsion Code", '%1|%2', pFamily.Propulsion, '');
        CandidateRule.SetFilter("Segment Code", '%1|%2', pFamily.Segment, '');

        BestWeight := -1;
        Clear(BestRule);

        if CandidateRule.FindSet() then
            repeat
                CurrentWeight := 0;
                if CandidateRule."Product Type" <> '' then CurrentWeight += 105;
                if CandidateRule."RMH Code" <> '' then CurrentWeight += 104;
                if CandidateRule."Propulsion Code" <> '' then CurrentWeight += 102;
                if CandidateRule."Segment Code" <> '' then CurrentWeight += 101;

                if CurrentWeight > BestWeight then begin
                    BestWeight := CurrentWeight;
                    BestRule := CandidateRule;
                end;
            until CandidateRule.Next() = 0;
        exit(BestRule);
    end;

    local procedure CalculateOrderTotals(SalesHeader: Record "Sales Header"; FreightItemNo: Code[20]; var TotalQty: Decimal; var TotalAmt: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        TotalQty := 0;
        TotalAmt := 0;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', FreightItemNo);
        if SalesLine.FindSet() then
            repeat
                TotalQty += SalesLine.Quantity;
                TotalAmt += SalesLine."Line Amount";
            until SalesLine.Next() = 0;
    end;

    local procedure GetCountryRegionCode(SalesHeader: Record "Sales Header"; var pCountryRegionCode: Code[20]; var pProvinceCode: Code[20])
    var
        Country: Record "Country/Region";
    begin
        if (SalesHeader."Ship-to Country/Region Code" <> '') and Country.Get(SalesHeader."Ship-to Country/Region Code") then begin
            pCountryRegionCode := Country.Code;
            pProvinceCode := SalesHeader."Ship-to County";
            exit;
        end;
        if Country.Get(SalesHeader."Sell-to Country/Region Code") then begin
            pCountryRegionCode := Country.Code;
            pProvinceCode := SalesHeader."Sell-to County";
        end;
    end;

    local procedure CreateOrUpdateFreightLine(SalesHeader: Record "Sales Header"; Amount: Decimal)
    var
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        NextLineNo: Integer;
    begin
        SalesSetup.Get();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", SalesSetup."Freight Item No.");

        // CRITICAL CHANGE: Only look for lines that are NOT posted (Shipped=0, Invoiced=0)
        SalesLine.SetRange("Quantity Shipped", 0);
        SalesLine.SetRange("Quantity Invoiced", 0);

        if SalesLine.FindFirst() then begin
            // Update Existing Open Line
            if SalesLine."Unit Price" <> Amount then begin
                SalesLine.Validate("Unit Price", Amount);
                SalesLine.Modify(true);
            end;
        end else begin
            // Create New Line (Handles case where a previous freight line was posted)
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindLast() then NextLineNo := SalesLine."Line No." + 10000 else NextLineNo := 10000;

            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Line No." := NextLineNo;
            SalesLine.Insert(true);
            SalesLine.Validate(Type, SalesLine.Type::Item);
            SalesLine.Validate("No.", SalesSetup."Freight Item No.");
            SalesLine.Validate(Quantity, 1);
            SalesLine.Validate("Unit Price", Amount);
            SalesLine.Modify(true);
        end;
    end;

    local procedure DeleteExistingFreightLine(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetRange("No.", SalesSetup."Freight Item No.");

        // CRITICAL CHANGE: Only delete lines that are NOT posted
        SalesLine.SetRange("Quantity Shipped", 0);
        SalesLine.SetRange("Quantity Invoiced", 0);

        if SalesLine.FindSet() then
            SalesLine.DeleteAll(true);
    end;
}