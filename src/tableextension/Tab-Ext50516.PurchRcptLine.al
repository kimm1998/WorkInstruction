tableextension 50516 "Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50500; "Revision No."; Code[3])
        {
            Caption = 'Revision No.';
            DataClassification = CustomerContent;
        }
        field(50501; "Label Printed"; Boolean)
        {

        }
        field(50502; "Manufacturing Lead Time"; DateFormula)
        {
            Caption = 'Manufacturing Lead Time';
            DataClassification = CustomerContent;
        }
        field(50503; "Transit Lead Time"; DateFormula)
        {
            Caption = 'Transit Lead Time';
            DataClassification = CustomerContent;
        }
        field(50504; "Requested Ship Date"; Date)
        {
            Caption = 'Requested Ship Date';
            DataClassification = CustomerContent;
        }
        field(50505; "Promised Ship Date"; Date)
        {
            Caption = 'Promised Ship Date';
            DataClassification = CustomerContent;
        }
        field(50506; "Planned Ship Date"; Date)
        {
            Caption = 'Planned Ship Date';
            DataClassification = CustomerContent;
        }

    }
}
