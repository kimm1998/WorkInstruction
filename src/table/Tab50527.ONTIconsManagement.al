table 50527 "ONT Icons Management"
{
    DataClassification = ToBeClassified;
    Caption = 'Icons Management';
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; Name; Enum "ONT Availability Status")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Import_icons();
            end;

        }
        field(3; Icon; Blob)
        {
            Subtype = Bitmap;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    local procedure Import_icons()
    var

        fileName: Text;
        inStreamImage: InStream;
        OutStreamImage: OutStream;
        res: Boolean;
        Text0001: Label 'Icon imported No. %1';
        Text0002: Label 'Import Canceled!';
    begin
        res := UploadIntoStream('Please select an icon', '', 'All Files (*.bmp)|*.bmp', fileName, inStreamImage);

        if (res = true) then begin
            Icon.CreateOutStream(OutStreamImage);
            CopyStream(OutStreamImage, inStreamImage);
            Message(Text0001, "No.");
        end
        else
            Message(Text0002);
    end;



}

