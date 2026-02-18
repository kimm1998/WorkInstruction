page 50583 "Sales Type Commission"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ONT Sales Type Commission";
    Caption = 'Sales Type Commissions';
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                // field("Fiscal Year"; Rec."Starting Date")
                // {
                //     ToolTip = 'Specifies the value of the Fiscal Year field.', Comment = '%';
                // }
                field(Salesperson; Rec.Salesperson)
                {
                    ToolTip = 'Specifies the value of the Salesman field.', Comment = '%';
                    // Editable = false;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesman field.', Comment = '%';
                }

                field("Order Type Code"; Rec."Order Type Code")
                {
                    ToolTip = 'Specifies the value of the Order Type Code field.', Comment = '%';
                }
                field("Order Type Description"; Rec."Order Type Description")
                {
                    ToolTip = 'Specifies the value of the Order Type Description field.', Comment = '%';
                }
                field("Commission Rate %"; Rec."Commission Rate %")
                {
                    ToolTip = 'Specifies the value of the Commission Rate % field.', Comment = '%';
                }
            }
        }
    }


}