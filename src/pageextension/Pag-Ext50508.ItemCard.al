pageextension 50508 "Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Label Layout"; Rec."ONT Label Layout")
            {
                ApplicationArea = all;
                Caption = 'Label Layout';
            }
        }
        AddAfter("Item")
        {
            Group(bicycle)
            {
                Caption = 'Bicycle';
                Visible = false;
            }
        }
        AddAfter("Item")
        {
            Group(components)
            {
                Caption = 'Components';
            }
        }
        AddAfter("components")
        {
            Group(MatieresDangereuses)
            {
                Caption = 'Matieres Dangereuses';
            }
        }
        AddFirst("bicycle")
        {
            field("ModelNo_DPR"; Rec."ModelNo")
            {
                ApplicationArea = all;
            }
            field("FrameNo_DPR"; Rec."FrameNo")
            {
                ApplicationArea = all;
            }
            field("SizeNo_DPR"; Rec."SizeNo")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        AddAfter("Item Category Code")
        {
            field("FactoryDepartment_DPR"; Rec."FactoryDepartment")
            {
                ApplicationArea = all;
            }
            field("BuAssignment_DPR"; Rec."BuAssignment")
            {
                ApplicationArea = all;
            }
        }
        AddAfter("Item Tracking Code")
        {
            field("RecordItemCategory_DPR"; Rec."RecordItemCategory")
            {
                ApplicationArea = all;
            }
        }
        addlast(Item)
        {
            field("Item Status Desc."; Rec."Item Status Desc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Status field.';
            }
            field("Revision No."; Rec."Revision No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Revision No. field.';
            }
            // field("Family No."; Rec."Family No.")
            // {
            //     ApplicationArea = all;
            //     trigger OnDrillDown()
            //     var
            //         FamilyPage: Page Family;
            //         Family: Record Family;
            //     begin
            //         Family.SetRange("No.", rec."Family No.");
            //         if Family.FindFirst() then begin
            //             FamilyPage.SetTableView(Family);
            //             FamilyPage.run;
            //         end;

            //     end;
            // }
            field("ONT Family Code"; Rec."ONT Family Code")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the Family Code associated to the item.';
            }
        }
        addafter("Country/Region of Origin Code")
        {
            field("HS Code Count"; Rec."HS Code Count")
            {
                ApplicationArea = All;
                Caption = 'HS code count';
                ToolTip = 'Number of HS code that respect these criterias: Tariff No, Country/Region of Origin Code, Item No.';
            }
        }
        modify(Blocked)
        {
            // Enabled = false;
            ToolTip = 'Specifies that the validation of the related record in transactions is blocked, for example an article is placed in quarantine. Can be changed by changing item status';
        }
        modify("Sales Blocked")
        {
            Enabled = false;
            ToolTip = 'Specifies that the item cannot be entered on sales documents except for returns, credit notes, and journals. Can be changed by changing item status';
        }
        modify("Purchasing Blocked")
        {
            Enabled = false;
            ToolTip = 'Specifies that the item cannot be entered on purchase documents, except for returns, credit notes, and journals. Can be changed by changing item status';
        }
        addafter("Indirect Cost %")
        {
            field("Import Custom Rate %"; Rec."Import Custom Rate %")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Modified field behavior by Cycles Devinci: originally used to specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item. Now used only to manage the import custom fees, by lookup with Custom Rate table using article no., Tariff no. and article origin.';
            }
        }
        modify("Indirect Cost %")
        {
            Editable = false;
            Visible = false;
        }
    }
    actions
    {
        addlast(PricesandDiscounts)
        {
            action(CustomRate)
            {
                ApplicationArea = All;
                Caption = 'Custom Rates';
                Image = Price;
                PromotedCategory = Category6;
                Promoted = true;
                // RunObject = page "Custom Rates";
                // RunPageLink = "Item No." = field("No.");
                ToolTip = 'Executes the Custom Rates action.';

                trigger OnAction()
                var
                    CustomRates: Record "Custom Rate";
                begin
                    if Rec."Country/Region of Origin Code" <> '' then CustomRates.SetRange("Country/Region", Rec."Country/Region of Origin Code");
                    if rec."Tariff No." <> '' then CustomRates.SetRange("Tariff No.", rec."Tariff No.");
                    CustomRates.SetRange("Item No.", Rec."No.");
                    Page.Run(Page::"Cust Rates", CustomRates);
                end;
            }
        }
        addafter(PrintLabel)
        {
            action("Print Raw Material Label")
            {
                Visible = rec."ONT Label Layout" = rec."ONT Label Layout"::"Raw Material";
                ApplicationArea = all;
                Image = PrintForm;
                trigger OnAction()
                var
                    RawMaterialLabel: Report "ONT Raw Material Label";
                    Item: Record Item;
                begin
                    Item.SetRange("No.", rec."No.");
                    RawMaterialLabel.SetTableView(Item);
                    RawMaterialLabel.Run();
                end;
            }
            // action(RawMaterielLabel)
            // {
            //     ApplicationArea = All;
            //     Caption = 'item label';
            //     Image = Report;
            //     ToolTip = 'Executes the item label action.';

            //     trigger OnAction()
            //     var
            //         LItem: Record Item;
            //     begin
            //         LItem.Reset();
            //         LItem.SetRange("No.", Rec."No.");
            //         if LItem.FindFirst() then Report.RunModal(Report::"Raw Materiel Label", true, false, LItem);
            //     end;
            // }
        }

        addlast(Functions)
        {
            action(Export)
            {
                ApplicationArea = All;
                Caption = 'Export CSV';
                Image = Report;
                RunObject = codeunit "Blob Storage Mgt";
                ToolTip = 'Executes the Export CSV action.';
            }
        }
    }
}
