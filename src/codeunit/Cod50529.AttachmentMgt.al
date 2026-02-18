codeunit 50529 "ONT Attachment Mgt"
{
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        Type: option " ","Sales",Cusotmer;
        LineNo: Integer;

        JrnlBatch: Code[20];
    begin
        case RecRef.Number of
            DATABASE::CpscCertificationDSF:
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
        CPSCCertificate: Record CpscCertificationDSF;
    // PQVendors: Record "OTG.Purchase Quote Vendors";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::CpscCertificationDSF:
                begin
                    RecRef.Open(DATABASE::CpscCertificationDSF);

                    // AttachmentEntry.setrange("Record No.", DocumentAttachment."No.");
                    // AttachmentEntry.SetRange("Line No.", DocumentAttachment."OTG Line No.");
                    // AttachmentEntry.SetRange(Type, DocumentAttachment."OTG.Attachment Type");
                    // if AttachmentEntry.FindFirst() then
                    if CPSCCertificate.get(DocumentAttachment."No.") then
                        RecRef.GetTable(CPSCCertificate);
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
            DATABASE::CpscCertificationDSF:
                begin
                    FieldRefRecNo := RecRef.Field(1);
                    RecordNo := FieldRefRecNo.Value;
                    DocumentAttachment.SetRange("No.", RecordNo);
                    DocumentAttachment.SetRange("Line No.", 0);
                    FlowFieldsEditable := false;
                end;

        end;
    end;
}