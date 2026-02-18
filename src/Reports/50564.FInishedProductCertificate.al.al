report 50564 "ONT Finished Good  Certificate"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Finished Product Cerificate";

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Entry Type" = filter(output));
            column(Serial_No_; "Serial No.") { }
            column(CompanyAddressTxt; CompanyAddressTxt) { }
            column(Posting_Date; "Posting Date") { }
            dataitem(Item; Item)
            {

                DataItemLink = "No." = field("Item No.");
                DataItemTableView = where("ONT Label Layout" = const("Finished Product"));
                DataItemLinkReference = "Item Ledger Entry";
                column(No_; "No.")
                {

                }
                // column(Description; Description) { }
                column(Date; workdate()) { }
                // column(Inventory; Inventory) { }
                // column(Barcode; ItemNobarcode) { }
                // column(ItemSerialBarcode; ItemSerialBarcode) { }
                // column(SerialBarcode; SerialBarcode) { }
                // column(UPCBarcode; UPCBarcode) { }
                // column(CompanyAddressTxt; CompanyAddressTxt) { }

                dataitem("Family Line"; "Family Line")
                {
                    DataItemLink = "Item No." = field("No.");
                    dataitem(Family; Family)
                    {
                        DataItemLink = "No." = field("Family No.");
                        dataitem(CpscCertificationDSF; CpscCertificationDSF)
                        {
                            DataItemLink = No = field(CpscCertificationNo);
                            column(No; No) { }
                            column(Description; Description) { }
                            column(ProductCategory; ProductCategory) { }
                            column(Standard; Standard) { }
                            column(CertificationDate; CertificationDate) { }
                            column(CertificationLocation; CertificationLocation) { }
                            column(ContactName; ContactName) { }
                            column(CertificationLabName; CertificationLabName) { }
                            dataitem(Vendor; Vendor)
                            {
                                DataItemLink = "No." = field(CertificationLabNo);
                                column(Name; Name) { }
                                column(Address; Address) { }
                                column(City; City) { }
                                column(Post_Code; "Post Code") { }
                                column(CountryName; GetCountryName) { }
                                // column(Phone_No_; "Phone No.") { }
                                // column(E_Mail; "E-Mail") { }
                                column(County; County) { }


                            }
                            dataitem(Contact; Contact)
                            {
                                DataItemLink = "No." = field(ContactNo);
                                column(Phone_No_; "Phone No.") { }
                                column(E_Mail; "E-Mail") { }
                            }
                        }
                    }
                }

            }
        }
    }

    rendering
    {
        layout("Finished Product Cerificate")
        {
            Type = RDLC;
            LayoutFile = 'src/Reports/FinishedProductCertificate.rdl';
        }
    }
    trigger OnInitReport()
    var

    begin
        CompanyInfo.get();
        CompanyAddressTxt := CompanyInfo.City + ', ' + CompanyInfo.County + ', ' + GetCountryName();
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
        if CountryRegion.get(Vendor."Country/Region Code") then
            exit(CountryRegion.Name);
    end;
}