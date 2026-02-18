page 50594 "ONT Family Product Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ONT Family Product Type";
    Caption = 'Family Product Type';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Bicycle Fields Display"; Rec."Bicycle Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Finished Painted Frame Code"; Rec."Fshd Pntd Frame Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Forecast Item Fields Display"; Rec."Forecast Item Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Frameset Fields Display"; Rec."Frameset Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Painted Frame Fields Display"; Rec."Painted Frame Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Raw Frame Fields Display"; Rec."Raw Frame Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Service Part Fields Display"; Rec."Service Part Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Transformed Tube Fields Display"; Rec."Trnsfrmd Tube Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Warranty Part Fields Display"; Rec."Warranty Part Fields Display")
                {
                    ToolTip = '’When checked, display respective fields of this product type in the Families header page.', Comment = '%';
                }
                field("Unique Item Line"; Rec."Unique Item Line")
                {
                    ApplicationArea = all;
                    ToolTip = '’When checked, any family from this Product type, can’t share the same item within the family lines.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}