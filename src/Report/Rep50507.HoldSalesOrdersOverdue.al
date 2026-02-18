report 50507 "Hold Sales Orders - Overdue"
{
    Caption = 'Hold Sales Orders - Overdue';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group";
            trigger OnAfterGetRecord()
            var
                HasOverdue: Boolean;
                GracePeriod: DateFormula;
            begin

                HasOverdue := CustomerHasOverdueOpenEntries(Customer, GracePeriod);
                if HasOverdue then begin
                    HoldCustomerSalesOrders(Customer);
                    // HoldCustomer(Customer);
                end;
            end;

            trigger OnPreDataItem()
            begin
                ClearSalesHold();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }
    }

    var



    local procedure CustomerHasOverdueOpenEntries(Cust: Record Customer; var GracePeriod: DateFormula): Boolean
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        FinChargeTerms: Record "Finance Charge Terms";
        CheckDate: Date;
        CutoffDate: Date;
        MinAmount: Decimal;
        TotalOverdueLCY: Decimal;
    begin
        CheckDate := Today();
        Clear(GracePeriod);
        MinAmount := 0;

        if Cust."Fin. Charge Terms Code" <> '' then
            if FinChargeTerms.Get(Cust."Fin. Charge Terms Code") then begin
                GracePeriod := FinChargeTerms."Grace Period";

                // Use the correct field name in your environment:
                // MinAmount := FinChargeTerms."Minimum Amount";
                MinAmount := FinChargeTerms."Minimum Amount (LCY)";
            end;

        CustLedgEntry.Reset();
        CustLedgEntry.SetCurrentKey("Customer No.", Open, "Due Date");
        CustLedgEntry.SetRange("Customer No.", Cust."No.");
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetFilter("Due Date", '<>%1', 0D);

        TotalOverdueLCY := 0;

        if CustLedgEntry.FindSet(false) then
            repeat
                CutoffDate := CalcDate(GracePeriod, CustLedgEntry."Due Date");

                if CutoffDate < CheckDate then begin
                    CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                    TotalOverdueLCY += Abs(CustLedgEntry."Remaining Amt. (LCY)");
                end;
            until CustLedgEntry.Next() = 0;
        exit((TotalOverdueLCY > 0) and (TotalOverdueLCY >= MinAmount));
    end;

    // local procedure CustomerHasOverdueOpenEntries(Cust: Record Customer; var GracePeriod: DateFormula): Boolean
    // var
    //     CustLedgEntry: Record "Cust. Ledger Entry";
    //     FinChargeTerms: Record "Finance Charge Terms";
    //     CheckDate: Date;
    //     CutoffDate: Date;
    //     salesSetup: Record "Sales & Receivables Setup";
    // begin
    //     salesSetup.Get();
    //     CheckDate := Today();

    //     Clear(GracePeriod);

    //     if Cust."Fin. Charge Terms Code" <> '' then
    //         if FinChargeTerms.Get(Cust."Fin. Charge Terms Code") then
    //             GracePeriod := FinChargeTerms."Grace Period";

    //     CustLedgEntry.Reset();
    //     CustLedgEntry.SetCurrentKey("Customer No.", Open, "Due Date");
    //     CustLedgEntry.SetRange("Customer No.", Cust."No.");
    //     CustLedgEntry.SetRange(Open, true);
    //     CustLedgEntry.SetFilter("Remaining Amount", '<>%1', 0);
    //     CustLedgEntry.SetFilter("Due Date", '<>%1', 0D);

    //     if CustLedgEntry.FindSet(false) then
    //         repeat
    //             CutoffDate := CalcDate(GracePeriod, CustLedgEntry."Due Date");

    //             if CutoffDate < CheckDate then
    //                 exit(true);
    //         until CustLedgEntry.Next() = 0;

    //     exit(false);
    // end;

    local procedure HoldCustomerSalesOrders(Cust: Record Customer)
    var
        SalesHeader: Record "Sales Header";
        salesSetup: Record "Sales & Receivables Setup";
    begin
        salesSetup.Get();
        SalesHeader.Reset();
        SalesHeader.SetRange("Sell-to Customer No.", Cust."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("ONT No overright", false);
        SalesHeader.SetRange("Sales Order Blocked", false);

        if SalesHeader.FindSet(true) then
            repeat
                SalesHeader.Validate("Sales Order Blocked", true);
                SalesHeader.Validate("ONT Block Reason", salesSetup."Block Reason Code");
                SalesHeader.Modify(true);
            until SalesHeader.Next() = 0;
    end;

    local procedure HoldCustomer(Cust: Record Customer)
    var
        Customers: Record Customer;
        salesSetup: Record "Sales & Receivables Setup";
    begin
        salesSetup.Get();
        if Customers.Get(Cust."No.") then begin
            Customers.Validate(Blocked, Customer.Blocked::Ship);
            Customers.Validate("Block Reason Code", salesSetup."Block Reason Code");
            Customers.Modify(true);
        end;
    end;

    local procedure ClearSalesHold()
    var
        SalesHeader: Record "Sales Header";
        salesSetup: Record "Sales & Receivables Setup";
    begin
        salesSetup.Get();
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sales Order Blocked", true);
        if SalesHeader.FindSet(true) then
            repeat
                SalesHeader.Validate("Sales Order Blocked", false);
                SalesHeader.Validate("ONT Block Reason", '');
                SalesHeader.Modify(true);
            until SalesHeader.Next() = 0;
    end;
}
