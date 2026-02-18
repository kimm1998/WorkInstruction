codeunit 50521 "ONT Devenci Subscribers"
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, 6500, OnAfterCreateLotInformation, '', false, false)]
    local procedure OnAfterCreateLotInformation(var TrackingSpecification: Record "Tracking Specification"; var LotNoInfo: Record "Lot No. Information")
    var
    begin
        LotNoInfo."ONT Expiration Date" := TrackingSpecification."Expiration Date";
        LotNoInfo.Modify();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnAfterCreateSNInformation, '', false, False)]
    local procedure OnAfterCreateSnInformation(TrackingSpecification: Record "Tracking Specification"; var SerialNoInfo: Record "Serial No. Information")
    var
        itemLedgerEntry: Record "Item Ledger Entry";
        ILEConsumption: Record "Item Ledger Entry";
        LotNoInformation: Record "Lot No. Information";
    begin
        itemLedgerEntry.SetRange("Serial No.", SerialNoInfo."Serial No.");
        if itemLedgerEntry.FindFirst() then begin
            ILEConsumption.SetRange("Entry Type", ILEConsumption."Entry Type"::Consumption);
            ILEConsumption.SetRange("Order Type", ILEConsumption."Order Type"::Production);
            ILEConsumption.SetRange("Order No.", itemLedgerEntry."Order No.");
            ILEConsumption.SetRange("ONT Child Maintenance Required", true);
            if ILEConsumption.FindFirst() then begin
                LotNoInformation.SetRange("Lot No.", ILEConsumption."Lot No.");
                LotNoInformation.SetRange("Item No.", ILEConsumption."Item No.");
                if LotNoInformation.FindFirst() then begin
                    SerialNoInfo."ONT Child Item No." := ILEConsumption."Item No.";
                    SerialNoInfo."ONT Child Last maintenace Date" := LotNoInformation."ONT Last Maintenance Date";
                    SerialNoInfo."ONT Child Lot No." := LotNoInformation."Lot No.";
                    SerialNoInfo."ONT Last Maintenance Date" := LotNoInformation."ONT Last Maintenance Date";
                    SerialNoInfo.Modify();
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5407, OnBeforeOnRun, '', false, false)]
    local procedure OnBeforeOnRunProdOrderStatusManagement(var IsHandled: Boolean; var ProductionOrder: Record "Production Order")
    var
        ChangeStatusOnProdOrderPage: Page "ONT Change Sts on Prod. Order";
        ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
        NewStatus: Enum "Production Order Status";
        NewPostingDate: Date;
        NewUpdateUnitCost: Boolean;
        TransferMgt: Codeunit "ONT Shopfloor Transfer Mgt";
        NewCreateTransfer: Boolean;
        ONTProdOrdrStatsMangmnt: Codeunit "ONT Prod. Ordr Stats Mangmnt";
    begin
        if ProductionOrder.Status = ProductionOrder.Status::"Firm Planned" then begin
            IsHandled := true;
            CODEUNIT.Run(CODEUNIT::"ONT Prod. Ordr Stats Mangmnt", ProductionOrder);
            // ChangeStatusOnProdOrderPage.Set(ProductionOrder);
            // if ChangeStatusOnProdOrderPage.RunModal() = ACTION::Yes then begin
            //     ChangeStatusOnProdOrderPage.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost, NewCreateTransfer);
            //     ProdOrderStatusManagement.ChangeProdOrderStatus(ProductionOrder, NewStatus, NewPostingDate, NewUpdateUnitCost);
            //     if NewCreateTransfer then
            //         TransferMgt.RunForProductionOrder(NewStatus, ProductionOrder."No.");
            //     Commit();
            // ShowStatusMessage(ProductionOrder);
            // end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, 5407, OnAfterChangeStatusOnProdOrder, '', false, false)]
    local procedure OnAfterChangeStatusOnProdOrder(var ToProdOrder: Record "Production Order"; var ProdOrder: Record "Production Order")
    var

    begin
        if ProdOrder.Status = ProdOrder.Status::"Firm Planned" then begin
            ShowStatusMessage(ProdOrder, ToProdOrder);
        end;
        ToProdictionOrder := ToProdOrder;
    end;

    local procedure ShowStatusMessage(ProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order")
    var
        Text000: Label '%2 %3  with status %1 has been changed to %5 %6 with status %4.';
    begin

        Message(Text000, ProdOrder.Status, ProdOrder.TableCaption(), ProdOrder."No.", ToProdictionOrder.Status, ToProdictionOrder.TableCaption(), ToProdictionOrder."No.");
    end;

    [EventSubscriber(ObjectType::codeunit, 90, 'OnRunOnAfterPostInvoice', '', false, false)]
    local procedure OnAfterPostPurchLines(var PurchaseHeader: Record "Purchase Header"; var PreviewMode: Boolean)
    var
        PurchLine: Record "Purchase Line";
        cod: codeunit 90;
    begin
        if not PreviewMode then begin
            if PurchaseHeader.Receive then begin
                PurchLine.reset();
                PurchLine.SetRange("Document No.", PurchaseHeader."No.");
                PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
                PurchLine.SetRange(PrintLabelReceive, true);
                PurchLine.SetRange(Type, PurchLine.Type::Item);
                if PurchLine.FindFirst() then
                    report.run(report::"Component Label", false, false, PurchLine);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::codeunit, 90, 'OnAfterPurchRcptLineInsert', '', false, false)]
    LOCAL procedure OnAfterPurchRcptLineInsert(PurchaseLine: Record "Purchase Line";
  VAR PurchRcptLine: Record "Purch. Rcpt. Line";
  ItemLedgShptEntryNo: Integer;
  WhseShip: Boolean;
  WhseReceive: Boolean;
  CommitIsSupressed: Boolean;
  PurchInvHeader: record "Purch. Inv. Header")
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.reset();
        PurchLine.SetRange("Document No.", PurchaseLine."Document No.");
        PurchLine.SetRange("Document Type", PurchaseLine."Document Type");
        PurchLine.SetRange("Line No.", PurchaseLine."Line No.");
        //  report.run(report::PurchaseOrderReceived,false,false,PurchLine);
        if PurchLine.FindFirst() then
            if PurchLine."Qty. to Receive" > 0 then begin
                PurchLine.PrintLabelReceive := true;
                PurchLine.modify(false);
            end;
    end;

    [EventSubscriber(ObjectType::codeunit, 90, 'OnAfterCheckAndUpdate', '', false, false)]
    LOCAL procedure OnAfterCheckAndUpdate(VAR PurchaseHeader: Record "Purchase Header";
    CommitIsSuppressed: Boolean;
    PreviewMode: Boolean)
    var
        PurchLine: Record "Purchase Line";
    begin
        if PurchaseHeader.Receive then begin
            PurchLine.reset();
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
            // PurchLine.setfilter("Qty. to Receive",'>%1',0 );
            //report.run(report::PurchaseOrderReceived,false,false,PurchLine);
            if PurchLine.FindFirst() then
                repeat
                    if PurchLine."Qty. to Receive" > 0 then
                        PurchLine.PrintLabelReceive := true
                    else
                        PurchLine.PrintLabelReceive := false;
                    PurchLine.modify(false);
                until PurchLine.Next() = 0;
        end
        else begin
            PurchLine.reset();
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
            //report.run(report::PurchaseOrderReceived,false,false,PurchLine);
            if PurchLine.FindFirst() then
                repeat
                    PurchLine.PrintLabelReceive := false;
                    PurchLine.modify(false);
                until PurchLine.Next() = 0;
        end;
    end;


    [EventSubscriber(ObjectType::Table, 36, OnAfterInitDefaultDimensionSources, '', false, false)]
    local procedure OnAfterInitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; var SalesHeader: Record "Sales Header"; FieldNo: Integer)
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::"ONT Sales Type", SalesHeader."Sales Order Type", FieldNo = SalesHeader.FieldNo("Sales Order Type"));
    end;

    [EventSubscriber(ObjectType::page, 2900, OnProdForecastQtyBase_OnValidateOnAfterCalcShouldConfirmMovingForecasts, '', false, false)]
    local procedure OnProdForecastQtyBase_OnValidateOnAfterCalcShouldConfirmMovingForecasts(var ShouldConfirmMovingForecasts: Boolean)
    var

    begin
        ShouldConfirmMovingForecasts := false;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnAfterPostLines', '', False, False)]
    // // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", , '', false, false)]
    // local procedure MyProcedure(var ItemJournalLine: Record "Item Journal Line"; var WhseRegNo: Integer)
    // begin
    //     Message(format(ItemJournalLine."Entry Type"));
    // end;

#if not CLEAN27

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterPostOutput, '', false, false)]

    // local procedure MyProcedure1(var ItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ProdOrderLine: Record "Prod. Order Line")
    // var
    //     ItemTrackingCode: record "Item Tracking Code";
    //     item: Record Item;
    //     ItemLedgerEntryConsumption: Record "Item Ledger Entry";
    // begin
    //     // check related consumptionitemledgerentries
    // end;

#endif



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterPostItemJnlLine, '', false, false)]

    local procedure PrintItemLabelandCertificate(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        Item: Record item;
        DataCompression: Codeunit "Data Compression";
        ZipInStream: InStream;
        ZipOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        ZIpName: Text;
    begin
        if ItemLedgerEntry.IsTemporary then exit;
        if ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Output then
            exit;

        if item.get(ItemLedgerEntry."Item No.") then
            if item."ONT Label Layout" <> item."ONT Label Layout"::"Finished Product" then
                exit;

        DataCompression.CreateZipArchive();
        PrintFinishedProductLabel(ItemLedgerEntry, DataCompression);
        PrintFinishedProductCerificate(ItemLedgerEntry, DataCompression);
        TempBlob.CreateOutStream(ZipOutStream);
        DataCompression.SaveZipArchive(ZipOutStream);
        TempBlob.CreateInStream(ZipInStream);
        ZIpName := item."No." + ' - Label and Certificate.zip';
        DownloadFromStream(ZipInStream, '', '', '', ZIpName);


    end;

    local procedure PrintFinishedProductLabel(ItemLedgerEntry: Record "Item Ledger Entry"; DataCompression: Codeunit "Data Compression")
    var
        FinishedProductLabel: Report "ONT Finished Product Label";
        FinishedProductCertificate: Report "ONT Finished Good  Certificate";
        Outs: OutStream;
        ItemLedEntryVar: Record "Item Ledger Entry";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Ins: InStream;
        FileManagement: Codeunit "File Management";
        item: Record Item;
        printerSelection: Record "Printer Selection";
    begin
        TempBlob.CreateOutStream(Outs);

        RecRef.Open(Database::"Item Ledger Entry");
        ItemLedEntryVar.SetRange("Entry No.", ItemLedgerEntry."Entry No.");
        RecRef.GetTable(ItemLedEntryVar);
        FinishedProductLabel.SetTableView(ItemLedgerEntry);
        FinishedProductLabel.SaveAs('', ReportFormat::Pdf, Outs, RecRef);
        TempBlob.CreateInStream(Ins);
        DataCompression.AddEntry(Ins, ItemLedgerEntry."Item No." + ' - Label.pdf');
        // FileManagement.BLOBExport(TempBlob, ItemLedgerEntry."Item No." + ' - Label.pdf', true);
    end;

    local procedure PrintFinishedProductCerificate(ItemLedgerEntry: Record "Item Ledger Entry"; DataCompression: Codeunit "Data Compression")
    var
        FinishedProductLabel: Report "ONT Finished Product Label";
        FinishedProductCertificate: Report "ONT Finished Good  Certificate";
        Outs: OutStream;
        ItemLedEntryVar: Record "Item Ledger Entry";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Ins: InStream;
        FileManagement: Codeunit "File Management";
        item: Record Item;
        printerSelection: Record "Printer Selection";
    begin
        TempBlob.CreateOutStream(Outs);


        RecRef.Open(Database::"Item Ledger Entry");
        ItemLedEntryVar.SetRange("Entry No.", ItemLedgerEntry."Entry No.");
        RecRef.GetTable(ItemLedEntryVar);
        FinishedProductCertificate.SetTableView(ItemLedgerEntry);
        FinishedProductCertificate.SaveAs('', ReportFormat::Pdf, Outs, RecRef);
        // FinishedProductCertificate.Execute('', RecRef)
        TempBlob.CreateInStream(Ins);
        DataCompression.AddEntry(Ins, ItemLedgerEntry."Item No." + ' - Certificate.pdf');

        // FileManagement.BLOBExport(TempBlob, ItemLedgerEntry."Item No." + ' - Certificate.pdf', true);
    end;

    var

        ToProdictionOrder: Record "Production Order";
        myInt: Integer;
}