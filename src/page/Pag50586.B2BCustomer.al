page 50586 B2BCustomer
{
    PageType = API;
    Caption = 'B2BCustomer';
    APIPublisher = 'OnTarget';
    APIGroup = 'B2B';
    EntityName = 'B2BCustomer';
    EntitySetName = 'B2BCustomer';
    SourceTable = Customer;
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

                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(b2BCustSeq; Rec."B2B Cust_Seq")
                {
                    Caption = 'B2B Cust_Seq';
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
                field(state; Rec.State)
                {
                    Caption = 'State';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                }
                field(creditLimitLCY; Rec."Credit Limit (LCY)")
                {
                    Caption = 'Credit Limit (LCY)';
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }
                field(b2BOutstandingOrders; rec."Outstanding Orders (LCY)")
                {
                    Caption = 'B2B Outstanding Orders ($)';
                }
                field(b2BInShippingBal; Rec."B2B In Shipping_Bal")
                {
                    Caption = 'B2B In Shipping_Bal';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(surchargeCreditCard; Rec."Surcharge Credit Card")
                {
                    Caption = 'Surcharge Credit Card';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(b2BCodeABC; Rec."B2B Code ABC")
                {
                    Caption = 'B2B Code ABC';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
            }
        }
    }
}