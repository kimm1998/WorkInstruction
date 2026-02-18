page 50525 "SetupCard"
{
    PageType = Card;
    SourceTable = "SetupDSF";
    Caption = 'Devinci Customizations Setup';
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("Number seriesGrp")
            {
                Caption = 'Number series';

                field(BusinessCase_Number; Rec.BusinessCase_Number)
                {
                    ApplicationArea = All;
                }
                field(CusmaCertification_Number; Rec.CusmaCertification_Number)
                {
                    ApplicationArea = All;
                }
                field(CpscCertification_Number; Rec.CpscCertification_Number)
                {
                    ApplicationArea = All;
                }
                field(FrameSizes_Number; Rec.FrameSizes_Number)
                {
                    ApplicationArea = All;
                }
                
                field(AvgSalesTransCost_Number; Rec.AvgSalesTransCost_Number)
                {
                    ApplicationArea = All;
                }
                
                field(ModelName_Number; Rec.ModelName_Number)
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
    trigger OnInit()
    begin
        if Rec.IsEmpty()then Rec.Insert();
    end;
}
