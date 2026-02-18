codeunit 50567 "OTG.Attachement Management"
{

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        Type: option " ","Sales",Customer;
        LineNo: Integer;

        JrnlBatch: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Warehouse Shipment Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);

                end;





        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        FieldVal: code[20];
        lrecProductionOrder: Record "Production Order";
        WhseShipment: Record "Warehouse Shipment Header";
        WhseRcpt: Record "Warehouse Receipt Header";
        ItemJrnlLine: Record "Item Journal Line";
    // PQVendors: Record "OTG.Purchase Quote Vendors";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Warehouse Receipt Header":

                begin

                    RecRef.Open(Database::"Warehouse Shipment Header");

                    if WhseRcpt.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(WhseRcpt);

                end;


        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean);
    var
        FieldRefRecNo: FieldRef;
        FieldRefType: FieldRef;
        FieldRefLineNo: FieldRef;
        checkListNo: Code[20];
        Type: option " ",Sales,Customer;
        RecordNo: code[20];
        LineNo: Integer;
        FieldRef: FieldRef;
        RecNo: Code[20];
        JrnlBatch: Code[20];
    begin
        case RecRef.Number of

            Database::"Warehouse Shipment Header":
                begin
                    FieldRefRecNo := RecRef.Field(1);
                    RecordNo := FieldRefRecNo.Value;
                    DocumentAttachment.SetRange("No.", RecordNo);
                    DocumentAttachment.SetRange("Line No.", 0);

                end;
        end;
    end;


    // Add Field to IWX App

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"IWX DocXtender", 'OnGetCustomRecRefFromDocAttachment', '', false, false)]
    local procedure OnGetCustomRecRefFromDocAttachmentDocXtender(precDocumentAttachment: Record "Document Attachment"; var prrRecordRef: RecordRef; var lbRecordRefHandled: Boolean);
    var


        WhseShipment: Record "Warehouse Shipment Header";
        Val: code[20];
    begin
        if not lbRecordRefHandled then begin
            case precDocumentAttachment."Table ID" of
                Database::"Warehouse Shipment Header":
                    begin
                        prrRecordRef.Open(Database::"Warehouse Shipment Header");
                        if WhseShipment.Get(precDocumentAttachment."No.") then begin
                            prrRecordRef.GetTable(WhseShipment);
                            lbRecordRefHandled := true;
                        end;
                    end;
            end
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"IWX DocXtender", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRefDocXtender(var precDocumentAttachment: Record "Document Attachment"; var prrRecordRef: RecordRef);
    var
        lfrFieldRef: FieldRef;
        lcodRecNo: Code[20];

    begin

        case prrRecordRef.Number of
            Database::"Warehouse Shipment Header":

                begin
                    lfrFieldRef := prrRecordRef.Field(1);
                    lcodRecNo := lfrFieldRef.Value;
                    precDocumentAttachment.SetRange("No.", lcodRecNo);
                    precDocumentAttachment.SetRange("Line No.", 0);
                end;


        end;
    end;



    var
}
