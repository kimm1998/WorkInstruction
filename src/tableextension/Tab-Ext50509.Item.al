tableextension 50509 "Item" extends Item
{
    fields
    {
        field(80000; "Item Status"; Code[20])
        {
            Caption = 'Item Status';
            DataClassification = CustomerContent;
            TableRelation = "Item Status"."Code";

            trigger OnValidate()
            var
                ItemStatus: Record "Item Status";
            begin
                If ItemStatus.Get("Item Status") then begin
                    Blocked := ItemStatus."Blocked (Any transaction)";
                    "Sales Blocked" := ItemStatus."Blocked Sales";
                    "Purchasing Blocked" := ItemStatus."Blocked Purchase";
                end;
            end;
        }
        field(80001; "Item Status Desc."; Text[200])
        {
            Caption = 'Item Status';
            DataClassification = CustomerContent;
            TableRelation = "Item Status"."Description";

            trigger OnValidate()
            var
                ItemStatus: Record "Item Status";
            begin
                ItemStatus.SetRange("Description", "Item Status Desc.");
                If ItemStatus.FindFirst() then begin
                    Blocked := ItemStatus."Blocked (Any transaction)";
                    "Sales Blocked" := ItemStatus."Blocked Sales";
                    "Purchasing Blocked" := ItemStatus."Blocked Purchase";
                end;
            end;

            trigger OnLookup()
            var
                ItemStatus: Record "Item Status";
                ItemStatusList: Page "Item Status";
            begin
                CLEAR(ItemStatusList);
                ItemStatusList.LOOKUPMODE(TRUE);
                IF ItemStatusList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    ItemStatusList.GETRECORD(ItemStatus);
                    Validate("Item Status Desc.", ItemStatus."Description");
                END;
            end;
        }
        field(80002; "Revision No."; code[3])
        {
            Caption = 'Revision No.';
            DataClassification = CustomerContent;
        }
        field(80003; "HS Code Count"; Integer)
        {
            Caption = 'HS Code Count';
            CalcFormula = count("Custom Rate" where("Item No." = FIELD("No."), "Country/Region" = filter(<> ''), "Tariff No." = filter(<> '')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80008; "Import Custom Rate %"; Decimal)
        {
            Caption = 'Import Custom Rate %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            FieldClass = FlowField;
            CalcFormula = lookup("Custom Rate"."Custom Rate" where("Item No." = field("No."), "HS Market" = const('CAN'), "Country/Region" = field("Country/Region of Origin Code"), "Tariff No." = field("Tariff No.")));
        }
        field(90227; "ONT Label Layout"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "None","Raw Material","Finished Product";
        }
        field(80009; "ONT Family Code"; Code[20])
        {
            Caption = 'Family Code';
            TableRelation = Family;
            DataClassification = CustomerContent;
        }
    }
}
