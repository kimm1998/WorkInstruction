enum 50514 "ONT Maintenance Window"
{
    Extensible = true;
    Caption = 'Maintenance Window';

    value(0; All) { Caption = 'All'; }
    value(1; DueNow) { Caption = 'Due now / Overdue'; }
    value(2; Next7) { Caption = 'Next 7 days'; }
    value(3; Next30) { Caption = 'Next 30 days'; }
    value(4; Next60) { Caption = 'Next 60 days'; }
}
