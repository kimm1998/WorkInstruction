tableextension 50511 "Warehouse Receipt Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(80000; "Container ID"; Code[30])
        {
            Caption = 'Container ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                WarehouseReceiptHeader: Record "Warehouse Receipt Header";
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
                ContainerErr: Label 'Container ID %1 is already used on Warehouse Receipt %2', Comment = '%1, %2 are fields';
            begin
                if "Container ID" <> '' then begin
                    WarehouseReceiptHeader.SetFilter("No.", '<>%1', "No.");
                    WarehouseReceiptHeader.SetRange("Container ID", "Container ID");
                    if WarehouseReceiptHeader.FindFirst() then
                        Error(ContainerErr, "Container ID", WarehouseReceiptHeader."No.")
                    else begin
                        WarehouseReceiptLine.SetRange("No.", "No.");
                        if WarehouseReceiptLine.FindSet() then
                            repeat
                                WarehouseReceiptLine.Validate("Container ID", "Container ID");
                                WarehouseReceiptLine.Modify();
                            until WarehouseReceiptLine.Next() = 0;
                    end;
                end;
            end;
        }
        field(80001; "Container Type"; Code[20])
        {
            Caption = 'Container Type';
            DataClassification = CustomerContent;
            TableRelation = "Container Type";
        }
        field(80002; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(80003; "Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Open,Prepared,Loaded,Shipped,"Arrived at Destination",Delivered;
            OptionCaptionML = FRC = 'Ouvert,Préparé,Chargé,Parti,Arrivé à destination,Livré', ENU = 'Open,Prepared,Loaded,Shipped,Arrived at Destination,Delivered', ENC = 'Open,Prepared,Loaded,Shipped,Arrived at Destination,Delivered';
        }
        field(80004; "Balanced"; Boolean)
        {
            Caption = 'Balanced';
            DataClassification = CustomerContent;
        }
        field(80005; "Cleared"; Boolean)
        {
            Caption = 'Cleared';
            DataClassification = CustomerContent;
        }
        field(80006; "Route"; Code[20])
        {
            Caption = 'Route';
            DataClassification = CustomerContent;
            TableRelation = "Import Route";
            // trigger OnValidate()
            // begin
            //     TestField("Estimated Time Departure", 0D);
            //     TestField("Actual Time of Departure", 0D);
            //     TestField("Estimated Time of Arrival", 0D);
            //     TestField("Actual Time of Arrival", 0D);
            //     TestField("Expected Delivery Date", 0D);
            // end;
        }
        field(80007; "Container Shipping Agent"; Code[10])
        {
            Caption = 'Container Shipping Agent';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(80008; "Tracking No."; Code[30])
        {
            Caption = 'Tracking No.';
            DataClassification = CustomerContent;
        }
        field(80009; "Cargo Control No."; Code[30])
        {
            Caption = 'Cargo Control No.';
            DataClassification = CustomerContent;
        }
        field(80010; "Transit Warehouse"; Code[30])
        {
            Caption = 'Transit Warehouse';
            DataClassification = CustomerContent;
        }
        field(80011; "Bill of Lading No."; Code[30])
        {
            Caption = 'Bill of Lading No.';
            DataClassification = CustomerContent;
        }
        field(80012; "Vessel ID"; Code[30])
        {
            Caption = 'Vessel ID';
            DataClassification = CustomerContent;
        }
        field(80013; "Seal No."; Code[30])
        {
            Caption = 'Seal No.';
            DataClassification = CustomerContent;
        }
        field(80014; "Package Qty."; Integer)
        {
            Caption = 'Package Qty.';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(80015; "Estimated Time Departure"; Date)
        {
            Caption = 'Estimated Time of Departure';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField("Actual Time of Departure", 0D);
            end;
        }
        field(80016; "Actual Time of Departure"; Date)
        {
            Caption = 'Actual Time of Departure';
            DataClassification = CustomerContent;
        }
        field(80017; "Estimated Time of Arrival"; Date)
        {
            Caption = 'Estimated Time of Arrival';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ImportRoute: Record "Import Route";
                WhseReceiptLine: Record "Warehouse Receipt Line";
                PurchaseLine: Record "Purchase Line";
                TransferLine: Record "Transfer Line";
                SalesLine: record "Sales Line";
                Text000: label 'You have modified Estimated Time of Arrival. Do you want to update the lines?', Comment = 'Text Question';
            begin
                //TestField("Estimated Time of Arrival");
                if Route = '' then Error(EmptyRouteErr);
                ImportRoute.Get(Route);
                if "Estimated Time of Arrival" <> 0D then begin
                    Validate("Expected Delivery Date", CalcDate(ImportRoute."Transit Delay", "Estimated Time of Arrival"));
                    WhseReceiptLine.SetRange("No.", "No.");
                    if WhseReceiptLine.FindSet() then
                        if Dialog.Confirm(Text000, true) then
                            repeat
                                WhseReceiptLine.Validate("Due Date", CalcDate(ImportRoute."Transit Delay", "Estimated Time of Arrival"));
                                WhseReceiptLine.Modify(true);
                                case WhseReceiptLine."Source Document" of
                                    WhseReceiptLine."Source Document"::"Purchase Order":
                                        begin
                                            PurchaseLine.Get(SalesLine."Document Type"::Order, WhseReceiptLine."Source No.", WhseReceiptLine."Source Line No.");
                                            PurchaseLine.SuspendStatusCheck(true);
                                            PurchaseLine.Validate(PurchaseLine."Expected Receipt Date", CalcDate(ImportRoute."Transit Delay", "Estimated Time of Arrival"));
                                            PurchaseLine.Modify();
                                        end;
                                    WhseReceiptLine."Source Document"::"Inbound Transfer":
                                        begin
                                            TransferLine.Get(WhseReceiptLine."Source No.", WhseReceiptLine."Source Line No.");
                                            TransferLine.SuspendStatusCheck(true);
                                            TransferLine.Validate(TransferLine."Receipt Date", CalcDate(ImportRoute."Transit Delay", "Estimated Time of Arrival"));
                                            TransferLine.Modify();
                                        end;
                                    WhseReceiptLine."Source Document"::"Sales Return Order":
                                        begin
                                            SalesLine.Get(SalesLine."Document Type"::"Return Order", WhseReceiptLine."Source No.", WhseReceiptLine."Source Line No.");
                                            SalesLine.SuspendStatusCheck(true);
                                            SalesLine.Validate(SalesLine."Shipment Date", CalcDate(ImportRoute."Transit Delay", "Estimated Time of Arrival"));
                                            SalesLine.Modify();
                                        end;
                                end;
                            until WhseReceiptLine.Next() = 0;
                end;
            end;
        }
        field(80018; "Actual Time of Arrival"; Date)
        {
            Caption = 'Actual Time of Arrival';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ImportRoute: Record "Import Route";
                WhseReceiptLine: Record "Warehouse Receipt Line";
                PurchaseLine: Record "Purchase Line";
                TransferLine: Record "Transfer Line";
                SalesLine: record "Sales Line";
                Text000: label 'You have modified Actual Time of Arrival. Do you want to update the lines?', Comment = 'Text Question';
            begin
                //TestField("Estimated Time of Arrival");
                if Route = '' then Error(EmptyRouteErr);
                ImportRoute.Get(Route);
                if "Actual Time of Arrival" <> 0D then begin
                    Validate("Expected Delivery Date", CalcDate(ImportRoute."Transit Delay", "Actual Time of Arrival"));
                    WhseReceiptLine.SetRange("No.", "No.");
                    if WhseReceiptLine.FindSet() then
                        if Dialog.Confirm(Text000, true) then
                            repeat
                                WhseReceiptLine.Validate("Due Date", CalcDate(ImportRoute."Transit Delay", "Actual Time of Arrival"));
                                WhseReceiptLine.Modify(true);
                                case WhseReceiptLine."Source Document" of
                                    WhseReceiptLine."Source Document"::"Purchase Order":
                                        begin
                                            PurchaseLine.Get(SalesLine."Document Type"::Order, WhseReceiptLine."Source No.", WhseReceiptLine."Source Line No.");
                                            PurchaseLine.SuspendStatusCheck(true);
                                            PurchaseLine.Validate(PurchaseLine."Expected Receipt Date", CalcDate(ImportRoute."Transit Delay", "Actual Time of Arrival"));
                                            PurchaseLine.Modify();
                                        end;
                                    WhseReceiptLine."Source Document"::"Inbound Transfer":
                                        begin
                                            TransferLine.Get(WhseReceiptLine."Source No.", WhseReceiptLine."Source Line No.");
                                            TransferLine.SuspendStatusCheck(true);
                                            TransferLine.Validate(TransferLine."Receipt Date", CalcDate(ImportRoute."Transit Delay", "Actual Time of Arrival"));
                                            TransferLine.Modify();
                                        end;
                                    WhseReceiptLine."Source Document"::"Sales Return Order":
                                        begin
                                            SalesLine.Get(SalesLine."Document Type"::"Return Order", WhseReceiptLine."Source No.", WhseReceiptLine."Source Line No.");
                                            SalesLine.SuspendStatusCheck(true);
                                            SalesLine.Validate(SalesLine."Shipment Date", CalcDate(ImportRoute."Transit Delay", "Actual Time of Arrival"));
                                            SalesLine.Modify();
                                        end;
                                end;
                            until WhseReceiptLine.Next() = 0;
                end;
            end;
        }
        field(80019; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80020; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            DataClassification = CustomerContent;
        }
        field(80021; "Number of Pallets"; Integer)
        {
            Caption = 'Number of Pallets';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(80022; "Number of Exchange Pallets"; Integer)
        {
            Caption = 'Number of Exchange Pallets';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(80023; "Storage Date"; Date)
        {
            Caption = 'Storage Date';
            DataClassification = CustomerContent;
        }
        field(80024; "Pickup Shipping Agent"; Code[10])
        {
            Caption = 'Pickup Shipping Agent';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(80025; "Pickup Confirmation No."; Code[30])
        {
            Caption = 'Pickup Confirmation No.';
            DataClassification = CustomerContent;
        }
        field(80026; "Release Date"; Date)
        {
            Caption = 'Release Date';
            DataClassification = CustomerContent;
        }
        field(80027; "Pickup Date"; Date)
        {
            Caption = 'Pickup Date';
            DataClassification = CustomerContent;
        }
        field(80028; "Pickup Tracking No."; Code[30])
        {
            Caption = 'Pickup Tracking No.';
            DataClassification = CustomerContent;
        }
    }
    var
        EmptyRouteErr: label 'A Route must be defined';

    trigger OnAfterDelete()
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.SetRange("Table ID", Database::"Warehouse Receipt Header");
        DocAttachment.SetRange("No.", "No.");
        DocAttachment.DeleteAll(true);
    end;
}
