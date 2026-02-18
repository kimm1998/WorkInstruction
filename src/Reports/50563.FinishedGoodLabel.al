report 50563 "ONT Finished Product Label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Finished Product Label";

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Entry Type" = filter(output));
            column(Serial_No_; "Serial No.") { }

            dataitem(Item; Item)
            {

                DataItemLink = "No." = field("Item No.");
                DataItemTableView = where("ONT Label Layout" = const("Finished Product"));
                DataItemLinkReference = "Item Ledger Entry";
                column(No_; "No.")
                {

                }
                column(Description; Description) { }
                column(Date; workdate()) { }
                column(Inventory; Inventory) { }
                column(Barcode; ItemNobarcode) { }
                column(ItemSerialBarcode; ItemSerialBarcode) { }
                column(SerialBarcode; SerialBarcode) { }
                column(UPCBarcode; UPCBarcode) { }
                column(CompanyAddressTxt; CompanyAddressTxt) { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

                    ItemNobarcode := BarcodeFontProvider.EncodeFont(Item."No.", BarcodeSymbology);



                    ItemSerialBarcode := BarcodeFontProvider.EncodeFont(Item."No." + "Item Ledger Entry"."Serial No.", BarcodeSymbology);
                    SerialBarcode := BarcodeFontProvider.EncodeFont("Item Ledger Entry"."Serial No.", BarcodeSymbology);
                    UPCBarcode := BarcodeFontProvider.EncodeFont(Item.GTIN, BarcodeSymbology);
                end;
            }
        }
    }

    rendering
    {
        layout("Finished Product Label")
        {
            Type = RDLC;
            LayoutFile = 'src/Reports/FinishedGoodLabel.rdl';
        }
    }
    trigger OnInitReport()
    var

    begin
        CompanyInfo.get();
        CompanyAddressTxt := CompanyInfo.Name + ' ' + CompanyInfo.Address + ' / ' + CompanyInfo.City + ' ' + CompanyInfo.County + ' / ' + GetCountryName() + ' / ' + CompanyInfo."Post Code";
    end;

    var
        ItemNobarcode: text[1024];
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeString: Text;
        ItemSerialBarcode: text[1024];
        SerialBarcode: text[1024];
        UPCBarcode: text[1024];

        CompanyInfo: Record "Company Information";
        CompanyAddressTxt: Text;



    local procedure GetCountryName(): text
    var
        CountryRegion: Record "Country/Region";
    begin
        if CountryRegion.get(CompanyInfo."Country/Region Code") then
            exit(CountryRegion.Name);
    end;
}