page 50548 "ONT Component Status FactBox"
{
    Caption = 'Components Status';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Prod. Order Component";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Components';
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Component Desc.';
                    ToolTip = 'Specifies the name of components that are assigned to this production order.';
                    StyleExpr = StyleText;
                }
                field("Remaining Qty. (Base)"; Rec."Remaining Qty. (Base)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remaining Qty';
                    ToolTip = 'Specifies the remaining quantity of the component that is assigned to this production order.';
                    StyleExpr = StyleText;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        If Rec."ONT Shortage" then
            StyleText := 'unfavorable'
        else
            StyleText := 'favorable';
    end;

    Var
        StyleText: Text[20];
}

