table 50503 "FrameSizesDSF"
{
    TableType = Normal;
    Caption = 'Frame sizes';
    // LookupPageId = 50507;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; Frame; Code[20])
        {
            Caption = 'Frame';
            DataClassification = ToBeClassified;
            TableRelation = FrameDSF.FrameNo;
        }
        field(3; Size; Code[20])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
            TableRelation = SizesDSF.Size;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        Setup: Record "SetupDSF";
        IsHandled: Boolean;
        NoSeriesMgt: Codeunit "No. Series";
        NewNoSeries: Code[20];
    begin
        IsHandled := false;
        OnBeforeInsert(Rec, IsHandled);
        if IsHandled then exit;
        if Rec."No" = '' then begin
            Setup.Get();
            Setup.TestField("FrameSizes_Number");
            // NoSeriesMgt.InitSeries(Setup.FrameSizes_Number, '', 0D, No, NewNoSeries);
            NoSeriesMgt.AreRelated(Setup.FrameSizes_Number, NewNoSeries);
        end;
    end;

    local procedure OnBeforeInsert(var Rec: Record "FrameSizesDSF"; var IsHandled: Boolean)
    begin
    end;
}
