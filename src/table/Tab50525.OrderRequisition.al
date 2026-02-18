table 50525 "Order Requisition"
{
    Caption = 'Order Requisition';

    fields
    {
        field(80000; "Requisition No."; Code[40])
        {
            Caption = 'Requisition No.';
            DataClassification = CustomerContent;
        }
        field(80001; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80002; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));

            trigger OnValidate()
            begin
                Rec."Document Type" := Rec."Document Type"::Order;
            end;
        }
        field(80003; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Line"."Line No." where("Document Type" = field("Document Type"), "Document No." = field("Document No."));

            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
            begin
                SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Document No.");
                SalesLine.Get(SalesLine."Document Type"::Order, Rec."Document No.", Rec."Line No.");
                Rec."Document Type" := Rec."Document Type";
                Rec.Validate("Item No.", SalesLine."No.");
                Rec.Validate("Ordered Qty", SalesLine.Quantity);
                Rec.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
                Rec.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                Rec.Validate("Ship-to Code", SalesHeader."Ship-to Code");
            end;
        }
        field(80004; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            //TableRelation = "Sales Line"."No." where("Document Type" = field("Document Type"),
            //                                                "Document No." = field("Document No."),
            //                                                "Line No." = field("Line No."));
            TableRelation = Item."No.";
            Editable = false;
        }
        field(80005; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(80006; "Ordered Qty"; Decimal)
        {
            Caption = 'Ordered Qty';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80007; "Requested Qty. To Ship"; Decimal)
        {
            Caption = 'Requested Qty. To Ship';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                QtyError: Label 'The quantity cannot exceed the quantity ordered on the sales line.';
            begin
                If Rec."Ordered Qty" < Rec."Requested Qty. To Ship" then Error(QtyError);
            end;
        }
        field(80008; "Qty Shipped"; Decimal)
        {
            Caption = 'Qty Shipped';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Shipment Line".Quantity where("Order No." = FIELD("Document No."), "Order Line No." = field("Line No.")));
            Editable = false;
        }
        field(80009; "Unit of Measure Code"; code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
            //TableRelation = "Sales Line"."Unit of Measure Code" where("Document Type" = FIELD("Document Type"),
            //                                                "Document No." = FIELD("Document No."),
            //                                                "Line No." = field("Line No."));
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
            Editable = false;
        }
        field(80010; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcuateRequisitonNo(Rec);
                //if not Rec.Insert() then Rec.Modify();
            end;
        }
        field(80011; "Shipping Agent Code"; code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent".Code;
        }
        field(80012; "Ship. Agent Service Code"; code[10])
        {
            Caption = 'Shipping Agent Service Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));
            ValidateTableRelation = false;
        }
        field(80013; "Sell-to Customer No."; code[20])
        {
            Caption = 'Sell-to Customer No.';
            DataClassification = CustomerContent;
            //TableRelation = "Sales Header"."Sell-to Customer No." where("Document Type" = field("Document Type"),
            //                                                "No." = field("Document No."));
            TableRelation = Customer."No.";
            Editable = false;
        }
        field(80014; "Ship-to Code"; code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            //TableRelation = "Sales Header"."Ship-to Code" where("Document Type" = field("Document Type"),
            //                                                "No." = field("Document No."));
            TableRelation = "Ship-to Address".Code;
            Editable = false;
        }
        field(80015; "EDI Order"; Boolean)
        {
            Caption = 'EDI Order';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."LAX EDI Order" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Editable = false;
        }
        field(80016; "EDI Whse Shp. Gen"; Boolean)
        {
            Caption = 'EDI Whse Shp. Gen';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80017; "EDI Whse Shp. Gen Date"; Date)
        {
            Caption = 'EDI Whse Shp. Gen Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80018; "Cancelled"; Boolean)
        {
            Caption = 'Cancelled';
            DataClassification = CustomerContent;
        }
        field(80019; "Error"; Boolean)
        {
            Caption = 'Error';
            DataClassification = CustomerContent;
        }
        field(80020; "Error Description"; Text[250])
        {
            Caption = 'Error Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80021; "Processed"; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80022; "LAX EDI Order"; Boolean)
        {
            Caption = 'LAX EDI Order';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80024; "Delete"; Boolean)
        {
            Caption = 'Delete';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(pk; "Document No.", "Line No.", "Shipment Date", "Cancelled")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        SalesLine: Record "Sales Line";
    begin
        IF SalesLine.get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
            Clear(SalesLine."Requisition No.");
            SalesLine.Modify();
        end;
    end;

    procedure OrderRequisitionCheck()
    begin
    end;

    procedure CalcuateRequisitonNo(var OrderRequisition: Record "Order Requisition")
    begin
        OrderRequisition."Requisition No." := OrderRequisition."Sell-to Customer No.";
        If OrderRequisition."Shipment Date" <> 0D then OrderRequisition."Requisition No." += '-' + Format(Date2DMY(OrderRequisition."Shipment Date", 3)) + '-' + Format(Date2DMY(OrderRequisition."Shipment Date", 2)) + '-' + Format(Date2DMY(OrderRequisition."Shipment Date", 1));
    end;

    procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end
        else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.SetReadDateTimeInUtcDate(true);
        TempExcelBuffer.ReadSheet();
    end;

    procedure ImportExcelData()
    var
        RowNo: Integer;
        ColNo: Integer;
        CellValue: Text;
        LineNo: Integer;
        MaxRowNo: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        Clear(ImportedLines);
        Clear(SkippedLines);
        OrderRequisition.Reset();
        if TempExcelBuffer.FindLast() then MaxRowNo := TempExcelBuffer."Row No.";
        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;
            ImportedLines += 1;
            Clear(OrderRequisition);
            OrderRequisition.Init();
            OrderRequisition."Document Type" := OrderRequisition."Document Type"::Order;
            if not SalesHeader.Get(SalesHeader."Document Type"::Order, GetValueAtCell(RowNo, 2)) then begin
                OrderRequisition."Error" := true;
                OrderRequisition."Error Description" := StrSubstNo(OrderErr, GetValueAtCell(RowNo, 2));
            end
            else
                OrderRequisition."Document No." := GetValueAtCell(RowNo, 2);
            CellValue := GetValueAtCell(RowNo, 3);
            If CellValue = '' then CellValue := '0';
            If not SalesLine.Get(SalesLine."Document Type"::Order, OrderRequisition."Document No.", CellValue) then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(LineErr, GetValueAtCell(RowNo, 3), GetValueAtCell(RowNo, 2));
                OrderRequisition."Error" := true;
            end
            else
                Evaluate(OrderRequisition."Line No.", GetValueAtCell(RowNo, 3));
            If GetValueAtCell(RowNo, 1) <> SalesHeader."Sell-to Customer No." then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(CustErr, GetValueAtCell(RowNo, 1), SalesHeader."Sell-to Customer No.", SalesHeader."No.");
                OrderRequisition."Error" := true;
            end
            else
                Evaluate(OrderRequisition."Sell-to Customer No.", GetValueAtCell(RowNo, 1));
            If GetValueAtCell(RowNo, 5) <> SalesLine."No." then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(ItemErr, GetValueAtCell(RowNo, 5), SalesLine."No.", SalesHeader."No.");
                OrderRequisition."Error" := true;
            end
            else
                Evaluate(OrderRequisition."Item No.", GetValueAtCell(RowNo, 5));
            If GetValueAtCell(RowNo, 6) <> SalesLine."Unit of Measure Code" then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(UoMErr, GetValueAtCell(RowNo, 6), SalesLine."Unit of Measure Code", SalesHeader."No.");
                OrderRequisition."Error" := true;
            end
            else
                Evaluate(OrderRequisition."Unit of Measure Code", GetValueAtCell(RowNo, 6));
            If GetValueAtCell(RowNo, 4) <> SalesLine."Location Code" then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(UoMErr, GetValueAtCell(RowNo, 4), SalesLine."Location Code", SalesHeader."No.");
                OrderRequisition."Error" := true;
            end
            else
                Evaluate(OrderRequisition."Location Code", GetValueAtCell(RowNo, 4));
            If GetValueAtCell(RowNo, 7) <> format(SalesLine.Quantity) then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(OrderedQtyErr, GetValueAtCell(RowNo, 7), SalesLine.Quantity, SalesHeader."No.", SalesLine."Line No.");
                OrderRequisition."Error" := true;
            end;
            OrderRequisition.Validate("Ordered Qty", SalesLine.Quantity);
            OrderRequisition.Validate("Item No.", SalesLine."No.");
            OrderRequisition.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
            OrderRequisition.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
            OrderRequisition.Validate("Ship-to Code", SalesHeader."Ship-to Code");
            CellValue := GetValueAtCell(RowNo, 8);
            If CellValue = '' then CellValue := '0';
            Evaluate(OrderRequisition."Requested Qty. To Ship", CellValue);
            CellValue := GetValueAtCell(RowNo, 9);
            If CellValue <> '' then Evaluate(OrderRequisition."Shipment Date", CellValue);
            Evaluate(OrderRequisition."Shipping Agent Code", GetValueAtCell(RowNo, 10));
            Evaluate(OrderRequisition."Ship. Agent Service Code", GetValueAtCell(RowNo, 11));
            OrderRequisition.CalcuateRequisitonNo(OrderRequisition);
            if not ShippingAgent.Get(OrderRequisition."Shipping Agent Code") then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(ShippingAgentErr, OrderRequisition."Shipping Agent Code");
                OrderRequisition."Error" := true;
            end;
            OrderRequisition2.Reset();
            OrderRequisition2.SetRange("Document Type", OrderRequisition."Document Type");
            OrderRequisition2.SetRange("Document No.", OrderRequisition."Document No.");
            OrderRequisition2.SetRange("Line No.", OrderRequisition."Line No.");
            OrderRequisition2.SetRange("Shipment Date", OrderRequisition."Shipment Date");
            OrderRequisition2.SetRange("Cancelled", false);
            OrderRequisition2.SetRange("EDI Whse Shp. Gen", false);
            OrderRequisition2.SetRange("Qty Shipped", 0);
            If OrderRequisition2.FindFirst() then
                if Confirm(StrSubstNo(Req1Msg, OrderRequisition."Requisition No."), false) then begin
                    OrderRequisition2."Error" := true;
                    OrderRequisition2."Error Description" := StrSubstNo(ReqCancelledMsg, OrderRequisition."Requisition No.", OrderRequisition."Document No.", OrderRequisition."Line No.");
                    OrderRequisition2.Modify();
                    OrderRequisition2.Rename(OrderRequisition2."Document No.", OrderRequisition2."Line No.", OrderRequisition2."Shipment Date", true);
                end
                else begin
                    SkippedLines += 1;
                    OrderRequisition."Error" := true;
                    OrderRequisition."Delete" := true;
                end;
            OrderRequisition2.SetRange("EDI Whse Shp. Gen", true);
            OrderRequisition2.SetRange("Qty Shipped", 0);
            If OrderRequisition2.FindFirst() then
                if Confirm(StrSubstNo(Req2Msg, OrderRequisition."Requisition No.", OrderRequisition."Sell-to Customer No."), false) then begin
                    OrderRequisition2."Error" := true;
                    OrderRequisition2."Error Description" := StrSubstNo(ReqCancelledMsg, OrderRequisition."Requisition No.", OrderRequisition."Document No.", OrderRequisition."Line No.");
                    OrderRequisition2.Modify();
                    OrderRequisition2.Rename(OrderRequisition2."Document No.", OrderRequisition2."Line No.", OrderRequisition2."Shipment Date", true);
                end
                else begin
                    SkippedLines += 1;
                    OrderRequisition."Error" := true;
                    OrderRequisition."Delete" := true;
                end;
            OrderRequisition2.SetRange("EDI Whse Shp. Gen");
            OrderRequisition2.SetFilter("Qty Shipped", '<>%1', 0);
            If OrderRequisition2.FindFirst() then begin
                SkippedLines += 1;
                OrderRequisition."Error" := true;
                OrderRequisition."Delete" := true;
                Message(StrSubstNo(ImportCancelledMsg, OrderRequisition."Requisition No.", OrderRequisition."Document No.", OrderRequisition."Line No.", OrderRequisition."Shipment Date"));
            end;
            IF (SalesLine.Quantity < OrderRequisition."Requested Qty. To Ship") and (not OrderRequisition."Error") then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(QtyErr, OrderRequisition."Requested Qty. To Ship", SalesLine.Quantity, SalesHeader."No.");
                OrderRequisition."Error" := true;
            end;
            OrderRequisition2.Reset();
            OrderRequisition2.SetRange("Document Type", OrderRequisition."Document Type");
            OrderRequisition2.SetRange("Document No.", OrderRequisition."Document No.");
            OrderRequisition2.SetRange("Line No.", OrderRequisition."Line No.");
            OrderRequisition2.SetRange("Item No.", OrderRequisition."Item No.");
            OrderRequisition2.SetRange("Cancelled", false);
            OrderRequisition2.CalcSums("Requested Qty. To Ship");
            IF (SalesLine.Quantity < OrderRequisition2."Requested Qty. To Ship" + OrderRequisition."Requested Qty. To Ship") and (not OrderRequisition."Error") then begin
                if not OrderRequisition."Error" then OrderRequisition."Error Description" := StrSubstNo(QtyErr, OrderRequisition2."Requested Qty. To Ship" + OrderRequisition."Requested Qty. To Ship", SalesLine.Quantity, SalesHeader."No.");
                OrderRequisition."Error" := true;
            end;
            OrderRequisition2.Reset();
            OrderRequisition2.SetRange("Document Type", OrderRequisition."Document Type");
            OrderRequisition2.SetRange("Document No.", OrderRequisition."Document No.");
            OrderRequisition2.SetRange("Line No.", OrderRequisition."Line No.");
            OrderRequisition2.SetRange("Cancelled", false);
            OrderRequisition2.SetRange("LAX EDI Order", true);
            OrderRequisition2.SetRange("EDI Whse Shp. Gen", false);
            if OrderRequisition2.FindSet() then
                if Confirm(StrSubstNo(ReqExists, OrderRequisition2."Requisition No.", OrderRequisition."Document No.", GetValueAtCell(RowNo, 1)), false) then
                    repeat
                        OrderRequisition2.Rename(OrderRequisition2."Document No.", OrderRequisition2."Line No.", OrderRequisition2."Shipment Date", true);
                    until OrderRequisition2.Next() = 0
                else begin
                    SkippedLines += 1;
                    OrderRequisition."Error" := true;
                    OrderRequisition."Delete" := true;
                end;
            OrderRequisition."LAX EDI Order" := SalesHeader."LAX EDI Order";
            If not OrderRequisition."Error" then begin
                //Clear(SalesHeader."LAX EDI WHSE Shp. Gen");
                //Clear(SalesHeader."LAX EDI WHSE Shp. Gen Date");
                //SalesHeader.Modify();
                If (not TmpSalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.")) and (SalesHeader."LAX EDI Order") and (SalesHeader."LAX EDI WHSE Shp. Gen") then begin
                    TmpSalesHeader.Init();
                    TmpSalesHeader.TransferFields(SalesHeader);
                    TmpSalesHeader.Insert();
                end;
                SalesLine."Requisition No." := OrderRequisition."Requisition No.";
                SalesLine.Modify();
            end;
            IF not OrderRequisition."Delete" then OrderRequisition.Insert();
        end;
        TmpSalesHeader.Reset();
        If TmpSalesHeader.FindSet() then
            repeat
                SalesHeader.Get(TmpSalesHeader."Document Type", TmpSalesHeader."No.");
                Clear(SalesHeader."LAX EDI WHSE Shp. Gen");
                Clear(SalesHeader."LAX EDI WHSE Shp. Gen Date");
                SalesHeader.Modify();
            until TmpSalesHeader.Next() = 0;
        Message(StrSubstNo(ImportMsg, Format(ImportedLines - SkippedLines), Format(SkippedLines)));
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    var
        OrderRequisition: Record "Order Requisition";
        OrderRequisition2: Record "Order Requisition";
        TmpSalesHeader: Record "Sales Header" temporary;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentService: Record "Shipping Agent Services";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];
        ImportedLines: Integer;
        CustErr: Label 'Customer %1 is different from customer (debtor) %2 in sales order %3. Registration will not be processed.';
        ItemErr: Label 'Item %1 is different from Sales Item %2 of Sales Order %3. Registration will not be processed.';
        UoMErr: label 'Unit of measure %1 is different from unit of measure of sales %2 of sales order %3. Registration will not be processed.';
        LocationErr: Label 'Location code %1 is different from sales location code %2 on sales order %3. Registration will not be processed.';
        QtyErr: Label 'The quantity requested %1 cannot exceed quantity %2 of sales order %3.';
        OrderedQtyErr: Label 'The ordered quantity %1 cannot exceed quantity %2 of sales order %3, line no. %4.';
        LineErr: Label 'Sales Line %1 does not exist in the sales order %2';
        OrderErr: Label 'Sales order %1 does not exist';
        ShippingAgentErr: Label 'Shipping Agent %1 does not exist.';
        ShippingAgentServiceErr: Label 'Shipping Agent Service %1 does not exist for Shipping Agent %2.';
        ReqExists: Label 'A requisition %1 is already present for order %2 and has not been sent to partner %3.  Do you want to replace it with this new application?';
        Req1Msg: Label 'Requisition request %1 is already present in the requisition table. Do you wish to cancel it?';
        Req2Msg: Label 'Request for requisition %1 has already been sent to your partner %2. Do you wish to cancel it?';
        ReqCancelledMsg: Label 'Requisition %1, order %2, line %3 has been cancelled.  Please contact your partner to let them know.';
        ImportCancelledMsg: Label 'You cannot create requisition %1 for order %2, line %3 because it already has delivery for delivery date %4.';
        SkippedLines: Integer;
        ImportMsg: Label 'Import is finished. %1 lines imported, %2 lines skipped.';
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}
