pageextension 50540 "ONT Mfg Setup Page Ext" extends "Manufacturing Setup"
{
    layout
    {
        addlast(Content)
        {
            group(ONTShopfloorTransfer)
            {
                Caption = 'Shopfloor Transfer';


                field("ONT From Location Code"; Rec."ONT From Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Location Code (Supply) field.', Comment = '%';
                }
                field("ONT Shopfloor Location Code"; Rec."ONT Shopfloor Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopfloor Location Code (Destination) field.', Comment = '%';
                }
                field("ONT Default From Bin Code"; Rec."ONT Default From Bin Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Default bin at the from location to pick components from.';
                }
                field("ONT Shopfloor Bin Code"; Rec."ONT Shopfloor Bin Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Bin that represents the open shop floor; used to detect whether components are already available there.';
                }
                field("ONT Use In-Transit"; Rec."ONT Use In-Transit")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'If enabled, transfers will route through the configured In-Transit location.';
                }
                field("ONT In-Transit Location Code"; Rec."ONT In-Transit Location Code")
                {
                    ApplicationArea = Manufacturing;
                    Enabled = Rec."ONT Use In-Transit";
                    ToolTip = 'In-Transit location to use when creating transfer orders.';
                }
                field("ONT Default To Bin Code"; Rec."ONT Default To Bin Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Default destination bin for transfers to the shopfloor. Leave blank to let the system pick the default bin of the destination location.';
                }
            }
        }
    }
}
