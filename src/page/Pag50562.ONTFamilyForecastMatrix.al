page 50562 "ONT Family Forecast Matrix"
{
    Caption = 'Family Forecast Matrix';
    DataCaptionExpression = ProductionForecastName;
    PageType = ListPart;
    SourceTable = "ONT Forecast Family Loc";
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                ShowCaption = false;

                field("Family"; Rec."Family")
                {
                    ApplicationArea = Planning;
                    Caption = 'Family';
                    Editable = false;
                }
                field("Family Description"; Rec."Family Description")
                {
                    ApplicationArea = Planning;
                    Caption = 'Description';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Planning;
                    Editable = false;
                    Visible = ShowLocations;
                }

                // ---- Period cells: bind to scalar vars, not array indices ----
                field(Field1; Cell1) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap1; DecimalPlaces = 0 : 5; Visible = Vis1; trigger OnValidate() begin QtyValidate(1); end; }
                field(Field2; Cell2) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap2; DecimalPlaces = 0 : 5; Visible = Vis2; trigger OnValidate() begin QtyValidate(2); end; }
                field(Field3; Cell3) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap3; DecimalPlaces = 0 : 5; Visible = Vis3; trigger OnValidate() begin QtyValidate(3); end; }
                field(Field4; Cell4) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap4; DecimalPlaces = 0 : 5; Visible = Vis4; trigger OnValidate() begin QtyValidate(4); end; }
                field(Field5; Cell5) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap5; DecimalPlaces = 0 : 5; Visible = Vis5; trigger OnValidate() begin QtyValidate(5); end; }
                field(Field6; Cell6) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap6; DecimalPlaces = 0 : 5; Visible = Vis6; trigger OnValidate() begin QtyValidate(6); end; }
                field(Field7; Cell7) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap7; DecimalPlaces = 0 : 5; Visible = Vis7; trigger OnValidate() begin QtyValidate(7); end; }
                field(Field8; Cell8) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap8; DecimalPlaces = 0 : 5; Visible = Vis8; trigger OnValidate() begin QtyValidate(8); end; }
                field(Field9; Cell9) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap9; DecimalPlaces = 0 : 5; Visible = Vis9; trigger OnValidate() begin QtyValidate(9); end; }
                field(Field10; Cell10) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap10; DecimalPlaces = 0 : 5; Visible = Vis10; trigger OnValidate() begin QtyValidate(10); end; }
                field(Field11; Cell11) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap11; DecimalPlaces = 0 : 5; Visible = Vis11; trigger OnValidate() begin QtyValidate(11); end; }
                field(Field12; Cell12) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap12; DecimalPlaces = 0 : 5; Visible = Vis12; trigger OnValidate() begin QtyValidate(12); end; }
                field(Field13; Cell13) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap13; DecimalPlaces = 0 : 5; Visible = Vis13; trigger OnValidate() begin QtyValidate(13); end; }
                field(Field14; Cell14) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap14; DecimalPlaces = 0 : 5; Visible = Vis14; trigger OnValidate() begin QtyValidate(14); end; }
                field(Field15; Cell15) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap15; DecimalPlaces = 0 : 5; Visible = Vis15; trigger OnValidate() begin QtyValidate(15); end; }
                field(Field16; Cell16) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap16; DecimalPlaces = 0 : 5; Visible = Vis16; trigger OnValidate() begin QtyValidate(16); end; }
                field(Field17; Cell17) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap17; DecimalPlaces = 0 : 5; Visible = Vis17; trigger OnValidate() begin QtyValidate(17); end; }
                field(Field18; Cell18) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap18; DecimalPlaces = 0 : 5; Visible = Vis18; trigger OnValidate() begin QtyValidate(18); end; }
                field(Field19; Cell19) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap19; DecimalPlaces = 0 : 5; Visible = Vis19; trigger OnValidate() begin QtyValidate(19); end; }
                field(Field20; Cell20) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap20; DecimalPlaces = 0 : 5; Visible = Vis20; trigger OnValidate() begin QtyValidate(20); end; }
                field(Field21; Cell21) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap21; DecimalPlaces = 0 : 5; Visible = Vis21; trigger OnValidate() begin QtyValidate(21); end; }
                field(Field22; Cell22) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap22; DecimalPlaces = 0 : 5; Visible = Vis22; trigger OnValidate() begin QtyValidate(22); end; }
                field(Field23; Cell23) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap23; DecimalPlaces = 0 : 5; Visible = Vis23; trigger OnValidate() begin QtyValidate(23); end; }
                field(Field24; Cell24) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap24; DecimalPlaces = 0 : 5; Visible = Vis24; trigger OnValidate() begin QtyValidate(24); end; }
                field(Field25; Cell25) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap25; DecimalPlaces = 0 : 5; Visible = Vis25; trigger OnValidate() begin QtyValidate(25); end; }
                field(Field26; Cell26) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap26; DecimalPlaces = 0 : 5; Visible = Vis26; trigger OnValidate() begin QtyValidate(26); end; }
                field(Field27; Cell27) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap27; DecimalPlaces = 0 : 5; Visible = Vis27; trigger OnValidate() begin QtyValidate(27); end; }
                field(Field28; Cell28) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap28; DecimalPlaces = 0 : 5; Visible = Vis28; trigger OnValidate() begin QtyValidate(28); end; }
                field(Field29; Cell29) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap29; DecimalPlaces = 0 : 5; Visible = Vis29; trigger OnValidate() begin QtyValidate(29); end; }
                field(Field30; Cell30) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap30; DecimalPlaces = 0 : 5; Visible = Vis30; trigger OnValidate() begin QtyValidate(30); end; }
                field(Field31; Cell31) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap31; DecimalPlaces = 0 : 5; Visible = Vis31; trigger OnValidate() begin QtyValidate(31); end; }
                field(Field32; Cell32) { ApplicationArea = Planning; BlankZero = true; CaptionClass = Cap32; DecimalPlaces = 0 : 5; Visible = Vis32; trigger OnValidate() begin QtyValidate(32); end; }
            }
        }
    }

    var
        // Matrix data (server-side arrays)
        MATRIX_CaptionSet: array[32] of Text[80];
        MatrixRecords: array[32] of Record Date;
        MATRIX_NoOfMatrixColumns: Integer;

        // Bound field values (client-safe)
        Cell1: Decimal;
        Cell2: Decimal;
        Cell3: Decimal;
        Cell4: Decimal;
        Cell5: Decimal;
        Cell6: Decimal;
        Cell7: Decimal;
        Cell8: Decimal;
        Cell9: Decimal;
        Cell10: Decimal;
        Cell11: Decimal;
        Cell12: Decimal;
        Cell13: Decimal;
        Cell14: Decimal;
        Cell15: Decimal;
        Cell16: Decimal;
        Cell17: Decimal;
        Cell18: Decimal;
        Cell19: Decimal;
        Cell20: Decimal;
        Cell21: Decimal;
        Cell22: Decimal;
        Cell23: Decimal;
        Cell24: Decimal;
        Cell25: Decimal;
        Cell26: Decimal;
        Cell27: Decimal;
        Cell28: Decimal;
        Cell29: Decimal;
        Cell30: Decimal;
        Cell31: Decimal;
        Cell32: Decimal;

        // Visibility flags (client-safe)
        Vis1: Boolean;
        Vis2: Boolean;
        Vis3: Boolean;
        Vis4: Boolean;
        Vis5: Boolean;
        Vis6: Boolean;
        Vis7: Boolean;
        Vis8: Boolean;
        Vis9: Boolean;
        Vis10: Boolean;
        Vis11: Boolean;
        Vis12: Boolean;
        Vis13: Boolean;
        Vis14: Boolean;
        Vis15: Boolean;
        Vis16: Boolean;
        Vis17: Boolean;
        Vis18: Boolean;
        Vis19: Boolean;
        Vis20: Boolean;
        Vis21: Boolean;
        Vis22: Boolean;
        Vis23: Boolean;
        Vis24: Boolean;
        Vis25: Boolean;
        Vis26: Boolean;
        Vis27: Boolean;
        Vis28: Boolean;
        Vis29: Boolean;
        Vis30: Boolean;
        Vis31: Boolean;
        Vis32: Boolean;

        // Caption classes (client-safe)
        Cap1: Text[1024];
        Cap2: Text[1024];
        Cap3: Text[1024];
        Cap4: Text[1024];
        Cap5: Text[1024];
        Cap6: Text[1024];
        Cap7: Text[1024];
        Cap8: Text[1024];
        Cap9: Text[1024];
        Cap10: Text[1024];
        Cap11: Text[1024];
        Cap12: Text[1024];
        Cap13: Text[1024];
        Cap14: Text[1024];
        Cap15: Text[1024];
        Cap16: Text[1024];
        Cap17: Text[1024];
        Cap18: Text[1024];
        Cap19: Text[1024];
        Cap20: Text[1024];
        Cap21: Text[1024];
        Cap22: Text[1024];
        Cap23: Text[1024];
        Cap24: Text[1024];
        Cap25: Text[1024];
        Cap26: Text[1024];
        Cap27: Text[1024];
        Cap28: Text[1024];
        Cap29: Text[1024];
        Cap30: Text[1024];
        Cap31: Text[1024];
        Cap32: Text[1024];

        // Header/state
        ProductionForecastName: Code[10];
        DateFilter: Text;
        QtyType: Enum "Analysis Amount Type";
        ShowLocations: Boolean;

        // External filters (text views) – used by LoadData()
        FamilyFilterText: Text;
        LocationFilterText: Text;

    trigger OnInit()
    begin
        // default visible – will be refined in SetVisible()
        Vis1 := true;
        Vis2 := true;
        Vis3 := true;
        Vis4 := true;
        Vis5 := true;
        Vis6 := true;
        Vis7 := true;
        Vis8 := true;
        Vis9 := true;
        Vis10 := true;
        Vis11 := true;
        Vis12 := true;
        Vis13 := true;
        Vis14 := true;
        Vis15 := true;
        Vis16 := true;
        Vis17 := true;
        Vis18 := true;
        Vis19 := true;
        Vis20 := true;
        Vis21 := true;
        Vis22 := true;
        Vis23 := true;
        Vis24 := true;
        Vis25 := true;
        Vis26 := true;
        Vis27 := true;
        Vis28 := true;
        Vis29 := true;
        Vis30 := true;
        Vis31 := true;
        Vis32 := true;
    end;

    trigger OnAfterGetRecord()
    var
        col: Integer;
        qty: Decimal;
    begin
        // Clear cells
        ClearCells();

        // Fill cells from FlowField for each column
        col := 0;
        while col < MATRIX_NoOfMatrixColumns do begin
            col += 1;

            SetDateFilter(col);

            if ProductionForecastName <> '' then
                Rec.SetRange("Production Forecast Name", ProductionForecastName)
            else
                Rec.SetRange("Production Forecast Name");

            if Rec."Location Code" <> '' then
                Rec.SetFilter("Location Filter", Rec."Location Code")
            else
                Rec.SetRange("Location Filter");

            Rec.CalcFields("Family Forecast Qty");
            qty := Rec."Family Forecast Qty";
            SetCell(col, qty);
        end;

        if (col > 0) and (QtyType = QtyType::"Net Change") then
            Rec.SetRange("Date Filter", MatrixRecords[1]."Period Start", MatrixRecords[col]."Period End");
    end;

    procedure Load(
        MatrixCaptions: array[32] of Text[1024];
        var MatrixRecs: array[32] of Record Date;
        ForecastName: Code[10];
        DateFilterParam: Text;
        QtyTypeParam: Enum "Analysis Amount Type";
        NoOfCols: Integer;
        FamilyFilterParam: Text;
        LocationFilterParam: Text;
        IncludeLocations: Boolean)
    begin
        CopyArray(MATRIX_CaptionSet, MatrixCaptions, 1);
        CopyArray(MatrixRecords, MatrixRecs, 1);
        MATRIX_NoOfMatrixColumns := NoOfCols;

        ProductionForecastName := ForecastName;
        DateFilter := DateFilterParam;
        QtyType := QtyTypeParam;
        ShowLocations := IncludeLocations;

        FamilyFilterText := FamilyFilterParam;
        LocationFilterText := LocationFilterParam;

        SetVisible();
        SetCaptionClasses();
        LoadData();
    end;

    local procedure SetVisible()
    begin
        Vis1 := MATRIX_CaptionSet[1] <> '';
        Vis2 := MATRIX_CaptionSet[2] <> '';
        Vis3 := MATRIX_CaptionSet[3] <> '';
        Vis4 := MATRIX_CaptionSet[4] <> '';
        Vis5 := MATRIX_CaptionSet[5] <> '';
        Vis6 := MATRIX_CaptionSet[6] <> '';
        Vis7 := MATRIX_CaptionSet[7] <> '';
        Vis8 := MATRIX_CaptionSet[8] <> '';
        Vis9 := MATRIX_CaptionSet[9] <> '';
        Vis10 := MATRIX_CaptionSet[10] <> '';
        Vis11 := MATRIX_CaptionSet[11] <> '';
        Vis12 := MATRIX_CaptionSet[12] <> '';
        Vis13 := MATRIX_CaptionSet[13] <> '';
        Vis14 := MATRIX_CaptionSet[14] <> '';
        Vis15 := MATRIX_CaptionSet[15] <> '';
        Vis16 := MATRIX_CaptionSet[16] <> '';
        Vis17 := MATRIX_CaptionSet[17] <> '';
        Vis18 := MATRIX_CaptionSet[18] <> '';
        Vis19 := MATRIX_CaptionSet[19] <> '';
        Vis20 := MATRIX_CaptionSet[20] <> '';
        Vis21 := MATRIX_CaptionSet[21] <> '';
        Vis22 := MATRIX_CaptionSet[22] <> '';
        Vis23 := MATRIX_CaptionSet[23] <> '';
        Vis24 := MATRIX_CaptionSet[24] <> '';
        Vis25 := MATRIX_CaptionSet[25] <> '';
        Vis26 := MATRIX_CaptionSet[26] <> '';
        Vis27 := MATRIX_CaptionSet[27] <> '';
        Vis28 := MATRIX_CaptionSet[28] <> '';
        Vis29 := MATRIX_CaptionSet[29] <> '';
        Vis30 := MATRIX_CaptionSet[30] <> '';
        Vis31 := MATRIX_CaptionSet[31] <> '';
        Vis32 := MATRIX_CaptionSet[32] <> '';
    end;

    local procedure SetCaptionClasses()
    begin
        Cap1 := '3,' + MATRIX_CaptionSet[1];
        Cap2 := '3,' + MATRIX_CaptionSet[2];
        Cap3 := '3,' + MATRIX_CaptionSet[3];
        Cap4 := '3,' + MATRIX_CaptionSet[4];
        Cap5 := '3,' + MATRIX_CaptionSet[5];
        Cap6 := '3,' + MATRIX_CaptionSet[6];
        Cap7 := '3,' + MATRIX_CaptionSet[7];
        Cap8 := '3,' + MATRIX_CaptionSet[8];
        Cap9 := '3,' + MATRIX_CaptionSet[9];
        Cap10 := '3,' + MATRIX_CaptionSet[10];
        Cap11 := '3,' + MATRIX_CaptionSet[11];
        Cap12 := '3,' + MATRIX_CaptionSet[12];
        Cap13 := '3,' + MATRIX_CaptionSet[13];
        Cap14 := '3,' + MATRIX_CaptionSet[14];
        Cap15 := '3,' + MATRIX_CaptionSet[15];
        Cap16 := '3,' + MATRIX_CaptionSet[16];
        Cap17 := '3,' + MATRIX_CaptionSet[17];
        Cap18 := '3,' + MATRIX_CaptionSet[18];
        Cap19 := '3,' + MATRIX_CaptionSet[19];
        Cap20 := '3,' + MATRIX_CaptionSet[20];
        Cap21 := '3,' + MATRIX_CaptionSet[21];
        Cap22 := '3,' + MATRIX_CaptionSet[22];
        Cap23 := '3,' + MATRIX_CaptionSet[23];
        Cap24 := '3,' + MATRIX_CaptionSet[24];
        Cap25 := '3,' + MATRIX_CaptionSet[25];
        Cap26 := '3,' + MATRIX_CaptionSet[26];
        Cap27 := '3,' + MATRIX_CaptionSet[27];
        Cap28 := '3,' + MATRIX_CaptionSet[28];
        Cap29 := '3,' + MATRIX_CaptionSet[29];
        Cap30 := '3,' + MATRIX_CaptionSet[30];
        Cap31 := '3,' + MATRIX_CaptionSet[31];
        Cap32 := '3,' + MATRIX_CaptionSet[32];
    end;

    local procedure SetDateFilter(ColumnID: Integer)
    begin
        if DateFilter <> '' then
            MatrixRecords[ColumnID].SetFilter("Period Start", DateFilter)
        else
            MatrixRecords[ColumnID].SetRange("Period Start");

        if QtyType = QtyType::"Net Change" then
            if MatrixRecords[ColumnID]."Period Start" = MatrixRecords[ColumnID]."Period End" then
                Rec.SetRange("Date Filter", MatrixRecords[ColumnID]."Period Start")
            else
                Rec.SetRange("Date Filter", MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End")
        else
            Rec.SetRange("Date Filter", 0D, MatrixRecords[ColumnID]."Period End");
    end;

    local procedure LoadData()
    var
        Family: Record "Family";
        Loc: Record Location;
        EntryNo: Integer;
    begin
        Rec.DeleteAll();
        EntryNo := 0;

        if FamilyFilterText <> '' then
            Family.SetView(FamilyFilterText);

        if Family.IsEmpty() then
            exit;

        if ShowLocations then begin
            if LocationFilterText <> '' then
                Loc.SetFilter(Code, LocationFilterText)
            else
                Loc.SetRange(Code);

            if Loc.FindSet() then
                repeat
                    if Family.FindSet() then
                        repeat
                            EntryNo += 1;
                            Rec.Init();
                            Rec."Entry No." := EntryNo;
                            Rec."Family" := Family."No.";
                            Rec."Family Description" := Family.Description;
                            Rec."Location Code" := Loc.Code;
                            Rec.Insert();
                        until Family.Next() = 0;
                until Loc.Next() = 0;
        end else begin
            if Family.FindSet() then
                repeat
                    EntryNo += 1;
                    Rec.Init();
                    Rec."Entry No." := EntryNo;
                    Rec."Family" := Family."No.";
                    Rec."Family Description" := Family.Description;
                    Rec."Location Code" := '';
                    Rec.Insert();
                until Family.Next() = 0;
        end;

        if not Rec.IsEmpty() then
            Rec.FindFirst();
    end;

    local procedure QtyValidate(ColumnID: Integer)
    begin
        UpsertBucket(ColumnID, GetCell(ColumnID));
    end;

    local procedure UpsertBucket(ColumnID: Integer; NewQty: Decimal)
    var
        Fam: Record "ONT Family Forecast Entry";
        Dt: Date;
    begin
        // Persist at period start, similar to standard behavior
        Dt := MatrixRecords[ColumnID]."Period Start";

        Fam.Reset();
        Fam.SetRange("Production Forecast Name", ProductionForecastName);
        Fam.SetRange("Family", Rec."Family");
        Fam.SetRange("Location Code", Rec."Location Code");
        Fam.SetRange(Date, Dt);

        if NewQty = 0 then begin
            if not Fam.IsEmpty() then
                Fam.DeleteAll();
            exit;
        end;

        if Fam.FindFirst() then begin
            Fam.Validate(Quantity, NewQty);
            Fam.Modify(true);
        end else begin
            Fam.Init();
            Fam.Validate("Production Forecast Name", ProductionForecastName);
            Fam.Validate("Family", Rec."Family");
            Fam.Validate("Location Code", Rec."Location Code");
            Fam.Validate(Date, Dt);
            Fam.Validate(Quantity, NewQty);
            Fam.Insert(true);
        end;
    end;

    // ---------- helpers to map column index <-> scalar vars ----------
    local procedure ClearCells()
    begin
        Cell1 := 0;
        Cell2 := 0;
        Cell3 := 0;
        Cell4 := 0;
        Cell5 := 0;
        Cell6 := 0;
        Cell7 := 0;
        Cell8 := 0;
        Cell9 := 0;
        Cell10 := 0;
        Cell11 := 0;
        Cell12 := 0;
        Cell13 := 0;
        Cell14 := 0;
        Cell15 := 0;
        Cell16 := 0;
        Cell17 := 0;
        Cell18 := 0;
        Cell19 := 0;
        Cell20 := 0;
        Cell21 := 0;
        Cell22 := 0;
        Cell23 := 0;
        Cell24 := 0;
        Cell25 := 0;
        Cell26 := 0;
        Cell27 := 0;
        Cell28 := 0;
        Cell29 := 0;
        Cell30 := 0;
        Cell31 := 0;
        Cell32 := 0;
    end;

    local procedure SetCell(Index: Integer; Value: Decimal)
    begin
        case Index of
            1:
                Cell1 := Value;
            2:
                Cell2 := Value;
            3:
                Cell3 := Value;
            4:
                Cell4 := Value;
            5:
                Cell5 := Value;
            6:
                Cell6 := Value;
            7:
                Cell7 := Value;
            8:
                Cell8 := Value;
            9:
                Cell9 := Value;
            10:
                Cell10 := Value;
            11:
                Cell11 := Value;
            12:
                Cell12 := Value;
            13:
                Cell13 := Value;
            14:
                Cell14 := Value;
            15:
                Cell15 := Value;
            16:
                Cell16 := Value;
            17:
                Cell17 := Value;
            18:
                Cell18 := Value;
            19:
                Cell19 := Value;
            20:
                Cell20 := Value;
            21:
                Cell21 := Value;
            22:
                Cell22 := Value;
            23:
                Cell23 := Value;
            24:
                Cell24 := Value;
            25:
                Cell25 := Value;
            26:
                Cell26 := Value;
            27:
                Cell27 := Value;
            28:
                Cell28 := Value;
            29:
                Cell29 := Value;
            30:
                Cell30 := Value;
            31:
                Cell31 := Value;
            32:
                Cell32 := Value;
        end;
    end;

    local procedure GetCell(Index: Integer): Decimal
    begin
        case Index of
            1:
                exit(Cell1);
            2:
                exit(Cell2);
            3:
                exit(Cell3);
            4:
                exit(Cell4);
            5:
                exit(Cell5);
            6:
                exit(Cell6);
            7:
                exit(Cell7);
            8:
                exit(Cell8);
            9:
                exit(Cell9);
            10:
                exit(Cell10);
            11:
                exit(Cell11);
            12:
                exit(Cell12);
            13:
                exit(Cell13);
            14:
                exit(Cell14);
            15:
                exit(Cell15);
            16:
                exit(Cell16);
            17:
                exit(Cell17);
            18:
                exit(Cell18);
            19:
                exit(Cell19);
            20:
                exit(Cell20);
            21:
                exit(Cell21);
            22:
                exit(Cell22);
            23:
                exit(Cell23);
            24:
                exit(Cell24);
            25:
                exit(Cell25);
            26:
                exit(Cell26);
            27:
                exit(Cell27);
            28:
                exit(Cell28);
            29:
                exit(Cell29);
            30:
                exit(Cell30);
            31:
                exit(Cell31);
            32:
                exit(Cell32);
        end;
    end;
}
