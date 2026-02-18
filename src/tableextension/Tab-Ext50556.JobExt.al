tableextension 50556 JobExt extends Job
{
    fields
    {
        field(50500; RSDECategory; code[20])
        {
            TableRelation = T_RSDECategory.Code;
            
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}