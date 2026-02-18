Codeunit 50526 "OTG.OnHold Mgt"
{
    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnSalesLineOnAfterGetRecordOnBeforeCreateShptHeader', '', False, False)]
    local procedure CheckSalesOrderOnHold(SalesLine: Record "Sales Line"; var WarehouseRequest: Record "Warehouse Request"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WhseHeaderCreated: Boolean; var OneHeaderCreated: Boolean; var IsHandled: Boolean; var ErrorOccured: Boolean; var LinesCreated: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.get(SalesHeader."Document Type"::Order, SalesLine."Document No.") then
            if SalesHeader."Sales Order Blocked" then
                Error('The Sales Order %1 is on Hold.', WarehouseRequest."Source No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', False, False)]
    local procedure CheckMandatoryInfoBeforeRelease(var SalesHeader: Record "Sales Header")
    var
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
            ReleaseSalesOrderFromHold(SalesHeader);

        end;
    end;

    procedure ReleaseSalesOrderFromHold(var SalesHeader: Record "Sales Header")
    var
        SalesLines: Record "Sales Line";
    begin
        SalesHeader."Sales Order Blocked" := false;
        SalesHeader.Modify(false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnSalesPostOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
    begin
        if SalesHeader.Ship then begin
            if SalesHeader."Sales Order Blocked" then Error('Sales docuemnt can not be posted because it is on hold.');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeUpdateSalesLineBeforePost', '', false, false)]
    local procedure OnPostSalesLineOnBeforeUpdateSalesLineBeforePost(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
    begin
        if SalesHeader.Ship then begin
            if SalesLine."Qty. to Ship" > 0 then
                if SalesLine."OTG Sales Line On Hold" then Error('Sales docuemnt can not be posted because line %1 it on hold.', SalesLine."Line No.");
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", 'OnBeforeCreateFromSalesOrder', '', False, False)]
    local procedure CheckOnHoldSalesOrder(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Sales Order Blocked" then Error('Sales docuemnt can not be Processed because it is on hold.');
    end;

    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Blocked', false, false)]
    // local procedure OnAfterValidateEventBlocked(var Rec: Record Customer;
    // var xRec: Record Customer;
    // CurrFieldNo: Integer)
    // var
    //     SalesHeader: Record "Sales Header";
    //     SalesSetup: Record "Sales & Receivables Setup";
    // begin
    //     SalesSetup.Get();
    //     if (Rec.Blocked = Rec.Blocked::Ship) or (Rec.Blocked = Rec.Blocked::All) then begin
    //         SalesHeader.SetRange("Sell-to Customer No.", rec."No.");
    //         if GuiAllowed and SalesHeader.FindFirst() then
    //             if Confirm('Do you want to set all current sales docuemnts to On Hold?') then begin
    //                 SalesHeader.ModifyAll("Sales Order Blocked", true);
    //             end;

    //     end;
    // end;

}