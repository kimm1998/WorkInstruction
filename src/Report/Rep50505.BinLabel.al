report 50505 "Bin Label"
{
    ApplicationArea = All;
    Caption = 'Bin Label';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/BinLabelReport.rdl';

    dataset
    {
        dataitem(Bin; Bin)
        {
            DataItemTableView = sorting("Code");
            RequestFilterFields = "Location Code", "Code";

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(Location_Code; Bin."Location Code")
                    {
                    }
                    column(Bin_Code; Bin."Code")
                    {
                    }
                    column(EncodedText; EncodedText)
                    {
                    }
                    column(Outputno; OutputNo)
                    {
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText:=FormatDocument.GetCOPYText();
                        OutputNo+=1;
                    end;
                end;
                trigger OnPreDataItem();
                begin
                    NoOfLoops:=ABS(NoOfCopies) + 1;
                    CopyText:='';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                BarcodeString: Code[50];
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                BarcodeFontProvider:=Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology:=Enum::"Barcode Symbology"::Code39;
                BarcodeString:=Bin.Code;
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                EncodedText:=BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    ShowCaption = false;

                    field(No_Of_Copies; NoOfCopies)
                    {
                        Caption = 'Copies';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var FormatDocument: Codeunit "Format Document";
    EncodedText: Text;
    CopyText: Text[30];
    OutputNo: Integer;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
}
