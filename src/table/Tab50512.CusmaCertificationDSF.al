table 50512 "CusmaCertificationDSF"
{
    TableType = Normal;
    Caption = 'CUSMA Certification';
    LookupPageId = 50526;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Boolean)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
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
            Setup.TestField("CusmaCertification_Number");
            // NoSeriesMgt.InitSeries(Setup.CusmaCertification_Number, '', 0D, No, NewNoSeries);
            NoSeriesMgt.AreRelated(Setup.CusmaCertification_Number, NewNoSeries);
        end;
    end;

    local procedure OnBeforeInsert(var Rec: Record "CusmaCertificationDSF"; var IsHandled: Boolean)
    begin
    end;
}
