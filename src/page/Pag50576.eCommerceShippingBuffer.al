page 50576 "eCommerce Shipping Buffer"
{
    ApplicationArea = All;
    Caption = 'eCommerce Shipping Buffer';
    PageType = Worksheet;
    SourceTable = "eCommerce Shipping Buffer";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Days to shipping"; Rec."Days to shipping")
                {
                    ToolTip = 'Specifies the value of the Days to shipping field.';
                }
                field("Buffer Days"; Rec."Buffer Days")
                {
                    ToolTip = 'Specifies the value of the Buffer Days field.';
                }
            }
        }
    }
}
