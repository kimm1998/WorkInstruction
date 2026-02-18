page 50541 "API AvgSalesTransCostDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'Average Sales Transport Cost';
    EntitySetCaption = 'Average Sales Transport Costs';
    EntityName = 'avgsalestranscost';
    EntitySetName = 'avgsalestranscosts';
    ODataKeyFields = SystemId;
    SourceTable = "AvgSalesTransCostDSF";
    Extensible = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(RepeaterGroup)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'SystemId';
                    Editable = false;
                }
                field(no; Rec."No")
                {
                    Caption = 'No';
                }
                field(itemcategory; Rec."ItemCategory")
                {
                    Caption = 'Item Category';
                }
                field(model; Rec."Model")
                {
                    Caption = 'Model';
                }
                field(market; Rec."Market")
                {
                    Caption = 'Market';
                }
                field(packagingcostun; Rec."PackagingCostUn")
                {
                    Caption = 'Packaging Cost Un.';
                }
                field(parcelshipmentcostun; Rec."ParcelShipmentCostUn")
                {
                    Caption = 'Parcel Shipment Cost Un.';
                }
                field(storagecostun; Rec."StorageCostUn")
                {
                    Caption = 'Storage Cost Un.';
                }
                field(handlingcostun; Rec."HandlingCostUn")
                {
                    Caption = 'Handling Cost Un.';
                }
                field(avghandlingshipcostun; Rec."AvgHandlingShipCostUn")
                {
                    Caption = 'Average Handling & Shipment Cost Un.';
                }
                field(avgltlshipmentcostun; Rec."AvgLtlShipmentCostUn")
                {
                    Caption = 'Average LTL Shipment Cost Un';
                }
            }
        }
    }
}
