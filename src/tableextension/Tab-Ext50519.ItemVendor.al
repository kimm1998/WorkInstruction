tableextension 50519 "Item Vendor" extends "Item Vendor"
{
    fields
    {
        field(80000; "Manufacturing Lead Time"; DateFormula)
        {
            Caption = 'Manufacturing Lead Time';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLeadTime();
            end;
        }
        field(80001; "Transit Lead Time"; DateFormula)
        {
            Caption = 'Transit Lead Time';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateLeadTime();
            end;
        }
    }
    local procedure UpdateLeadTime()
    var
        _varDate1: Date;
        _varDate2: Date;
        _daysTxt: Text;
    begin
        _varDate1 := CalcDate("Manufacturing Lead Time", Today);
        _varDate2 := CalcDate("Transit Lead Time", _varDate1);
        if Today > _varDate2 then exit;
        _daysTxt := '<' + format(_varDate2 - Today) + 'D>';
        Evaluate("Lead Time Calculation", _daysTxt);
    end;
}
