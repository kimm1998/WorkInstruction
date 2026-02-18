codeunit 50527 "Commission Engine"
{
    Permissions = tabledata "Sales Invoice Header" = rm,
                  tabledata "Sales Cr.Memo Header" = rm;
    // A. LOAD DATA
    procedure LoadCommissionLines(
        var TempBuffer: Record "Commission Buffer" temporary;
        SalespersonFilter: Code[20];
        DateFilter: Text)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        TempBuffer.Reset();
        TempBuffer.DeleteAll();

        // 1. Process Invoices
        // Optimize: Pre-calc Amount and load only needed fields
        SalesInvHeader.SetAutoCalcFields(Amount);
        SalesInvHeader.SetLoadFields("No.", "Posting Date", "Salesperson Code", "Sell-to Customer No.", "Sell-to Customer Name", Amount);

        SalesInvHeader.SetRange("Commission Paid", false);

        if SalespersonFilter <> '' then SalesInvHeader.SetRange("Salesperson Code", SalespersonFilter);
        if DateFilter <> '' then SalesInvHeader.SetFilter("Posting Date", DateFilter);

        if SalesInvHeader.FindSet() then
            repeat
                // Check if Salesperson has a Vendor Link
                if Salesperson.Get(SalesInvHeader."Salesperson Code") then
                    if Salesperson."Vendor No." <> '' then
                        InsertBufferLine(TempBuffer,
                                         SalesInvHeader."No.",
                                         SalesInvHeader."Posting Date",
                                         SalesInvHeader."Salesperson Code",
                                         SalesInvHeader."Sell-to Customer No.",
                                         SalesInvHeader."Sell-to Customer Name",
                                         SalesInvHeader.Amount,
                                         TempBuffer."Document Type"::Invoice,
                                         Salesperson,
                                         SalesInvHeader."Sales Order Type",
                                         SalesInvHeader."Salesman commission %",
                                         SalesInvHeader."Order No.",
                                         SalesInvHeader."Due Date");

            until SalesInvHeader.Next() = 0;

        // 2. Process Credit Memos (Returns)
        SalesCrMemoHeader.SetAutoCalcFields(Amount);
        SalesCrMemoHeader.SetLoadFields("No.", "Posting Date", "Salesperson Code", "Sell-to Customer No.", "Sell-to Customer Name", Amount);

        SalesCrMemoHeader.SetRange("Commission Deducted", false);

        if SalespersonFilter <> '' then SalesCrMemoHeader.SetRange("Salesperson Code", SalespersonFilter);
        if DateFilter <> '' then SalesCrMemoHeader.SetFilter("Posting Date", DateFilter);

        if SalesCrMemoHeader.FindSet() then
            repeat
                if Salesperson.Get(SalesCrMemoHeader."Salesperson Code") and (Salesperson."Vendor No." <> '') then
                    InsertBufferLine(TempBuffer,
                                     SalesCrMemoHeader."No.",
                                     SalesCrMemoHeader."Posting Date",
                                     SalesCrMemoHeader."Salesperson Code",
                                     SalesCrMemoHeader."Sell-to Customer No.",
                                     SalesCrMemoHeader."Sell-to Customer Name",
                                     -SalesCrMemoHeader.Amount, // Negative for Return
                                     TempBuffer."Document Type"::"Credit Memo",
                                     Salesperson,
                                     SalesCrMemoHeader."Sales Order Type",
                                     SalesCrMemoHeader."Salesman commission %",
                                     SalesCrMemoHeader."Return Order No.",
                                     SalesCrMemoHeader."Due Date");
            until SalesCrMemoHeader.Next() = 0;
    end;

    // Helper: Insert Line into Buffer
    local procedure InsertBufferLine(
        var TempBuffer: Record "Commission Buffer" temporary;
        DocNo: Code[20];
        PostDate: Date;
        SPCode: Code[20];
        CustNo: Code[20];
        CustName: Text;
        DocAmount: Decimal;
        DocType: Enum "Sales Document Type";
        Salesperson: Record "Salesperson/Purchaser";
        SalesOrderType: code[20];
        Commission: Decimal;
        OrderNo: code[20];
        DueDate: Date)

    var
        SalesOrderTypeRec: Record "ONT Sales Type";
    begin
        TempBuffer.Init();
        TempBuffer."Document Type" := DocType;
        TempBuffer."Document No." := DocNo;
        TempBuffer."Posting Date" := PostDate;
        TempBuffer."Salesperson Code" := SPCode;
        TempBuffer."Vendor No." := Salesperson."Vendor No.";
        TempBuffer."Customer No." := CustNo;
        TempBuffer."Customer Name" := CustName;
        TempBuffer."Sales Amount (LCY)" := DocAmount;
        TempBuffer."Sales Order Type" := SalesOrderType;
        TempBuffer."Order No." := OrderNo;
        TempBuffer."Document Due Date" := DueDate;
        if SalesOrderTypeRec.get(SalesOrderType) then
            TempBuffer."Sales Order Type Desc." := SalesOrderTypeRec.Description;

        // Calc Collected Amount
        CalculateCollectedAmount(TempBuffer);

        // Calc Commission using STANDARD Field

        TempBuffer."Commission Paid" := GetCommissionAmountPaid(DocNo, DocType);
        TempBuffer."Commission Paid Not Posted" := GetCommissionAmountPaidNotPosted(DocNo, DocType);
        TempBuffer."Commission %" := Commission;
        if TempBuffer."Commission %" <> 0 then
            TempBuffer."Commission Amount" := Round((TempBuffer."Collected Amount (LCY)" * (TempBuffer."Commission %" / 100)), 0.01, '=') - TempBuffer."Commission Paid" - TempBuffer."Commission Paid Not Posted";
        TempBuffer."Commission to Pay" := Round((TempBuffer."Sales Amount (LCY)" * TempBuffer."Commission %" / 100), 0.01, '=') - TempBuffer."Commission Paid";
        TempBuffer.Insert();
    end;


    local procedure GetCommissionAmountPaid(DocNo: code[20]; DocType: enum "Sales Document Type"): Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCRMemo: Record "Purch. Cr. Memo Hdr.";
        Amount: Decimal;

    begin
        case DocType of
            DocType::Invoice:
                begin
                    PurchInvHeader.SetAutoCalcFields("Amount");
                    PurchInvHeader.SetRange("ONT Comm. Sales Inv. No", DocNo);
                    if PurchInvHeader.FindSet(false) then
                        repeat

                            Amount += PurchInvHeader.Amount;
                        until PurchInvHeader.Next() = 0;
                end;
            DocType::"Credit Memo":
                begin
                    PurchCRMemo.SetAutoCalcFields("Amount");
                    PurchCRMemo.SetRange("ONT Comm. Sales Inv. No", DocNo);
                    if PurchCRMemo.FindSet(false) then
                        repeat

                            Amount += PurchCRMemo.Amount;
                        until PurchInvHeader.Next() = 0;
                end;

        end;
        exit(Amount);
    end;

    local procedure GetCommissionAmountPaidNotPosted(DocNo: code[20]; DocType: enum "Sales Document Type"): Decimal
    var
        PurchaseHeader: Record "Purchase Header";
        PurchCRMemo: Record "Purch. Cr. Memo Hdr.";
        Amount: Decimal;

    begin
        case DocType of
            DocType::Invoice:
                begin
                    PurchaseHeader.SetAutoCalcFields("Amount");
                    PurchaseHeader.SetRange("ONT Comm. Sales Inv. No", DocNo);
                    PurchaseHeader.SetRange("Document Type", DocType);
                    if PurchaseHeader.FindSet(false) then
                        repeat

                            Amount += PurchaseHeader.Amount;
                        until PurchaseHeader.Next() = 0;
                end;
            DocType::"Credit Memo":
                begin
                    begin
                        PurchaseHeader.SetAutoCalcFields("Amount");
                        PurchaseHeader.SetRange("ONT Comm. Sales Inv. No", DocNo);
                        PurchaseHeader.SetRange("Document Type", DocType);
                        if PurchaseHeader.FindSet(false) then
                            repeat

                                Amount += PurchaseHeader.Amount;
                            until PurchaseHeader.Next() = 0;
                    end;

                end;
        end;
        exit(Amount);
    end;
    // Helper: Calculate Collected vs Remaining
    local procedure CalculateCollectedAmount(var Buffer:
                                                     Record "Commission Buffer")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CollectedAmount:
                Decimal;
    begin
        CustLedgerEntry.SetCurrentKey("Document No.", "Document Type");
        CustLedgerEntry.SetRange("Document No.", Buffer."Document No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);

        if CustLedgerEntry.FindFirst() then begin
            CustLedgerEntry.CalcFields("Amount (LCY)", "Remaining Amt. (LCY)");

            CollectedAmount := CustLedgerEntry."Amount (LCY)" - CustLedgerEntry."Remaining Amt. (LCY)" - GetVatAmount(CustLedgerEntry."Document No.");
            if CollectedAmount > 0 then
                Buffer."Collected Amount (LCY)" := CollectedAmount;

            Buffer."Is Fully Paid" := (CustLedgerEntry."Remaining Amt. (LCY)" = 0);
        end;
    end;


    local procedure GetVatAmount(DocNo: code[20]): Decimal
    var
        VatEntry: Record "VAT Entry";
        Amount: Decimal;
    begin
        VatEntry.SetRange("Document No.", DocNo);
        if VatEntry.FindSet(false) then
            repeat
                Amount += VatEntry.Amount;
            until VatEntry.Next() = 0;

        exit(-Amount);
    end;

    // B. GENERATE PURCHASE INVOICE
    procedure CreatePurchaseInvoice(var SelectedBuffer: Record "Commission Buffer" temporary)
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        SalesSetup: Record "Sales & Receivables Setup";
        LineNo: Integer;
        CurrentVendor: Code[20];
    begin
        if not SelectedBuffer.FindSet() then exit;

        // 1. Get G/L Config
        SalesSetup.Get();
        SalesSetup.TestField("Commission Expense Acc.");

        // 2. Sort by Vendor to group invoices
        SelectedBuffer.SetCurrentKey("Vendor No.");
        CurrentVendor := '';

        repeat
            // Create New Header if Vendor changes
            if SelectedBuffer."Vendor No." <> CurrentVendor then begin
                CurrentVendor := SelectedBuffer."Vendor No.";

                PurchHeader.Init();
                PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;
                PurchHeader.Insert(true);
                PurchHeader.Validate("Buy-from Vendor No.", CurrentVendor);
                PurchHeader.Validate("Posting Date", WorkDate());
                PurchHeader.Validate("Vendor Invoice No.", 'COMM-' + Format(WorkDate()) + '-' + SelectedBuffer."Salesperson Code");
                PurchHeader."ONT Comm. Sales Inv. No" := SelectedBuffer."Document No.";
                PurchHeader.Modify(true);

                LineNo := 10000;
            end;

            // Create Line
            PurchLine.Init();
            PurchLine."Document Type" := PurchHeader."Document Type";
            PurchLine."Document No." := PurchHeader."No.";
            PurchLine."Line No." := LineNo;
            PurchLine.Type := PurchLine.Type::"G/L Account";
            PurchLine.Insert(true);

            // Use Configured G/L Account
            PurchLine.Validate("No.", SalesSetup."Commission Expense Acc.");

            PurchLine.Description := StrSubstNo('Comm: %1 %2', SelectedBuffer."Document Type", SelectedBuffer."Document No.");
            PurchLine.Validate(Quantity, 1);
            PurchLine.Validate("Direct Unit Cost", SelectedBuffer."Commission Amount");
            PurchLine.Modify(true);
            // Mark Source Document as Paid
            //Check here if the sales invoice is not closed then will not mark as paid



            //Update Commission Amount Paid in Posted Docs
            //Check if fully Paid 
            //mark as Fully Paid
            // if CheckifDocumentisClosed(SelectedBuffer."Document No.", SelectedBuffer."Document Type") then
            MarkDocumentAsPaid(SelectedBuffer, PurchHeader."No.", SelectedBuffer."Commission Amount");

            LineNo += 10000;

        until SelectedBuffer.Next() = 0;

        Message('Success: Purchase Invoice(s) created.');
    end;

    // local procedure CheckifDocumentisClosed(DocNo: code[20]; Type: Enum "Sales Document Type"): Boolean
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     CrMemoHeader: Record "Sales Cr.Memo Header";
    // begin
    //     case Type of
    //         type::Invoice:
    //             begin
    //                 SalesInvoiceHeader.SetAutoCalcFields(Closed, "Remaining Amount");

    //                 SalesInvoiceHeader.get(DocNo);
    //                 if SalesInvoiceHeader.Closed then
    //                     exit(true);
    //             end;

    //         Type::"Credit Memo":
    //             begin
    //                 CrMemoHeader.SetAutoCalcFields("Remaining Amount");
    //                 CrMemoHeader.get(DocNo);
    //                 if CrMemoHeader."Remaining Amount" = 0 then
    //                     exit(true);
    //             end;
    //     end;

    //     exit(false);
    // end;

    local procedure MarkDocumentAsPaid(var Buffer: Record "Commission Buffer"; PurchInvNo: Code[20]; ComissionAmounttoPay: Decimal)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        SalesInvHeader.SetAutoCalcFields(Amount, "Amount Including VAT");
        SalesCrMemoHeader.SetAutoCalcFields(Amount, "Amount Including VAT");
        if Buffer."Document Type" = Buffer."Document Type"::Invoice then begin
            if SalesInvHeader.Get(Buffer."Document No.") then begin
                // SalesInvHeader."Commission Paid" := true;

                SalesInvHeader."Commission Amount Paid" := SalesInvHeader."Commission Amount Paid" + ComissionAmounttoPay;
                SalesInvHeader."Comm. Purch. Inv. No." := PurchInvNo;

                SalesInvHeader."Commission paid" := Round((Buffer."Sales Amount (LCY)" * SalesInvHeader."Salesman commission %" / 100), 0.01, '=') = SalesInvHeader."Commission Amount Paid";

                SalesInvHeader.Modify();
            end;
        end else begin
            if SalesCrMemoHeader.Get(Buffer."Document No.") then begin
                // SalesCrMemoHeader."Commission Deducted" := true;

                SalesCrMemoHeader."Commission Amount Paid" := SalesCrMemoHeader."Commission Amount Paid" + ComissionAmounttoPay;
                SalesCrMemoHeader."Comm. Purch. Inv. No." := PurchInvNo;
                SalesCrMemoHeader."Commission Deducted" := Round((Buffer."Sales Amount (LCY)" * SalesCrMemoHeader."Salesman commission %" / 100), 0.01, '=') = salesCrMemoheader."Commission Amount Paid";
                SalesCrMemoHeader.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::table, Database::"Purchase Header", OnBeforeOnDelete, '', false, false)]
    local procedure MyProcedure(var PurchaseHeader: Record "Purchase Header")
    var
        PSI: Record "Sales Invoice Header";
    begin
        if not PurchaseHeader.IsTemporary then begin
            if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Invoice then
                exit;

            PurchaseHeader.CalcFields(Amount);
            PSI.SetRange("Comm. Purch. Inv. No.", PurchaseHeader."No.");
            if PSI.FindFirst() then begin
                PSI."Commission Amount Paid" := PSI."Commission Amount Paid" - PurchaseHeader.Amount;
                PSI.Modify();
            end;
        end;

    end;

}