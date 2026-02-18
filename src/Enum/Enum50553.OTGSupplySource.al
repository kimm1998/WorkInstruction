enum 50553 "OTG Supply Source"
{
    Extensible = true;

    value(0; OnHandILE) { Caption = 'On-hand (Item Ledger Entry)'; }
    value(1; PurchaseLine) { Caption = 'Purchase Order Line'; }
    value(2; TransferInboundLine) { Caption = 'Transfer Order Line (Inbound)'; }
    value(3; ProdOrderOutput) { Caption = 'Production Order Output (Expected)'; }
    value(9; Other) { Caption = 'Other'; }
}
