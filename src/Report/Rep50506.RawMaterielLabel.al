report 50506 "Raw Materiel Label"
{
    Caption = 'Raw Materiel report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/RawMaterielLabelReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Permissions = tabledata "Item Reference" = R,
        tabledata Item = R;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            column(ItemDescription; Item.Description)
            {
            }
            column(VendorItemDescription; Item."Vendor Item No.")
            {
            }
            column(ItemCategoryCode; Item."Item Category Code")
            {
            }
            column(ItemNo_ItemReference; Item."No.")
            {
            }
            column(Barcode; Barcode)
            {
            }
            column(QtyLabel; QtyLabel)
            {
            }
            column(DescriptionLabel; DescriptionLabel)
            {
            }
            column(VendorDescriptionLabel; VendorDescriptionLabel)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(Outputno; OutputNo)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                BarcodeString: Code[50];
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code128;
                BarcodeString := Item."No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                Barcode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    ShowCaption = false;

                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'Copies';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        FormatDocument: Codeunit "Format Document";
        Barcode: Text;
        QtyLabel: Label 'QTy';
        DescriptionLabel: Label 'Description';
        VendorDescriptionLabel: Label 'Vendor Description';
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
}
