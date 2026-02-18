xmlport 50503 "Import Requisition"
{
    Caption = 'Import Order Requisition';
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;
    //FieldSeparator = ',';
    //RecordSeparator = '<NewLine>';
    //FieldDelimiter = '"';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ERAOrderRequisition; "Order Requisition")
            {
                textelement(ERASelltoCustomerNo)
                {
                    //ERAOrderRequisition."Sell-to Customer No."
                }
                fieldelement(ERADocumentNo; ERAOrderRequisition."Document No.")
                {
                }
                fieldelement(ERALineNo; ERAOrderRequisition."Line No.")
                {
                }
                textelement(ERAItemNo)
                {
                    //ERAOrderRequisition."Item No."
                }
                textelement(ERAUnitofMeasureCode)
                {
                    //ERAOrderRequisition."Unit of Measure Code"
                }
                textelement(ERALocationCode)
                {
                    //ERAOrderRequisition."Location Code"
                }
                textelement(ERAOrderedQty)
                {
                    //ERAOrderRequisition."Ordered Qty"
                }
                fieldelement(ERARequestedQtyToShip; ERAOrderRequisition."Requested Qty. To Ship")
                {
                }
                fieldelement(ERAShipmentDate; ERAOrderRequisition."Shipment Date")
                {
                }
                fieldelement(ERAShippingAgentCode; ERAOrderRequisition."Shipping Agent Code")
                {
                }
                fieldelement(ERAShipAgentServiceCode; ERAOrderRequisition."Ship. Agent Service Code")
                {
                }
                trigger OnBeforeInsertRecord()
                var
                    OrderRequisition2: Record "Order Requisition";
                    SalesHeader: Record "Sales Header";
                    SalesLine: Record "Sales Line";
                    ShippingAgent: Record "Shipping Agent";
                    ShippingAgentService: Record "Shipping Agent Services";
                    CustErr: Label 'Customer %1 is different from customer (debtor) %2 in sales order %3. Registration will not be processed.';
                    ItemErr: Label 'Item %1 is different from Sales Item %2 of Sales Order %3. Registration will not be processed.';
                    UoMErr: Label 'Unit of measure %1 is different from unit of measure of sales %2 of sales order %3. Registration will not be processed.';
                    LocationErr: Label 'Location code %1 is different from sales location code %2 on sales order %3. Registration will not be processed.';
                    QtyErr: Label 'The quantity requested %1 cannot exceed quantity %2 of sales order %3.';
                    LineErr: Label 'Sales Line %1 does not exist in the sales order %2';
                    OrderErr: Label 'Sales order %1 does not exist';
                    ShippingAgentErr: Label 'Shipping Agent %1 does not exist.';
                    ShippingAgentServiceErr: Label 'Shipping Agent Service %1 does not exist for Shipping Agent %2.';
                    ReqExists: Label 'A requisition %1 is already present for order %2 and has not been sent to partner %3.  Do you want to replace it with this new application?';
                begin
                    ImportedLines += 1;
                    if not SalesHeader.Get(SalesHeader."Document Type"::Order, ERAOrderRequisition."Document No.") then begin
                        ERAOrderRequisition."Error" := true;
                        ERAOrderRequisition."Error Description" := StrSubstNo(OrderErr, ERAOrderRequisition."Document No.");
                    end;
                    ERAOrderRequisition."Document Type" := SalesHeader."Document Type";

                    if not ERAOrderRequisition."Error" then
                        if not SalesLine.Get(SalesLine."Document Type"::Order, ERAOrderRequisition."Document No.", ERAOrderRequisition."Line No.") then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(LineErr, ERAOrderRequisition."Line No.", ERAOrderRequisition."Document No.");
                        end;

                    if not ERAOrderRequisition."Error" then
                        if ERASelltoCustomerNo <> SalesHeader."Sell-to Customer No." then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(CustErr, ERASelltoCustomerNo, SalesHeader."Sell-to Customer No.", SalesHeader."No.");
                        end
                        else
                            ERAOrderRequisition."Sell-to Customer No." := ERASelltoCustomerNo;

                    if not ERAOrderRequisition."Error" then
                        if ERAItemNo <> SalesLine."No." then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(ItemErr, ERAItemNo, SalesLine."No.", SalesHeader."No.");
                        end
                        else
                            ERAOrderRequisition."Item No." := ERAItemNo;

                    if not ERAOrderRequisition."Error" then
                        if ERAUnitofMeasureCode <> SalesLine."Unit of Measure Code" then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(UoMErr, ERAUnitofMeasureCode, SalesLine."Unit of Measure Code", SalesHeader."No.");
                        end
                        else
                            ERAOrderRequisition."Unit of Measure Code" := ERAUnitofMeasureCode;

                    if not ERAOrderRequisition."Error" then
                        if ERALocationCode <> SalesLine."Location Code" then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(LocationErr, ERALocationCode, SalesLine."Location Code", SalesHeader."No.");
                        end
                        else
                            ERAOrderRequisition."Location Code" := ERALocationCode;

                    ERAOrderRequisition.Validate("Item No.", SalesLine."No.");
                    ERAOrderRequisition.Validate("Ordered Qty", SalesLine.Quantity);
                    ERAOrderRequisition.Validate("Unit of Measure Code", SalesLine."Unit of Measure");
                    ERAOrderRequisition.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                    ERAOrderRequisition.Validate("Ship-to Code", SalesHeader."Ship-to Code");


                    OrderRequisition2.SetRange("Document Type", ERAOrderRequisition."Document Type");
                    OrderRequisition2.SetRange("Document No.", ERAOrderRequisition."Document No.");
                    OrderRequisition2.SetRange("Line No.", ERAOrderRequisition."Line No.");
                    OrderRequisition2.SetRange("Item No.", ERAOrderRequisition."Item No.");
                    OrderRequisition2.SetRange("Cancelled", false);
                    OrderRequisition2.CalcSums("Requested Qty. To Ship");
                    if (SalesLine.Quantity < OrderRequisition2."Requested Qty. To Ship") and (not ERAOrderRequisition."Error") then begin
                        ERAOrderRequisition."Error" := true;
                        ERAOrderRequisition."Error Description" := StrSubstNo(UoMErr, ERAUnitofMeasureCode, SalesLine."Unit of Measure Code", SalesHeader."No.");
                    end;

                    if not ERAOrderRequisition."Error" then
                        if not ShippingAgent.Get(ERAOrderRequisition."Shipping Agent Code") then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(ShippingAgentErr, ERAOrderRequisition."Shipping Agent Code");
                        end;
                    if not ERAOrderRequisition."Error" then
                        if not ShippingAgentService.Get(ERAOrderRequisition."Shipping Agent Code", ERAOrderRequisition."Ship. Agent Service Code") then begin
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Error Description" := StrSubstNo(ShippingAgentServiceErr, ERAOrderRequisition."Ship. Agent Service Code", ERAOrderRequisition."Shipping Agent Code");
                        end;
                    ERAOrderRequisition.CalcuateRequisitonNo(ERAOrderRequisition);
                    OrderRequisition2.SetRange("Document Type", ERAOrderRequisition."Document Type");
                    OrderRequisition2.SetRange("Document No.", ERAOrderRequisition."Document No.");
                    OrderRequisition2.SetRange("Line No.", ERAOrderRequisition."Line No.");
                    OrderRequisition2.SetRange("Cancelled", false);
                    OrderRequisition2.SetRange("LAX EDI Order", true);
                    OrderRequisition2.SetRange("EDI Whse Shp. Gen", false);
                    if OrderRequisition2.FindSet() then
                        if Confirm(StrSubstNo(ReqExists, ERAOrderRequisition."Requisition No.", ERAOrderRequisition."Document No.", ERASelltoCustomerNo), false) then
                            OrderRequisition2.ModifyAll("Cancelled", true)
                        else begin
                            SkippedLines += 1;
                            ERAOrderRequisition."Error" := true;
                            ERAOrderRequisition."Delete" := true;
                        end;
                    ERAOrderRequisition."LAX EDI Order" := SalesHeader."LAX EDI Order";
                    if (not ERAOrderRequisition."Error") and (SalesHeader."LAX EDI Order") and (SalesHeader."LAX EDI WHSE Shp. Gen") then begin
                        Clear(SalesHeader."LAX EDI WHSE Shp. Gen");
                        Clear(SalesHeader."LAX EDI WHSE Shp. Gen Date");
                        SalesHeader.Modify();
                        SalesLine."Requisition No." := ERAOrderRequisition."Requisition No.";
                        SalesLine.Modify();
                    end;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPostXmlPort()
    begin
        ERAOrderRequisition.Reset();
        ERAOrderRequisition.SetRange("Delete", true);
        ERAOrderRequisition.DeleteAll();
        Message(StrSubstNo(ImportMsg, Format(ImportedLines - SkippedLines), Format(SkippedLines)));
    end;

    var
        ImportedLines: Integer;
        SkippedLines: Integer;
        ImportMsg: Label 'Import is finished. %1 lines imported, %2 lines skipped.';
}
