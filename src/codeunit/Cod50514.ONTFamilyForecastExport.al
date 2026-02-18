codeunit 50514 "ONT Family Forecast Export"
{
    procedure ExportTemplate(MonthCount: Integer)
    var
        ExcelBuf: Record "Excel Buffer" temporary;
        SheetName: Text[50];
        StartDate: Date;
        m: Integer;
    begin
        if MonthCount <= 0 then
            MonthCount := 12;

        SheetName := 'Family Forecast Matrix';

        // reset the buffer
        ExcelBuf.Reset();
        ExcelBuf.DeleteAll();

        // Header row
        AddTextCell(ExcelBuf, 'Family No.', true);
        AddTextCell(ExcelBuf, 'Family Description', true);
        AddTextCell(ExcelBuf, 'Location Code', true);

        // Month headers (current month + MonthCount-1)
        StartDate := DMY2DATE(1, DATE2DMY(WORKDATE(), 2), DATE2DMY(WORKDATE(), 3));
        for m := 0 to (MonthCount - 1) do
            AddTextCell(ExcelBuf, MonthHeader(CalcDate(Format(m) + '<M>', StartDate)), true);

        ExcelBuf.NewRow();

        // Optional sample row (kept simple; all zeros)
        AddTextCell(ExcelBuf, 'FAM-001', false);
        AddTextCell(ExcelBuf, 'Road Bikes', false);
        AddTextCell(ExcelBuf, 'MAIN', false);
        for m := 1 to MonthCount do
            AddDecimalCell(ExcelBuf, 0);
        ExcelBuf.NewRow();

        // Build workbook and open on client (SaaS-safe)
        ExcelBuf.CreateNewBook('Family Forecast Template');
        ExcelBuf.WriteSheet(SheetName, CompanyName(), UserId());
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    local procedure AddTextCell(var ExcelBuf: Record "Excel Buffer" temporary; Value: Text[250]; Bold: Boolean)
    begin
        ExcelBuf.AddColumn(Value, false, '', Bold, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure AddDecimalCell(var ExcelBuf: Record "Excel Buffer" temporary; Value: Decimal)
    begin
        ExcelBuf.AddColumn(Format(Value), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
    end;

    local procedure MonthHeader(BucketDate: Date): Text[20]
    var
        mn: Integer;
        yr: Integer;
        monTxt: Text[3];
    begin
        if BucketDate = 0D then
            exit('');
        mn := DATE2DMY(BucketDate, 2);
        yr := DATE2DMY(BucketDate, 3);
        case mn of
            1:
                monTxt := 'Jan';
            2:
                monTxt := 'Feb';
            3:
                monTxt := 'Mar';
            4:
                monTxt := 'Apr';
            5:
                monTxt := 'May';
            6:
                monTxt := 'Jun';
            7:
                monTxt := 'Jul';
            8:
                monTxt := 'Aug';
            9:
                monTxt := 'Sep';
            10:
                monTxt := 'Oct';
            11:
                monTxt := 'Nov';
            12:
                monTxt := 'Dec';
        end;
        exit(StrSubstNo('%1 %2', monTxt, Format(yr)));
    end;
}
