page 50565 "ONT Shortage Cost Summary"
{
    Caption = 'Cost Summary (by Commitment)';
    PageType = CardPart;
    ApplicationArea = Planning;

    layout
    {
        area(content)
        {
            group(Matrix)
            {
                Caption = 'Sum of Extended Cost (CAD)';

                group(RowOnTime)
                {
                    Caption = 'On Time';
                    field(OnTime_Committed; OnTime_Committed) { Caption = '00-Committed'; ApplicationArea = Planning; Editable = false; }
                    field(OnTime_Hard; OnTime_Hard) { Caption = '01-Hard Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(OnTime_NoCommit; OnTime_NoCommit) { Caption = '04-No Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(OnTime_Total; OnTime_Total) { Caption = 'Grand Total'; ApplicationArea = Planning; Editable = false; }
                }

                group(RowTooLate)
                {
                    Caption = 'Too Late';
                    field(Late_Committed; Late_Committed) { Caption = '00-Committed'; ApplicationArea = Planning; Editable = false; }
                    field(Late_Hard; Late_Hard) { Caption = '01-Hard Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(Late_NoCommit; Late_NoCommit) { Caption = '04-No Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(Late_Total; Late_Total) { Caption = 'Grand Total'; ApplicationArea = Planning; Editable = false; }
                }

                group(RowTooEarly)
                {
                    Caption = 'Too Early';
                    field(Early_Committed; Early_Committed) { Caption = '00-Committed'; ApplicationArea = Planning; Editable = false; }
                    field(Early_Hard; Early_Hard) { Caption = '01-Hard Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(Early_NoCommit; Early_NoCommit) { Caption = '04-No Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(Early_Total; Early_Total) { Caption = 'Grand Total'; ApplicationArea = Planning; Editable = false; }
                }

                group(RowGrandTotal)
                {
                    Caption = 'Grand Total';
                    field(Total_Committed; Total_Committed) { Caption = '00-Committed'; ApplicationArea = Planning; Editable = false; }
                    field(Total_Hard; Total_Hard) { Caption = '01-Hard Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(Total_NoCommit; Total_NoCommit) { Caption = '04-No Commitment'; ApplicationArea = Planning; Editable = false; }
                    field(Total_Grand; Total_Grand) { Caption = 'Grand Total'; ApplicationArea = Planning; Editable = false; }
                }
            }
        }
    }

    actions { }

    trigger OnOpenPage()
    begin
        ResetSums();
    end;

    procedure LoadFromView(viewText: Text)
    var
        Comp: Record "Prod. Order Component";
        extCost: Decimal;
        rowId: Integer;  // 1=OnTime, 2=Late, 3=Early
        colId: Integer;  // 1=Committed, 2=Hard, 3=NoCommit
    begin
        ResetSums();

        // Apply the same filters as the parent list
        Comp.SetView(viewText);

        if Comp.FindSet() then
            repeat
                extCost := GetExtCost(Comp);


                rowId := GetRowBucket(Comp);
                colId := GetCommitBucket(Comp);

                AddToBucket(rowId, colId, extCost);
            until Comp.Next() = 0;

        RecalcTotals();
        CurrPage.Update(false);
    end;

    local procedure GetExtCost(var Comp: Record "Prod. Order Component"): Decimal
    var
        value: Decimal;
    begin
        value := 0;

        // Prefer ONT Ext Cost CAD
        if Comp.FieldNo("ONT Ext Cost CAD") <> 0 then begin
            //Comp.CalcFields("ONT Ext Cost CAD");
            value := Comp."ONT Ext Cost CAD";
        end;

        // Fall back to ONT Extended Cost if needed
        if (value = 0) and (Comp.FieldNo("ONT Extended Cost") <> 0) then begin
            //Comp.CalcFields("ONT Extended Cost");
            value := Comp."ONT Extended Cost";
        end;

        exit(value);
    end;

    local procedure GetRowBucket(var Comp: Record "Prod. Order Component"): Integer
    var
        hasStatField: Boolean;
        late: Integer;
        early: Integer;
    begin
        hasStatField := Comp.FieldNo("ONT Availability Status") <> 0;

        if hasStatField then begin
            // Option members expected: "A Temps","Trop Tard","Trop Tôt"
            case Format(Comp."ONT Availability Status") of
                'A Temps':
                    exit(1); // On Time
                'Trop Tard':
                    exit(2); // Too Late
                'Trop Tôt':
                    exit(3); // Too Early
            end;
        end;

        // Fallback by day deltas
        late := 0;
        early := 0;
        if Comp.FieldNo("ONT Days Late") <> 0 then late := Comp."ONT Days Late";
        if Comp.FieldNo("ONT Days Early") <> 0 then early := Comp."ONT Days Early";

        if late > 0 then
            exit(2);
        if early > 0 then
            exit(3);
        exit(1);
    end;

    local procedure GetCommitBucket(var Comp: Record "Prod. Order Component"): Integer
    var
        confirmedDate: Date;
        promiseDate: Date;
    begin
        confirmedDate := 0D;
        promiseDate := 0D;

        if Comp.FieldNo("ONT Confirmed Date") <> 0 then
            confirmedDate := Comp."ONT Confirmed Date";
        if Comp.FieldNo("ONT Promise Date") <> 0 then
            promiseDate := Comp."ONT Promise Date";

        if confirmedDate <> 0D then
            exit(1); // 00-Committed
        if promiseDate <> 0D then
            exit(2); // 01-Hard Commitment
        exit(3);     // 04-No Commitment
    end;

    local procedure AddToBucket(rowId: Integer; colId: Integer; amount: Decimal)
    begin
        case rowId of
            1: // On Time
                case colId of
                    1:
                        OnTime_Committed += amount;
                    2:
                        OnTime_Hard += amount;
                    3:
                        OnTime_NoCommit += amount;
                end;
            2: // Too Late
                case colId of
                    1:
                        Late_Committed += amount;
                    2:
                        Late_Hard += amount;
                    3:
                        Late_NoCommit += amount;
                end;
            3: // Too Early
                case colId of
                    1:
                        Early_Committed += amount;
                    2:
                        Early_Hard += amount;
                    3:
                        Early_NoCommit += amount;
                end;
        end;
    end;

    local procedure RecalcTotals()
    begin
        OnTime_Total := OnTime_Committed + OnTime_Hard + OnTime_NoCommit;
        Late_Total := Late_Committed + Late_Hard + Late_NoCommit;
        Early_Total := Early_Committed + Early_Hard + Early_NoCommit;

        Total_Committed := OnTime_Committed + Late_Committed + Early_Committed;
        Total_Hard := OnTime_Hard + Late_Hard + Early_Hard;
        Total_NoCommit := OnTime_NoCommit + Late_NoCommit + Early_NoCommit;

        Total_Grand := OnTime_Total + Late_Total + Early_Total;
    end;

    local procedure ResetSums()
    begin
        OnTime_Committed := 0;
        OnTime_Hard := 0;
        OnTime_NoCommit := 0;
        OnTime_Total := 0;
        Late_Committed := 0;
        Late_Hard := 0;
        Late_NoCommit := 0;
        Late_Total := 0;
        Early_Committed := 0;
        Early_Hard := 0;
        Early_NoCommit := 0;
        Early_Total := 0;
        Total_Committed := 0;
        Total_Hard := 0;
        Total_NoCommit := 0;
        Total_Grand := 0;
    end;

    var
        // On Time row
        OnTime_Committed: Decimal;
        OnTime_Hard: Decimal;
        OnTime_NoCommit: Decimal;
        OnTime_Total: Decimal;

        // Too Late row
        Late_Committed: Decimal;
        Late_Hard: Decimal;
        Late_NoCommit: Decimal;
        Late_Total: Decimal;

        // Too Early row
        Early_Committed: Decimal;
        Early_Hard: Decimal;
        Early_NoCommit: Decimal;
        Early_Total: Decimal;

        // Grand totals
        Total_Committed: Decimal;
        Total_Hard: Decimal;
        Total_NoCommit: Decimal;
        Total_Grand: Decimal;
}
