page 50567 "ONT Order Header Info"
{
    Caption = 'Order Header';
    PageType = CardPart;
    SourceTable = "Production Order";
    ApplicationArea = Planning;
    Editable = false;

    layout
    {
        area(content)
        {
            group(Header)
            {
                Caption = 'Production Order';
                field(Status; Rec.Status) { ApplicationArea = Planning; }
                field("No."; Rec."No.") { ApplicationArea = Planning; }
                field(Description; Rec.Description) { ApplicationArea = Planning; }
                field("Source Type"; Rec."Source Type") { ApplicationArea = Planning; }
                field("Source No."; Rec."Source No.") { ApplicationArea = Planning; Caption = 'Source (Family/Item)'; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = Planning; }
                field("Due Date"; Rec."Due Date") { ApplicationArea = Planning; }
                // Custom header field you asked for earlier:
                field("ONT Demand Forecast"; Rec."ONT Demand Forecast")
                {
                    ApplicationArea = Planning;
                    Caption = 'Demand Forecast';
                }
            }
        }
    }
}
