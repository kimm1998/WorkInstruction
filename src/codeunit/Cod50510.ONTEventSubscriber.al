codeunit 50510 "ONT Event Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnInsertProdOrderWithReqLine', '', false, false)]
    local procedure OnInsertProdOrderWithReqLine(var ProductionOrder: Record "Production Order"; var RequisitionLine: Record "Requisition Line");
    begin
        ProductionOrder."ONT Demand Forecast" := RequisitionLine."ONT Demand Forecast";
        if (ProductionOrder."ONT Original Due Date" = 0D) or (ProductionOrder."ONT Original Due Date" = WorkDate()) then
            ProductionOrder.Validate("ONT Original Due Date", ProductionOrder."Due Date");
    end;

    [EventSubscriber(ObjectType::Report, Report::"Carry Out Action Msg. - Plan.", OnBeforeCheckLine, '', false, false)]
    local procedure OnBeforeCarryOutActionMsg(RequisitionLine: Record "Requisition Line")
    var
        carryOutByFamily: Codeunit "ONT Carry Out By Family";
        SingleInstance: Codeunit "Single Instance";
        targetStatus: Enum "Production Order Status";
    begin
        if not SingleInstance.GetByFamily() then
            exit;
        RequisitionLine.TestField("Worksheet Template Name");
        RequisitionLine.TestField("Journal Batch Name");


        // targetStatus := targetStatus::"Firm Planned"; // change to Planned/Released if desired
        targetStatus := SingleInstance.GetTargetStatus();

        carryOutByFamily.RunForBatch(
            RequisitionLine."Worksheet Template Name",
            RequisitionLine."Journal Batch Name",
            targetStatus);
        Commit();
    end;


    [EventSubscriber(ObjectType::Table, database::"Production Order", 'OnAfterValidateEvent', "Due Date", false, false)]
    local procedure OnAfterValidateEventProductionOrderDueDate(var Rec: Record "Production Order");
    begin
        if (Rec."ONT Original Due Date" = 0D) or (Rec."ONT Original Due Date" = WorkDate()) then
            rec.Validate("ONT Original Due Date", rec."Due Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnBeforeBinContentInsert', '', false, false)]
    local procedure OnBeforeBinContentInsert(var BinContent: Record "Bin Content");
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        WarehouseSetup.get;
        if WarehouseSetup."Enable Default on Bin Creation" then
            exit
        else begin
            BinContent.Default := false;
            BinContent.Fixed := BinContent.Default;
        end;

    end;


    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnBeforeValidateEvent', "Planned Receipt Date", false, false)]
    local procedure OnBeforeValidateEventPlannedReceiptDate(var Rec: Record "Purchase Line");
    begin
        if rec."Planned Ship Date" = 0D then begin
            if rec."Planned Receipt Date" <> 0D then begin
                if Format(rec."Transit Lead Time") <> '' then
                    Rec.Validate("Requested Ship Date", CalcDate(rec."Transit Lead Time", rec."Planned Receipt Date"))
                else
                    Rec.Validate("Requested Ship Date", rec."Planned Receipt Date");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnBeforeValidateEvent', "Transit Lead Time", false, false)]
    local procedure OnBeforeValidateEventTransitLeadTime(var Rec: Record "Purchase Line");
    begin
        if rec."Planned Ship Date" = 0D then begin
            if rec."Planned Receipt Date" <> 0D then begin
                if Format(rec."Transit Lead Time") <> '' then
                    Rec.Validate("Requested Ship Date", CalcDate(rec."Transit Lead Time", rec."Planned Receipt Date"))
                else
                    Rec.Validate("Requested Ship Date", rec."Planned Receipt Date");
            end;

        end;
    end;

    // [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnAfterValidateEvent', "No.", false, false)]
    // local procedure OnAfterValidateEventNo(var Rec: Record "Purchase Line");
    // var
    // begin



    // end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertPurchLineEvent(var Rec: Record "Purchase Line");
    var
        ItemVendor: Record "Item Vendor";
        Item: Record item;

    begin
        ItemVendor.Reset();
        ItemVendor.SetRange("Item No.", rec."No.");
        ItemVendor.SetRange("Vendor No.", Rec."Pay-to Vendor No.");
        if ItemVendor.FindFirst() then begin
            rec.Validate("Manufacturing Lead Time", ItemVendor."Manufacturing Lead Time");
            rec.Validate("Transit Lead Time", ItemVendor."Transit Lead Time");
        end;
        if item.get(rec."No.") then begin
            rec.Validate("Revision No.", item."Revision No.");
        end;
    end;

    //////
    /// 
    /// 
    /// 
    /// 
    /// 
    /// 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnAfterTransferBOMComponent', '', false, false)]

    local procedure OnAfterTransferBOMComponent(var ProdOrderLine: Record "Prod. Order Line";

     var ProductionBOMLine: Record "Production BOM Line";

     var ProdOrderComponent: Record "Prod. Order Component";

     LineQtyPerUOM: Decimal;

     ItemQtyPerUOM: Decimal);

    var

        WorkCenter: Code[20];

        LocationCode: Code[20];

        BinCode: Code[20];

    begin

        WorkCenter := GetSubcontractorWorkCenterNo(ProdOrderComponent."Prod. Order No.", ProdOrderComponent.Status, ProdOrderComponent."Prod. Order Line No.", ProdOrderComponent."Routing Link Code");

        If WorkCenter <> '' then begin

            SetSubcontractWorkCenterLocation(WorkCenter, LocationCode, BinCode);

            if LocationCode <> '' then
                ProdOrderComponent.Validate("Location Code", LocationCode);

            if BinCode <> '' then
                ProdOrderComponent.Validate("Bin Code", BinCode);

        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Planning Line Management", 'OnBeforeInsertPlanningComponent', '', false, false)]

    local procedure OnBeforeInsertPlanningComponent(var ReqLine: Record "Requisition Line";

    var ProductionBOMLine: Record "Production BOM Line";

    var PlanningComponent: Record "Planning Component";

    LineQtyPerUOM: Decimal;

    ItemQtyPerUOM: Decimal);

    var

        WorkCenter: Code[20];

        LocationCode: Code[20];

        BinCode: Code[20];

    begin

        // WorkCenter := GetCustomerWorkCenterNoRequisition(PlanningComponent."Worksheet Template Name", PlanningComponent."Worksheet Batch Name", PlanningComponent."Worksheet Line No.", PlanningComponent."Routing Link Code");

        // If WorkCenter <> '' then begin

        //     SetSubcontractWorkCenterLocation(WorkCenter, LocationCode, BinCode);

        //     if LocationCode <> '' then
        //         PlanningComponent.Validate("Location Code", LocationCode);

        //     if BinCode <> '' then
        //         PlanningComponent.Validate("Bin Code", BinCode);

        // end;

        WorkCenter := GetSubcontractWorkCenterNoRequisition(PlanningComponent."Worksheet Template Name", PlanningComponent."Worksheet Batch Name", PlanningComponent."Worksheet Line No.", PlanningComponent."Routing Link Code");

        If WorkCenter <> '' then begin

            SetSubcontractWorkCenterLocation(WorkCenter, LocationCode, BinCode);

            if LocationCode <> '' then
                PlanningComponent.Validate("Location Code", LocationCode);

            if BinCode <> '' then
                PlanningComponent.Validate("Bin Code", BinCode);

        end;

    end;

    local procedure SetSubcontractWorkCenterLocation(WorkCenterNo: Code[20];

        var LocationCode: Code[20];

        var BinCode: Code[20])

    var

        WorkCenter: Record "Work Center";

    begin

        if WorkCenter.get(WorkCenterNo) then begin

            LocationCode := WorkCenter."Location Code";

            BinCode := WorkCenter."To-Production Bin Code";

        end;

    end;

    procedure UpdateComponentSubcontractDefaultLocation()

    var

        WorkCenter: Code[20];

        LocationCode: Code[20];

        BinCode: Code[20];

        ProdOrderComponent: Record "Prod. Order Component";

    begin

        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::"Firm Planned");

        ProdOrderComponent.SetFilter("Remaining Quantity", '>%1', 0);

        if ProdOrderComponent.FindFirst() then
            repeat

                // WorkCenter := GetCustomerWorkCenterNo(ProdOrderComponent."Prod. Order No.", ProdOrderComponent.Status, ProdOrderComponent."Prod. Order Line No.", ProdOrderComponent."Routing Link Code");

                // If WorkCenter <> '' then begin

                //     SetSubcontractWorkCenterLocation(WorkCenter, LocationCode, BinCode);

                //     if LocationCode <> '' then
                //         ProdOrderComponent."Location Code" := LocationCode;

                //     if LocationBinMandatory(ProdOrderComponent."Location Code") and (BinCode <> '') then
                //         ProdOrderComponent."Bin Code" := BinCode;

                // end;

                WorkCenter := GetSubcontractorWorkCenterNo(ProdOrderComponent."Prod. Order No.", ProdOrderComponent.Status, ProdOrderComponent."Prod. Order Line No.", ProdOrderComponent."Routing Link Code");

                If WorkCenter <> '' then begin

                    SetSubcontractWorkCenterLocation(WorkCenter, LocationCode, BinCode);

                    if LocationCode <> '' then
                        ProdOrderComponent."Location Code" := LocationCode;

                    if LocationBinMandatory(ProdOrderComponent."Location Code") and (BinCode <> '') then
                        ProdOrderComponent."Bin Code" := BinCode;

                end;

            until ProdOrderComponent.Next() = 0;

    end;

    // local procedure GetCustomerWorkCenterNo(ProductionOrderNo: Code[20];

    //     Status: Enum "Production Order Status";

    //                 ProductionOrderLineNo: Integer;

    //                 RoutingLinkCode: Code[10]): Code[20]

    // var

    //     ProdOrderRoutingLine: Record "Prod. Order Routing Line";

    // begin

    //     ProdOrderRoutingLine.SetRange(Status, Status);

    //     ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrderNo);

    //     ProdOrderRoutingLine.SetRange("Routing Reference No.", ProductionOrderLineNo);

    //     ProdOrderRoutingLine.SetRange("Routing Link Code", RoutingLinkCode);

    //     ProdOrderRoutingLine.SetFilter("OTG.Customer No.", '<>%1', '');

    //     if ProdOrderRoutingLine.FindFirst() then
    //         Exit(ProdOrderRoutingLine."Work Center No.")

    // end;

    local procedure GetSubcontractorWorkCenterNo(ProductionOrderNo: Code[20]; Status: Enum "Production Order Status"; ProductionOrderLineNo: Integer; RoutingLinkCode: Code[10]): Code[20]
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRoutingLine.SetRange(Status, Status);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrderNo);
        ProdOrderRoutingLine.SetRange("Routing Reference No.", ProductionOrderLineNo);
        ProdOrderRoutingLine.SetRange("Routing Link Code", RoutingLinkCode);
        ProdOrderRoutingLine.SetFilter("ONT Subcontractor No.", '<>%1', '');
        if ProdOrderRoutingLine.FindFirst() then
            Exit(ProdOrderRoutingLine."Work Center No.")

    end;

    local procedure LocationBinMandatory(Code: Code[20]): Boolean

    var

        Location: Record Location;

    begin

        if Location.get(Code) then
            exit(Location."Bin Mandatory");

    end;

    // local procedure GetCustomerWorkCenterNoRequisition(WorksheetTemplateName: Code[10];

    // WorksheetBatchName: Code[10];

    // RequisitionLineNo: Integer;

    // RoutingLinkCode: Code[10]): Code[20]

    // var

    //     PlanningRoutingLine: Record "Planning Routing Line";

    // begin

    //     PlanningRoutingLine.SetRange("Worksheet Template Name", WorksheetTemplateName);

    //     PlanningRoutingLine.SetRange("Worksheet Batch Name", WorksheetBatchName);

    //     PlanningRoutingLine.SetRange("Worksheet Line No.", RequisitionLineNo);

    //     PlanningRoutingLine.SetRange("Routing Link Code", RoutingLinkCode);

    //     PlanningRoutingLine.SetFilter("Customer No.", '<>%1', '');

    //     if PlanningRoutingLine.FindFirst() then exit(PlanningRoutingLine."Work Center No.");

    // end;

    local procedure GetSubcontractWorkCenterNoRequisition(WorksheetTemplateName: Code[10];

                                                            WorksheetBatchName: Code[10];

                                                            RequisitionLineNo: Integer;

                                                            RoutingLinkCode: Code[10]): Code[20]

    var

        PlanningRoutingLine: Record "Planning Routing Line";

    begin

        PlanningRoutingLine.SetRange("Worksheet Template Name", WorksheetTemplateName);

        PlanningRoutingLine.SetRange("Worksheet Batch Name", WorksheetBatchName);

        PlanningRoutingLine.SetRange("Worksheet Line No.", RequisitionLineNo);

        PlanningRoutingLine.SetRange("Routing Link Code", RoutingLinkCode);

        PlanningRoutingLine.SetFilter("ONT Subcontractor No.", '<>%1', '');

        if PlanningRoutingLine.FindFirst() then exit(PlanningRoutingLine."Work Center No.");

    end;

    // [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterInsertEvent', '', false, false)]
    // local procedure OnAfterInsertEventtrline();
    // begin
    //     Message('1');
    // end;


}
