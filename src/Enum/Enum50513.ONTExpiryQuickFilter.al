enum 50513 "ONT Expiry Quick Filter"
{
    Extensible = true;
    Caption = 'Expiry Quick Filter';

    value(0; All) { Caption = 'All'; }
    value(1; Expired) { Caption = 'Expired'; }
    value(2; NextWeek) { Caption = 'Next 7 days'; }
    value(3; NextMonth) { Caption = 'Next 30 days'; }
    value(4; Next60) { Caption = 'Next 60 days'; }
}
