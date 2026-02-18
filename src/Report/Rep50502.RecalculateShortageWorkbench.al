report 50502 "Recalculate Shortage Workbench"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Prod. Order Component"; "Prod. Order Component")
        {
            RequestFilterFields = Status, "Prod. Order No.", "Item No.", "Due Date";
            DataItemTableView = where("Earliest Avail. Date" = filter(<> 0D));
            trigger OnAfterGetRecord()
            var
                DifDays: Decimal;
            begin
                if "Earliest Avail. Date" <> 0D then begin
                    DifDays := "Earliest Avail. Date" - "Due Date";
                    if DifDays > 0 then begin
                        "ONT Days Late" := DifDays;
                        "ONT Availability Status" := "ONT Availability Status"::"Too Late";
                    end else begin
                        "ONT Days Early" := Abs(DifDays);
                        "ONT Availability Status" := "ONT Availability Status"::"Too Late";
                    end;
                    Modify();
                end;

            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }
    }


    var
}