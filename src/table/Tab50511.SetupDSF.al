table 50511 "SetupDSF"
{
    TableType = Normal;
    Caption = 'Devinci Customizations Setup';

    fields
    {
        field(1; PK; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; BusinessCase_Number; Code[20])
        {
            Caption = 'BusinessCase Number series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(3; CusmaCertification_Number; Code[20])
        {
            Caption = 'CusmaCertification Number series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(4; CpscCertification_Number; Code[20])
        {
            Caption = 'CpscCertification Number series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(5; FrameSizes_Number; Code[20])
        {
            Caption = 'FrameSizes Number series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(10; AvgSalesTransCost_Number; Code[20])
        {
            Caption = 'AvgSalesTransCost Number series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(14; ModelName_Number; Code[20])
        {
            Caption = 'ModelName Number series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
