codeunit 50528 "OTG.Code Runner"
{
    Permissions = tabledata "Sales Invoice Header" = rmi;
    trigger OnRun()
    begin
        PurchaseInvoice.SetAutoCalcFields(Amount);
        PurchaseInvoiceHeader.SetAutoCalcFields(Amount);

        if SalesInvHeader.FindSet(true) then
            repeat
                amount := 0;
                PurchaseInvoice.SetRange("ONT Comm. Sales Inv. No", SalesInvHeader."No.");
                if PurchaseInvoice.FindSet() then
                    repeat
                        amount += PurchaseInvoice.Amount;
                    until PurchaseInvoice.Next() = 0;
                PurchaseInvoiceHeader.SetRange("ONT Comm. Sales Inv. No", SalesInvHeader."No.");
                if PurchaseInvoice.FindSet() then
                    repeat
                        amount += PurchaseInvoiceHeader.Amount;
                    until PurchaseInvoiceHeader.Next() = 0;
                SalesInvHeader."Commission Amount Paid" := amount;
                SalesInvHeader.Modify();
            until SalesInvHeader.Next() = 0;
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        PurchaseInvoice: Record "Purchase Header";
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
        amount: Decimal;
}