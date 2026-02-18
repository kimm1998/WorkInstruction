tableextension 50515 "Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(80000; "Revision No."; Code[3])
        {
            Caption = 'Revision No.';
            DataClassification = CustomerContent;
        }
        field(80001; "Whse Receipt No."; Code[20])
        {
            Caption = 'Whse. Receipt No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Receipt Line"."No." where("Source Document" = const("Purchase Order"), "Source No." = field("Document No."), "Source Line No." = field("Line No.")));
        }
        field(80002; "Manufacturing Lead Time"; DateFormula)
        {
            Caption = 'Manufacturing Lead Time';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                UpdateLeadTime();
            end;
        }
        field(80003; "Transit Lead Time"; DateFormula)
        {
            Caption = 'Transit Lead Time';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                UpdateLeadTime();
            end;
        }
        field(80004; "Requested Ship Date"; Date)
        {
            Caption = 'Requested Ship Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ErrLbl: Label 'You cannot change the Requested Ship Date when the Promised Ship Date has been filled in.';
            begin
                if "Promised Ship Date" <> 0D then Error(ErrLbl);
                Validate("Planned Ship Date", "Requested Ship Date");
            end;
        }
        field(80005; "Promised Ship Date"; Date)
        {
            Caption = 'Promised Ship Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Promised Ship Date" <> 0D then Validate("Planned Ship Date", "Promised Ship Date");
            end;
        }
        field(80006; "Planned Ship Date"; Date)
        {
            Caption = 'Planned Ship Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Planned Ship Date" <> 0D then Validate("Planned Receipt Date", CalcDate("Transit Lead Time", "Planned Ship Date"));
            end;
        }
        field(80007; "Container ID"; Code[30])
        {
            Caption = 'Container ID';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Receipt Header"."Container ID" where("No." = field("Whse Receipt No.")));
        }
        field(80008; "Import Custom Rate %"; Decimal)
        {
            Caption = 'Import Custom Rate %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        
    }



    procedure UpdateLeadTime()
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
