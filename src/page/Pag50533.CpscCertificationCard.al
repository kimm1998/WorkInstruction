page 50533 "CpscCertificationCard"
{
    PageType = Card;
    SourceTable = "CpscCertificationDSF";
    Caption = 'CPSC Certification Card';

    layout
    {
        area(content)
        {
            group(GeneralGrp)
            {
                Caption = 'General';

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
            }
            // group("Test DetailsGrp")
            // {
            //     Caption = 'Test Details';

            //     field(DvpCertification; Rec.DvpCertification)
            //     {
            //         ApplicationArea = All;
            //     }
            // }
        }
        area(FactBoxes)
        {
#if not CLEAN25
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ObsoleteTag = '25.0';
                ObsoleteState = Pending;
                ObsoleteReason = 'The "Document Attachment FactBox" has been replaced by "Doc. Attachment List Factbox", which supports multiple files upload.';
                ApplicationArea = All;
                Visible = false;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::CpscCertificationDSF),
                              "No." = field(No);
            }
#endif
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::CpscCertificationDSF),
                              "No." = field(No);
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
    }
    var
        CustoemrCa: page "Customer Card";
}
