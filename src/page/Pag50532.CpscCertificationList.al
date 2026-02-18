page 50532 "CpscCertificationList"
{
    PageType = List;
    SourceTable = "CpscCertificationDSF";
    Caption = 'CPSC Certification List';
    CardPageId = "CpscCertificationCard";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Text area to define the certification, where you can specify the model and/or frame reference.';
                }
                field(ProductCategory; Rec.ProductCategory)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Text area to enter the product category that concerns CPSC certification. This information will be found in the header of the certification label.';
                }
                field(Standard; Rec.Standard)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(CertificationDate; Rec.CertificationDate)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Date on which certification was obtained / confirmed. This information will be found on the certification label.';
                }
                field(CertificationLocation; Rec.CertificationLocation)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Text area to specify the city, the region and the country where the certification was obtained / confirmed. This information will be found on the certification label.';
                }
                field(ContactNo; Rec.ContactNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Reference of the contact person who did the test. This information will be found on the certification label.';
                }
                field(ContactName; Rec.ContactName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Refers to the Search Name of contact No table.';
                }
                field(CertificationLabNo; Rec.CertificationLabNo)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(CertificationLabName; Rec.CertificationLabName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(DvpCertification; Rec.DvpCertification)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
}
