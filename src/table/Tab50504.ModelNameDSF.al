table 50504 "ModelNameDSF"
{
    TableType = Normal;
    Caption = 'Model name';
    LookupPageId = 50509;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
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
        if Rec."No." = '' then begin
            Setup.Get();
            Setup.TestField("ModelName_Number");
            // NoSeriesMgt.InitSeries(Setup.ModelName_Number, '', 0D, "No.", NewNoSeries);
            NoSeriesMgt.AreRelated(Setup.ModelName_Number, NewNoSeries);
        end;
    end;

    local procedure OnBeforeInsert(var Rec: Record "ModelNameDSF"; var IsHandled: Boolean)
    begin
    end;
}
