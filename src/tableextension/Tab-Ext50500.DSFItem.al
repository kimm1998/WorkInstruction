tableextension 50500 "DSFItem" extends "Item"
{
    fields
    {
        field(50500; "FrameNo"; Code[20])
        {
            Caption = 'Bike Frame No';
            DataClassification = ToBeClassified;
            TableRelation = FrameDSF.FrameNo;
        }
        field(50501; "ModelNo"; Code[20])
        {
            Caption = 'Bike Model No.';
            DataClassification = ToBeClassified;
            TableRelation = ModelDSF."No.";
        }
        field(50502; "SizeNo"; Code[20])
        {
            Caption = 'Bike Size';
            DataClassification = ToBeClassified;
            TableRelation = FrameSizesDSF.No where(Frame = field(FrameNo));
        }
        field(50504; "RecordSN"; Boolean)
        {
            Caption = 'Record Serial Number';
            DataClassification = ToBeClassified;
        }
        field(50505; "RecordItemCategory"; Option)
        {
            Caption = 'Record Item Category';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Battery","BCU","Bike QR Code","GPS ConnectedCycle","GPS MAC","GPS MSN","Motor Controller","NFC Tag","Noa","Puce","RFID","Sentinel Lock","Sentinel Lock IMEI","STM UUID";
        }

        field(50510; "BuAssignment"; Code[20])
        {
            Caption = 'BU Assignment';
            DataClassification = ToBeClassified;
            TableRelation = "Business Unit Lookup";
        }
        field(50511; "FactoryDepartment"; Option)
        {
            Caption = 'Factory Department';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Painting"," Manufacturing"," Assembly"," Supply";
        }
        field(50512; "Files_Location"; Text[100])
        {
            Caption = 'Files_Location';
            DataClassification = ToBeClassified;
        }
        // field(50513; "Family No."; Code[20])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Family Line"."Family No." where("Item No." = field("No.")));
        // }
    }
}
