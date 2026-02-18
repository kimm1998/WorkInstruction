pageextension 50538 "ONT Planning Wksh CarryFamily" extends "Planning Worksheet"
{
    actions
    {
        addlast(processing)
        {
            action(CarryOutByFamily)
            {
                ApplicationArea = Planning;
                Caption = 'Carry Out by Family';
                Image = Production;
                ToolTip = 'Create one Production Order per Family (per Location & Due Date) and add one line per item.';

                trigger OnAction()
                var
                    carryOutByFamily: Codeunit "ONT Carry Out By Family";
                    targetStatus: Enum "Production Order Status";
                begin
                    Rec.TestField("Worksheet Template Name");
                    Rec.TestField("Journal Batch Name");

                    targetStatus := targetStatus::"Firm Planned"; // change to Planned/Released if desired

                    carryOutByFamily.RunForBatch(
                        Rec."Worksheet Template Name",
                        Rec."Journal Batch Name",
                        targetStatus);

                    Message('Carry out by Family completed for %1/%2.',
                        Rec."Worksheet Template Name", Rec."Journal Batch Name");
                end;
            }
        }
    }
}
