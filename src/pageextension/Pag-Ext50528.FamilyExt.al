pageextension 50528 FamilyExt extends Family
{
    layout
    {
        addlast(General)
        {
            field("Product Type"; Rec."Product Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Product Type field.', Comment = '%';
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    ValidateProductType();
                    ValidateFamilLines();
                    CurrPage.Update();

                end;
            }


            field("Life Cycle Code"; Rec."Life Cycle Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Life Cycle Code field.', Comment = '%';
            }
            field("Distrubution Type"; Rec."Distrubution Type")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    CurrPage.Update();

                end;
            }
        }
        addafter(General)
        {
            part(Bicycle; "Family Bicycle Card Part")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
                Visible = BicycleVisiblity;
            }
            part(FrameSet; "Family FrameSet Card Part")
            {
                ApplicationArea = all;
                Visible = FramesetVisiblity;
                SubPageLink = "No." = field("No.");
            }
            part(WARRANTYPART; "Family WARRANTYPART Card Part")
            {
                ApplicationArea = all;
                Visible = WarrantyPartVisiblity;
                SubPageLink = "No." = field("No.");
            }
            part(FORECASTITEM; "Family FORECASTITEM Card Part")
            {
                ApplicationArea = all;
                Visible = ForecastItemVisiblity;
                SubPageLink = "No." = field("No.");
            }
            part(RAWFRAME; "Family RAWFRAME Card Part")
            {
                ApplicationArea = all;
                Visible = RawFrameVisiblity;
                SubPageLink = "No." = field("No.");
            }
            part(PAINTEDFRAME; "Family PAINTEDFRAME Card Part")
            {
                ApplicationArea = all;
                Visible = PaintedFrameVisiblity;
                SubPageLink = "No." = field("No.");
            }
            part(FinishedPAINTEDFRAME; "Family PAINTEDFRAME Card Part")
            {
                ApplicationArea = all;
                Visible = FinishedPaintedFrameVisiblity;
                SubPageLink = "No." = field("No.");
            }
            part(TRANSFRMDTUBE; "Family TRANSFRMDTUBE Card Part")
            {
                ApplicationArea = all;
                Visible = TransformedTubeVisiblity;
                SubPageLink = "No." = field("No.");
            }


        }
        addafter(Control13)
        {
            part(Control14; "ONT Family Lines")
            {
                ApplicationArea = Manufacturing;
                SubPageLink = "Family No." = field("No.");
                Visible = (Rec."Distrubution Type" = rec."Distrubution Type"::Percentage);
                SubPageView = sorting("Family No.", "Line No.");

            }
        }
        modify(Control13)
        {
            Visible = (Rec."Distrubution Type" = rec."Distrubution Type"::Quantity);
        }
    }


    actions
    {
        // Add changes to page actions here
    }


    trigger OnOpenPage()
    var
        WhseSetup: Record "Warehouse Setup";
    begin

        ValidateProductType();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        DistributionPrctVisibility := (Rec."Distrubution Type" = rec."Distrubution Type"::Percentage);


    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        CalcTotalDistribution
    end;

    local procedure ValidateProductType()
    var
        ProductType: Record "ONT Family Product Type";
    begin
        BicycleVisiblity := false;
        FramesetVisiblity := false;
        ServicePartVisiblity := false;
        WarrantyPartVisiblity := false;
        ForecastItemVisiblity := false;
        RawFrameVisiblity := false;
        PaintedFrameVisiblity := false;
        FinishedPaintedFrameVisiblity := false;
        TransformedTubeVisiblity := false;
        if ProductType.Get(Rec."Product Type") then begin
            BicycleVisiblity := ProductType."Bicycle Fields Display";
            FramesetVisiblity := ProductType."Frameset Fields Display";
            ServicePartVisiblity := ProductType."Service Part Fields Display";
            WarrantyPartVisiblity := ProductType."Warranty Part Fields Display";
            ForecastItemVisiblity := ProductType."Forecast Item Fields Display";
            RawFrameVisiblity := ProductType."Raw Frame Fields Display";
            PaintedFrameVisiblity := ProductType."Painted Frame Fields Display";
            FinishedPaintedFrameVisiblity := ProductType."Fshd Pntd Frame Fields Display";
            TransformedTubeVisiblity := ProductType."Trnsfrmd Tube Fields Display";
        end;
        CurrPage.Update();

    end;

    local procedure ValidateFamilLines()
    var
        Lines: Record "Family Line";
    begin
        Lines.Reset();
        Lines.SetRange("Family No.", rec."No.");
        if Lines.FindFirst() then begin
            repeat
                lines.ValidateItemUnique(Lines."Item No.");
            until Lines.Next() = 0;
        end;
    end;

    local procedure CalcTotalDistribution()
    var
        myInt: Integer;
        Lines: Record "Family Line";
        TotalDistribution: Decimal;
    begin
        TotalDistribution := 0;
        lines.Reset();
        Lines.SetRange("Family No.", rec."No.");
        if lines.FindFirst() then begin
            repeat
                TotalDistribution += Lines."Distribution %";
            until lines.next = 0;
            if TotalDistribution <> 100 then
                if rec."Distrubution Type" = rec."Distrubution Type"::Percentage then
                    Error('Total Distribution Should be 100 %');
        end;
    end;

    var
        myInt: Integer;
        DistributionPrctVisibility: Boolean;
        BicycleVisiblity: boolean;
        FramesetVisiblity: boolean;
        ServicePartVisiblity: boolean;
        WarrantyPartVisiblity: boolean;
        ForecastItemVisiblity: boolean;
        RawFrameVisiblity: boolean;
        PaintedFrameVisiblity: boolean;
        FinishedPaintedFrameVisiblity: boolean;
        TransformedTubeVisiblity: boolean;
}