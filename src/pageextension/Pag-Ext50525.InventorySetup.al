pageextension 50525 "Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field("ONT Family Nos."; Rec."ONT Family Nos.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Gen. Journal Templates")
        {
            group(Web)
            {
                Caption = 'Web';

                field("Web Inventory Location"; Rec."Web Inventory Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Web Inventory Location field.';
                }
            }
        }
        addlast(General)
        {
            field("Family Product Type Code"; Rec."Family Product Type Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Family Product Type Code field.';
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            // action(RAUpdateTINXProducts)
            // {
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ApplicationArea = All;
            //     Caption = 'Update TINX Products';
            //     RunObject = codeunit "TINX Mgmt";
            // }
        }
    }
}
