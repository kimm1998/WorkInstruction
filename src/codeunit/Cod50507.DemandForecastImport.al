codeunit 50507 "Demand Forecast Import"
{
    procedure ImportDemandForecast(ForecastName: Text[10])
    var
        ExcelTools: Codeunit "Excel Tools";
        Buffer: Record "Excel Buffer" temporary;
        InStream: InStream;
        Filename: Text;
        Row: Integer;
        Column: Integer;
        LastRow: Integer;
        LastColumn: Integer;
        EntryNo: Integer;
        ItemNo: Code[20];
        Quantity: Decimal;
        Location: Code[20];
        FirstDate: Date;
        ForecastDate: Date;
        CurrentMonth: Integer;
        Records: Integer;
        WindowDialog: Dialog;
        txtBuilder: TextBuilder;
        TotalRecords: Integer;

    begin

        if UploadIntoStream(UploadMsg, '', '', Filename, InStream) then begin
            WindowDialog.Open(textCnting + '\\' + ProgressBarSpaces);
            Buffer.OpenBookStream(InStream, 'Demand Forecast Matrix');
            Buffer.ReadSheet();
            ExcelTools.GetFirstRow(Buffer, 1);
            FirstDate := GetFirstDate(ExcelTools.GetText(Buffer, 'D', 1));
            LastRow := ExcelTools.GetLastRow(Buffer, 1);
            Buffer.Reset();
            LastColumn := ExcelTools.GetLastColumn(Buffer, 1);
            Buffer.Reset();
            EntryNo := GetLastEntryNo;
            TotalRecords := LastRow;
            DeleteDemandForecast(ForecastName);
            for Row := 2 to LastRow do begin
                Records += 1;
                ItemNo := ExcelTools.GetText(Buffer, 'A', row);
                Location := ExcelTools.GetText(Buffer, 'C', row);
                for Column := 4 to LastColumn do begin
                    CurrentMonth := Column - 4;
                    Quantity := ExcelTools.GetDecimal(Buffer, Column, row);
                    ForecastDate := CalcDate(Format(CurrentMonth) + '<M>', FirstDate);
                    InsertDemandForecast(ForecastName, ItemNo, Location, ForecastDate, Quantity, EntryNo);
                    WindowDialog.Update(1, Round(Records * 10000 / TotalRecords, 1));
                    WindowDialog.Update(2, ItemNo);

                end;
            end;
            WindowDialog.CLOSE();
        end;
    end;


    Local procedure InsertDemandForecast(ForecastName: Text[10]; ItemNo: Code[20]; Location: Code[20]; ForecastDate: Date; Quantity: Decimal; var EntryNo: Integer)
    var
        ProductionForecastEntry: Record "Production Forecast Entry";
    begin
        EntryNo += 1;
        ProductionForecastEntry.Init();
        ProductionForecastEntry.Validate("Production Forecast Name", ForecastName);
        ProductionForecastEntry."Entry No." := EntryNo;
        ProductionForecastEntry."Forecast Date" := ForecastDate;
        ProductionForecastEntry.Validate("Item No.", ItemNo);
        ProductionForecastEntry.Validate("Location Code", Location);
        ProductionForecastEntry.Validate("Forecast Quantity", Quantity);
        ProductionForecastEntry.Insert(true);

    end;


    Local procedure UpdateDemandForecast(ForecastName: Text[10]; ItemNo: Code[20]; Location: Code[20]; ForecastDate: Date; Quantity: Decimal; var EntryNo: Integer)
    var
        ProductionForecastEntry: Record "Production Forecast Entry";
    begin
        ProductionForecastEntry.SetCurrentKey("Production Forecast Name", "Item No.", "Location Code", "Forecast Date");
        ProductionForecastEntry.SetRange("Production Forecast Name", ForecastName);
        ProductionForecastEntry.SetRange("Item No.", ItemNo);
        ProductionForecastEntry.SetRange("Location Code", Location);
        ProductionForecastEntry.SetRange("Forecast Date", ForecastDate);
        IF ProductionForecastEntry.FindFirst() then begin
            ProductionForecastEntry.Validate("Forecast Quantity", Quantity);
            ProductionForecastEntry.Modify(true);
        end
        else begin
            EntryNo += 1;
            ProductionForecastEntry.Init();
            ProductionForecastEntry.Validate("Production Forecast Name", ForecastName);
            ProductionForecastEntry."Entry No." := EntryNo;
            ProductionForecastEntry."Forecast Date" := ForecastDate;
            ProductionForecastEntry.Validate("Item No.", ItemNo);
            ProductionForecastEntry.Validate("Location Code", Location);
            ProductionForecastEntry.Validate("Forecast Quantity", Quantity);
            ProductionForecastEntry.Insert(true);
        end;
    end;

    local procedure GetLastEntryNo(): Integer
    var
        ProductionForecastEntry: Record "Production Forecast Entry";
    begin
        if ProductionForecastEntry.FindLast() then exit(ProductionForecastEntry."Entry No.");
    end;

    local procedure GetFirstDate(ColumnName: Text[20]): Date
    var
        MonthText: Text[3];
        Year: Integer;
        Date: Date;
        Month: Integer;
    begin

        MonthText := ColumnName.Substring(1, 3);
        case MonthText of
            'Jan':
                Month := 1;
            'Feb':
                Month := 2;
            'Mar':
                Month := 3;
            'Apr':
                Month := 4;
            'May':
                Month := 5;
            'Jun':
                Month := 6;
            'Jul':
                Month := 7;
            'Aug':
                Month := 8;
            'Sep':
                Month := 9;
            'Oct':
                Month := 10;
            'Nov':
                Month := 11;
            'Dec':
                Month := 12;
        end;
        Evaluate(Year, ColumnName.Substring(5, 4));
        Date := DMY2Date(1, Month, Year);
        exit(Date);
    end;

    Local procedure DeleteDemandForecast(ForecastName: Text[10])
    var
        ProductionForecastEntry: Record "Production Forecast Entry";
    begin
        ProductionForecastEntry.SetRange("Production Forecast Name", ForecastName);
        IF ProductionForecastEntry.FindSet() then
            ProductionForecastEntry.DeleteAll();

    ENd;



    var
        UploadMsg: label 'Select the forecast file for import';
        textCnting: Label 'Importing: @1@@@@@@@@';
        ProgressBarSpaces: Label 'Item: #2#';
        ShowProgressText: Label '❚';
}
