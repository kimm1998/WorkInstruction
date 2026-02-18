tableextension 50545 "ONT Item Forecast Weight" extends Item
{
    fields
    {
        field(60100; "ONT Forecast Weight"; Decimal)
        {
            Caption = 'Forecast Weight';
            DecimalPlaces = 0 : 5;
            ToolTip = 'Relative weight for distributing family forecast to this item. Leave 0/blank to treat as 1.';
            DataClassification = CustomerContent;
        }

        field(60101; "ONT Maintenance Interval"; DateFormula)
        {
            Caption = 'Maintenance Interval';
            DataClassification = CustomerContent;
            ToolTip = 'Default interval between maintenance (e.g., recharging batteries). Leave blank if not applicable.';
        }
    }
}

    
