codeunit 50522 "Barcode Helper"
{
    var
        ManufacturingSetup: Record "Manufacturing Setup";
 
    procedure EncodeProductionReport(BarcodeString: Text; var FontFamily: Text): Text
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
    begin
        ManufacturingSetup.Get();
 
        // Declare the barcode provider using the barcode provider interface and enum
        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
 
        // Declare the font using the barcode symbology enum
        BarcodeSymbology := BarcodeSymbology::Code128;
 
        // Validate the input. This method is not available for 2D provider
        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
 
        // Encode the data string to the barcode font
        FontFamily := GetFontFamily(BarcodeSymbology);
        exit(BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology));
    end;
 
 
 
    procedure GetFontFamily(BarcodeSymbology: Enum "Barcode Symbology"): Text
    begin
 
        case BarcodeSymbology of
            BarcodeSymbology::Code39:
                exit('IDAutomationHC39M');
            BarcodeSymbology::Code128:
                exit('IDAutomationC128S');
        end;
    end;
 
}
 