reportextension 50502 "ONT Purchase Credit Memo NA" extends "Purchase Credit Memo NA"
{
    RDLCLayout = './src/ReportExtension/PurchaseCreditMemoNA.ReportExt.rdl';
    dataset
    {
        add("Purch. Cr. Memo Hdr.")
        {
            column(ONT_CompanyAddress1; CompanyAddr2[1]) { }
            column(ONT_CompanyAddress2; CompanyAddr2[2]) { }
            column(ONT_CompanyAddress3; CompanyAddr2[3]) { }
            column(ONT_CompanyAddress4; CompanyAddr2[4]) { }
            column(ONT_CompanyAddress5; CompanyAddr2[5]) { }
            column(ONT_CompnyInfoPicture; CompnyInfo.Picture) { }
        }
        add(PageLoop)
        {
            column(ONTSalesPurchPersonPhoneNoCaption; PhoneNoCaption) { }
            column(ONTSalesPurchPersonEmailCaption; EmailCaption) { }
            column(ONTSalesPurchPersonPhoneNo; SalesPurchasePerson."Phone No.") { }
            column(ONTSalesPurchPersonEmail; SalesPurchasePerson."E-Mail") { }
        }
        modify("Purch. Cr. Memo Hdr.")
        {
            trigger OnAfterAfterGetRecord()
            begin
                if "Purchaser Code" = '' then
                    Clear(SalesPurchasePerson)
                else
                    SalesPurchasePerson.Get("Purchaser Code");
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompnyInfo.get();
        CompnyInfo.CalcFields(Picture);

        CompanyAddr2[1] := CompnyInfo.Name;
        CompanyAddr2[2] := CompnyInfo."Phone No." + '  ' + CompnyInfo."Fax No.";
        CompanyAddr2[3] := CompnyInfo."Home Page";
        CompanyAddr2[4] := CompnyInfo.Address;
        CompanyAddr2[5] := CompnyInfo.City + ' / ' + CompnyInfo.County + ' / ' + CompnyInfo."Post Code";
    end;

    var
        SalesPurchasePerson: Record "Salesperson/Purchaser";
        CompnyInfo: record "Company Information";
        CompanyAddr2: array[8] of Text[100];
        PhoneNoCaption: Label 'Phone No :';
        EmailCaption: Label 'E-mail :';
}
