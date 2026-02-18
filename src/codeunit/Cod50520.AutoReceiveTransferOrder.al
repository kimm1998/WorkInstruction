codeunit 50520 "Auto Receive Transfer Order"
// {

//     procedure AutoReceiveTransferOrder(TransferHeader: Record "Transfer Header")
//     var
//         Location: Record Location;
//         TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
//         TransferLine: Record "Transfer Line";
//     begin
//         Location.Get(TransferHeader."Transfer-to Code");

//         // TransferLine.SetRange("Document No.", TransferHeader."No.");
//         // TransferLine.SetRange("Derived From Line No.", 0);
//         // if TransferLine.FindFirst() then
//         //     repeat
//         //         TransferLine.Validate("Qty. to Receive (Base)", TransferLine."Qty. Shipped (Base)");
//         //     until TransferLine.Next() = 0;

//         if Location."Auto Create Wrhs Recpt" then begin
//             UpdateTransferOrderLinesQtyToReceive(TransferHeader);
//             TransferOrderPostReceipt.SetHideValidationDialog(true);
//             TransferOrderPostReceipt.SetPreviewMode(false);
//             TransferOrderPostReceipt.Run(TransferHeader);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterTransferOrderPostShipment, '', false, false)]
//     local procedure "TransferOrder-Post Shipment_OnAfterTransferOrderPostShipment"(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var TransferShipmentHeader: Record "Transfer Shipment Header"; InvtPickPutaway: Boolean)
//     begin
//         AutoReceiveTransferOrder(TransferHeader);
//     end;

//     procedure UpdateTransferOrderLinesQtyToReceive(var TransferHeader: Record "Transfer Header")
//     var
//         TransferLine: Record "Transfer Line";
//     begin

//         TransferLine.SetRange("Document No.", TransferHeader."No.");

//         if TransferLine.FindSet(true) then
//             repeat
//                 if not TransferLine.IsTemporary then begin

//                     if TransferLine."Quantity Shipped" > 0 then begin
//                         TransferLine.Validate("Qty. to Receive", TransferLine."Quantity Shipped" - TransferLine."Quantity Received");
//                         TransferLine.Modify();
//                     end;
//                 end;
//             until TransferLine.Next() = 0;
//     end;



// }


// codeunit 92111 "Auto Receive Transfer Order"
{

    var
        AutoReceiveLocationSetup: Record "Auto Receive Location Setup";

    #region subscribers
    // -------------------------------------------------------------------------

    // Event Subscribers

    // -------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterTransferOrderPostShipment, '', false, false)]
    local procedure "TransferOrder-Post Shipment_OnAfterTransferOrderPostShipment"(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var TransferShipmentHeader: Record "Transfer Shipment Header"; InvtPickPutaway: Boolean)
    begin
        //# not using warehouse shipment
        AutoReceiveTransferOrder_FromTransferShipment(TransferHeader, TransferShipmentHeader, InvtPickPutaway);
    end;

    #endregion
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnBeforeCode, '', False, false)]
    local procedure SaveLicensePlateNo(var WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        LpHeader: Record "IWX LP Header";
        SingleInstance: Codeunit "Single Instance";
    begin
        LpHeader.SetRange("Source Document", LpHeader."Source Document"::"Invt. Pick");
        LpHeader.SetRange("Source No.", WarehouseActivityLine."No.");
        if LpHeader.Findset(false) then
            repeat
                SingleInstance.SetLicensePlates(LpHeader."No.");
            until LpHeader.Next() = 0;


    end;

    // -------------------------------------------------------------------------

    // Main Functions

    // -------------------------------------------------------------------------
    #region main procedures

    procedure AutoReceiveTransferOrder_FromTransferShipment(TransferHeader: Record "Transfer Header"; TransferShipmentHeader: Record "Transfer Shipment Header"; InvPutAway: Boolean)
    var
        Location: Record Location;
        TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TransferLine: Record "Transfer Line";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        toBinCode: Code[20];
        invPick: page "Warehouse Pick";
    begin
        AutoReceiveLocationSetup.SetRange("From Location", TransferHeader."Transfer-from Code");
        AutoReceiveLocationSetup.SetRange("To Location", TransferHeader."Transfer-to Code");
        AutoReceiveLocationSetup.SetRange("Auto Receive", true);
        if not AutoReceiveLocationSetup.FindFirst() then
            exit;

        Location.Get(TransferHeader."Transfer-to Code");

        if not Location."Require Receive" then begin
            //Update Item tracking when receiving
            UpdateTransferOrderLinesQtyToReceive(TransferHeader);
            updatetransferorderlinesbintoreceive(TransferHeader);
            TransferOrderPostReceipt.SetHideValidationDialog(true);
            TransferOrderPostReceipt.SetPreviewMode(false);
            TransferOrderPostReceipt.Run(TransferHeader);

            if InvPutAway then begin
                MoveLicensPlatetoReceiptBin(Location.Code, AutoReceiveLocationSetup."Override Bin"); //Check here
            end;
        end else begin
            // toBinCode := TransferHeader."Trailer No.";
            CreateWarehouseReceipt(TransferHeader, WarehouseReceiptHeader, toBinCode);
            GetWarehouseReceiptSourceDocuments(TransferHeader."No.", '', WarehouseReceiptHeader);
            if false then//# TODO fix this for mixed orders
                UpdateReceiptLinesQtyToReceive_Zero(WarehouseReceiptHeader)
            else
                UpdateReceiptLinesQtyToReceive_Max(WarehouseReceiptHeader);

            AssignLicensePlateToWarehouseReceipt(TransferShipmentHeader."No.", WarehouseReceiptHeader);
            Commit();
            PostWarehouseRecipt(WarehouseReceiptHeader);
        end;
    end;


    #endregion


    #region Create Whse Receipt
    // -------------------------------------------------------------------------

    // Create Whse Receipt

    // -------------------------------------------------------------------------

    procedure CreateWarehouseReceipt(var TransferHeader: Record "Transfer Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; BinCode: Code[20])
    var
        Location: Record Location;
        TransferLine: Record "Transfer Line";
    begin
        Location.Get(TransferHeader."Transfer-to Code");


        //# try bin on transfer line
        if BinCode = '' then begin
            TransferLine.SetRange("Document No.", TransferHeader."No.");
            if TransferLine.FindFirst() then
                BinCode := TransferLine."Transfer-To Bin Code";
        end;

        //# override bin logic
        BinCode := GetDefaultBinCode(Location, BinCode);

        //# try trailer no (trailer always highest priority)
        // if TransferHeader."Trailer No." <> '' then
        //     BinCode := TransferHeader."Trailer No.";

        Clear(WarehouseReceiptHeader);
        WarehouseReceiptHeader.Init();
        WarehouseReceiptHeader.Insert(true);
        WarehouseReceiptHeader.Validate("Location Code", TransferHeader."Transfer-to Code");
        if BinCode <> '' then
            WarehouseReceiptHeader.Validate("Bin Code", BinCode);
        WarehouseReceiptHeader.Modify();

    end;

    procedure GetWarehouseReceiptSourceDocuments(TransferOrderNo: Code[20]; ShipmentNo: Code[20]; var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseRequest: Record "Warehouse Request";
        GetSourceDocuments: Report "Get Source Documents";
    begin

        // -- set warehouse rcpt filter
        WarehouseRequest.SetRange(Type, WarehouseRequest.Type::Inbound);
        WarehouseRequest.SetRange("Source Type", Database::"Transfer Line");
        WarehouseRequest.SetRange("Source Subtype", 1);
        WarehouseRequest.SetRange("Location Code", WarehouseReceiptHeader."Location Code");
        WarehouseRequest.SetRange("Document Status", WarehouseRequest."Document Status"::Released);
        WarehouseRequest.SetRange("Completely Handled", false);

        WarehouseRequest.SetRange("Source No.", TransferOrderNo);

        // -- get source documents
        GetSourceDocuments.SetOneCreatedReceiptHeader(WarehouseReceiptHeader);
        GetSourceDocuments.UseRequestPage(false);
        GetSourceDocuments.SetTableView(WarehouseRequest);
        GetSourceDocuments.RunModal();

    end;


    #endregion
    #region Update Receipt Lines
    // -------------------------------------------------------------------------

    // Update Receipt Lines

    // -------------------------------------------------------------------------
    procedure UpdateReceiptLinesQtyToReceive_Max(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    begin
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.FindSet(true) then
            repeat
                WarehouseReceiptLine.Validate("Qty. to Receive", WarehouseReceiptLine."Qty. Outstanding");
                WarehouseReceiptLine.Modify();
                RemoveItemTrackingLines_Max(WarehouseReceiptLine);
            until WarehouseReceiptLine.Next() = 0;
    end;

    procedure UpdateReceiptLinesQtyToReceive_Zero(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    begin
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.FindSet(true) then
            repeat
                if WarehouseReceiptLine."Qty. to Receive" > 0 then begin
                    WarehouseReceiptLine.Validate("Qty. to Receive", 0);
                    WarehouseReceiptLine.Modify();
                    RemoveItemTrackingLines_Zero(WarehouseReceiptLine);
                end;
            until WarehouseReceiptLine.Next() = 0;
    end;

    procedure UpdateReceiptLinesQtyToReceive_Zero_LP(WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var LPHeader: Record "IWX LP Header"; var AdjustedLineList: List of [Integer])
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        LPLine: Record "IWX LP Line";
    begin
        LPLine.SetRange("License Plate No.", LPHeader."No.");
        LPLine.SetRange(Type, LPLine.Type::Item);
        if LPLine.FindSet() then
            repeat
                WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
                WarehouseReceiptLine.SetRange("Item No.", LPLine."No.");
                WarehouseReceiptLine.SetFilter("Qty. to Receive", '>0');
                if WarehouseReceiptLine.FindSet() then
                    repeat
                        if not AdjustedLineList.Contains(WarehouseReceiptLine."Line No.") then begin
                            WarehouseReceiptLine.Validate("Qty. to Receive", 0);
                            WarehouseReceiptLine.Modify();
                            RemoveItemTrackingLines_Zero(WarehouseReceiptLine);
                            AdjustedLineList.Add(WarehouseReceiptLine."Line No.");
                        end;
                    until LPLine.Next() = 0;
            until LPLine.Next() = 0;
    end;

    #endregion



    #region License Plate Assignment
    // -------------------------------------------------------------------------

    // License Plate Assignment

    // -------------------------------------------------------------------------
    procedure MoveLicensPlatetoReceiptBin(LocationCode: code[20]; BinCode: code[20])
    var
        LicensePlate: codeunit "IWX License Plate Common";
        TransferHeader: Record "Transfer Header";
        QtyToShip: Decimal;
        LPHeader: Record "IWX LP Header";
        LPLine: Record "IWX LP Line";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        LineList: List of [Integer];
        LPHeaderList: list of [code[20]];
        SingleInstance: Codeunit "Single Instance";
        LpHeaderNo: code[20];
    begin
        LPHeaderList := SingleInstance.GetLicensePlateNos();
        foreach LpHeaderNo in LPHeaderList do begin
            LPHeader.get(LpHeaderNo);
            LPHeader.Validate("Location Code", LocationCode);
            LPHeader.Validate("Bin Code", BinCode);
            LpHeader.Modify();

        end;

    end;

    procedure AssignLicensePlateToWarehouseReceipt(ShipmentNo: Code[20]; var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        LicensePlate: codeunit "IWX License Plate Common";
        TransferHeader: Record "Transfer Header";
        QtyToShip: Decimal;
        LPHeader: Record "IWX LP Header";
        LPLine: Record "IWX LP Line";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        LineList: List of [Integer];
    begin
        LPHeader.SetRange("Shipped Source Document", LPHeader."Shipped Source Document"::"Outbound Transfer");
        LPHeader.SetRange("Shipment No.", ShipmentNo);
        LPHeader.SetRange("Source No.", '');
        if LPHeader.FindSet() then
            repeat
                if true then begin
                    UpdateReceiptLinesQtyToReceive_Zero_LP(WarehouseReceiptHeader, LPHeader, LineList);

                end;//# TODO fix this for mixed orders
                LicensePlate.assignLP(LPHeader."Source Document"::Receipt,
                                        WarehouseReceiptHeader."No.",
                                        WarehouseReceiptHeader."Location Code",
                                        WarehouseReceiptHeader."Bin Code",
                                        false,
                                        LPHeader."No."
                                    );
            until LPHeader.Next() = 0;
    end;



    procedure UpdateTransferOrderLinesQtyToReceive(var TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
        Puaway: page "Warehouse Put-away";
    begin

        TransferLine.SetRange("Document No.", TransferHeader."No.");
        TransferLine.SetRange("Derived From Line No.", 0);
        if TransferLine.FindSet(true) then
            repeat
                if not TransferLine.IsTemporary then begin

                    if TransferLine."Quantity Shipped" > 0 then begin
                        TransferLine.Validate("Qty. to Receive", TransferLine."Quantity Shipped" - TransferLine."Quantity Received");
                        TransferLine.Modify();
                    end;
                end;
            until TransferLine.Next() = 0;
    end;

    procedure UpdateTransferOrderLinesBinToReceive(var TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
        Location: Record Location;
    begin
        Location.Get(TransferHeader."Transfer-to Code");
        TransferLine.SetRange("Document No.", TransferHeader."No.");
        TransferLine.SetRange("Derived From Line No.", 0);
        if TransferLine.FindSet(true) then
            repeat
                if not TransferLine.IsTemporary then begin

                    TransferLine.Validate("Transfer-To Bin Code", GetDefaultBinCode(Location, TransferLine."Transfer-To Bin Code"));
                    TransferLine.Modify();
                end;
            until TransferLine.Next() = 0;
    end;


    #endregion



    #region Posting
    // -------------------------------------------------------------------------

    // Posting

    // -------------------------------------------------------------------------

    procedure PostWarehouseRecipt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptPost: Codeunit "Whse.-Post Receipt";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    begin
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.FindFirst() then
            WarehouseReceiptPost.Run(WarehouseReceiptLine);
    end;

    #endregion



    #region Item Tracking Lines
    // -------------------------------------------------------------------------

    // Item Tracking Lines

    // -------------------------------------------------------------------------

    local procedure RemoveItemTrackingLines_Zero(var WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        ItemTrackingLine: Record "Reservation Entry";
    begin
        ItemTrackingLine.SetRange("Reservation Status", ItemTrackingLine."Reservation Status"::Surplus);
        ItemTrackingLine.SetRange("Source Type", Database::"Transfer Line");
        ItemTrackingLine.SetRange("Source Subtype", 1);
        ItemTrackingLine.SetRange("Source ID", WarehouseReceiptLine."Source No.");
        ItemTrackingLine.SetRange("Source Prod. Order Line", WarehouseReceiptLine."Source Line No.");
        if ItemTrackingLine.FindSet() then
            repeat
                ItemTrackingLine.Validate("Qty. to Handle (Base)", 0);
                ItemTrackingLine.Modify();
            until ItemTrackingLine.Next() = 0;
    end;

    local procedure RemoveItemTrackingLines_Max(var WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        ItemTrackingLine: Record "Reservation Entry";
    begin
        ItemTrackingLine.SetRange("Reservation Status", ItemTrackingLine."Reservation Status"::Surplus);
        ItemTrackingLine.SetRange("Source Type", Database::"Transfer Line");
        ItemTrackingLine.SetRange("Source Subtype", 1);
        ItemTrackingLine.SetRange("Source ID", WarehouseReceiptLine."Source No.");
        ItemTrackingLine.SetRange("Source Prod. Order Line", WarehouseReceiptLine."Source Line No.");
        if ItemTrackingLine.FindSet() then
            repeat
                ItemTrackingLine.Validate("Qty. to Handle (Base)", ItemTrackingLine.Quantity);
                ItemTrackingLine.Modify();
            until ItemTrackingLine.Next() = 0;
    end;

    #endregion

    #region Bin Logic
    // -------------------------------------------------------------------------

    // Bin Logic

    // -------------------------------------------------------------------------

    local procedure GetDefaultBinCode(Location: Record Location; CurrentBinCode: Code[20]): Code[20]
    begin
        if AutoReceiveLocationSetup."Override Bin" <> '' then begin
            case AutoReceiveLocationSetup."Receipt Bin Policy" of
                AutoReceiveLocationSetup."Receipt Bin Policy"::"Always Override Bin":
                    CurrentBinCode := AutoReceiveLocationSetup."Override Bin";
                AutoReceiveLocationSetup."Receipt Bin Policy"::"Override Bin If Empty":
                    begin
                        if CurrentBinCode = '' then
                            CurrentBinCode := AutoReceiveLocationSetup."Override Bin";
                    end;
            end;
        end;

        exit(CurrentBinCode);
    end;

    #endregion

}

