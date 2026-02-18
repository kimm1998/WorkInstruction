tableextension 50546 "ONT ProdForecastName Ext" extends "Production Forecast Name"
{
    fields
    {
        field(60100; "ONT Family Filter"; Blob)
        {
            Caption = 'Family Filter';
            DataClassification = CustomerContent;
        }
    }

    procedure GetFamilyFilterBlobAsText(): Text
    var
        Ins: InStream;
        T: Text;
    begin
        CalcFields("ONT Family Filter");
        "ONT Family Filter".CreateInStream(Ins);
        Ins.ReadText(T);
        exit(T);
    end;

    procedure SetTextFilterToFamilyFilterBlob(TextFilter: Text)
    var
        Outs: OutStream;
    begin
        Clear("ONT Family Filter");
        "ONT Family Filter".CreateOutStream(Outs);
        Outs.WriteText(TextFilter);
    end;
}