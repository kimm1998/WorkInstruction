
reportextension 50503 "Sales Order" extends "Sales Order"
{
    RDLCLayout = './src/ReportExtension/SalesOrder.ReportExt.rdl';
    dataset
    {
        add("Sales Header")
        {
            column(ONT_CompanyAddress1; CompanyAddr2[1]) { }
            column(ONT_CompanyAddress2; CompanyAddr2[2]) { }
            column(ONT_CompanyAddress3; CompanyAddr2[3]) { }
            column(ONT_CompanyAddress4; CompanyAddr2[4]) { }
            column(ONT_CompanyAddress5; CompanyAddr2[5]) { }
            column(ONT_CompanyInfoPicture; CompanyInfo.Picture) { }
            column(ONT_Sales_Order_Type_Caption; FieldCaption("Sales Order Type")) { }
            column(ONT_Sales_Order_Type; "Sales Order Type") { }
            column(ONT_Currency_Code; "Currency Code") { }
            column(ONT_Invoice_Discount_Lbl; InvoiceDiscountLbl) { }
            column(ONT_Due_Date_Caption; FieldCaption("Due Date")) { }
            column(ONT_Due_Date; "Due Date") { }
            column(ONT_GST_No_Lbl; GSTNoLbl) { }
            column(ONT_Order_No_Lbl; OrderNoLbl) { }
            column(ONT_Document_Date_Lbl; DocumentDateLbl) { }
            column(ONT_Document_Comment; DocumentComment) { }
        }
        add(SalesLine)
        {
            column(ONT_Item_Reference_No_Lbl; ItemReferenceNoLbl) { }
            column(ONT_Line_Discount_Amount_Lbl; LineDiscountAmountLbl) { }
            column(ONT_Item_GTIN_Lbl; GTINLbl) { }
            column(ONT_Unit_Lbl; UnitLbl) { }
            column(ONT_Item_Reference_No_; TempSalesLine2."Item Reference No.") { }
            column(ONT_Line_Discount_Amount; TempSalesLine2."Line Discount Amount") { }
            column(ONT_Item_GTIN; Item.GTIN) { }
        }
        modify(SalesLine)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                OnLineNumber2 := OnLineNumber2 + 1;
                if OnLineNumber2 = 1 then
                    TempSalesLine2.Find('-')
                else
                    TempSalesLine2.Next();
                if Item.Get(TempSalesLine2."No.") then;
            end;

            trigger OnBeforePreDataItem()
            begin
                TempSalesLine2.Reset();
                NumberOfLines2 := TempSalesLine2.Count();
                SetRange(Number, 1, NumberOfLines2);
                OnLineNumber2 := 0;
            end;
        }
        modify("Sales Line")
        {
            trigger OnAfterAfterGetRecord()
            begin
                TempSalesLine2 := "Sales Line";
                TempSalesLine2.Insert();
            end;

            trigger OnAfterPreDataItem()
            begin
                TempSalesLine2.Reset();
                TempSalesLine2.DeleteAll();
            end;
        }
        modify("Sales Header")
        {
            trigger OnAfterAfterGetRecord()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Sales Header"."Sell-to Customer No.") then
                    DocumentComment := GetEcoFeesComment(Customer);
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        CompanyAddr2[1] := CompanyInfo.Name;
        CompanyAddr2[2] := CompanyInfo."Phone No." + '  ' + CompanyInfo."Fax No.";
        CompanyAddr2[3] := CompanyInfo."Home Page";
        CompanyAddr2[4] := CompanyInfo.Address;
        CompanyAddr2[5] := CompanyInfo.City + ' / ' + CompanyInfo.County + ' / ' + CompanyInfo."Post Code";
    end;

    procedure GetEcoFeesComment(var Customer: Record Customer) Result: Text[1024]
    var
        EcoRec: Record "Document Comment";
        LangCode: Code[10];
    begin
        LangCode := Customer."Language Code";

        EcoRec.Reset();
        EcoRec.SetRange("Language Code", LangCode);
        EcoRec.SetRange("Object Type", EcoRec."Object Type"::EcoFees);

        if EcoRec.FindFirst() then
            exit(EcoRec.Comment);

        exit('');
    end;

    // procedure GetEcoFeesCommentByLanguage(LanguageCode: Code[10]) Result: Text[1024]
    // var
    //     EcoRec: Record "Document Comment";
    // begin
    //     EcoRec.Reset();
    //     EcoRec.SetRange("Language Code", LanguageCode);
    //     EcoRec.SetRange("Object Type", EcoRec."Object Type"::EcoFees);

    //     if EcoRec.FindFirst() then
    //         exit(EcoRec.Comment);

    //     exit('');
    // end;

    var
        CompanyInfo: record "Company Information";
        TempSalesLine2: Record "Sales Line" temporary;
        Item: Record Item;
        CompanyAddr2: array[8] of Text[100];
        NumberOfLines2: Integer;
        OnLineNumber2: Integer;
        PONoLbl: Label 'PO No.';
        VatRegistrationNoLbl: Label 'Vat Registration No. (GTS No.)';
        ItemReferenceNoLbl: Label 'Cust. Item No.';
        LineDiscountAmountLbl: Label 'Line Discount';
        UnitLbl: Label 'Unit';
        GTINLbl: Label 'GTIN';
        InvoiceDiscountLbl: Label 'Esc Total :';
        GSTNoLbl: Label 'GST No.';
        OrderNoLbl: Label 'Order No.';
        DocumentDateLbl: Label 'Document Date';
        DocumentComment: Text;
}
