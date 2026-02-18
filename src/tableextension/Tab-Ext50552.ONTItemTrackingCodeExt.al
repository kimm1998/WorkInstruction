tableextension 50552 "ONT Item Tracking Code Ext" extends "Item Tracking Code"
{
    fields
    {
        field(50500; "ONT Maintenance Required"; Boolean)
        {
            Caption = 'Require Maintenance';
            DataClassification = CustomerContent;
        }
        field(50501; "ONT Maintenance Interval"; DateFormula)
        {
            Caption = 'Maintenance Interval (Override)';
            DataClassification = CustomerContent;
            ToolTip = 'Overrides the Item default maintenance interval for this lot.';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}