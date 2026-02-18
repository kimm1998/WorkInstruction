page 50563 "ONT Family Forecast Card"
{
    Caption = 'Family Forecast Overview';
    PageType = Card;
    SourceTable = "Production Forecast Name";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Name; Rec.Name)
                {
                    ApplicationArea = Planning;
                    Caption = 'Demand Forecast Name';
                    ToolTip = 'Specifies the name of the demand forecast.';
                    trigger OnValidate()
                    begin
                        SetMatrix();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Planning;
                }
                field("View By"; Rec."View By")
                {
                    ApplicationArea = Planning;
                    Caption = 'View by';
                    ToolTip = 'Choose the period granularity for the matrix (Month recommended).';
                    trigger OnValidate()
                    begin
                        SetMatrixColumns("Matrix Page Step Type"::Initial);
                    end;
                }
                field("Quantity Type"; Rec."Quantity Type")
                {
                    ApplicationArea = Planning;
                    Caption = 'View as';
                    trigger OnValidate()
                    begin
                        SetMatrix();
                    end;
                }

                field("Family Filter"; FamilyFilter)
                {
                    ApplicationArea = Planning;
                    Caption = 'Family Filter';
                    Editable = IsEditable;

                    trigger OnDrillDown()
                    var
                        FPB: FilterPageBuilder;
                        Fam: Record Family;
                        Helper: Codeunit "Request Page Parameters Helper";
                        CaptionTxt: Code[30];
                    begin
                        if not IsEditable then
                            exit;

                        CaptionTxt := CopyStr(Fam.TableCaption(), 1, MaxStrLen(CaptionTxt));
                        // Helper.BuildDynamicRequestPage(FPB, CaptionTxt, Database::Family);
                        // Helper.SetViewOnDynamicRequestPage(FPB, Rec.GetFamilyFilterBlobAsText(), CaptionTxt, Database::Family);
                        // FPB.PageCaption := CaptionTxt;

                        // if not FPB.RunModal() then
                        //     exit;

                        // FamilyFilter := Helper.GetViewFromDynamicRequestPage(FPB, CaptionTxt, Database::Family);
                        EditFamilyFilter();
                        Rec.SetTextFilterToFamilyFilterBlob(FamilyFilter);
                        Rec.Modify();
                        SetMatrix();
                    end;
                }

                field("Forecast By Locations"; Rec."Forecast By Locations")
                {
                    ApplicationArea = Planning;
                    Caption = 'Forecast by Locations';
                    trigger OnValidate()
                    begin
                        LocationFilterEnabled := Rec."Forecast By Locations";
                        if not LocationFilterEnabled then begin
                            LocationFilter := '';
                            Rec.SetTextFilterToLocationBlob('');
                            Rec.Modify();
                        end;
                        SetMatrix();
                    end;
                }
                field("Location Filter"; LocationFilter)
                {
                    ApplicationArea = Planning;
                    Caption = 'Location Filter';
                    Enabled = LocationFilterEnabled;
                    Editable = IsEditable;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Loc: Record Location;
                        LocList: Page "Location List";
                    begin
                        Loc.SetRange("Use As In-Transit", false);
                        LocList.SetTableView(Loc);
                        LocList.LookupMode(true);
                        if LocList.RunModal() <> Action::LookupOK then
                            exit(false);
                        Text := LocList.GetSelectionFilter();
                        exit(true);
                    end;

                    trigger OnValidate()
                    var
                        Loc: Record Location;
                    begin
                        Loc.SetFilter(Code, LocationFilter);
                        LocationFilter := Loc.GetFilter(Code);
                        Rec.SetTextFilterToLocationBlob(LocationFilter);
                        Rec.Modify();
                        SetMatrix();
                    end;
                }

                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Planning;
                    Caption = 'Date Filter';
                    Editable = IsEditable;
                    trigger OnValidate()
                    var
                        FilterTokens: Codeunit "Filter Tokens";
                        DF: Text;
                    begin
                        DF := Rec."Date Filter";
                        FilterTokens.MakeDateFilter(DF);
                        Rec."Date Filter" := CopyStr(DF, 1, MaxStrLen(Rec."Date Filter"));
                        SetMatrixColumns("Matrix Page Step Type"::Initial);
                    end;
                }
            }

            part(Matrix; "ONT Family Forecast Matrix")
            {
                ApplicationArea = Planning;
                Editable = IsEditable;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Planning;
                Image = PreviousSet;
                trigger OnAction()
                begin
                    SetMatrixColumns("Matrix Page Step Type"::Previous);
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Planning;
                Image = PreviousRecord;
                trigger OnAction()
                begin
                    SetMatrixColumns("Matrix Page Step Type"::PreviousColumn);
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Planning;
                Image = NextRecord;
                trigger OnAction()
                begin
                    SetMatrixColumns("Matrix Page Step Type"::NextColumn);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Planning;
                Image = NextSet;
                trigger OnAction()
                begin
                    SetMatrixColumns("Matrix Page Step Type"::Next);
                end;
            }

            action("Apply to Item Forecast (Replace)")
            {
                ApplicationArea = Planning;
                Image = Calculate;
                trigger OnAction()
                var
                    Mgt: Codeunit "ONT Family Forecast Mgt";
                begin
                    Rec.TestField(Name);
                    Mgt.ApplyToItemForecast(Rec.Name, true);
                    Message('Applied family forecast "%1" (replace).', Rec.Name);
                end;
            }
            action("Apply to Item Forecast (Add)")
            {
                ApplicationArea = Planning;
                Image = AddAction;
                trigger OnAction()
                var
                    Mgt: Codeunit "ONT Family Forecast Mgt";
                begin
                    Rec.TestField(Name);
                    Mgt.ApplyToItemForecast(Rec.Name, false);
                    Message('Applied family forecast "%1" (add).', Rec.Name);
                end;
            }
            action("Export Template (Excel)")
            {
                ApplicationArea = Planning;
                Image = ExportToExcel;
                ToolTip = 'Export a blank Family Forecast template to Excel (12 months from current month).';
                //Promoted = true;
                //PromotedCategory = Process;
                //PromotedIsBig = false;

                trigger OnAction()
                var
                    Exporter: Codeunit "ONT Family Forecast Export";
                begin
                    Exporter.ExportTemplate(12);
                end;
            }

            action("Import Family Forecast (Excel)")
            {
                ApplicationArea = Planning;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                Caption = 'Import Family Forecast (Excel)';
                ToolTip = 'Import family-level forecast buckets from an Excel matrix (Family, Location, monthly quantities).';
                trigger OnAction()
                var
                    Importer: Codeunit "ONT Family Forecast Import";
                begin
                    Rec.TestField(Name); // Forecast name required
                    Importer.ImportFamilyForecast(Rec.Name);
                    // Refresh the matrix after import
                    SetMatrixColumns("Matrix Page Step Type"::Initial);
                    CurrPage.Matrix.Page.Update(false);
                end;
            }

        }
    }

    trigger OnOpenPage()
    begin
        IsEditable := CurrPage.Editable;
        Rec.CheckDateFilterIsValid();

        // Force Monthly as the initial view if user hasn’t chosen something else yet (or left it at Day)
        if Rec."View By" in [Rec."View By"::Day] then begin
            Rec.Validate("View By", Rec."View By"::Month);
            Rec.Modify(false);
        end;

        SetMatrixColumns("Matrix Page Step Type"::Initial);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Default new forecast cards to Monthly
        Rec.Validate("View By", Rec."View By"::Month);
    end;

    trigger OnAfterGetRecord()
    begin
        IsEditable := CurrPage.Editable;
        FamilyFilter := Rec.GetFamilyFilterBlobAsText();
        LocationFilter := Rec.GetLocationFilterBlobAsText();
        LocationFilterEnabled := Rec."Forecast By Locations";

        if RefreshMatrixNext then begin
            SetMatrix();
            CurrPage.Matrix.Page.Update(false);
        end;
        RefreshMatrixNext := false;
    end;

    trigger OnNextRecord(steps: Integer): Integer
    begin
        RefreshMatrixNext := true;
        exit(Rec.Next(steps));
    end;

    var
        IsEditable: Boolean;
        RefreshMatrixNext: Boolean;
        LocationFilterEnabled: Boolean;

        FamilyFilter: Text;
        LocationFilter: Text;

        MatrixRecords: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text;
        PKFirstRecInCurrSet: Text;
        CurrentSetLength: Integer;

    protected procedure SetMatrixColumns(StepType: Enum "Matrix Page Step Type")
    var
        MatrixMgt: Codeunit "Matrix Management";
    begin
        MatrixMgt.GeneratePeriodMatrixData(
            StepType.AsInteger(),
            ArrayLen(MatrixRecords),
            false,
            Rec."View By",
            Rec."Date Filter",
            PKFirstRecInCurrSet,
            MatrixColumnCaptions,
            ColumnSet,
            CurrentSetLength,
            MatrixRecords);

        SetMatrix();
    end;

    protected procedure SetMatrix()
    begin
        CurrPage.Matrix.PAGE.Load(
            MatrixColumnCaptions,
            MatrixRecords,
            Rec.Name,
            Rec."Date Filter",
            Rec."Quantity Type",
            CurrentSetLength,
            Rec.GetFamilyFilterBlobAsText(),
            Rec.GetLocationFilterBlobAsText(),
            Rec."Forecast By Locations");
    end;

    Local procedure EditFamilyFilter()
    var
        FilterPageBuilder: FilterPageBuilder;
        RequisitionLine: Record "Requisition Line";
    begin
        FilterPageBuilder.AddTable('Family', Database::Family);
        FilterPageBuilder.PageCaption := 'Family' + ' Filter';
        if FamilyFilter <> '' then
            FilterPageBuilder.SetView('Family', FamilyFilter);
        if FilterPageBuilder.RunModal() then
            FamilyFilter := FilterPageBuilder.GetView('Family');
        // rec.Modify(false);
    end;
}
