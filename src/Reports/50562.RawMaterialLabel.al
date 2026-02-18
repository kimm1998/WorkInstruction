report 50562 "ONT Raw Material Label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "Raw Material Label";

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where("ONT Label Layout" = const("Raw material"));
            column(No_; "No.")
            {

            }
            column(Description; Description) { }
            column(Date; workdate()) { }
            column(Inventory; Inventory) { }
            column(Barcode; Barcode) { }
            column(Vendor_Item_No_; "Vendor Item No.") { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;

                Barcode := BarcodeFontProvider.EncodeFont(Item."No.", BarcodeSymbology);

            end;
        }
    }


    rendering
    {
        layout("Raw Material Label")
        {
            Type = RDLC;
            LayoutFile = 'src/Reports/RawMaterial.rdl';
        }
    }

    var
        Barcode: text[1024];
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
}