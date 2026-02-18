page 50534 "API CpscCertificationDSF"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'hougaard';
    APIGroup = 'DSF';
    EntityCaption = 'CPSC Certification';
    EntitySetCaption = 'CPSC Certifications';
    EntityName = 'cpsccertification';
    EntitySetName = 'cpsccertifications';
    ODataKeyFields = SystemId;
    SourceTable = "CpscCertificationDSF";
    Extensible = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(RepeaterGroup)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'SystemId';
                    Editable = false;
                }
                field(no; Rec."No")
                {
                    Caption = 'No';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(productcategory; Rec."ProductCategory")
                {
                    Caption = 'Product Category';
                }
                field(standard; Rec."Standard")
                {
                    Caption = 'Standard';
                }
                field(certificationdate; Rec."CertificationDate")
                {
                    Caption = 'Certification Date';
                }
                field(certificationlocation; Rec."CertificationLocation")
                {
                    Caption = 'Certification Location';
                }
                field(contactno; Rec."ContactNo")
                {
                    Caption = 'Contact No';
                }
                field(contactname; Rec."ContactName")
                {
                    Caption = 'Contact Name';
                }
                field(certificationlabno; Rec."CertificationLabNo")
                {
                    Caption = 'Certification Lab No';
                }
                field(certificationlabname; Rec."CertificationLabName")
                {
                    Caption = 'Certification Lab Name';
                }
                field(status; Rec."Status")
                {
                    Caption = 'Status';
                }
                field(dvpcertification; Rec."DvpCertification")
                {
                    Caption = 'DVP Certification';
                }
            }
        }
    }
}
