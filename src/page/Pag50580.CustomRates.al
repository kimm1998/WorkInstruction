page 50580 "Custom Rates"
{
    ApplicationArea = All;
    Caption = 'Custom Rates';
    PageType = List;
    SourceTable = "Custom Rate";
    UsageCategory = Lists;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = all;
                    Caption = 'Item No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Item: Record Item;
                        Itemlist: Page "Item list";
                        RecRef: RecordRef;
                    begin
                        Item.Reset();
                        Itemlist.SetTableView(Item);
                        Itemlist.LookupMode := true;
                        if Itemlist.RunModal() = ACTION::LookupOK then begin
                            Itemlist.SetSelectionFilter(Item);
                            RecRef.GetTable(Item);
                            Text := SelectionFilterManagement.GetSelectionFilter(RecRef, Item.FieldNo("No."));
                        end
                        else
                            exit(false);
                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        PageFilterOnAfterValidate();
                    end;
                }
                field(CountryRegionCodeFilter; CountryRegionCodeFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Country Region Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecCountryRegion: Record "Country/Region";
                        PageCountryRegion: Page "Countries/Regions";
                        RecRef: RecordRef;
                    begin
                        RecCountryRegion.Reset();
                        PageCountryRegion.SetTableView(RecCountryRegion);
                        PageCountryRegion.LookupMode := true;
                        if PageCountryRegion.RunModal() = ACTION::LookupOK then begin
                            PageCountryRegion.SetSelectionFilter(RecCountryRegion);
                            RecRef.GetTable(RecCountryRegion);
                            Text := SelectionFilterManagement.GetSelectionFilter(RecRef, RecCountryRegion.FieldNo(Code));
                        end
                        else
                            exit(false);
                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        PageFilterOnAfterValidate();
                    end;
                }
                field(TariffNoFilter; TariffNoFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Tariff No. Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecTariffNo: Record "Tariff Number";
                        PageTariffNo: Page "Tariff Numbers";
                        RecRef: RecordRef;
                    begin
                        RecTariffNo.Reset();
                        PageTariffNo.SetTableView(RecTariffNo);
                        PageTariffNo.LookupMode := true;
                        if PageTariffNo.RunModal() = ACTION::LookupOK then begin
                            PageTariffNo.SetSelectionFilter(RecTariffNo);
                            RecRef.GetTable(RecTariffNo);
                            Text := SelectionFilterManagement.GetSelectionFilter(RecRef, RecTariffNo.FieldNo("No."));
                        end
                        else
                            exit(false);
                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        PageFilterOnAfterValidate();
                    end;
                }
            }
            repeater(General)
            {
                field(Market; Rec."HS Market")
                {
                    ToolTip = 'Enter the market to which the harmonized code belongs.';
                    ApplicationArea = All;
                }
                field("Country/Region"; Rec."Country/Region")
                {
                    ToolTip = 'Enter the origin associated with the customs tariff of the item.';
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ToolTip = 'The first 6 digits of the universal harmonized code.';
                    ApplicationArea = All;
                }
                field("HS Code"; Rec."HS Code")
                {
                    ToolTip = 'The last 4 digits specific to the market, which classifies the item type for customs agents.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Custom Rate"; Rec."Custom Rate")
                {
                    ToolTip = 'Enter the customs rate applicable to the origin of the product and its classification.';
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                    ApplicationArea = All;
                }
                field("Trade Agreement"; Rec."Trade Agreement")
                {
                    ToolTip = 'Optional: Enter a reference about the trade agreement that defines this rate.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Enter the reference description from the customs document.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        GetRecFilters();
        SetRecFilters();
    end;

    local procedure GetRecFilters()
    begin
        if Rec.GetFilters <> '' then begin
            CountryRegionCodeFilter := Rec.GetFilter("Country/Region");
            TariffNoFilter := Rec.GetFilter("Tariff No.");
            ItemNo := Rec.GetFilter("Item No.");
        end;
    end;

    local procedure PageFilterOnAfterValidate()
    begin
        SetRecFilters();
    end;

    procedure SetRecFilters()
    begin
        if CountryRegionCodeFilter <> '' then
            Rec.SetFilter("Country/Region", CountryRegionCodeFilter)
        else
            Rec.SetRange("Country/Region");
        if TariffNoFilter <> '' then
            Rec.SetFilter("Tariff No.", TariffNoFilter)
        else
            Rec.SetRange("Tariff No.");
        if ItemNo <> '' then
            Rec.SetFilter("Item No.", ItemNo)
        else
            Rec.SetRange("Item No.");
        CurrPage.Update(false);
    end;

    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        CountryRegionCodeFilter: Text;
        TariffNoFilter: Text;
        ItemNo: Code[20];
}
