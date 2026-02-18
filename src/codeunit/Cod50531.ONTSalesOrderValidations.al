codeunit 50531 "ONT.Sales Order Validations"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        // Exit if we are just previewing (no actual release happening)
        if PreviewMode then
            exit;

        SalesHeader.TestField("Sales Order Type");
    end;

}