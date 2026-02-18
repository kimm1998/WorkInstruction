pageextension 50557 "Prod Order Componenets" extends "Prod. Order Components"
{
    layout
    {
        // Add changes to page layout here
        
    }

    actions
    {

        addlast("&Line")
        {
            action("Print Raw Material Label")
            {
                Visible = rec."ONT Label Layout" = rec."ONT Label Layout"::"Raw Material";
                Image = PrintForm;
                ApplicationArea = all;

                trigger OnAction()
                var
                    RawMaterialLabel: Report "ONT Raw Material Label";
                    Item: Record Item;
                begin
                    Item.SetRange("No.", rec."Item No.");
                    RawMaterialLabel.SetTableView(Item);
                    RawMaterialLabel.Run();
                end;
            }
        }
    }


}