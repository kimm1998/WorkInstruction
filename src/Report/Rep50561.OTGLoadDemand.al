report 50561 "OTG Load Demand"
{
    Caption = 'OTG Load Demand';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset { }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(ClearBeforeLoad; ClearBeforeLoad)
                    {
                        ApplicationArea = All;
                        Caption = 'Clear current demand before load';
                        ToolTip = 'Delete all rows from OTG Demand Buffer before loading new demand.';
                    }
                    field(LocationFilter; LocationFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Filter';
                        TableRelation = Location.Code;
                    }
                }

                group(SalesOrders)
                {
                    Caption = 'Sales Orders';
                    field(IncludeSales; IncludeSales)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Sales Orders';
                    }
                    field(SalesOnlyReleased; SalesOnlyReleased)
                    {
                        ApplicationArea = All;
                        Caption = 'Only Released Sales Orders';
                        Enabled = IncludeSales;
                    }
                    field(SalesDateFrom; SalesDateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment Date From';
                        Enabled = IncludeSales;
                    }
                    field(SalesDateTo; SalesDateTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment Date To';
                        Enabled = IncludeSales;
                    }
                    field(SalesPriority; SalesPriority)
                    {
                        ApplicationArea = All;
                        Caption = 'Default Priority (Sales)';
                        Enabled = IncludeSales;
                        ToolTip = '1 = highest priority.';
                    }
                }

                group(ProdComponents)
                {
                    Caption = 'Production Order Components';
                    field(IncludeProdComp; IncludeProdComp)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Prod. Order Components';
                    }
                    field(POC_Planned; POC_Planned)
                    {
                        ApplicationArea = All;
                        Caption = 'Planned';
                        Enabled = IncludeProdComp;
                    }
                    field(POC_FirmPlanned; POC_FirmPlanned)
                    {
                        ApplicationArea = All;
                        Caption = 'Firm Planned';
                        Enabled = IncludeProdComp;
                    }
                    field(POC_Released; POC_Released)
                    {
                        ApplicationArea = All;
                        Caption = 'Released';
                        Enabled = IncludeProdComp;
                    }
                    field(POC_Priority; POC_Priority)
                    {
                        ApplicationArea = All;
                        Caption = 'Default Priority (Prod. Comp.)';
                        Enabled = IncludeProdComp;
                        ToolTip = '1 = highest priority.';
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    var
        Loader: Codeunit "OTG Demand Loader";
    begin
        if ClearBeforeLoad then
            Loader.ClearBuffer();

        if IncludeSales then
            Loader.LoadFromSalesOrders(SalesDateFrom, SalesDateTo, LocationFilter, SalesOnlyReleased, SalesPriority);

        if IncludeProdComp then
            Loader.LoadFromProdOrderComponents(POC_Planned, POC_FirmPlanned, POC_Released, LocationFilter, POC_Priority);

        Message('Demand load complete.');
    end;

    var
        // General
        ClearBeforeLoad: Boolean;
        LocationFilter: Code[10];

        // Sales
        IncludeSales: Boolean;
        SalesOnlyReleased: Boolean;
        SalesDateFrom: Date;
        SalesDateTo: Date;
        SalesPriority: Integer;

        // Prod. Components
        IncludeProdComp: Boolean;
        POC_Planned: Boolean;
        POC_FirmPlanned: Boolean;
        POC_Released: Boolean;
        POC_Priority: Integer;
}
