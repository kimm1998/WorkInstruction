table 50535 "ONT Sales Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ONT Sales Type List";

    fields
    {
        // field(1; "Document Type"; Enum "Sales Document Type")
        // {
        //     DataClassification = ToBeClassified;

        // }
        field(1; Code; Code[50])
        {
            NotBlank = true;
        }
        field(3; Description; Text[100])
        { }
        field(4; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(5; "Payment term"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(6; "Customer Discount Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(7; "Fixed Rate"; Decimal)
        {
        }

        field(8; "Shipping Formula"; Enum "ONT Shipping Formula")
        {
            Caption = 'Shipping Formula';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

}