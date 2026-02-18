page 50582 "ONT Sales Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ONT Sales Type";
    Caption = 'Sales Type List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // field("Document Type"; Rec."Document Type")
                // {
                //     ToolTip = 'Specifies the value of the Document Type field.', Comment = '%';
                // }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Customer Discount Group"; Rec."Customer Discount Group")
                {
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.', Comment = '%';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ToolTip = 'Specifies the value of the Customer Price Group field.', Comment = '%';
                }
                field("Payment term"; Rec."Payment term")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.', Comment = '%';
                }
                field("Shipping Formula"; Rec."Shipping Formula")
                {
                    ToolTip = 'Specifies the value of the Shipping Formula field.', Comment = '%';
                }
                // field("Salesman commission %"; Rec."Salesman commission %")
                // {
                //     ToolTip = 'Specifies the value of the Salesman commission % field.', Comment = '%';
                // }

                field("Fixed Rate"; Rec."Fixed Rate")
                {
                    ToolTip = 'Specifies the value of the Shipping fees field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DimensionsSingle)
            {
                ApplicationArea = Dimensions;
                Caption = 'Dimensions-Single';
                Image = Dimensions;
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = const(50535),
                                      "No." = field(Code);
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
            }
        }
    }

    var
        myInt: Integer;
}