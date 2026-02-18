table 50514 "CpscCertificationDSF"
{
    TableType = Normal;
    Caption = 'CPSC Certification';
    LookupPageId = 50532;

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
        field(3; ProductCategory; Text[40])
        {
            Caption = 'Product Category';
            DataClassification = ToBeClassified;
        }
        field(4; Standard; Code[20])
        {
            Caption = 'Standard';
            DataClassification = ToBeClassified;
            // TableRelation = "Standard HeaderDSF".StandardNo;
        }
        field(5; CertificationDate; Date)
        {
            Caption = 'Certification Date';
            DataClassification = ToBeClassified;
        }
        field(6; CertificationLocation; Text[50])
        {
            Caption = 'Certification Location';
            DataClassification = ToBeClassified;
        }
        field(7; ContactNo; Code[20])
        {
            Caption = 'Contact No';
            DataClassification = ToBeClassified;
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                RelRec: Record "Contact";
            begin
                RelRec.Setrange("No.", Rec.ContactNo);
                RelRec.FindFirst();
                Rec.Validate(ContactName, RelRec."Name");
            end;
        }
        field(8; ContactName; Code[100])
        {
            Caption = 'Contact Name';
            DataClassification = ToBeClassified;
        }
        field(9; CertificationLabNo; Code[20])
        {
            Caption = 'Certification Lab No';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                RelRec: Record "Vendor";
            begin
                RelRec.Setrange("No.", Rec.CertificationLabNo);
                RelRec.FindFirst();
                Rec.Validate(CertificationLabName, RelRec."Name");
            end;
        }
        field(10; CertificationLabName; Text[100])
        {
            Caption = 'Certification Lab Name';
            DataClassification = ToBeClassified;
        }
        field(11; Status; Boolean)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(30; DvpCertification; Code[20])
        {
            Caption = 'DVP Certification';
            DataClassification = ToBeClassified;
            // TableRelation = "DvpCertification HeaderDSF".DvpNo;
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
            Setup.TestField("CpscCertification_Number");
            // NoSeriesMgt.InitSeries(Setup.CpscCertification_Number, '', 0D, No, NewNoSeries);
            NoSeriesMgt.AreRelated(Setup.CpscCertification_Number, NewNoSeries);
        end;
    end;

    local procedure OnBeforeInsert(var Rec: Record "CpscCertificationDSF"; var IsHandled: Boolean)
    begin
    end;
}
