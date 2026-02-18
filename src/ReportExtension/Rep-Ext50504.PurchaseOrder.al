/// <summary>
/// Unknown Purchase Order (ID 81000) extends Record Purchase Order.
/// </summary>
reportextension 50504 "Purchase Order" extends "Purchase Order"
{
    RDLCLayout = './src/ReportExtension/PurchaseOrder.ReportExt.rdl';
    dataset
    {
        add("Purchase Header")
        {
            column(ONT_CompanyAddress1; CompanyAddress2[1]) { }
            column(ONT_CompanyAddress2; CompanyAddress2[2]) { }
            column(ONT_CompanyAddress3; CompanyAddress2[3]) { }
            column(ONT_CompanyAddress4; CompanyAddress2[4]) { }
            column(ONT_CompanyAddress5; CompanyAddress2[5]) { }
            column(ONT_CompanyAddress6; CompanyAddress2[6]) { }
            column(ONT_CompanyAddress7; CompanyAddress2[7]) { }
            column(ONT_CompanyAddress8; CompanyAddress2[8]) { }
            column(ONT_CompnyInfoPicture; CompnyInfo.Picture) { }
            column(ONT_ReportPrintDateCaption; ReportPrintDateCaption) { }
            column(ONT_ReportPrintDate; ReportPrintDate) { }
            column(ONT_SubtotalCaptionTxt; SubtotalCaptionTxt) { }
            column(ONT_TotalCaptionTxt; TotalCaptionTxt) { }
            column(ONT_PurchOrderNumCaption; PurchOrderNumCaptionLbl2) { }
            column(ONT_PurchOrderDateCaption; PurchOrderDateCaptionLbl2) { }

        }
        modify("Purchase Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                if "Currency Code" = '' then begin
                    GLSetup.Get();
                    GLSetup.TestField("LCY Code");
                    SubtotalCaptionTxt := StrSubstNo(SubtotalCaptionLbl2, GLSetup."LCY Code");
                    TotalCaptionTxt := StrSubstNo(TotalCaptionLbl2, GLSetup."LCY Code");
                end else begin
                    SubtotalCaptionTxt := StrSubstNo(SubtotalCaptionLbl2, "Currency Code");
                    TotalCaptionTxt := StrSubstNo(TotalCaptionLbl2, "Currency Code");

                end;

            end;
        }
        add("Purchase Line")
        {
            column(ONT_LineNoCaption; LineNoCaption) { }
            column(ONT_VendItemNoCaption; VendItemNoCaption) { }
            column(ONT_RevisionNoCaption; RevisionNoCaption) { }
            column(ONT_RequestedShipDateCaption; RequestedShipDateCaption) { }
            column(ONT_QuantityDueCaption; QuantityDueCaption) { }
            column(ONT_UnitOfMesureCaption; UnitOfMesureCaption) { }

            column(ONT_LineNoPurchLine; "Line No." / 10000) { }
            column(ONT_VendItemNoPurchLine; "Vendor Item No.") { }
            column(ONT_RevisionNoPurchLine; "Revision No.") { }
            column(ONT_RequestedShipDatePurchLine; "Requested Ship Date") { }
            column(ONT_QuantityDuPurchLine; Quantity - "Quantity Received") { }

            column(ONTItemNo; "No.") { }
        }
    }

    trigger OnPreReport()
    begin
        CompnyInfo.get();
        CompnyInfo.CalcFields(Picture);

        CompanyAddress2[1] := CompnyInfo.Name;
        CompanyAddress2[2] := CompnyInfo."Phone No." + '  ' + CompnyInfo."Fax No.";
        //CompanyAddress2[3] := CompnyInfo."Fax No.";
        CompanyAddress2[4] := CompnyInfo."Home Page";
        CompanyAddress2[5] := CompnyInfo.Address;
        CompanyAddress2[6] := CompnyInfo.City + ' / ' + CompnyInfo.County + ' / ' + CompnyInfo."Post Code";
        //CompanyAddress2[7] := CompnyInfo.County;
        //CompanyAddress2[8] := CompnyInfo."Post Code";

        ReportPrintDate := Today;
    end;

    Var
        CompnyInfo: record "Company Information";
        CompanyAddress2: array[8] of Text[100];
        ReportPrintDate: Date;
        LineNoCaption: Label 'Line No';
        VendItemNoCaption: Label 'Vendor Item No';
        RevisionNoCaption: Label 'Rev. No';
        RequestedShipDateCaption: Label 'Req. Ship date';
        QuantityDueCaption: Label 'Quantity Due';
        ReportPrintDateCaption: Label 'Printed on:';
        SubtotalCaptionLbl2: Label 'Total %1 HT:', Comment = '%1 Currency Code';
        SubtotalCaptionTxt: Text;
        TotalCaptionLbl2: Label 'Total: %1 TTC:', Comment = '%1 Currency Code';
        TotalCaptionTxt: Text;
        UnitOfMesureCaption: Label 'Unit of measure';
        PurchOrderNumCaptionLbl2: Label 'No :';
        PurchOrderDateCaptionLbl2: Label 'Date:';
}
