table 50560 "ONT.Main. Workbench Buff."
{
    DataClassification = CustomerContent;
    Caption = 'Maintenance Workbench';

    fields
    {
        // The unique identifier for the record
        field(1; "Item No."; code[20])
        {
            Caption = 'Item No.';
        }
        // The main description of the task
        field(2; "Lot No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Serial No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Next Maintenance Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Last Maintenance Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SerialNoInfo: Record "Serial No. Information";
                LotNoInfo: Record "Lot No. Information";
                NExtMainDate: date;

            begin
                if rec."Is Lot Tracked" then begin
                    if LotNoInfo.Get(rec."Item No.", rec."Variant Code", rec."Lot No.") then begin
                        LotNoInfo."ONT Last Maintenance Date" := rec."Last Maintenance Date";
                        LotNoInfo."ONT Next Maintenance Date" := CalcDate(rec."Maintenance Interval", rec."Last Maintenance Date");
                        LotNoInfo.Modify();
                    end;
                end
                else begin
                    if SerialNoInfo.Get(rec."Item No.", rec."Variant Code", rec."Serial No.") then begin
                        SerialNoInfo."ONT Last Maintenance Date" := rec."Last Maintenance Date";
                        SerialNoInfo."ONT Next Maintenance Date" := CalcDate(rec."Maintenance Interval", rec."Last Maintenance Date");
                        SerialNoInfo.Modify();
                    end;
                end;

                rec."Next Maintenance Date" := CalcDate(rec."Maintenance Interval", rec."Last Maintenance Date");

            end;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; "Qty On Hand"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Location Filter"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Expired Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Date Filter"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Variant Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "ONT Expiration Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Maintenance Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Is Lot Tracked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Maintenance Interval"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        // A checkbox to mark completion;
    }

    keys
    {
        // The Primary Key makes every record unique
        key(PK; "Item No.", "Lot No.", "Serial No.")
        {
            Clustered = true;
        }
    }
}