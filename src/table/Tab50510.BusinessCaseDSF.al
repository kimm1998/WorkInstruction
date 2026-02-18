table 50510 "BusinessCaseDSF"
{
    TableType = Normal;
    Caption = 'Business case';
    LookupPageId = 50522;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; BusinessUnitNo; Code[20])
        {
            Caption = 'BusinessUnitNo';
            DataClassification = ToBeClassified;
            TableRelation = "Business Unit".Code;
        }
        field(4; Status; Code[20])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            TableRelation = "Item Status"."Code" where("Type" = filter('Business Case'));
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
            Setup.TestField("BusinessCase_Number");
            // NoSeriesMgt.InitSeries(Setup.BusinessCase_Number, '', 0D, No, NewNoSeries);
            NoSeriesMgt.AreRelated(Setup.BusinessCase_Number,  NewNoSeries);
        end;
    end;

    local procedure OnBeforeInsert(var Rec: Record "BusinessCaseDSF"; var IsHandled: Boolean)
    begin
    end;
}
