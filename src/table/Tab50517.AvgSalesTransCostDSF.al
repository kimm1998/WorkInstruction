table 50517 "AvgSalesTransCostDSF"
{
    TableType = Normal;
    Caption = 'Average Sales Transport Cost';
    LookupPageId = 50540;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; ItemCategory; Code[20])
        {
            Caption = 'Item Category';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category".Code;
        }
        field(3; Model; Code[20])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;
            TableRelation = ModelDSF."No.";
        }
        field(4; Market; Code[10])
        {
            Caption = 'Market';
            DataClassification = ToBeClassified;
            TableRelation = "ONT HS Market".Code;
        }
        field(5; PackagingCostUn; Decimal)
        {
            Caption = 'Packaging Cost Un.';
            DataClassification = ToBeClassified;
        }
        field(6; ParcelShipmentCostUn; Decimal)
        {
            Caption = 'Parcel Shipment Cost Un.';
            DataClassification = ToBeClassified;
        }
        field(7; StorageCostUn; Decimal)
        {
            Caption = 'Storage Cost Un.';
            DataClassification = ToBeClassified;
        }
        field(8; HandlingCostUn; Decimal)
        {
            Caption = 'Handling Cost Un.';
            DataClassification = ToBeClassified;
        }
        field(9; AvgHandlingShipCostUn; Decimal)
        {
            Caption = 'Average Handling & Shipment Cost Un.';
            DataClassification = ToBeClassified;
        }
        field(10; AvgLtlShipmentCostUn; Decimal)
        {
            Caption = 'Average LTL Shipment Cost Un';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Setup: Record "SetupDSF";
        IsHandled: Boolean;
        NoSeriesMgt: Codeunit "No. Series";
        NewNoSeries: Code[20];
    begin
        IsHandled := false;
        OnBeforeInsert(Rec, IsHandled);
        if IsHandled then exit;
        if Rec."No" = '' then begin
            Setup.Get();
            Setup.TestField("AvgSalesTransCost_Number");
            // NoSeriesMgt.InitSeries(Setup.AvgSalesTransCost_Number, '', 0D, No, NewNoSeries);
            NoSeriesMgt.AreRelated(Setup.AvgSalesTransCost_Number, NewNoSeries);
        end;
    end;

    local procedure OnBeforeInsert(var Rec: Record "AvgSalesTransCostDSF"; var IsHandled: Boolean)
    begin
    end;
}
