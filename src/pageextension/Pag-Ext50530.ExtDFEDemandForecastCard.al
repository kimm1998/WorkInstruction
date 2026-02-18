pageextension 50530 "ExtDFEDemand Forecast Card" extends "Demand Forecast Card"
{
    layout
    {
        modify("Date Filter")
        {
            Visible = false;
        }
        addlast(General)
        {

            field("From Date"; Rec."From Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the From Date field.';
                trigger OnValidate()
                begin
                    BuildDateFilter;
                end;
            }
            field("To Date"; Rec."To Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the To Date field.';
                trigger OnValidate()
                begin
                    BuildDateFilter;
                end;
            }

        }

    }
    actions
    {
        addlast(processing)
        {
            action(ImportFromExcel)
            {
                ApplicationArea = All;
                Caption = 'Import From Excel';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ImportExcel;

                trigger OnAction()
                var
                    DemandForecastImport: Codeunit "Demand Forecast Import";
                begin
                    rec.TestField("View By", rec."View By"::Month);
                    rec.TestField("Forecast By Locations");
                    rec.TestField("From Date");
                    rec.TestField("To Date");
                    rec.TestField("Location Filter");
                    DemandForecastImport.ImportDemandForecast(rec.Name);
                end;
            }
        }
    }

    local procedure BuildDateFilter()
    var
        DateFilter: Text;
        FilterTokens: Codeunit "Filter Tokens";
    begin
        if (Format(rec."From Date") = '') or (Format(rec."To Date") = '') then
            rec.Validate("Date Filter", '')
        else begin
            rec.Validate("Date Filter", Format(rec."From Date") + '..' + Format(rec."To Date"));
            DateFilter := Rec."Date Filter";
            FilterTokens.MakeDateFilter(DateFilter);
            Rec."Date Filter" := CopyStr(DateFilter, 1, MaxStrLen(Rec."Date Filter"));
            SetMatrixColumns("Matrix Page Step Type"::Initial);
        end;


    end;
}
