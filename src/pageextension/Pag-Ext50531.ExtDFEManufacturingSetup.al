pageextension 50531 "ExtDFEManufacturingSetup" extends "Manufacturing Setup"
{
    layout
    {
        addafter(Planning)
        {
            group("Demand Forecast Setup")
            {
                field("Demand Forecast Name"; Rec."Demand Forecast Name")
                {
                    ApplicationArea = All;
                }
                field("Demand Forecast Starting Date"; Rec."Starting Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Demand Forecast Ending Date"; Rec."Ending Time Calculation")
                {
                    ApplicationArea = All;
                }

                field("Demand Forecast View By"; Rec."Demand Forecast View By")
                {
                    ApplicationArea = Planning;
                    Caption = 'View by';
                    ToolTip = 'Specifies the period of time for which amounts are displayed.';
                }
                field("Demand Forecast Location Code"; Rec."Demand Forecast Location Code")
                {
                    ApplicationArea = All;
                }

                field("Demand Forecast Type"; Rec."Demand Forecast Type")
                {
                    ApplicationArea = Planning;
                    Caption = 'Forecast Type';
                    ToolTip = 'Specifies whether the demand forecast entry is for a sales item or a component item. If you choose Sales Item, only sales orders net the forecast. If you choose Component Item, demand from production order components net the forecast.';

                }
                field("Location Filter"; LocationFilter)
                {
                    ApplicationArea = Planning;
                    Caption = 'Location Filter';
                    ToolTip = 'Specifies a location code if you want to create a forecast entry for a specific location.';
                    Importance = Additional;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(OnLookupLocationFilter(Text, LocationFilter));
                    end;

                    trigger OnValidate()
                    var
                        Location: Record Location;
                    begin
                        Location.SetFilter(Code, LocationFilter);
                        LocationFilter := Location.GetFilter(Code);
                        Rec.SetTextFilterToLocationBlob(LocationFilter);
                        Rec.Modify();
                    end;
                }
                field("Item Filter"; ItemFilter)
                {
                    ApplicationArea = Planning;
                    Caption = 'Item Filter';
                    ToolTip = 'Specifies a filter that will show specific items on the Demand Forecast Matrix FastTab. This reduces the number of entries on the FastTab.';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ItemFilterXMLText: Text;
                    begin

                        ItemFilterXMLText := ItemFilterDrillDown(Rec.GetItemFilterBlobAsText());
                        if ItemFilterXMLText <> '' then begin
                            Rec.SetTextFilterToItemFilterBlob(ItemFilterXMLText);
                            Rec.Modify();
                            ItemFilter := Rec.GetItemFilterAsDisplayText();
                        end;
                    end;
                }

            }


        }
    }


    trigger OnAfterGetRecord()
    begin
        ItemFilter := Rec.GetItemFilterAsDisplayText();
        LocationFilter := Rec.GetLocationFilterBlobAsText();
    end;


    local procedure ItemFilterDrillDown(ItemFilterBlobText: Text): Text
    var
        Item: Record Item;
        RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
        FilterPage: FilterPageBuilder;
        ItemCaptionTxt: Code[20];
    begin
        ItemCaptionTxt := CopyStr(Item.TableCaption(), 1, MaxStrLen(ItemCaptionTxt));
        RequestPageParametersHelper.BuildDynamicRequestPage(FilterPage, ItemCaptionTxt, Database::Item);
        RequestPageParametersHelper.SetViewOnDynamicRequestPage(FilterPage, ItemFilterBlobText, ItemCaptionTxt, Database::Item);
        FilterPage.PageCaption := ItemCaptionTxt;
        if not FilterPage.RunModal() then
            exit;
        exit(RequestPageParametersHelper.GetViewFromDynamicRequestPage(FilterPage, ItemCaptionTxt, Database::Item));
    end;

    local procedure OnLookupLocationFilter(var Text: Text; LocationFilterVal: Text): Boolean
    var
        Loc: Record Location;
        LocList: Page "Location List";
    begin
        Loc.SetRange("Use As In-Transit", false);
        LocList.SetTableView(Loc);

        Loc.SetFilter(Code, LocationFilterVal);
        if Loc.FindSet() then
            LocList.SetRecord(Loc);

        LocList.LookupMode(true);
        if not (LocList.RunModal() = ACTION::LookupOK) then
            exit(false);

        Text := LocList.GetSelectionFilter();

        exit(true);
    end;


    var
        ItemFilter: Text;
        LocationFilter: Text;

}