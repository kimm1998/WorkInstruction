codeunit 50502 "ONT Update Prod Order Availab."
{
    SingleInstance = true;
    Permissions = tabledata "Production Order" = RMID, tabledata "Prod. Order Line" = RMID, tabledata "Prod. Order Comment Line" = RMID, tabledata "Prod. Order Routing Line" = RMID;

    Procedure UpdateProductionOrderAvailability(SalesOrderNo: Code[20]; ProductionOrderNo: Code[20])
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProductionOrder: Record "Production Order";
        UpdateProdOrderAvail: Codeunit "ONT Update Prod Order Availab.";
        SalesOrderFunctions: Codeunit "ONT Sales Order Status Functs.";
    begin
        if SalesOrderNo <> '' then
            ProductionOrder.SetRange("ONT Sales Order No.", SalesOrderNo);
        If ProductionOrderNo <> '' then
            ProductionOrder.SetRange("No.", ProductionOrderNo);
        if (SalesOrderNo = '') and (ProductionOrderNo = '') then
            ProductionOrder.SetRange("ONT Sales Order No.", '');
        ProductionOrder.SetFilter(Status, '<>%1', ProductionOrder.Status::Finished);
        IF ProductionOrder.FindSet() then
            repeat
                ProdOrderLine.Reset();
                ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                ProdOrderLine.SetRange(Status, ProductionOrder.Status);
                if ProdOrderLine.FindSet() then
                    repeat
                        if ProductionOrderNo <> '' then
                            UpdateProdOrderAvail.UpdateProductionComponentShortages(ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.", '');
                        UpdateProdOrderLineAvailabilityStatus(ProdOrderLine);
                        commit;
                    until ProdOrderLine.Next() = 0;
                UpdateProductionOrderNextOperation(ProductionOrder);
                SalesOrderFunctions.UpdateProdOrderAvailabilityStatus(ProductionOrder);
            until ProductionOrder.Next() = 0
        else begin
            ProductionOrder.SetRange("ONT Remaining Qty. Exist");
            IF ProductionOrder.FindFirst() and (ProductionOrderNo <> '') then
                ProdOrderLine.Reset();
            ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
            ProdOrderLine.SetRange(Status, ProductionOrder.Status);
            if ProdOrderLine.FindSet() then
                repeat
                    UpdateProdOrderAvail.UpdateProductionComponentShortages(ProdOrderLine."Prod. Order No.", ProdOrderLine."Line No.", '');
                until ProdOrderLine.Next() = 0;
        end;
    End;

    procedure UpdateProductionComponentShortages(ProductionOrderNo: Code[20]; ProductionOrderLineNo: Integer; SalesOrderNo: code[20])
    var
        ProdOrderComponent: record "Prod. Order Component";
    begin
        OnBeforeUpdateProductionComponentShortages();

        if ProductionOrderNo <> '' then begin
            ProdOrderComponent.SetRange("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponent.SetRange("Prod. Order Line No.", ProductionOrderLineNo)
        end;
        if SalesOrderNo <> '' then
            ProdOrderComponent.SetRange("ONT Sales Order No.", SalesOrderNo);
        ProdOrderComponent.SetFilter(Status, '<>%1', ProdOrderComponent.Status::Finished);
        ProdOrderComponent.SetFilter("Remaining Quantity", '<>0');
        ProdOrderComponent.CalcFields("ONT Inventory");
        if ProdOrderComponent.FindSet() then
            repeat
                if ProdOrderComponent."Remaining Quantity" > ProdOrderComponent."ONT Inventory" then
                    ProdOrderComponent."ONT Shortage" := true
                else
                    ProdOrderComponent."ONT Shortage" := false;

                ProdOrderComponent.Modify();
            until ProdOrderComponent.Next() = 0;
        Commit();
    end;

    procedure UpdateProductionComponentShortagesx(ProductionOrderNo: Code[20]; ProductionOrderLineNo: Integer; SalesOrderNo: code[20])//recheck
    var
        ReservationEntry: record "Reservation Entry";
        ProdOrderComponent: record "Prod. Order Component";
    begin
        OnBeforeUpdateProductionComponentShortages();

        if ProductionOrderNo <> '' then begin
            ProdOrderComponent.SetRange("Prod. Order No.", ProductionOrderNo);
            ProdOrderComponent.SetRange("Prod. Order Line No.", ProductionOrderLineNo)
        end;
        if SalesOrderNo <> '' then
            ProdOrderComponent.SetRange("ONT Sales Order No.", SalesOrderNo);
        ProdOrderComponent.SetFilter(Status, '<>%1', ProdOrderComponent.Status::Finished);
        ProdOrderComponent.SetFilter("Remaining Quantity", '<>0');
        if ProdOrderComponent.FindSet() then
            repeat
                ReservationEntry.reset;
                ReservationEntry.SetRange(Positive, true);
                ReservationEntry.SetRange("Source Type", 32);
                ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
                ReservationEntry.SetRange("Item No.", ProdOrderComponent."Item No.");
                ReservationEntry.SetRange("Location Code", ProdOrderComponent."Location Code");
                ReservationEntry.SetRange("ONT Related Source ID", ProdOrderComponent."Prod. Order No.");
                ReservationEntry.SetRange("ONT Related Source Ref. No.", ProdOrderComponent."Line No.");
                ReservationEntry.SetRange("ONT Related Src Prod Ord. Line", ProdOrderComponent."Prod. Order Line No.");
                ReservationEntry.CalcSums("Quantity (Base)");
                if ProdOrderComponent."Remaining Quantity" > ReservationEntry."Quantity (Base)" then
                    ProdOrderComponent."ONT Shortage" := true
                else
                    ProdOrderComponent."ONT Shortage" := false;

                ProdOrderComponent.Modify();
            until ProdOrderComponent.Next() = 0;
        Commit();
    end;

    procedure UpdateProductionOrderNextOperation(var ProductionOrder: Record "Production Order")
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetFilter("Remaining Quantity", '>%1', 0);
        if ProdOrderLine.FindLast() then begin
            ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
            ProdOrderRoutingLine.SetRange(Status, ProdOrderLine.Status);
            ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Line No.");
            ProdOrderRoutingLine.Setfilter("Routing Status", '%1|%2', ProdOrderRoutingLine."Routing Status"::" ", ProdOrderRoutingLine."Routing Status"::Planned);
            if ProdOrderRoutingLine.FindFirst() then begin
                ProductionOrder."ONT Next Operation No." := ProdOrderRoutingLine."Operation No.";
                ProductionOrder."ONT Next Operation Name" := ProdOrderRoutingLine.Description;
                ProductionOrder."ONT Next Work Center No." := ProdOrderRoutingLine."Work Center No.";
                ProductionOrder."ONT Next Work Center Grp Code" := ProdOrderRoutingLine."Work Center Group Code";
            end
            else begin
                ProductionOrder."ONT Next Operation No." := '';
                ProductionOrder."ONT Next Operation Name" := '';
            end;
            ProductionOrder.Modify();
            Commit();
        end;
    end;

    local procedure FirstOperationRoutingLink(ProdOrderLine: Record "Prod. Order Line"): Code[20]
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Line No.");
        ProdOrderRoutingLine.SetRange(Status, ProdOrderLine.Status);
        if ProdOrderRoutingLine.FindFirst() then
            Exit(ProdOrderRoutingLine."Routing Link Code");
    end;

    procedure UpdateProdOrderLineAvailabilityStatus(var ProdOrderLine: Record "Prod. Order Line")
    var
        FirstOperationRoutingLinkCode: Code[20];
        ShortageExists: Boolean;
        ShortageFirstOperationExists: Boolean;
    begin
        FirstOperationRoutingLinkCode := FirstOperationRoutingLink(ProdOrderLine);
        ShortageFirstOperationExists := ComponentShortageExists(ProdOrderLine, FirstOperationRoutingLinkCode);
        ShortageExists := ComponentShortageExists(ProdOrderLine, '');
        if not ShortageExists then
            ProdOrderLine."ONT Availability Status" := ProdOrderLine."ONT Availability Status"::"Fully Available"
        else
            if not ShortageFirstOperationExists then
                ProdOrderLine."ONT Availability Status" := ProdOrderLine."ONT Availability Status"::"Partially Available"
            else
                ProdOrderLine."ONT Availability Status" := ProdOrderLine."ONT Availability Status"::Unavailable;
        ProdOrderLine.Modify(false);
        commit;
    end;

    // local procedure ComponentShortagebyProdOrderRouting(ProductionOrderLine: Record "Prod. Order Line";
    // RoutingLinkCode: Code[20]): Enum "ONT Availability Status"
    // var
    //     ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    //     ProdOrderComponents: record "Prod. Order Component";
    //     ItemLedgerEntry: Record "Item Ledger Entry";
    //     AvailabilityStatus : Enum "ONT Availability Status";
    // begin
    //     ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrderLine."Prod. Order No.");
    //     ProdOrderRoutingLine.SetRange(Status, ProductionOrderLine.Status);
    //     ProdOrderRoutingLine.SetRange("Routing Reference No.", ProductionOrderLine."Line No.");
    //     ProdOrderRoutingLine.Setfilter("Routing Status", '%1|%2', ProdOrderRoutingLine."Routing Status"::" ", ProdOrderRoutingLine."Routing Status"::Planned);
    //     if ProdOrderRoutingLine.FindFirst() then begin
    //         ProdOrderComponents.SetRange("Prod. Order No.", ProductionOrderLine."Prod. Order No.");
    //         ProdOrderComponents.SetRange(Status, ProductionOrderLine.Status);
    //         ProdOrderComponents.SetRange("Prod. Order Line No.", ProductionOrderLine."Line No.");
    //         IF RoutingLinkCode <> '' then
    //             ProdOrderComponents.SetRange("Routing Link Code", RoutingLinkCode);
    //         IF ProdOrderComponents.FindSet() then
    //             repeat
    //                 ItemLedgerEntry.SetRange("Item No.", ProdOrderComponents."Item No.");
    //                 ItemLedgerEntry.SetRange("Location Code", ProdOrderComponents."Location Code");
    //                 ItemLedgerEntry.SetRange("Variant Code", ProdOrderComponents."Variant Code");
    //                 IF ItemLedgerEntry.FindSet() then
    //                     ReservationEntry.CalcSums("Quantity (Base)");
    //                 IF 
    //             until ProdOrderComponents.Next() = 0;
    //     end;
    // end;
    procedure ComponentShortageExists(ProdOrderLine: Record "Prod. Order Line";
    RoutingLinkCode: Code[20]): Boolean
    var
        ProdOrderComponents: record "Prod. Order Component";
    begin
        ProdOrderComponents.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        ProdOrderComponents.SetRange(Status, ProdOrderLine.Status);
        ProdOrderComponents.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");
        IF RoutingLinkCode <> '' then
            ProdOrderComponents.SetRange("Routing Link Code", RoutingLinkCode);
        ProdOrderComponents.SetRange("ONT Shortage", true);
        exit(ProdOrderComponents.FindFirst())
    end;

    procedure UpdateProdOrderLineAvailabilityStatusforAllProductionOrders(ProductionOrderNo: Code[20])
    var
        RecProdOrderLine: Record "Prod. Order Line";
        CUSalesOrderStatusFunctions: Codeunit "ONT Update Prod Order Availab.";
    begin
        OnBeforeUpdateProdOrderLineAvailabilityStatusforAllProductionOrders();

        RecProdOrderLine.Reset();
        RecProdOrderLine.SetFilter(Status, '<>%1', RecProdOrderLine.Status::Finished);
        IF ProductionOrderNo <> '' THEN
            RecProdOrderLine.SetRange("Prod. Order No.", ProductionOrderNo);
        if RecProdOrderLine.FindSet() then
            repeat
                CUSalesOrderStatusFunctions.UpdateProdOrderLineAvailabilityStatus(RecProdOrderLine);
            until RecProdOrderLine.Next() = 0;
    end;

    local procedure UpdateProductionOrderAvailabilityStatusIcon(ProdOrder: Record "Production Order")//ONT.YAHYA+-
    var
        IconsManagement: Record "ONT Icons Management";
        inStreamImage: InStream;
        OutStreamImage: OutStream;
    begin
        IconsManagement.SetRange(Name, ProdOrder."ONT Availability Status");
        If IconsManagement.FindFirst() then begin
            IconsManagement.Icon.CreateInStream(inStreamImage);
            ProdOrder."ONT Icon".CreateOutStream(OutStreamImage);
            CopyStream(OutStreamImage, inStreamImage);
            ProdOrder.Modify();
        end;
    end;

    procedure UpdateOperationNoforAllProductionOrders()
    var
        ProdOrder: Record "Production Order";
    begin
        ProdOrder.reset;
        ProdOrder.SetFilter(Status, '<>%1', ProdOrder.Status::Finished);
        if ProdOrder.FindSet() then
            repeat
                UpdateOperationNo(ProdOrder);
            until ProdOrder.next = 0;
    end;

    local procedure UpdateOperationNo(Var ProductionOrder: record "Production Order")
    var
        ProductionLine: Record "Prod. Order Line";
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        LastOperation := false;
        EmptyProductionOrderOperationFields(ProductionOrder);
        CapacityLedgerEntry := UpdateLastOperationNoAndName(ProductionOrder);
        ProdOrderRoutingLine := UpdateFirstNextOperationNoAndName(CapacityLedgerEntry, ProductionOrder);
        UpdateNextOperationNoAndNameofNextRoutingReferenceNo(ProdOrderRoutingLine, ProductionOrder, LastProductionOrderLineNo);
        ProductionLine := UpdateNewProductionOrderOperationNoAndName(ProductionOrder);
        UpdateNextOperationNoAndName(ProductionOrder, ProductionLine, CapacityLedgerEntry);
        CheckMissingComponentOnReleasedProductionOrders(ProductionOrder);
        UpdateVariantCodeLines(ProductionOrder);
    end;


    local procedure EmptyProductionOrderOperationFields(Var ProductionOrder: Record "Production Order")
    begin
        ProductionOrder."ONT Current Item" := '';
        ProductionOrder."ONT Previous Operation No." := '';
        ProductionOrder."ONT Previous Operation Name" := '';
        ProductionOrder."ONT Next Operation No." := '';
        ProductionOrder."ONT Next Operation Name" := '';
    end;

    local procedure UpdateLastOperationNoAndName(var ProductionOrder: Record "Production Order"): Record "Capacity Ledger Entry";
    var
        CapacityLedgerEntry1: Record "Capacity Ledger Entry";
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
        MachineCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
    begin
        CapacityLedgerEntry1.Reset();
        CapacityLedgerEntry1.setcurrentkey("Order Type", "Order No.", "Order Line No.");
        CapacityLedgerEntry1.SetRange("Order Type", CapacityLedgerEntry1."Order Type"::Production);
        CapacityLedgerEntry1.SetRange("Order No.", ProductionOrder."No.");
        if CapacityLedgerEntry1.findfirst() then begin
            CapacityLedgerEntry.reset;
            CapacityLedgerEntry.setcurrentkey("Order Type", "Order No.", "Order Line No.");
            CapacityLedgerEntry.SetRange("Order Type", CapacityLedgerEntry1."Order Type"::Production);
            CapacityLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
            CapacityLedgerEntry.SetRange("Order Line No.", CapacityLedgerEntry1."Order Line No.");
            if CapacityLedgerEntry.FindLast() then begin

                ProductionOrder."ONT Previous Operation No." := CapacityLedgerEntry."Operation No.";
                LastProductionOrderLineNo := CapacityLedgerEntry."Order Line No.";

                case CapacityLedgerEntry.Type of
                    CapacityLedgerEntry.Type::"Machine Center":
                        begin
                            MachineCenter.Reset();
                            MachineCenter.SetRange("No.", CapacityLedgerEntry."No.");
                            if MachineCenter.FindFirst() then
                                ProductionOrder."ONT Previous Operation Name" := MachineCenter.Name;
                        end;
                    CapacityLedgerEntry.Type::"Work Center":
                        begin
                            WorkCenter.Reset();
                            WorkCenter.SetRange("No.", CapacityLedgerEntry."No.");
                            if WorkCenter.FindFirst() then
                                ProductionOrder."ONT Previous Operation Name" := WorkCenter.Name;
                        end;
                end;
            end;
        END;

        Exit(CapacityLedgerEntry);
    end;

    local procedure UpdateFirstNextOperationNoAndName(CapacityLedgerEntry: Record "Capacity Ledger Entry";
    var ProductionOrder: Record "Production Order"): Record "Prod. Order Routing Line"
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        MachineCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
    begin
        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.SetRange("Routing No.", CapacityLedgerEntry."Routing No.");
        ProdOrderRoutingLine.SetRange("Prod. Order No.", CapacityLedgerEntry."Order No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", CapacityLedgerEntry."Order Line No.");
        ProdOrderRoutingLine.SetRange("Operation No.", ProductionOrder."ONT Previous Operation No.");
        ProdOrderRoutingLine.SetRange(Status, ProductionOrder.Status);
        if ProdOrderRoutingLine.FindLast() then begin
            ProductionOrder."ONT Next Operation No." := ProdOrderRoutingLine."Next Operation No.";

            case ProdOrderRoutingLine.Type of
                ProdOrderRoutingLine.Type::"Machine Center":
                    begin
                        MachineCenter.Reset();
                        MachineCenter.SetRange("No.", ProdOrderRoutingLine."No.");
                        if MachineCenter.FindFirst() then begin
                            ProductionOrder."ONT Next Work Center No." := MachineCenter."No.";
                        end
                    end;
                ProdOrderRoutingLine.Type::"Work Center":
                    begin
                        WorkCenter.Reset();
                        WorkCenter.SetRange("No.", ProdOrderRoutingLine."No.");
                        if WorkCenter.FindFirst() then begin
                            ProductionOrder."ONT Next Work Center No." := WorkCenter."No.";
                        end
                    end;
            end;
            Exit(ProdOrderRoutingLine);
        end;
    end;

    local procedure UpdateNextOperationNoAndNameofNextRoutingReferenceNo(ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                                                                        var ProductionOrder: Record "Production Order";
                                                                        LastProductionOrderLineNo: Integer)
    var
        ProdOrderRoutingLine2: Record "Prod. Order Routing Line";
    begin
        if ProdOrderRoutingLine."Next Operation No." = '' then begin
            if ProdOrderRoutingLine."Routing Reference No." > 10000 then begin
                LastProductionOrderLineNo := ProdOrderRoutingLine."Routing Reference No." - 10000;
                ProdOrderRoutingLine2.Reset();
                ProdOrderRoutingLine2.SetRange("Prod. Order No.", ProductionOrder."No.");
                ProdOrderRoutingLine2.SetRange("Routing Reference No.", LastProductionOrderLineNo);
                ProdOrderRoutingLine2.SetRange(Status, ProductionOrder.Status);
                if ProdOrderRoutingLine2.FindFirst() then begin
                    ProductionOrder."ONT Next Operation No." := ProdOrderRoutingLine2."Operation No.";
                    ProductionOrder."ONT Next Work Center No." := ProdOrderRoutingLine2."Work Center No.";
                    ProductionOrder."ONT Next Work Center Grp Code" := ProdOrderRoutingLine2."Work Center Group Code";
                end;
            end;
        end;
    end;

    local procedure UpdateProductionOrderCurrentItem(var ProductionOrder: Record "Production Order")
    var
        ProductionLine: Record "Prod. Order Line";
    begin
        ProductionLine.Reset();
        ProductionLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        ProductionLine.SetRange(Status, ProductionOrder.Status);
        ProductionLine.SetRange("Line No.", LastProductionOrderLineNo);
        if ProductionLine.FindFirst() then
            ProductionOrder."ONT Current Item" := ProductionLine.Description;

        if ProductionOrder."ONT Next Operation No." = '' then begin
            ProductionOrder."ONT Current Item" := '';
            LastOperation := true;
        end;
        ProductionOrder.Modify(false);
        Commit();
    end;

    local procedure UpdateNewProductionOrderOperationNoAndName(var ProductionOrder: Record "Production Order"): Record "Prod. Order Line"
    var
        ProductionLine: Record "Prod. Order Line";
        ProducitonOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        if (ProductionOrder."ONT Previous Operation No." = '') and (ProductionOrder."ONT Next Operation No." = '') then begin
            ProductionLine.reset;
            ProductionLine.SetRange("Prod. Order No.", ProductionOrder."No.");
            ProductionLine.SetRange(Status, ProductionOrder.Status);
            if ProductionLine.FindLast() then begin
                ProductionOrder."ONT Current Item" := ProductionLine.Description;

                ProducitonOrderRoutingLine.Reset();
                ProducitonOrderRoutingLine.SetRange("Routing No.", ProductionLine."Routing No.");
                ProducitonOrderRoutingLine.SetRange("Routing Reference No.", ProductionLine."Routing Reference No.");
                ProducitonOrderRoutingLine.SetRange(Status, ProductionOrder.Status);
                ProducitonOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                if ProducitonOrderRoutingLine.FindFirst() then begin
                    ProductionOrder."ONT Next Operation No." := ProducitonOrderRoutingLine."Operation No.";
                    ProductionOrder."ONT Next Work Center No." := ProducitonOrderRoutingLine."Work Center No.";
                    ProductionOrder."ONT Next Work Center Grp Code" := ProducitonOrderRoutingLine."Work Center Group Code";
                end;
            end;
            ProductionOrder.Modify(false);
            Commit();
            Exit(ProductionLine);
        end;
    end;

    local procedure UpdateNextOperationNoAndName(var ProductionOrder: Record "Production Order";
                                                ProductionLine: Record "Prod. Order Line";
                                                CapacityLedgerEntry: Record "Capacity Ledger Entry")
    var
        ProductionOrderRoutingLine: Record "Prod. Order Routing Line";
        MachineCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
    begin
        if ProductionOrder."ONT Next Operation No." <> '' then begin
            ProductionOrderRoutingLine.Reset();
            ProductionOrderRoutingLine.SetRange("Routing No.", CapacityLedgerEntry."Routing No.");
            ProductionOrderRoutingLine.SetRange("Prod. Order No.", CapacityLedgerEntry."Order No.");
            ProductionOrderRoutingLine.SetRange("Operation No.", ProductionOrder."ONT Next Operation No.");

            if (ProductionOrder."ONT Previous Operation No." = '') then
                ProductionOrderRoutingLine.SetRange("Routing Reference No.", ProductionLine."Routing Reference No.")
            else
                ProductionOrderRoutingLine.SetRange("Routing Reference No.", LastProductionOrderLineNo);

            if ProductionOrderRoutingLine.findfirst() then begin
                case ProductionOrderRoutingLine.Type of
                    ProductionOrderRoutingLine.Type::"Machine Center":
                        begin
                            MachineCenter.Reset();
                            MachineCenter.SetRange("No.", ProductionOrderRoutingLine."No.");
                            if MachineCenter.FindFirst() then begin
                                ProductionOrder."ONT Next Operation Name" := MachineCenter.Name;
                                ProductionOrder."ONT Next Work Center No." := MachineCenter."Work Center No.";
                                ProductionOrder."ONT Next Work Center Grp Code" := ProductionOrderRoutingLine."Work Center Group Code";
                            end;
                        end;
                    ProductionOrderRoutingLine.Type::"Work Center":
                        begin
                            WorkCenter.Reset();
                            WorkCenter.SetRange("No.", ProductionOrderRoutingLine."No.");
                            if WorkCenter.FindFirst() then begin
                                ProductionOrder."ONT Next Operation Name" := WorkCenter.Name;
                                ProductionOrder."ONT Next Work Center No." := WorkCenter."No.";
                                ProductionOrder."ONT Next Work Center Grp Code" := WorkCenter."Work Center Group Code";
                            end;
                        end;
                end;
            end;
        end;
    end;

    local procedure CheckMissingComponentOnReleasedProductionOrders(var ProductionOrder: Record "Production Order")
    var
        ProductionLine: Record "Prod. Order Line";
        ProdOrderComponent: Record "Prod. Order Component";
        ComponentMissing: Boolean;
    begin
        if LastOperation and (ProductionOrder.Status = ProductionOrder.Status::Released) then begin
            ComponentMissing := false;
            ProductionLine.reset;
            ProductionLine.SetRange("Prod. Order No.", ProductionOrder."No.");
            ProductionLine.SetRange(Status, ProductionLine.Status::Released);
            if ProductionLine.FindSet() then
                repeat
                    ProdOrderComponent.Reset();
                    ProdOrderComponent.SetRange("Prod. Order No.", ProductionLine."Prod. Order No.");
                    ProdOrderComponent.SetRange("Prod. Order Line No.", ProductionLine."Line No.");
                    ProdOrderComponent.SetRange(Status, ProductionLine.Status::Released);
                    ProdOrderComponent.SetFilter("Remaining Qty. (Base)", '<>%1', 0);
                    if ProdOrderComponent.FindFirst() then
                        ComponentMissing := true;
                until (ProductionLine.Next() = 0) or ComponentMissing;
        end;

        if ComponentMissing then
            ProductionOrder."ONT Missing Consumption" := true;
    end;

    procedure UpdateVariantCodeLines(var ProductionOrder: record "Production Order")
    var
        VariantsTxt: text;
        ProdLineGrpByVariant: Query "ONT Prod Line Grp By Variant";
    begin
        VariantsTxt := '';
        clear(ProdLineGrpByVariant);
        ProdLineGrpByVariant.SetRange(Filter_Status, ProductionOrder.Status);
        ProdLineGrpByVariant.SetRange(FilterProd__Order_No_, ProductionOrder."No.");
        ProdLineGrpByVariant.SetFilter(Filter_Variant_Code, '<>%1', '');
        ProdLineGrpByVariant.Open();
        while ProdLineGrpByVariant.Read() do begin
            VariantsTxt += ProdLineGrpByVariant.Variant_Code + ', ';
        end;
        if VariantsTxt <> '' then
            VariantsTxt := CopyStr(VariantsTxt, 1, StrLen(VariantsTxt) - 2);
        ProductionOrder."ONT Variant Code Lines" := VariantsTxt;
        ProductionOrder.Modify(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateProductionComponentShortages()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateProdOrderLineAvailabilityStatusforAllProductionOrders()
    begin
    end;

    var
        LastProductionOrderLineNo: Integer;
        LastOperation: Boolean;
}

