report 50501 "Component Label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Component Label";
    Permissions = tabledata "Purch. Rcpt. Line" = rimd;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            column(No_; "No.")
            { }
            column(Description; Description)
            { }

            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Order No." = field("Document No."), "Order Line No." = field("Line No.");
                column(VendorDesc; VendorDesc)
                {

                }

                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");
                    column(Quantity; Quantity)
                    { }
                    column(Serial_No_; "Serial No.")
                    { }
                    column(Posting_Date; "Posting Date")
                    { }
                    column(ItemBarcode; ItemBarcode)
                    { }
                    trigger OnAfterGetRecord()
                    var
                        BarcodeHelper: Codeunit "Barcode Helper";
                    begin
                        ItemBarcode := '';
                        if "Item Ledger Entry"."Serial No." <> '' then
                            ItemBarcode := BarcodeHelper.EncodeProductionReport("Item Ledger Entry"."Serial No.", BarcodeFontFamily)
                        else
                            CurrReport.Skip();
                    end;
                }
                dataitem("Item Ledger Entry1"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = field("Prod. Order No."), "Posting Date" = field("Posting Date"), "Item No." = field("No.");
                    column(Quantity1; Quantity)
                    { }
                    column(Serial_No_1; "Serial No.")
                    { }
                    column(Posting_Date1; "Posting Date")
                    { }
                    column(ItemBarcode1; ItemBarcode)
                    { }
                    trigger OnAfterGetRecord()
                    var
                        BarcodeHelper: Codeunit "Barcode Helper";
                    begin
                        ItemBarcode := '';
                        if "Item Ledger Entry1"."Serial No." <> '' then
                            ItemBarcode := BarcodeHelper.EncodeProductionReport("Item Ledger Entry1"."Serial No.", BarcodeFontFamily)
                        else
                            CurrReport.Skip();
                    end;
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetRange("Label Printed", false);

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    "Purch. Rcpt. Line"."Label Printed" := true;
                    "Purch. Rcpt. Line".Modify();
                    VendorDesc := '';
                    ItemVendor.Reset();
                    ItemVendor.SetRange("Item No.", "No.");
                    ItemVendor.SetRange("Vendor No.", "Buy-from Vendor No.");
                    if ItemVendor.FindFirst() then
                        VendorDesc := ItemVendor."Vendor Item No.";

                end;
            }


        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {

        }
    }

    rendering
    {
        layout("Component Label")
        {
            Type = RDLC;
            LayoutFile = 'Layouts/ComponentLabel.rdl';
        }
    }

    var
        ItemBarcode: Text;
        BarcodeFontFamily: Text;
        myInt: Integer;
        ItemVendor: Record "Item Vendor";
        VendorDesc: text;
}