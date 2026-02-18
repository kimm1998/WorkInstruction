codeunit 50530 "License Plate Mgmt"
{

    [EventSubscriber(ObjectType::Table, Database::"IWX LP Header", OnAfterModifyEvent, '', false, false)]
    local procedure OnAfterValidateSourceNo(var Rec: Record "IWX LP Header"; xRec: Record "IWX LP Header")
    begin
        SetPickToProductionOrderNo(Rec);
    end;

    procedure SetPickToProductionOrderNo(var LPHeader: Record "IWX LP Header")
    var
        TransferHeader: Record "Transfer Header";
        WarehouseShipment: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WarehouseActLine: Record "Warehouse Activity Line";
    begin
        if (LPHeader."Source Document" = LPHeader."Source Document"::" ") or (LPHeader."Source No." = '') then
            exit;
        if not (LPHeader."Source Document" in [LPHeader."Source Document"::"Outbound Transfer", LPHeader."Source Document"::Shipment, LPHeader."Source Document"::"Invt. Pick"]) then
            exit;

        // get transfer header if LP is linked to Transfer
        if LPHeader."Source Document" = LPHeader."Source Document"::"Outbound Transfer" then begin
            TransferHeader.Get(LPHeader."Source No.");
        end;

        // get transfer header if LP is linked to Shipment - from shipment lines
        if LPHeader."Source Document" = LPHeader."Source Document"::Shipment then begin
            WarehouseShipment.Get(LPHeader."Source No.");
            WarehouseShipmentLine.SetRange("No.", WarehouseShipment."No.");
            if WarehouseShipmentLine.FindFirst() then begin
                if TransferHeader.Get(WarehouseShipmentLine."Source No.") then;
            end;
        end;

        // get transfer header if LP is linked to Invt. Pick - from activity lines
        if LPHeader."Source Document" = LPHeader."Source Document"::"Invt. Pick" then begin
            WarehouseActLine.SetRange("Activity Type", WarehouseActLine."Activity Type"::"Invt. Pick");
            WarehouseActLine.SetRange("No.", LPHeader."Source No.");
            if WarehouseActLine.FindFirst() then
                if TransferHeader.Get(WarehouseActLine."Source No.") then;
        end;

        // if we were able to get the transfer header, checking in case shipment or pick were not linked to transfer
        if TransferHeader."No." = '' then
            exit;

        LPHeader."Pick to Prod. Order No." := TransferHeader."External Document No.";


    end;
}