codeunit 50500 "Field Transfers Mgt. DSF"
{
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchaseHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(SalesLine: Record "Sales Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromPurchHeader(PurchHeader: Record "Purchase Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(PurchLine: Record "Purchase Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure OnAfterInitGLEntry(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', true, true)]
    local procedure OnAfterInitCustLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', true, true)]
    local procedure OnAfterInitVendLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var NewItemLedgEntry: Record "Item Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', true, true)]
    local procedure OnAfterInitValueEntry(ItemJournalLine: Record "Item Journal Line"; var ValueEntry: Record "Value Entry"; var ValueEntryNo: Integer)
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', true, true)]
    local procedure OnAfterInitBankAccLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitEmployeeLedgerEntry', '', true, true)]
    local procedure OnAfterInitEmployeeLedgerEntry(GenJournalLine: Record "Gen. Journal Line"; var EmployeeLedgerEntry: Record "Employee Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntryVAT', '', true, true)]
    local procedure OnAfterInitGLEntryVAT(GenJnlLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInitHeaderDefaults', '', true, true)]
    local procedure SalesOnAfterInitHeaderDefaults(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInitHeaderDefaults', '', true, true)]
    local procedure PurchaseOnAfterInitHeaderDefaults(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', true, true)]
    local procedure SalesOnAfterCopyFromItem(Item: Record Item; var SalesLine: Record "Sales Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignGLAccountValues', '', true, true)]
    local procedure OnAfterAssignGLAccountValues(GLAccount: Record "G/L Account"; var SalesLine: Record "Sales Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignGLAccountValues', '', true, true)]
    local procedure PurchaseOnAfterAssignGLAccountValues(GLAccount: Record "G/L Account"; var PurchLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', true, true)]
    local procedure OnCopyFromItemOnAfterCheck(Item: Record Item; var PurchLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', true, true)]
    local procedure SalesHeaderOnAfterValidateEvent(var Rec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if Customer.GET(Rec."Sell-to Customer No.")then begin
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Customer No.', true, true)]
    local procedure SalesHeaderOnAfterValidateEvent2(var Rec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if Customer.GET(Rec."Bill-to Customer No.")then begin
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Buy-from Vendor No.', true, true)]
    local procedure PurchaseHeaderOnAfterValidateEvent(var Rec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        Vendor: Record Vendor;
    begin
        if Vendor.GET(Rec."Buy-from Vendor No.")then begin
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Pay-to Vendor No.', true, true)]
    local procedure PurchaseHeaderOnAfterValidateEvent2(var Rec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        Vendor: Record Vendor;
    begin
        if Vendor.GET(Rec."Pay-to Vendor No.")then begin
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr', '', true, true)]
    local procedure OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(var SalesHeader: Record "Sales Header"; ShipToAddress: Record "Ship-to Address")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Subst.", 'OnCalcCustPriceOnBeforeTempItemSubstitutionInsert', '', true, true)]
    local procedure OnCalcCustPriceOnBeforeTempItemSubstitutionInsert(ItemSubstitution: Record "Item Substitution"; var TempItemSubstitution: Record "Item Substitution")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterCopyFromItem', '', true, true)]
    local procedure JobPlanLineOnAfterCopyFromItem(Item: Record Item; var JobPlanningLine: Record "Job Planning Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignStdTxtValues', '', true, true)]
    local procedure OnAfterAssignStdTxtValues(StandardText: Record "Standard Text"; var SalesLine: Record "Sales Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignStdTxtValues', '', true, true)]
    local procedure OnAfterAssignStdTxtValuesPurch(StandardText: Record "Standard Text"; var PurchLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader', '', true, true)]
    local procedure OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields', '', true, true)]
    local procedure OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields(var SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesInvHeaderInsert(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeSalesHeaderArchiveInsert', '', true, true)]
    local procedure OnBeforeSalesHeaderArchiveInsert(SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', true, true)]
    local procedure OnBeforeSalesInvLineInsert(SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', true, true)]
    local procedure OnBeforeSalesCrMemoLineInsert(SalesLine: Record "Sales Line"; var SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', true, true)]
    local procedure OnBeforeSalesShptLineInsert(SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeSalesLineArchiveInsert', '', true, true)]
    local procedure OnBeforeSalesLineArchiveInsert(SalesLine: Record "Sales Line"; var SalesLineArchive: Record "Sales Line Archive")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', true, true)]
    local procedure OnBeforePurchInvHeaderInsert(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', true, true)]
    local procedure OnBeforePurchCrMemoHeaderInsert(var PurchHeader: Record "Purchase Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', true, true)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforePurchHeaderArchiveInsert', '', true, true)]
    local procedure OnBeforePurchHeaderArchiveInsert(PurchaseHeader: Record "Purchase Header"; var PurchaseHeaderArchive: Record "Purchase Header Archive")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', true, true)]
    local procedure OnBeforePurchInvLineInsert(var PurchaseLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', true, true)]
    local procedure OnBeforePurchRcptLineInsert(var PurchLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoLineInsert', '', true, true)]
    local procedure OnBeforePurchCrMemoLineInsert(var PurchLine: Record "Purchase Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforePurchLineArchiveInsert', '', true, true)]
    local procedure OnBeforePurchLineArchiveInsert(PurchaseLine: Record "Purchase Line"; var PurchaseLineArchive: Record "Purchase Line Archive")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnBeforeCreatePickOrMoveLineFromSalesLoop', '', true, true)]
    local procedure OnBeforeCreatePickOrMoveLineFromSalesLoop(SalesHeader: Record "Sales Header"; var WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnGetCustomerAccountOnAfterCustGet', '', true, true)]
    local procedure OnGetCustomerAccountOnAfterCustGet(var Customer: Record Customer; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetVendorAccount(Vendor: Record Vendor; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetGLAccount(var GLAccount: Record "G/L Account"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetBankAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetBankAccount(var BankAccount: Record "Bank Account"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::Item, 'OnAfterValidateEvent', 'Item Category Code', true, true)]
    local procedure ItemOnAfterValidateEvent(var Rec: Record Item)
    var
        ItemCat: Record "Item Category";
    begin
        if Rec."Item Category Code" <> '' then if ItemCat.Get(Rec."Item Category Code")then begin
            end;
    end;
    [EventSubscriber(ObjectType::Table, database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure OnAfterCopyFromTransferHeaderShipment(TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
    end;
    [EventSubscriber(ObjectType::Table, database::"Transfer Receipt Header", 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure OnAfterCopyFromTransferHeaderReceipt(TransferHeader: Record "Transfer Header"; var TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", 'OnBeforeSalesShptHeaderModify', '', true, true)]
    local procedure OnBeforeSalesShptHeaderModify(FromSalesShptHeader: Record "Sales Shipment Header"; var SalesShptHeader: Record "Sales Shipment Header")
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedSalesShipment(var SalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean; xSalesShipmentHeader: Record "Sales Shipment Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnRunOnBeforeAssignValues', '', true, true)]
    local procedure OnRunOnBeforeAssignValuesSalesInvHeader(SalesInvoiceHeaderRec: Record "Sales Invoice Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Inv. Header - Edit", 'OnBeforePurchInvHeaderModify', '', true, true)]
    local procedure OnBeforePurchInvHeaderModify(PurchInvHeaderRec: Record "Purch. Inv. Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service Inv. Header - Edit", 'OnRunOnBeforeAssignNewValues', '', true, true)]
    local procedure OnRunOnBeforeAssignNewValuesServiceInv(ServiceInvoiceHeaderRec: Record "Service Invoice Header"; var ServiceInvoiceHeader: Record "Service Invoice Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Return Receipt Header - Edit", 'OnBeforeReturnReceiptHeaderModify', '', true, true)]
    local procedure OnBeforeReturnReceiptHeaderModify(ReturnReceiptHeaderRec: Record "Return Receipt Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Return Shipment Header - Edit", 'OnBeforeReturnShipmentHeaderModify', '', true, true)]
    local procedure OnBeforeReturnShipmentHeaderModify(ReturnShipmentHeaderRec: Record "Return Shipment Header"; var ReturnShipmentHeader: Record "Return Shipment Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Credit Memo Hdr. - Edit", 'OnBeforeSalesCrMemoHeaderModify', '', true, true)]
    local procedure OnBeforeSalesCrMemoHeaderModify(FromSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", 'OnValidateItemNoOnAfterGetDefaultBin', '', true, true)]
    local procedure OnValidateItemNoOnAfterGetDefaultBin(Item: Record Item; var AssemblyHeader: Record "Assembly Header")
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedSalesInvoice(xSalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean)
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Return Shpt. - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedReturnShip(xReturnShipmentHeaderGlobal: Record "Return Shipment Header"; xReturnShipmentHeader: Record "Return Shipment Header"; var ReturnShipmentHeader: Record "Return Shipment Header"; var IsChanged: Boolean)
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Service Inv. - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedServiceInvoice(xServiceInvoiceHeader: Record "Service Invoice Header"; var ServiceInvoiceHeader: Record "Service Invoice Header"; var IsChanged: Boolean)
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Purch. Invoice - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedPurchInvoice(xPurchInvHeaderGlobal: Record "Purch. Inv. Header"; xPurchInvHeader: Record "Purch. Inv. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var IsChanged: Boolean)
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Posted Return Receipt - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedReturnReceipt(xReturnReceiptHeaderGlobal: Record "Return Receipt Header"; xReturnReceiptHeader: Record "Return Receipt Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var IsChanged: Boolean)
    begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Pstd. Sales Cr. Memo - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChangedSalesCreditMemo(var IsChanged: Boolean; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; xSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', true, true)]
    local procedure PurchLineOnAfterAssignItemValues(Item: Record Item; var PurchLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnPostOnBeforePostedAssemblyHeaderInsert', '', true, true)]
    local procedure OnPostOnBeforePostedAssemblyHeaderInsert(AssemblyHeader: Record "Assembly Header"; var PostedAssemblyHeader: Record "Posted Assembly Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCapLedgEntry', '', true, true)]
    local procedure OnBeforeInsertCapLedgEntry(ItemJournalLine: Record "Item Journal Line"; var CapLedgEntry: Record "Capacity Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnAfterValidateEvent', 'No.', true, true)]
    local procedure ProdBOMLineOnAfterValidateEvent(var Rec: Record "Production BOM Line"; CurrFieldNo: Integer)
    var
        Item: Record Item;
    begin
        if Rec.Type = Rec.Type::Item then if Item.Get(Rec."No.")then begin
            end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Time Sheet Management", 'OnBeforeToTimeSheetLineInsert', '', true, true)]
    local procedure OnBeforeToTimeSheetLineInsert(FromTimeSheetLine: Record "Time Sheet Line"; var ToTimeSheetLine: Record "Time Sheet Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnSetJournalLineFieldsFromApplicationOnAfterFindFirstCustLedgEntryWithAppliesToID', '', true, true)]
    local procedure OnSetJournalLineFieldsFromApplicationOnAfterFindFirstCustLedgEntryWithAppliesToID(CustLedgEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnSetJournalLineFieldsFromApplicationOnAfterFindFirstCustLedgEntryWithAppliesToDocNo', '', true, true)]
    local procedure OnSetJournalLineFieldsFromApplicationOnAfterFindFirstCustLedgEntryWithAppliesToDocNo(CustLedgEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnSetJournalLineFieldsFromApplicationOnAfterFindFirstVendLedgEntryWithAppliesToID', '', true, true)]
    local procedure OnSetJournalLineFieldsFromApplicationOnAfterFindFirstVendLedgEntryWithAppliesToID(VendLedgEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnSetJournalLineFieldsFromApplicationOnAfterFindFirstVendLedgEntryWithAppliesToDocNo', '', true, true)]
    local procedure OnSetJournalLineFieldsFromApplicationOnAfterFindFirstVendLedgEntryWithAppliesToDocNo(VendLedgEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Gen. Journal Line", 'OnSetJournalLineFieldsFromApplicationOnAfterFindFirstEmplLedgEntryWithAppliesToID', '', true, true)]
    local procedure OnSetJournalLineFieldsFromApplicationOnAfterFindFirstEmplLedgEntryWithAppliesToID(CustLedgEntry: Record "Employee Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, CODEUNIT::"Req. Wksh.-Make Order", 'OnAfterInitPurchOrderLine', '', true, true)]
    local procedure OnBeforeInsertPurchOrderLine(RequisitionLine: Record "Requisition Line"; var PurchaseLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, CODEUNIT::"Req. Wksh.-Make Order", 'OnBeforePurchOrderHeaderInsert', '', true, true)]
    local procedure OnInsertHeaderOnBeforeValidateSellToCustNoFromReqLine(RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Header", 'OnAfterTransferSavedFields', '', true, true)]
    local procedure OnAfterTransferSavedFields(SourcePurchaseLine: Record "Purchase Line"; var DestinationPurchaseLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Header", 'OnBeforeTransferSavedFieldsDropShipment', '', true, true)]
    local procedure OnBeforeTransferSavedFieldsDropShipment(SourcePurchaseLine: Record "Purchase Line"; var DestinationPurchaseLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Header", 'OnBeforeTransferSavedFieldsSpecialOrder', '', true, true)]
    local procedure OnBeforeTransferSavedFieldsSpecialOrder(SourcePurchaseLine: Record "Purchase Line"; var DestinationPurchaseLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', true, true)]
    local procedure OnBeforeCustLedgEntryModify(FromCustLedgEntry: Record "Cust. Ledger Entry"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Vend. Entry-Edit", 'OnBeforeVendLedgEntryModify', '', true, true)]
    local procedure OnBeforeVendLedgEntryModify(FromVendLedgEntry: Record "Vendor Ledger Entry"; var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Sales Line", 'OnValidateVariantCodeOnAfterChecks', '', true, true)]
    local procedure OnValidateVariantCodeOnAfterChecks(var SalesLine: Record "Sales Line"; CallingFieldNo: Integer)
    var
        ItemVariant: Record "Item Variant";
    begin
        if ItemVariant.Get(SalesLine."No.", SalesLine."Variant Code")then begin
        end;
    end;
    [EventSubscriber(ObjectType::Table, DATABASE::"Purchase Line", 'OnValidateVariantCodeOnAfterValidationChecks', '', true, true)]
    local procedure OnValidateVariantCodeOnAfterValidationChecks(var PurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer)
    var
        ItemVariant: Record "Item Variant";
    begin
        if ItemVariant.Get(PurchaseLine."No.", PurchaseLine."Variant Code")then begin
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyNewTrackingFromReservEntry', '', true, true)]
    local procedure OnAfterCopyNewTrackingFromReservEntry(FromReservEntry: Record "Reservation Entry"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyNewTrackingFromWhseItemTrackingLine', '', true, true)]
    local procedure OnAfterCopyNewTrackingFromWhseItemTrackingLine(WhseItemTrackingLine: Record "Whse. Item Tracking Line"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromInvtProfile', '', true, true)]
    local procedure OnAfterCopyTrackingFromInvtProfile(InventoryProfile: Record "Inventory Profile"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromItemLedgEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry(ItemLedgerEntry: Record "Item Ledger Entry"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromItemTrackingSetup', '', true, true)]
    local procedure OnAfterCopyTrackingFromItemTrackingSetup(ItemTrackingSetup: Record "Item Tracking Setup" temporary; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromReservEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromReservEntry(FromReservationEntry: Record "Reservation Entry"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromReservEntryNewTracking', '', true, true)]
    local procedure OnAfterCopyTrackingFromReservEntryNewTracking(FromReservationEntry: Record "Reservation Entry"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromTrackingSpec', '', true, true)]
    local procedure OnAfterCopyTrackingFromTrackingSpec(TrackingSpecification: Record "Tracking Specification"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromWhseActivLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseActivLine(WarehouseActivityLine: Record "Warehouse Activity Line"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromWhseEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseEntry(WhseEntry: Record "Warehouse Entry"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromWhseItemTrackingLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseItemTrackingLine(WhseItemTrackingLine: Record "Whse. Item Tracking Line"; var ReservationEntry: Record "Reservation Entry")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Inventory Profile", 'OnAfterCopyTrackingFromInvtProfile', '', true, true)]
    local procedure OnAfterCopyTrackingFromInvtProfile2(FromInventoryProfile: Record "Inventory Profile"; var InventoryProfile: Record "Inventory Profile")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Inventory Profile", 'OnAfterCopyTrackingFromItemLedgEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry2(ItemLedgEntry: Record "Item Ledger Entry"; var InventoryProfile: Record "Inventory Profile")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Inventory Profile", 'OnAfterCopyTrackingFromReservEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromReservEntry2(ReservEntry: Record "Reservation Entry"; var InventoryProfile: Record "Inventory Profile")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Item Tracking Setup", 'OnAfterCopyTrackingFromReservEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromReservEntry3(ReservEntry: Record "Reservation Entry"; var ItemTrackingSetup: Record "Item Tracking Setup" temporary)
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyNewTrackingFromNewTrackingSpec', '', true, true)]
    local procedure OnAfterCopyNewTrackingFromNewTrackingSpec(FromTrackingSpecification: Record "Tracking Specification"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyNewTrackingFromTrackingSpec', '', true, true)]
    local procedure OnAfterCopyNewTrackingFromTrackingSpec(FromTrackingSpecification: Record "Tracking Specification"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromEntrySummary', '', true, true)]
    local procedure OnAfterCopyTrackingFromEntrySummary(EntrySummary: Record "Entry Summary" temporary; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromItemLedgEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry3(ItemLedgerEntry: Record "Item Ledger Entry"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromItemTrackingSetup', '', true, true)]
    local procedure OnAfterCopyTrackingFromItemTrackingSetup2(ItemTrackingSetup: Record "Item Tracking Setup" temporary; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromReservEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromReservEntry4(ReservEntry: Record "Reservation Entry"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromTrackingSpec', '', true, true)]
    local procedure OnAfterCopyTrackingFromTrackingSpec2(FromTrackingSpecification: Record "Tracking Specification"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromWhseActivityLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseActivityLine(WhseActivityLine: Record "Warehouse Activity Line"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromWhseItemTrackingLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseItemTrackingLine2(WhseItemTrackingLine: Record "Whse. Item Tracking Line"; var TrackingSpecification: Record "Tracking Specification")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromEntrySummary', '', true, true)]
    local procedure OnAfterCopyTrackingFromEntrySummary2(EntrySummary: Record "Entry Summary" temporary; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromItemLedgEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry4(ItemLedgerEntry: Record "Item Ledger Entry"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromPostedWhseRcptLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromPostedWhseRcptLine(PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromPostedWhseReceiptine', '', true, true)]
    local procedure OnAfterCopyTrackingFromPostedWhseReceiptine(PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromRelation', '', true, true)]
    local procedure OnAfterCopyTrackingFromRelation(WhseItemEntryRelation: Record "Whse. Item Entry Relation"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromReservEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromReservEntry5(ReservationEntry: Record "Reservation Entry"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromWhseActivityLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseActivityLine2(WhseActivityLine: Record "Warehouse Activity Line"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromWhseEntry', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseEntry2(WhseEntry: Record "Warehouse Entry"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Whse. Item Tracking Line", 'OnAfterCopyTrackingFromWhseItemTrackingLine', '', true, true)]
    local procedure OnAfterCopyTrackingFromWhseItemTrackingLine3(FromWhseItemTrackingLine: Record "Whse. Item Tracking Line"; var WhseItemTrackingLine: Record "Whse. Item Tracking Line")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyTrackingFromSpec', '', true, true)]
    local procedure OnAfterCopyTrackingFromSpec(TrackingSpecification: Record "Tracking Specification"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnAfterCreateProdOrderFromSalesLine', '', true, true)]
    local procedure OnAfterCreateProdOrderFromSalesLine(var SalesLine: Record "Sales Line"; var ProdOrder: Record "Production Order")
    begin
    end;
    [EventSubscriber(ObjectType::Table, Database::"BOM Component", 'OnAfterCopyFromItem', '', true, true)]
    local procedure OnAfterCopyFromItem(Item: Record Item; var BOMComponent: Record "BOM Component")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforePostedWhseShptHeaderInsert', '', true, true)]
    local procedure OnBeforePostedWhseShptHeaderInsert(WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnBeforeNewWhseActivLineInsert', '', true, true)]
    local procedure OnBeforeNewWhseActivLineInsert(WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseActivityLine: Record "Warehouse Activity Line")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnCodeOnBeforeModify', '', true, true)]
    local procedure DropOnCodeOnBeforeModify(SalesHeader: Record "Sales Header"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnBeforePurchaseLineInsert', '', true, true)]
    local procedure DropOnBeforePurchaseLineInsert(SalesLine: Record "Sales Line"; var PurchaseLine: Record "Purchase Line")
    begin
    end;
    [EventSubscriber(ObjectType::Report, Report::"Get Sales Orders", 'OnBeforeInsertReqWkshLine', '', true, true)]
    local procedure OnBeforeInsertReqWkshLine(SalesLine: Record "Sales Line"; var ReqLine: Record "Requisition Line")
    begin
    end;
    procedure DataCaption(VarRec: Variant): Text var
        Ref: RecordRef;
        i: Integer;
        AddedFields: Integer;
        Fref: FieldRef;
        Result: Text;
        UsedFields: Dictionary of[Integer, Text];
        UsedFieldTypes: Dictionary of[Text, Text];
    begin
        Ref.GetTable(VarRec);
        for i:=1 to Ref.KeyIndex(1).FieldCount()do begin
            Fref:=Ref.FieldIndex(i);
            UsedFields.Add(Fref.Number(), Fref.Name());
            if not UsedFieldTypes.ContainsKey(format(Fref.Type()))then UsedFieldTypes.Add(Format(Fref.Type()), format(Fref.Type()));
            if Result <> '' then result+=' ' + FRef.Caption + ': ' + format(FRef.Value())
            else
                Result+=FRef.Caption + ': ' + format(Fref.Value());
        end;
        for i:=1 to Ref.FieldCount()do begin
            Fref:=Ref.FieldIndex(i);
            if not UsedFields.ContainsKey(Fref.Number())then begin
                case Fref.Type of FieldType::Text: begin
                    if Result <> '' then result+=' ' + FRef.Caption + ': ' + format(FRef.Value())
                    else
                        Result+=FRef.Caption + ': ' + format(Fref.Value());
                end;
                else
                begin
                    if not UsedFieldTypes.ContainsKey(format(Fref.Type()))then begin
                        if Result <> '' then result+=' ' + FRef.Caption + ': ' + format(FRef.Value())
                        else
                            Result+=FRef.Caption + ': ' + format(Fref.Value());
                        UsedFieldTypes.Add(Format(Fref.Type()), format(Fref.Type()));
                    end;
                end;
                end;
                AddedFields+=1;
                if AddedFields > 4 then exit(Result);
            end;
        end;
        exit(Result);
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FrameDSF: Record FrameDSF;
    begin
        case DocumentAttachment."Table ID" of DATABASE::FrameDSF: begin
            RecRef.Open(DATABASE::FrameDSF);
            if FrameDSF.Get(DocumentAttachment."No.")then RecRef.GetTable(FrameDSF);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of DATABASE::FrameDSF: begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of DATABASE::FrameDSF: begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        end;
    end;
}
