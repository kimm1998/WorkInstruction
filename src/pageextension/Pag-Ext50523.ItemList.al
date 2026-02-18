pageextension 50523 "Item List" extends "Item List"
{
    layout
    {
        AddAfter("Description")
        {
            field("ModelNo_DPR"; Rec."ModelNo")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("FrameNo_DPR"; Rec."FrameNo")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("SizeNo_DPR"; Rec."SizeNo")
            {
                Visible = false;
                ApplicationArea = all;
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
    }
}