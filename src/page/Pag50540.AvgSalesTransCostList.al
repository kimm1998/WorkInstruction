page 50540 "AvgSalesTransCostList"
{
    PageType = List;
    SourceTable = "AvgSalesTransCostDSF";
    Caption = 'Average Sales Transport Cost';
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(ItemCategory; Rec.ItemCategory)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field(Market; Rec.Market)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(PackagingCostUn; Rec.PackagingCostUn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the average packaging cost of the product for the chosen market. This amount is used in the ?Commercial Invoice? report to deduct the invoiced amount from the customs tariff.';
                }
                field(ParcelShipmentCostUn; Rec.ParcelShipmentCostUn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the average parcel shipment cost, from factory to warehouse, of the product for the chosen market. This amount is used in the ?Commercial Invoice? report to deduct the invoiced amount from the customs tariff.';
                }
                field(StorageCostUn; Rec.StorageCostUn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the average storage cost of the product for the chosen market. This amount is used in the ?Commercial Invoice? report to deduct the invoiced amount from the customs tariff.';
                }
                field(HandlingCostUn; Rec.HandlingCostUn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the average warehouse handling cost of the product for the chosen market. This amount is used in the ?Commercial Invoice? report to deduct the invoiced amount from the customs tariff.';
                }
                field(AvgHandlingShipCostUn; Rec.AvgHandlingShipCostUn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the average Handling and shipping cost from the production warehouse to the client location, of the product for the chosen market. This amount is used to calculate standard cost for product with Handling and Shipping Cost.';
                }
                field(AvgLtlShipmentCostUn; Rec.AvgLtlShipmentCostUn)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the average LTL shipping cost (Less Than TruckLoad) from the warehouse to the client location, of the product for the chosen market. This amount is used in the ?Commercial Invoice? report to deduct the invoiced amount from the customs tariff.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}
