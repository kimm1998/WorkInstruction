xmlport 50501 "Export Product Data"
{
    Caption = 'Export Product Data';
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Headers; "Integer")
            {
                SourceTableView = where(Number = const(1));


                textelement(ItemNoHdr)
                {
                }
                textelement(ItemCategoryCodeHdr)
                {
                }
                textelement(BrandItemAttributeValueHdr)
                {
                }
                textelement(ApparelCatItemAttributeValueHdr)
                {
                }
                textelement(ApparelColectionItemAttributeValueHdr)
                {
                }
                textelement(ApparelExperienceItemAttributeValueHdr)
                {
                }
                textelement(ApparelMaterialItemAttributeValueHdr)
                {
                }
                textelement(ArticleModelItemAttributeValueHdr)
                {
                }
                textelement(MaterielItemAttributeValueHdr)
                {
                }
                textelement(PositionItemAttributeValueHdr)
                {
                }
                textelement(MontageTypeItemAttributeValueHdr)
                {
                }
                textelement(WidthItemAttributeValueHdr)
                {
                }
                textelement(AttachPointItemAttributeValueHdr)
                {
                }
                textelement(PowerSupplyItemAttributeValueHdr)
                {
                }
                textelement(LumensOutputItemAttributeValueHdr)
                {
                }
                textelement(IPXProtectionItemAttributeValueHdr)
                {
                }
                textelement(BBShellTypeItemAttributeValueHdr)
                {
                }
                textelement(IDSeatCollarItemAttributeValueHdr)
                {
                }
                textelement(DropperPostCompItemAttributeValueHdr)
                {
                }
                textelement(SeatpostItemAttributeValueHdr)
                {
                }
                textelement(ShisLowerItemAttributeValueHdr)
                {
                }
                textelement(ShisUpperItemAttributeValueHdr)
                {
                }
                textelement(SusprensionSystemItemAttributeValueHdr)
                {
                }
                textelement(BearingTypeItemAttributeValueHdr)
                {
                }
                textelement(MainLocationItemAttributeValueHdr)
                {
                }
                textelement(CapacityItemAttributeValueHdr)
                {
                }
                textelement(ColorGroupItemAttributeValueHdr)
                {
                }
                textelement(FrameMaterialItemAttributeValueHdr)
                {
                }
                textelement(ItemAttribute177ValueHdr)
                {
                }
                textelement(TailleItemAttributeValueHdr)
                {
                }
                textelement(TailleVetementItemAttributeValueHdr)
                {
                }
                textelement(WHeelSizeItemAttributeValueHdr)
                {
                }
                textelement(OldArriereItemAttributeValueHdr)
                {
                }
                textelement(OldAvantItemAttributeValueHdr)
                {
                }
                textelement(ShisBasItemAttributeValueHdr)
                {
                }
                textelement(ShisHautItemAttributeValueHdr)
                {
                }
                textelement(TypeDeMontageemAttributeValueHdr)
                {
                }
            }
            tableelement(Item; Item)
            {
                SourceTableView = where("TINX Publish to Webshop" = const(true)); //PBI#28100

                fieldelement(No; Item."No.")
                {
                }
                fieldelement(ItemCategoryCode; Item."Item Category Code")
                {
                }
                textelement(BrandItemAttributeValue)
                {
                }
                textelement(ApparelCatItemAttributeValue)
                {
                }
                textelement(ApparelColectionItemAttributeValue)
                {
                }
                textelement(ApparelExperienceItemAttributeValue)
                {
                }
                textelement(ApparelMaterialItemAttributeValue)
                {
                }
                textelement(ArticleModelItemAttributeValue)
                {
                }
                textelement(MaterielItemAttributeValue)
                {
                }
                textelement(PositionItemAttributeValue)
                {
                }
                textelement(MontageTypeItemAttributeValue)
                {
                }
                textelement(WidthItemAttributeValue)
                {
                }
                textelement(AttachPointItemAttributeValue)
                {
                }
                textelement(PowerSupplyItemAttributeValue)
                {
                }
                textelement(LumensOutputItemAttributeValue)
                {
                }
                textelement(IPXProtectionItemAttributeValue)
                {
                }
                textelement(BBShellTypeItemAttributeValue)
                {
                }
                textelement(IDSeatCollarItemAttributeValue)
                {
                }
                textelement(DropperPostCompItemAttributeValue)
                {
                }
                textelement(SeatpostItemAttributeValue)
                {
                }
                textelement(ShisLowerItemAttributeValue)
                {
                }
                textelement(ShisUpperItemAttributeValue)
                {
                }
                textelement(SusprensionSystemItemAttributeValue)
                {
                }
                textelement(BearingTypeItemAttributeValue)
                {
                }
                textelement(MainLocationItemAttributeValue)
                {
                }
                textelement(CapacityItemAttributeValue)
                {
                }
                textelement(ColorGroupItemAttributeValue)
                {
                }
                textelement(FrameMaterialItemAttributeValue)
                {
                }
                textelement(ItemAttribute177Value)
                {
                }
                textelement(TailleItemAttributeValue)
                {
                }
                textelement(TailleVetementItemAttributeValue)
                {
                }
                textelement(WHeelSizeItemAttributeValue)
                {
                }
                textelement(OldArriereItemAttributeValue)
                {
                }
                textelement(OldAvantItemAttributeValue)
                {
                }
                textelement(ShisBasItemAttributeValue)
                {
                }
                textelement(ShisHautItemAttributeValue)
                {
                }
                textelement(TypeDeMontageemAttributeValue)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(BrandItemAttributeValue);
                    Clear(ApparelCatItemAttributeValue);
                    Clear(ApparelColectionItemAttributeValue);
                    Clear(ApparelExperienceItemAttributeValue);
                    Clear(ApparelMaterialItemAttributeValue);
                    Clear(ArticleModelItemAttributeValue);
                    Clear(MaterielItemAttributeValue);
                    Clear(PositionItemAttributeValue);
                    Clear(MontageTypeItemAttributeValue);
                    Clear(WidthItemAttributeValue);
                    Clear(AttachPointItemAttributeValue);
                    Clear(PowerSupplyItemAttributeValue);
                    Clear(LumensOutputItemAttributeValue);
                    Clear(IPXProtectionItemAttributeValue);
                    Clear(BBShellTypeItemAttributeValue);
                    Clear(IDSeatCollarItemAttributeValue);
                    Clear(DropperPostCompItemAttributeValue);
                    Clear(SeatpostItemAttributeValue);
                    Clear(ShisLowerItemAttributeValue);
                    Clear(ShisUpperItemAttributeValue);
                    Clear(SusprensionSystemItemAttributeValue);
                    Clear(BearingTypeItemAttributeValue);
                    Clear(MainLocationItemAttributeValue);
                    Clear(CapacityItemAttributeValue);
                    Clear(ColorGroupItemAttributeValue);
                    Clear(FrameMaterialItemAttributeValue);
                    Clear(ItemAttribute177Value);
                    Clear(TailleItemAttributeValue);
                    Clear(TailleVetementItemAttributeValue);
                    Clear(WHeelSizeItemAttributeValue);
                    Clear(OldArriereItemAttributeValue);
                    Clear(OldAvantItemAttributeValue);
                    Clear(ShisBasItemAttributeValue);
                    Clear(ShisHautItemAttributeValue);
                    Clear(TypeDeMontageemAttributeValue);

                    if not Item."TINX Publish to Webshop" then
                        currXMLport.Skip();

                    ItemAttribute.Reset();
                    ItemAttribute.SetFilter(ID, '38|76|77|75|173|86|21|69|119|74|144|149|145|147|39|53|51|52|31|30|68|153|54|85|14|175|177|8|178|60|18|17|33|32|50');
                    if ItemAttribute.FindSet() then
                        repeat
                            if (ItemAttribute.Type = ItemAttribute.Type::Option) and (not TempItemAttribute.Get(ItemAttribute.ID)) then begin
                                TempItemAttribute.Init();
                                TempItemAttribute.TransferFields(ItemAttribute);
                                TempItemAttribute.Insert();
                            end;
                        until ItemAttribute.Next() = 0;

                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 38);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            BrandItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 76);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ApparelCatItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 77);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ApparelColectionItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 75);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ApparelExperienceItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 173);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ApparelMaterialItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 86);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ArticleModelItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 21);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            MaterielItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 69);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            PositionItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 119);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            MontageTypeItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 74);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            WidthItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 144);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            AttachPointItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 149);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            PowerSupplyItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 145);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            LumensOutputItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 147);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            IPXProtectionItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 39);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            BBShellTypeItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 53);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            IDSeatCollarItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 51);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            DropperPostCompItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 52);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            SeatpostItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 31);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ShisLowerItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 30);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ShisUpperItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 68);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            SusprensionSystemItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 153);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            BearingTypeItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 54);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            MainLocationItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 85);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            CapacityItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 14);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ColorGroupItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 175);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            FrameMaterialItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 177);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ItemAttribute177Value := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 8);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            TailleItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 178);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            TailleVetementItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 60);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            WHeelSizeItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 18);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            OldArriereItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 17);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            OldAvantItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 33);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ShisBasItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 32);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            ShisHautItemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                    ItemAttributeValueMapping.Reset();
                    ItemAttributeValueMapping.SetRange("No.", Item."No.");
                    ItemAttributeValueMapping.SetRange("Table ID", 27);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", 50);
                    if ItemAttributeValueMapping.FindFirst() then begin
                        ItemAttributeValue.Reset();
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                        ItemAttributeValue.SetRange(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                        if ItemAttributeValue.FindFirst() then
                            TypeDeMontageemAttributeValue := Format(ItemAttributeValue.ID);
                    end;
                end;
            }
        }
    }


    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort();
    begin
        ItemNoHdr := ItemNoHdrLbl;
        ItemCategoryCodeHdr := ItemCategoryCodeHdrLbl;
        BrandItemAttributeValueHdr := BrandItemAttributeValueHdrLbl;
        ApparelCatItemAttributeValueHdr := ApparelCatItemAttributeValueHdrLbl;
        ApparelColectionItemAttributeValueHdr := ApparelColectionItemAttributeValueHdrLbl;
        ApparelExperienceItemAttributeValueHdr := ApparelExperienceItemAttributeValueHdrLbl;
        ApparelMaterialItemAttributeValueHdr := ApparelMaterialItemAttributeValueHdrLbl;
        ArticleModelItemAttributeValueHdr := ArticleModelItemAttributeValueHdrLbl;
        MaterielItemAttributeValueHdr := MaterielItemAttributeValueHdrLbl;
        PositionItemAttributeValueHdr := PositionItemAttributeValueHdrLbl;
        MontageTypeItemAttributeValueHdr := MontageTypeItemAttributeValueHdrLbl;
        WidthItemAttributeValueHdr := WidthItemAttributeValueHdrLbl;
        AttachPointItemAttributeValueHdr := AttachPointItemAttributeValueHdrLbl;
        PowerSupplyItemAttributeValueHdr := PowerSupplyItemAttributeValueHdrLbl;
        LumensOutputItemAttributeValueHdr := LumensOutputItemAttributeValueHdrLbl;
        IPXProtectionItemAttributeValueHdr := IPXProtectionItemAttributeValueHdrLbl;
        BBShellTypeItemAttributeValueHdr := BBShellTypeItemAttributeValueHdrLbl;
        IDSeatCollarItemAttributeValueHdr := IDSeatCollarItemAttributeValueHdrLbl;
        DropperPostCompItemAttributeValueHdr := DropperPostCompItemAttributeValueHdrLbl;
        SeatpostItemAttributeValueHdr := SeatpostItemAttributeValueHdrLbl;
        ShisLowerItemAttributeValueHdr := ShisLowerItemAttributeValueHdrLbl;
        ShisUpperItemAttributeValueHdr := ShisUpperItemAttributeValueHdrLbl;
        SusprensionSystemItemAttributeValueHdr := SusprensionSystemItemAttributeValueHdrLbl;
        BearingTypeItemAttributeValueHdr := BearingTypeItemAttributeValueHdrLbl;
        MainLocationItemAttributeValueHdr := MainLocationItemAttributeValueHdrLbl;
        CapacityItemAttributeValueHdr := CapacityItemAttributeValueHdrLbl;
        ColorGroupItemAttributeValueHdr := ColorGroupItemAttributeValueHdrLbl;
        FrameMaterialItemAttributeValueHdr := FrameMaterialItemAttributeValueHdrLbl;
        ItemAttribute177ValueHdr := ItemAttribute177ValueHdrLbl;
        TailleItemAttributeValueHdr := TailleItemAttributeValueHdrLbl;
        TailleVetementItemAttributeValueHdr := TailleVetementItemAttributeValueHdrLbl;
        WHeelSizeItemAttributeValueHdr := WHeelSizeItemAttributeValueHdrLbl;
        OldArriereItemAttributeValueHdr := OldArriereItemAttributeValueHdrLbl;
        OldAvantItemAttributeValueHdr := OldAvantItemAttributeValueHdrLbl;
        ShisBasItemAttributeValueHdr := ShisBasItemAttributeValueHdrLbl;
        ShisHautItemAttributeValueHdr := ShisHautItemAttributeValueHdrLbl;
        TypeDeMontageemAttributeValueHdr := TypeDeMontageemAttributeValueHdrLbl;
    end;

    trigger OnPostXmlPort()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        ItemCategory: Record "Item Category";
        BlobStorageMgt: Codeunit "Blob Storage Mgt";
        TempBlob: Codeunit "Temp Blob";
        ExportAttributes: XmlPort "Export Attribute Data";
        ExportItemCategory: XmlPort "Export Item Category";
        AttributesOutStream: OutStream;
        AttributesInStream: InStream;
        FileNameLbl: Label 'Attributes_%1.csv';
    begin
        SalesSetup.Get();
        if TempItemAttribute.FindSet() then
            repeat
                Clear(AttributesInStream);
                Clear(AttributesOutStream);
                Clear(TempBlob);
                ItemAttributeValue.Reset();
                Clear(ExportAttributes);
                ItemAttributeValue.SetRange("Attribute ID", TempItemAttribute.ID);
                if ItemAttributeValue.FindSet() then;
                ExportAttributes.SetTableView(ItemAttributeValue);

                TempBlob.CreateOutStream(AttributesOutStream);
                ExportAttributes.SetDestination(AttributesOutStream);
                ExportAttributes.Export();
                TempBlob.CreateInStream(AttributesInStream);
                BlobStorageMgt.UploadfileintoContainers(AttributesInStream, StrSubstNo(FileNameLbl, TempItemAttribute.ID), SalesSetup."Attribute Folder Location");
            until TempItemAttribute.Next() = 0;
        Clear(AttributesOutStream);
        Clear(AttributesInStream);
        TempBlob.CreateOutStream(AttributesOutStream);
        ExportItemCategory.SetDestination(AttributesOutStream);
        ExportItemCategory.Export();
        TempBlob.CreateInStream(AttributesInStream);
        BlobStorageMgt.UploadfileintoContainers(AttributesInStream, StrSubstNo(FileNameLbl, ItemCategory.TableCaption), SalesSetup."Attribute Folder Location");
    end;

    var
        ItemAttribute: Record "Item Attribute";
        TempItemAttribute: Record "Item Attribute" temporary;
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValue: Record "Item Attribute Value";
        ItemNoHdrLbl: Label 'sku';
        ItemCategoryCodeHdrLbl: Label 'product_category_erp';
        BrandItemAttributeValueHdrLbl: Label 'brand';
        ApparelCatItemAttributeValueHdrLbl: Label 'Att. ID 76';
        ApparelColectionItemAttributeValueHdrLbl: Label 'Att. ID 77';
        ApparelExperienceItemAttributeValueHdrLbl: Label 'Att. ID 75';
        ApparelMaterialItemAttributeValueHdrLbl: Label 'Att. ID 173';
        ArticleModelItemAttributeValueHdrLbl: Label 'Att. ID 86';
        MaterielItemAttributeValueHdrLbl: Label 'Att. ID 21';
        PositionItemAttributeValueHdrLbl: Label 'Att. ID 69';
        MontageTypeItemAttributeValueHdrLbl: Label 'Att. ID 119';
        WidthItemAttributeValueHdrLbl: Label 'Att. ID 74';
        AttachPointItemAttributeValueHdrLbl: Label 'Att. ID 144';
        PowerSupplyItemAttributeValueHdrLbl: Label 'Att. ID 149';
        LumensOutputItemAttributeValueHdrLbl: Label 'Att. ID 145';
        IPXProtectionItemAttributeValueHdrLbl: Label 'Att. ID 147';
        BBShellTypeItemAttributeValueHdrLbl: Label 'Att. ID 39';
        IDSeatCollarItemAttributeValueHdrLbl: Label 'Att. ID 53';
        DropperPostCompItemAttributeValueHdrLbl: Label 'Att. ID 51';
        SeatpostItemAttributeValueHdrLbl: Label 'Att. ID 52';
        ShisLowerItemAttributeValueHdrLbl: Label 'Att. ID 31';
        ShisUpperItemAttributeValueHdrLbl: Label 'Att. ID 30';
        SusprensionSystemItemAttributeValueHdrLbl: Label 'Att. ID 68';
        BearingTypeItemAttributeValueHdrLbl: Label 'Att. ID 153';
        MainLocationItemAttributeValueHdrLbl: Label 'Att. ID 54';
        CapacityItemAttributeValueHdrLbl: Label 'Att. ID 85';
        ColorGroupItemAttributeValueHdrLbl: Label 'Att. ID 14';
        FrameMaterialItemAttributeValueHdrLbl: Label 'Att. ID 175';
        ItemAttribute177ValueHdrLbl: Label 'Att. ID 177';
        TailleItemAttributeValueHdrLbl: Label 'Att. ID 8';
        TailleVetementItemAttributeValueHdrLbl: Label 'Att. ID 178';
        WHeelSizeItemAttributeValueHdrLbl: Label 'Att. ID 60';
        OldArriereItemAttributeValueHdrLbl: Label 'Att. ID 18';
        OldAvantItemAttributeValueHdrLbl: Label 'Att. ID 17';
        ShisBasItemAttributeValueHdrLbl: Label 'Att. ID 33';
        ShisHautItemAttributeValueHdrLbl: Label 'Att. ID 32';
        TypeDeMontageemAttributeValueHdrLbl: Label 'Att. ID 50';
}

