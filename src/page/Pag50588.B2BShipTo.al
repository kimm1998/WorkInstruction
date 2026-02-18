page 50588 B2BShipTo
{
    PageType = API;
    Caption = 'B2BShipTo';
    APIPublisher = 'OnTarget';
    APIGroup = 'B2B';
    EntityName = 'B2BShipTo';
    EntitySetName = 'B2BShipTo';
    SourceTable = "Ship-to Address";
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    APIVersion = 'v2.0';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
            }
        }
    }
}