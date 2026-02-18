report 50500 "LP Label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "LB Label";

    dataset
    {
        dataitem("IWX LP Header"; "IWX LP Header")
        {
            RequestFilterFields = "No.", "Source Document", "Source No.";
            column(No_IWXLPHeader; "No.")
            {
            }

            // Barcode
            column(BarcodeFont; BarcodeFontFamily)
            {
            }
            column(LPBarcode; LPBarcode)
            {
            }

            // Pick to Prod. Order No.
            column(PickToProdOrderNo; "Pick to Prod. Order No.")
            {
            }

            dataitem("IWX LP Line"; "IWX LP Line")
            {
                DataItemLink = "License Plate No." = field("No.");

                column(Type_IWXLPLine; "Type")
                {
                }
                column(No_IWXLPLine; "No.")
                {
                }
                column(Description; Description)
                { }
                column(VariantCode_IWXLPLine; "Variant Code")
                {
                }
                column(Quantity_IWXLPLine; Quantity)
                {
                }
                column(QuantityBase_IWXLPLine; "Quantity (Base)")
                {
                }
                column(SerialNo_IWXLPLine; "Serial No.")
                {
                }
                column(LotNo_IWXLPLine; "Lot No.")
                {
                }
                column(UnitofMeasureCode_IWXLPLine; "Unit of Measure Code")
                {
                }

                // barcode
                column(LotNoBarcode; SerialNoBarcode)
                {
                }
                column(ItemBarcode; ItemBarcode)
                {
                }

                trigger OnAfterGetRecord()
                var
                    BarcodeHelper: Codeunit "Barcode Helper";
                begin
                    SerialNoBarcode := '';
                    if "Serial No." <> '' then
                        SerialNoBarcode := BarcodeHelper.EncodeProductionReport("Serial No.", BarcodeFontFamily);
                    ItemBarcode := BarcodeHelper.EncodeProductionReport("No.", BarcodeFontFamily);
                end;
            }

            trigger OnAfterGetRecord()
            var
                BarcodeHelper: Codeunit "Barcode Helper";
            begin
                LPBarcode := BarcodeHelper.EncodeProductionReport('%lp%' + "No.", BarcodeFontFamily);
            end;
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
            }
        }

        actions
        {

        }
    }

    rendering
    {
        layout("LB Label")
        {
            Type = RDLC;
            LayoutFile = 'Layouts/LbLabel.rdl';
        }
    }



    var
        BarcodeFontFamily: Text;
        LPBarcode: Text;
        SerialNoBarcode: Text;
        ItemBarcode: Text;
}