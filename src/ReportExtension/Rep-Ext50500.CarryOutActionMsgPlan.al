reportextension 50500 CarryOutActionMsgPlan extends "Carry Out Action Msg. - Plan."
{
    dataset
    {
    }

    requestpage
    {
        layout
        {
            addafter(CombineTransferOrders)
            {
                field("By Family"; ByFamily)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SingleInstance.SetByFamily(ByFamily);
                    end;
                }
            }
        }
        trigger OnOpenPage()
        begin
            ByFamily := true;
            SingleInstance.SetByFamily(ByFamily);
        end;

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        SingleInstance.SetTargetStatus(ProdOrderChoice);

    end;

    var
        SingleInstance: Codeunit "Single Instance";
        ByFamily: Boolean;
        TargetStatus: Enum "Production Order Status";
}