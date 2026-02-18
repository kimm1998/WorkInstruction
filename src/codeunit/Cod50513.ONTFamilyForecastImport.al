codeunit 50513 "ONT Family Forecast Import"
{
    procedure ImportFamilyForecast(ForecastName: Code[10])
    var
        ExcelBuf: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        InS: InStream;
        OutS: OutStream;
        FileName: Text;

        LastRow: Integer;
        LastCol: Integer;
        FirstMonthCol: Integer;

        FirstHeaderDate: Date;
        Row: Integer;
        Col: Integer;

        FamilyNo: Code[20];
        Qty: Decimal;
        ForecastDate: Date;
        MonthOffset: Integer;

        Progress: Dialog;
    begin
        if ForecastName = '' then
            Error('Forecast Name is required.');

        if not UploadIntoStream('Select the Family Forecast Excel file', '', '', FileName, InS) then
            exit;

        // Keep a copy so we can attempt several sheet names safely
        TempBlob.CreateOutStream(OutS);
        CopyStream(OutS, InS);

        if not TryOpenSheet(ExcelBuf, TempBlob, 'Family Forecast Matrix') then
            if not TryOpenSheet(ExcelBuf, TempBlob, 'Family Forecast') then
                if not TryOpenSheet(ExcelBuf, TempBlob, 'Sheet1') then
                    Error('Could not open any worksheet. Expected one of: %1, %2, %3.',
                          'Family Forecast Matrix', 'Family Forecast', 'Sheet1');

        ExcelBuf.ReadSheet();

        // Determine bounds
        LastRow := GetLastRow(ExcelBuf);
        if LastRow < 2 then
            Error('No data rows found. Expected headers in row 1 and data from row 2.');

        LastCol := GetLastColumnInRow(ExcelBuf, 1);
        if LastCol = 0 then
            LastCol := GetLastColumnAnywhere(ExcelBuf);
        if LastCol = 0 then
            Error('No columns detected in the Excel sheet.');

        // Find first monthly header anywhere on header row 1
        FirstMonthCol := FindFirstMonthColumn(ExcelBuf, 1, 1, LastCol);
        if FirstMonthCol = 0 then
            Error('No month header found on row 1 (e.g., "Jan 2025").');

        FirstHeaderDate := ParseHeaderMonthAsDate(GetCellText(ExcelBuf, 1, FirstMonthCol));
        if FirstHeaderDate = 0D then
            Error('First month header is not recognizable (e.g., "Jan 2025").');

        Progress.Open('Importing family forecast @1@@@@@@@@@\Row: #2#');

        // Data rows: Col A = Family; Months start from FirstMonthCol
        for Row := 2 to LastRow do begin
            FamilyNo := CopyStr(GetCellText(ExcelBuf, Row, 1), 1, MaxStrLen(FamilyNo)); // Column A

            // Skip empty lines (no Family No.)
            if FamilyNo <> '' then begin
                for Col := FirstMonthCol to LastCol do begin
                    Qty := GetCellDecimal(ExcelBuf, Row, Col);
                    MonthOffset := Col - FirstMonthCol;
                    ForecastDate := CalcDate(Format(MonthOffset) + '<M>', FirstHeaderDate);
                    UpsertFamilyForecast(ForecastName, FamilyNo, ForecastDate, Qty);
                end;
            end;

            Progress.Update(1, Round(Row * 10000 / LastRow, 1));
            Progress.Update(2, Row);
        end;

        Progress.Close();
        Message('Family forecast "%1" import complete.', ForecastName);
    end;

    // ===== Excel helpers =====

    [TryFunction]
    local procedure TryOpenSheet(var ExcelBuf: Record "Excel Buffer" temporary; var TempBlob: Codeunit "Temp Blob"; SheetName: Text)
    var
        ReInS: InStream;
    begin
        TempBlob.CreateInStream(ReInS);
        ExcelBuf.OpenBookStream(ReInS, SheetName);
    end;

    local procedure GetLastRow(var ExcelBuf: Record "Excel Buffer" temporary): Integer
    begin
        ExcelBuf.Reset();
        if ExcelBuf.FindLast() then
            exit(ExcelBuf."Row No.");
        exit(0);
    end;

    local procedure GetLastColumnInRow(var ExcelBuf: Record "Excel Buffer" temporary; TargetRowNo: Integer): Integer
    begin
        ExcelBuf.Reset();
        ExcelBuf.SetCurrentKey("Row No.", "Column No.");
        ExcelBuf.SetRange("Row No.", TargetRowNo);
        if ExcelBuf.FindLast() then
            exit(ExcelBuf."Column No.");
        exit(0);
    end;

    local procedure GetLastColumnAnywhere(var ExcelBuf: Record "Excel Buffer" temporary): Integer
    var
        MaxCol: Integer;
    begin
        MaxCol := 0;
        ExcelBuf.Reset();
        if ExcelBuf.FindSet() then
            repeat
                if ExcelBuf."Column No." > MaxCol then
                    MaxCol := ExcelBuf."Column No.";
            until ExcelBuf.Next() = 0;
        exit(MaxCol);
    end;

    local procedure GetCellText(var ExcelBuf: Record "Excel Buffer" temporary; RowNo: Integer; ColNo: Integer): Text
    begin
        ExcelBuf.Reset();
        ExcelBuf.SetRange("Row No.", RowNo);
        ExcelBuf.SetRange("Column No.", ColNo);
        if ExcelBuf.FindFirst() then
            exit(ExcelBuf."Cell Value as Text");
        exit('');
    end;

    local procedure GetCellDecimal(var ExcelBuf: Record "Excel Buffer" temporary; RowNo: Integer; ColNo: Integer): Decimal
    var
        T: Text;
        D: Decimal;
    begin
        T := GetCellText(ExcelBuf, RowNo, ColNo);
        if Evaluate(D, T) then
            exit(D);
        exit(0);
    end;

    local procedure FindFirstMonthColumn(var ExcelBuf: Record "Excel Buffer" temporary; HeaderRow: Integer; FromCol: Integer; ToCol: Integer): Integer
    var
        Col: Integer;
        H: Text;
    begin
        for Col := FromCol to ToCol do begin
            H := GetCellText(ExcelBuf, HeaderRow, Col);
            if ParseHeaderMonthAsDate(H) <> 0D then
                exit(Col);
        end;
        exit(0);
    end;

    local procedure ParseHeaderMonthAsDate(HeaderText: Text): Date
    var
        MonTxt: Text[3];
        Mon: Integer;
        Yr: Integer;
    begin
        if StrLen(HeaderText) < 3 then
            exit(0D);

        MonTxt := UpperCase(CopyStr(HeaderText, 1, 3));
        case MonTxt of
            'JAN':
                Mon := 1;
            'FEB':
                Mon := 2;
            'MAR':
                Mon := 3;
            'APR':
                Mon := 4;
            'MAY':
                Mon := 5;
            'JUN':
                Mon := 6;
            'JUL':
                Mon := 7;
            'AUG':
                Mon := 8;
            'SEP':
                Mon := 9;
            'OCT':
                Mon := 10;
            'NOV':
                Mon := 11;
            'DEC':
                Mon := 12;
        end;
        if Mon = 0 then
            exit(0D);

        Yr := FindFourDigitYear(HeaderText);
        if Yr = 0 then
            exit(0D);

        exit(DMY2DATE(1, Mon, Yr));
    end;

    local procedure FindFourDigitYear(S: Text): Integer
    var
        i: Integer;
        Four: Text[4];
        Y: Integer;
    begin
        for i := 1 to StrLen(S) - 3 do begin
            Four := CopyStr(S, i, 4);
            if (StrLen(Four) = 4) and Evaluate(Y, Four) and (Y >= 1900) and (Y <= 2100) then
                exit(Y);
        end;
        exit(0);
    end;

    // ===== Upsert (no Location) =====

    local procedure UpsertFamilyForecast(ForecastName: Code[10]; FamilyNo: Code[20]; ForecastDate: Date; Qty: Decimal)
    var
        FamEntry: Record "ONT Family Forecast Entry";
        HasLocationField: Boolean;
    begin
        // Filter by Forecast, Family, Date only
        FamEntry.Reset();
        FamEntry.SetRange("Production Forecast Name", ForecastName);
        FamEntry.SetRange("Family", FamilyNo);
        FamEntry.SetRange(Date, ForecastDate);

        HasLocationField := FamEntry.FieldNo("Location Code") <> 0;

        if FamEntry.FindFirst() then begin
            FamEntry.Validate(Quantity, Qty);
            FamEntry.Modify(true);
        end else begin
            FamEntry.Init();
            FamEntry.Validate("Production Forecast Name", ForecastName);
            FamEntry.Validate("Family", FamilyNo);
            FamEntry.Validate(Date, ForecastDate);

            // Ensure Location Code is blank if the field exists on the table
            if HasLocationField then
                FamEntry.Validate("Location Code", '');

            FamEntry.Validate(Quantity, Qty);
            FamEntry.Insert(true);
        end;
    end;
}
