codeunit 50562 "Recalculate Shortage Workbench"
{
    trigger OnRun()
    var
        ProdOrderComponent: Record "Prod. Order Component";
        DemandBuffer: Record "OTG Demand Buffer";
        AllocationResult: Record "OTG Allocation Result";
        PurchLine: Record "Purchase Line";
        WhsReceiptHeader: Record "Warehouse Receipt Header";
        WhsReceiptLine: Record "Warehouse Receipt Line";
        Item: Record Item;
        Loader: Codeunit "OTG Demand Loader";
        Calc: Codeunit "OTG Earliest Availability";
        Window: Dialog;
        DifDays: Decimal;
        ProcessMsg: Label 'Process Task      #2######', Comment = 'Counter';
        int: Integer;
    begin
        if GuiAllowed then begin
            Window.Open('#1#################################\\' + ProcessMsg);
            Window.Update(2, 'Update Demand');
        end;
        // Loader.LoadFromProdOrderComponents(false, false, true, '', 0);
        Loader.LoadFromProdOrderComponents(true, true, true, '', 0);
        Loader.LoadFromSalesOrders(0D, 0D, '', false, 0);
        if GuiAllowed then begin
            Window.Update(2, 'Update Allocation');
        end;
        Calc.RunForAllDemand();
        if GuiAllowed then begin
            Window.Update(2, 'Update Shortage Workbench');
        end;
        if ProdOrderComponent.FindSet() then
            repeat
                if ProdOrderComponent."Item No." = 'MFP24012' then
                    int := 1;
                Item.Get(ProdOrderComponent."Item No.");
                ProdOrderComponent.CalcFields("Earliest Avail. Date");
                if ProdOrderComponent."Demand Entry No." <> 0 then
                    if DemandBuffer.Get(ProdOrderComponent."Demand Entry No.") then begin
                        if ProdOrderComponent."Earliest Avail. Date" <> 0D then begin
                            DifDays := ProdOrderComponent."Earliest Avail. Date" - ProdOrderComponent."Due Date";

                            if DifDays > 0 then begin
                                ProdOrderComponent."ONT Days Late" := DifDays;
                                ProdOrderComponent."ONT Days Early" := 0;
                                ProdOrderComponent."ONT Availability Status" := ProdOrderComponent."ONT Availability Status"::"Too Late";
                            end else begin
                                if DifDays < 0 then begin
                                    ProdOrderComponent."ONT Days Early" := Abs(DifDays);
                                    ProdOrderComponent."ONT Days Late" := 0;
                                    ProdOrderComponent."ONT Availability Status" := ProdOrderComponent."ONT Availability Status"::"Too Early";
                                end
                                else if DifDays = 0 then begin
                                    ProdOrderComponent."ONT Days Early" := 0;
                                    ProdOrderComponent."ONT Days Late" := 0;
                                    ProdOrderComponent."ONT Availability Status" := ProdOrderComponent."ONT Availability Status"::"On Time";
                                end;
                            end;
                        end
                        else begin
                            ProdOrderComponent."ONT Days Early" := 0;
                            ProdOrderComponent."ONT Days Late" := 0;
                            ProdOrderComponent."ONT Availability Status" := ProdOrderComponent."ONT Availability Status"::"None";
                        end;
                        AllocationResult.SetRange("Demand Entry No.", ProdOrderComponent."Demand Entry No.");
                        AllocationResult.SetRange("Source Type", AllocationResult."Source Type"::PurchaseLine);
                        if AllocationResult.FindFirst() then begin
                            ProdOrderComponent."ONT Supply Reference No." := AllocationResult."Document No.";
                            ProdOrderComponent."ONT Supply Reference Line No." := AllocationResult."Document Line No.";
                            if PurchLine.Get(PurchLine."Document Type"::Order, AllocationResult."Document No.", AllocationResult."Document Line No.") then begin
                                ProdOrderComponent."ONT Vendor No." := PurchLine."Buy-from Vendor No.";
                                ProdOrderComponent."ONT Unit Cost (CAD)" := PurchLine."Unit Cost (LCY)";
                                ProdOrderComponent."ONT Ext Cost CAD" := PurchLine."Unit Cost (LCY)" * AllocationResult."Allocated Qty (Base)";
                                ProdOrderComponent."ONT Confirmed Date" := PurchLine."Requested Ship Date";
                                ProdOrderComponent."ONT Promise Date" := PurchLine."Promised Ship Date";
                                WhsReceiptLine.SetRange("Source Type", Database::"Purchase Line");
                                WhsReceiptLine.SetRange("Source Subtype", 1);
                                WhsReceiptLine.SetRange("Source No.", PurchLine."Document No.");
                                WhsReceiptLine.SetRange("Source Line No.", PurchLine."Line No.");
                                if WhsReceiptLine.FindFirst() then begin
                                    WhsReceiptHeader.Get(WhsReceiptLine."No.");
                                    ProdOrderComponent."ONT Receipt No." := WhsReceiptLine."No.";
                                    ProdOrderComponent."ONT Receipt Description" := WhsReceiptLine.Description;
                                    ProdOrderComponent."ONT Route Name" := WhsReceiptHeader.Route;
                                    ProdOrderComponent."ONT ETD" := WhsReceiptHeader."Estimated Time Departure";
                                    ProdOrderComponent."ONT ETA" := WhsReceiptHeader."Estimated Time of Arrival";
                                    ProdOrderComponent."ONT ATD" := WhsReceiptHeader."Actual Time of Departure";
                                    ProdOrderComponent."ONT ATA" := WhsReceiptHeader."Actual Time of Arrival";
                                    ProdOrderComponent."ONT Container Shipping Agent" := WhsReceiptHeader."Container Shipping Agent";
                                    ProdOrderComponent."ONT Vessel" := WhsReceiptHeader."Vessel ID";
                                    ProdOrderComponent."ONT Reference" := WhsReceiptHeader."Tracking No.";
                                    ProdOrderComponent."ONT Status" := WhsReceiptHeader.Status;
                                    ProdOrderComponent."Release Date" := WhsReceiptHeader."Release Date";
                                    ProdOrderComponent."Pickup Date" := WhsReceiptHeader."Pickup Date";
                                    ProdOrderComponent."ONT Delivery Date" := WhsReceiptHeader."Delivery Date";
                                end
                                else begin
                                    ClearProdOrderComponentWHSFields(ProdOrderComponent);
                                end;
                            end
                            else begin
                                ClearProdOrderComponentPurchFields(ProdOrderComponent);
                                ClearProdOrderComponentWHSFields(ProdOrderComponent);
                            end;
                        end
                        else begin
                            ClearProdOrderComponentPurchFields(ProdOrderComponent);
                            ClearProdOrderComponentWHSFields(ProdOrderComponent);
                            ClearProdOrderComponentAllFields(ProdOrderComponent);
                        end;
                        ProdOrderComponent.Modify();
                    end;
            until ProdOrderComponent.Next() = 0;
        Window.Close();
    end;

    procedure ClearProdOrderComponentAllFields(var
                                                   ProdOrderComponent: Record "Prod. Order Component")
    begin
        ProdOrderComponent."ONT Supply Reference No." := '';
        ProdOrderComponent."ONT Supply Reference Line No." := 0;
    end;

    procedure ClearProdOrderComponentPurchFields(var ProdOrderComponent: Record "Prod. Order Component")
    begin
        ProdOrderComponent."ONT Vendor No." := '';
        ProdOrderComponent."ONT Unit Cost (CAD)" := 0;
        ProdOrderComponent."ONT Ext Cost CAD" := 0;
        ProdOrderComponent."ONT Confirmed Date" := 0D;
        ProdOrderComponent."ONT Promise Date" := 0D;
    end;

    procedure ClearProdOrderComponentWHSFields(var ProdOrderComponent: Record "Prod. Order Component")
    begin
        ProdOrderComponent."ONT Receipt No." := '';
        ProdOrderComponent."ONT Receipt Description" := '';
        ProdOrderComponent."ONT Route Name" := '';
        ProdOrderComponent."ONT ETD" := 0D;
        ProdOrderComponent."ONT ETA" := 0D;
        ProdOrderComponent."ONT ATD" := 0D;
        ProdOrderComponent."ONT ATA" := 0D;
        ProdOrderComponent."ONT Container Shipping Agent" := '';
        ProdOrderComponent."ONT Vessel" := '';
        ProdOrderComponent."ONT Reference" := '';
        ProdOrderComponent."ONT Status" := ProdOrderComponent."ONT Status"::Open;
        ProdOrderComponent."Release Date" := 0D;
        ProdOrderComponent."Pickup Date" := 0D;
        ProdOrderComponent."ONT Delivery Date" := 0D;
    end;

}