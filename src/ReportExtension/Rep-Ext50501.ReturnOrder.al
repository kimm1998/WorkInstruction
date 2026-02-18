
reportextension 50501 "Return Order" extends "Return Order"
{
    RDLCLayout = './src/ReportExtension/PurchaseReturnOrder.ReportExt.rdl';
    dataset
    {
        add("Purchase Header")
        {
            column(ONT_CompanyAddress1; CompanyAddr2[1]) { }
            column(ONT_CompanyAddress2; CompanyAddr2[2]) { }
            column(ONT_CompanyAddress3; CompanyAddr2[3]) { }
            column(ONT_CompanyAddress4; CompanyAddr2[4]) { }
            column(ONT_CompanyAddress5; CompanyAddr2[5]) { }
            column(ONT_CompnyInfoPicture; CompnyInfo.Picture) { }
            column(ONT_ReportPrintDateCaption; ReportPrintDateCaption) { }
            column(ONT_ReportPrintDate; ReportPrintDate) { }
        }
        add(RoundLoop)
        {
            column(ONT_VendItemNoCaption; VendItemNoCaption) { }
            column(ONT_RevisionNoCaption; RevisionNoCaption) { }
            column(ONT_RequestedShipDateCaption; RequestedShipDateCaption) { }
            column(ONT_VendItemNoPurchLine; "Purchase Line"."Vendor Item No.") { }
            column(ONT_RevisionNoPurchLine; "Purchase Line"."Revision No.") { }
            column(ONT_RequestedShipDatePurchLine; "Purchase Line"."Requested Ship Date") { }
        }
    }
    trigger OnPreReport()
    begin
        CompnyInfo.Get();
        CompnyInfo.CalcFields(Picture);

        CompanyAddr2[1] := CompnyInfo.Name;
        CompanyAddr2[2] := CompnyInfo."Phone No." + '  ' + CompnyInfo."Fax No.";
        CompanyAddr2[3] := CompnyInfo."Home Page";
        CompanyAddr2[4] := CompnyInfo.Address;
        CompanyAddr2[5] := CompnyInfo.City + ' / ' + CompnyInfo.County + ' / ' + CompnyInfo."Post Code";
        ReportPrintDate := Today;
    end;

    var
        CompnyInfo: record "Company Information";
        CompanyAddr2: array[8] of Text[100];
        ReportPrintDate: Date;
        ReportPrintDateCaption: Label 'Report Print Date:';
        VendItemNoCaption: Label 'Vendor Item No';
        RevisionNoCaption: Label 'Revision No';
        RequestedShipDateCaption: Label 'Requested Shipment Date';
}
