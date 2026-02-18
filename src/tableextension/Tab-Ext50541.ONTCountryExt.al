tableextension 50541 "ONT Country Ext" extends "Country/Region"
{
    fields
    {
        field(50500; "ONT HS Market"; Code[20])
        {
            Caption = 'HS Market';
            DataClassification = CustomerContent;

            // This now looks up strictly from the new "ONT Sales Market" table
            TableRelation = "ONT HS Market";
        }
    }
}
