tableextension 50535 "ONT Job Queue Entry" extends "Job Queue Entry"
{
    fields
    {
        // Add changes to table fields here
        field(70100; "ONT Last Succ. Run"; DateTime)
        {
            CalcFormula = max("Job Queue Log Entry"."End Date/Time" where(Status = Const(0), ID = field(ID)));
            Caption = 'Last Success Run';
            Editable = false;
            FieldClass = FlowField;
        }
    }

}