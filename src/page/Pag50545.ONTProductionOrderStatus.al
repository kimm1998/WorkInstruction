page 50545 "ONT Production Order Status"
{
    ApplicationArea = all;
    Caption = 'Production Order Status';
    PromotedActionCategories = 'New,Process,Report,Production Order,Process,Entries,Related';
    PageType = list;
    Editable = true;
    SourceTable = "Production Order";
    UsageCategory = lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(ProdOrderStatus; ProdOrderStatus)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Status Filter';
                    ToolTip = 'Specifies the status of the production orders to define a filter on the lines.';
                    Enabled = (not ShowAll);

                    trigger OnValidate()
                    begin
                        ProdOrderStatusOnAfterValidate;
                    end;
                }
                field("Show All"; ShowAll)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Show all Production Orders';
                    ToolTip = 'Remove the filter on Production Order Status';

                    trigger OnValidate()
                    begin
                        BuildForm;
                    end;
                }
                field(ProdOrderAvailability; ProdOrderAvailability)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Availability Filter';
                    ToolTip = 'Specifies the availability of the production orders to define a filter on the lines.';

                    trigger OnValidate()
                    begin
                        ProdOrderAvailabilityOnAfterValidate;
                    end;
                }
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Must Start Before';
                    ToolTip = 'Specifies a date to define a filter on the lines.';

                    trigger OnValidate()
                    begin
                        StartingDateOnAfterValidate;
                    end;
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Ends Before';
                    ToolTip = 'Specifies a date to define a filter on the lines.';

                    trigger OnValidate()
                    begin
                        EndingDateOnAfterValidate;
                    end;
                }
            }
            repeater(Control1)
            {
                // Editable = false;
                ShowCaption = false;

                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the description of the production order.';
                }
                field(Shortages; rec."ONT Shortages")
                {
                    Caption = 'Shortages';
                    Editable = false;
                    ApplicationArea = Manufacturing;
                    StyleExpr = StyleText;

                    trigger OnDrillDown()
                    var
                        ProdOrderComponent: record "Prod. Order Component";
                    begin
                        ProdOrderComponent.Reset();
                        ProdOrderComponent.SetRange("Prod. Order No.", Rec."No.");
                        ProdOrderComponent.SetRange(Status, Rec.Status);
                        ProdOrderComponent.SetRange("ONT Shortage", true);
                        page.Run(page::"Prod. Order Components", ProdOrderComponent);
                    end;
                }
                field("ONT Prod Order Notes"; Rec."ONT Prod Order Notes")
                {
                    ApplicationArea = all;
                    Caption = 'Production Order Notes';
                }

                field("Variant Code"; Rec."ONT Variant Code Lines")
                {
                    Caption = 'Variant Code';
                    Editable = false;
                    Visible = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                }
                field("Print Batch No."; Rec."ONT Print Batch No.")
                {
                    Caption = 'Print Batch No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    Caption = 'Location Code';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    Caption = 'Bin Code';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                }
                field("Sales Order No."; Rec."ONT Sales Order No.")
                {
                    Caption = 'Sales Order No.';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                }
                field("ONT Sales Line No."; Rec."ONT Sales Line No.")
                {
                    ApplicationArea = all;
                    Caption = 'Sales Order Line No.';
                    StyleExpr = StyleText;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    Editable = false;
                    // Visible = False;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the date on which you created the production order.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    Caption = 'Source Type';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the source type of the production order.';
                }
                field("Source No."; Rec."Source No.")
                {
                    Caption = 'Source No.';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the source document that the entry originates from.';
                }
                field("Item Has Variant"; rec."ONT Item Has Variant")
                {
                    Caption = 'Item Has Variant';
                    ApplicationArea = All;
                    // Visible = False;
                    Editable = false;
                    StyleExpr = StyleText;
                }
                field("Starting Time"; rec."Starting Date-Time")
                {
                    Caption = 'Starting Time';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the starting time of the production order.';
                }
                field("Ending Time"; Rec."Ending Date-Time")
                {
                    Caption = 'Ending Time';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the ending time of the production order.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Caption = 'Due Date';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the due date of the production order.';
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    Caption = 'Finished Date';
                    Editable = false;
                    StyleExpr = StyleText;
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the actual finishing date of a finished production order.';
                }
                field("Availability Status"; Rec."ONT Availability Status")
                {
                    Caption = 'Availability Status';
                    Editable = false;
                    ApplicationArea = Manufacturing;
                    StyleExpr = StyleText;
                }
                field("Availability Status Icon"; Rec."ONT Icon")
                {
                    Caption = 'Availability Status Icon';
                    Editable = false;
                    ApplicationArea = Manufacturing;
                }
                field("Current Item"; Rec."ONT Current Item")
                {
                    Caption = 'Current Item';
                    Editable = false;
                    // Visible = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Next Operation No."; Rec."ONT Next Operation No.")
                {
                    Caption = 'Next Operation No.';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                    Visible = false;
                }
                field("Next Operation Name"; rec."ONT Next Operation Name")
                {
                    Caption = 'Next Operation Name';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Component No."; rec."ONT Component No.")
                {
                    Caption = 'Component No.';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                    // Visible = false;
                }
                field("Component Description"; rec."ONT Component Description")
                {
                    Caption = 'Component Description';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                    Visible = false;
                }
                field("Previous Operation No."; rec."ONT Previous Operation No.")
                {
                    Caption = 'Previous Operation No.';
                    Editable = false;
                    // Visible = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Previous Operation Name"; rec."ONT Previous Operation Name")
                {
                    Caption = 'Previous Operation Name';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Consumption Missing"; Rec."ONT Missing Consumption")
                {
                    Caption = 'Missing Consumption';
                    Editable = false;
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Output Exists"; Rec."ONT Output Exists")
                {
                    Caption = 'Output Exists';
                    Editable = false;
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field("ONT Finished Operations"; Rec."ONT Finished Operations")
                {
                    ApplicationArea = all;
                    Caption = 'Finished Operations';
                    StyleExpr = StyleText;
                    Editable = false;
                }
                field(Subcontracts; Rec."ONT Subcontracts")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Subcontracts field';
                    Caption = 'Subcontracts PO';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Current Operation"; Rec."ONT Current Operation")
                {
                    Caption = 'Current Operation';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Operation field';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Finished Operations"; Rec."ONT Finished Operations")
                {
                    Caption = 'Finished Operations';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Previous Operation field';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Current Work Center No."; Rec."ONT Current Work Center No.")
                {
                    Caption = 'Current Work Center No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Work Center No. field.';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                    // Visible = false;
                }
                field("Next Work Center No."; Rec."ONT Next Work Center No.")
                {
                    Caption = 'Next Work Center No.';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Next Work Center No. field.';
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                    trigger OnDrillDown()
                    var
                        ProdOrderRoutingLine: record "Prod. Order Routing Line";
                        ProdOrderRouting: PAGE "Prod. Order Routing";
                    begin
                        ProdOrderRoutingLine.SetRange(Status, rec.Status);
                        ProdOrderRoutingLine.SetRange("Prod. Order No.", rec."No.");
                        ProdOrderRoutingLine.SetRange("Work Center No.", rec."ONT Next Work Center No.");
                        ProdOrderRouting.SetTableView(ProdOrderRoutingLine);
                        ProdOrderRouting.Run();
                    end;
                }

                field("Next Work Center Group Code"; Rec."ONT Next Work Center Grp Code")
                {
                    Caption = 'Next Work Center Group Code';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Next Work Center Group field.';
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleText;
                    trigger OnDrillDown()
                    var
                        ProdOrderRoutingLine: record "Prod. Order Routing Line";
                        ProdOrderRouting: PAGE "Prod. Order Routing";
                    begin
                        ProdOrderRoutingLine.SetRange(Status, rec.Status);
                        ProdOrderRoutingLine.SetRange("Prod. Order No.", rec."No.");
                        ProdOrderRoutingLine.SetRange("Work Center Group Code", rec."ONT Next Work Center Grp Code");
                        ProdOrderRouting.SetTableView(ProdOrderRoutingLine);
                        ProdOrderRouting.Run();
                    end;
                }
                field("ONT Remaining Consumption"; Rec."ONT Remaining Consumption")
                {
                    ApplicationArea = all;
                    Caption = 'Remaining Consumption';
                    Editable = false;
                    StyleExpr = StyleText;
                }

                field("Missing Consumption Reason"; rec."ONT Missing Consumption Reason")
                {
                    Caption = 'Missing Consumption Reason';
                    ApplicationArea = all;
                    Editable = true;
                    // Visible = False;
                    StyleExpr = StyleText;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
            part("Component Status FactBox"; "ONT Component Status FactBox")
            {
                Caption = 'Component Status FactBox';
                ApplicationArea = Manufacturing;
                SubPageLink = Status = field(Status), "Prod. Order No." = field("No.");
            }
            part("Operation Status FactBox"; "ONT Operation Status FactBox")
            {
                Caption = 'Operation Status FactBox';
                ApplicationArea = Manufacturing;
                SubPageLink = "Prod. Order No." = field("No."), Status = field(Status);
            }
            part("ONT Job Queue FactBox"; "ONT Job Queue FactBox")
            {
                Caption = 'Job Queue FactBox';
                ApplicationArea = Manufacturing;
            }
        }

    }
    actions
    {
        area(navigation)
        {
            group("Prod. Order")
            {
                Caption = 'Prod. Order';
                Image = "Order";

                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;

                    action("Item Ledger E&ntries")
                    {
                        PromotedCategory = Category6;
                        ApplicationArea = Manufacturing;
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = true;
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the item ledger entries of the item on the document or journal line.';

                        trigger OnAction()
                        var
                            ItemLedgEntry: Record "Item Ledger Entry";
                        begin
                            if Rec.Status <> Rec.Status::Released then exit;
                            ItemLedgEntry.Reset();
                            ItemLedgEntry.SetCurrentKey("Order Type", "Order No.");
                            ItemLedgEntry.SetRange("Order Type", ItemLedgEntry."Order Type"::Production);
                            ItemLedgEntry.SetRange("Order No.", Rec."No.");
                            PAGE.RunModal(0, ItemLedgEntry);
                        end;
                    }
                    action("Capacity Ledger Entries")
                    {
                        PromotedCategory = Category6;
                        ApplicationArea = Manufacturing;
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        Promoted = true;
                        ToolTip = 'View the capacity ledger entries of the involved production order. Capacity is recorded either as time (run time, stop time, or setup time) or as quantity (scrap quantity or output quantity).';

                        trigger OnAction()
                        var
                            CapLedgEntry: Record "Capacity Ledger Entry";
                        begin
                            if Rec.Status <> Rec.Status::Released then exit;
                            CapLedgEntry.Reset();
                            CapLedgEntry.SetCurrentKey("Order Type", "Order No.");
                            CapLedgEntry.SetRange("Order Type", CapLedgEntry."Order Type"::Production);
                            CapLedgEntry.SetRange("Order No.", Rec."No.");
                            PAGE.RunModal(0, CapLedgEntry);
                        end;
                    }
                    action("Value Entries")
                    {
                        PromotedCategory = Category6;
                        ApplicationArea = Manufacturing;
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        Promoted = true;
                        ToolTip = 'View the value entries of the item on the document or journal line.';

                        trigger OnAction()
                        var
                            ValueEntry: Record "Value Entry";
                        begin
                            if Rec.Status <> Rec.Status::Released then exit;
                            ValueEntry.Reset();
                            ValueEntry.SetCurrentKey("Order Type", "Order No.");
                            ValueEntry.SetRange("Order Type", ValueEntry."Order Type"::Production);
                            ValueEntry.SetRange("Order No.", Rec."No.");
                            PAGE.RunModal(0, ValueEntry);
                        end;
                    }
                }
                action("Plannin&g")
                {
                    Promoted = true;
                    PromotedCategory = Category7;
                    ApplicationArea = Planning;
                    Caption = 'Plannin&g';
                    Image = Planning;
                    ToolTip = 'Plan supply orders for the production order order by order.';

                    trigger OnAction()
                    var
                        OrderPlanning: Page "Order Planning";
                    begin
                        OrderPlanning.SetProdOrder(Rec);
                        OrderPlanning.RunModal();
                    end;
                }
                action("Co&mments")
                {
                    PromotedCategory = Category7;
                    ApplicationArea = Manufacturing;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    PromotedCategory = Category7;
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Statistics)
                {
                    PromotedCategory = Category7;
                    ApplicationArea = Manufacturing;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status), "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Change &Status")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Change the production order to another status, such as Released.';

                    trigger OnAction()
                    var
                        ProductionOrder: Record "Production Order";
                        ChangeStatusForm: Page "Change Status on Prod. Order";
                        NewStatus: Enum "Production Order Status";
                        NewPostingDate: Date;
                        NewUpdateUnitCost: Boolean;
                        PrintOutBatchNo: Code[20];
                    begin
                        PrintOutBatchNo := GetPrintBatchNo();
                        Commit();
                        CurrPage.SetSelectionFilter(ProductionOrder);
                        ProductionOrder.FindSet();
                        ChangeStatusForm.Set(ProductionOrder);
                        if ChangeStatusForm.RunModal() = ACTION::Yes then begin
                            ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
                            repeat
                                // CheckEligibility(ProductionOrder);
                                AssignPrintBatchNo(ProductionOrder, NewStatus, PrintOutBatchNo);
                                ChangeProdOrderStatus(ProductionOrder, NewStatus, NewPostingDate, NewUpdateUnitCost);
                            until ProductionOrder.Next() = 0;
                            PrintJobCard(PrintOutBatchNo);
                        end;
                    end;
                }
                action("Production Order")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Order';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ShowProdOrder();
                    end;
                }
                action(Routing)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Prod. Order Routing';
                    Image = Route;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProdOrderRouting: Record "Prod. Order Routing Line";
                    begin
                        ProdOrderRouting.SetRange(Status, Rec."Status");
                        ProdOrderRouting.SetRange("Prod. Order No.", Rec."No.");
                        PAGE.Run(PAGE::"Prod. Order Routing", ProdOrderRouting);
                    end;
                }
                action(Components)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Prod. Order Components';
                    Image = Components;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProdOrderComp: Record "Prod. Order Component";
                    begin
                        ProdOrderComp.SetRange(Status, Rec."Status");
                        ProdOrderComp.SetRange("Prod. Order No.", Rec."No.");
                        PAGE.Run(PAGE::"Prod. Order Components", ProdOrderComp);
                    end;
                }
                action("Print Job Card")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Print Job Card';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField("ONT Print Batch No.");
                        PrintJobCard(Rec."ONT Print Batch No.");
                    end;
                }
                action(ShowDocument)
                {
                    Caption = 'Sales Order';
                    ApplicationArea = All;
                    Image = Document;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        SalesOrderHdr: Record "Sales Header";
                        NotFound: Label 'No Sales Order was found.';
                    begin
                        if SalesOrderHdr.Get(SalesOrderHdr."Document Type"::Order, Rec."ONT Sales Order No.") then
                            PAGE.Run(PAGE::"Sales Order", SalesOrderHdr)
                        else
                            Message(NotFound);
                    end;
                }
                action("Update Availability Status")
                {
                    ApplicationArea = Manufacturing;
                    Image = Status;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Selected: Integer;
                        Options: Text[44];
                        Text0001: Label 'Run Background task,Schedule a recurring Job';
                        Text0002: Label 'Please choose when would you like to update availability:';
                    begin
                        Options := Text0001;
                        Selected := Dialog.StrMenu(Options, 1, Text0002);
                        If Selected = 1 then begin
                            RunNowUpdateAvailabilityJob();
                        end
                        else
                            If Selected = 2 then
                                ScheduleUpdateAvailabilityJob();
                    end;
                }
                // action("Delete Registration")
                // {
                //     ApplicationArea = Manufacturing;
                //     Image = Delete;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //     begin
                //         DeleteONTRegistrationRecord();
                //         Message('Done');
                //     end;
                // }
            }
        }
    }
    views
    {
        view(OutputMissingConsumption)
        {
            Caption = 'Output - Missing Consumptions';
            Filters = where("ONT Output Exists" = const(true), "ONT Missing Consumption" = const(true));
        }
        view(DoneNotFinished)
        {
            Caption = 'Output Done, Consumptions Done, Status Not Finished';
            Filters = where(Status = Const(Released), "ONT Missing Consumption" = const(false), "ONT Remaining Qty. Exist" = const(false));
        }
        view(PendingSubcontractors)
        {
            Caption = 'Pending Subcontractors';
            Filters = where("ONT Subcontracts" = const(0), "ONT Remaining Qty. Exist" = const(false));
        }

    }
    trigger OnOpenPage()
    var
        IconsManagement: Record "ONT Icons Management";
        inStreamImage: InStream;
        OutStreamImage: OutStream;
    begin
        Rec.SetRange(Status, Rec.Status::"Firm Planned");
        ProdOrderStatus := ProdOrderStatus::"Firm Planned";
        CurrPage.Update(false);
    end;

    // trigger OnAfterGetRecord()
    // var
    //     IconsManagement: Record "Icons Management";
    //     inStreamImage: InStream;
    //     OutStreamImage: OutStream;
    // begin
    //     IconsManagement.SetRange(Name, Rec."Availability Status");
    //     If IconsManagement.FindFirst() then begin
    //         IconsManagement.Icon.CreateInStream(inStreamImage);
    //         Rec.Icon.CreateOutStream(OutStreamImage);
    //         CopyStream(OutStreamImage, inStreamImage);
    //         Rec.Modify();
    //     end;
    // end;

    var
        CurrentItem: text[100];
        LastOperationNo: code[20];
        CurrenctOperationNo: code[20];
        LastOperationName: text;
        CurrentOperationName: text;
        ProdOrderStatus: Enum "Production Order Status";
        StartingDate: DateTime;
        EndingDate: DateTime;
        EMPTYDate: DateTime;
        StyleText: Text[20];
        PriorityStyleText: text[20];
        ProdOrderAvailability: Option " ","Fully Available","Partially Available","Unavailable";
        ShowAll: Boolean;

    local procedure ScheduleUpdateAvailabilityJob()
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueEntryCard: Page "Job Queue Entry Card";
        Text0001: Label 'The job queue is already created.';
    begin
        JobQueueEntry.Reset();
        JobQueueEntry.SetRange("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"ONT Update Availability-Ops");
        if JobQueueEntry.FindFirst() then begin
            Page.RunModal(Page::"Job Queue Entry Card", JobQueueEntry);
        end
        else begin
            JobQueueEntry.Validate("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
            JobQueueEntry.Validate("Object ID to Run", Codeunit::"ONT Update Availability-Ops");
            JobQueueEntry.Insert(True);
            JobQueueEntry.Validate("Earliest Start Date/Time", CurrentDateTime());
            JobQueueEntry.Validate("Recurring Job", true);
            JobQueueEntry.Validate(Status, JobQueueEntry.Status::"On Hold");
            JobQueueEntry.Modify(true);
            Commit();
            Page.RunModal(Page::"Job Queue Entry Card", JobQueueEntry);
        end;
    end;

    local procedure RunNowUpdateAvailabilityJob()
    var
        SessionID: Integer;
        OK: Boolean;
    begin
        STARTSESSION(SessionId, CODEUNIT::"ONT Update Availability-Ops");
    end;

    local procedure BuildForm()
    begin
        Rec.SetRange(Status);
        Rec.SetRange("ONT Availability Status");
        Rec.SetRange("Starting Date-Time");
        Rec.SetRange("Ending Date-Time");

        if ShowAll then
            Rec.SetFilter(Status, '%1|%2|%3|%4|%5', Rec.Status::Finished, Rec.Status::"Firm Planned", Rec.Status::Planned, Rec.Status::Released, Rec.Status::Simulated)
        else
            Rec.SetRange(Status, ProdOrderStatus);

        if ProdOrderAvailability <> ProdOrderAvailability::" " then Rec.SetRange("ONT Availability Status", ProdOrderAvailability);
        if StartingDate <> EMPTYDate then Rec.SetFilter("Starting Date-Time", '..%1', StartingDate);
        if EndingDate <> EMPTYDate then Rec.SetFilter("Ending Date-Time", '..%1', EndingDate);
        CurrPage.Update(false);
    end;

    trigger OnAfterGetRecord()
    begin

        case Rec."ONT Availability Status" of
            Rec."ONT Availability Status"::"Fully Available":
                StyleText := 'favorable';
            Rec."ONT Availability Status"::"Partially Available":
                StyleText := 'Ambiguous';
            Rec."ONT Availability Status"::Unavailable:
                StyleText := 'Unfavorable';
            else
                StyleText := 'Standard';
        end;
        GetOperationNo();
    end;

    local procedure ShowProdOrder()
    var
        ProductionOrder: Record "Production Order";
    begin
        ProductionOrder.SetRange(Status, Rec."Status");
        ProductionOrder.SetRange("No.", Rec."No.");
        case Rec."Status" of
            Rec."Status"::"Firm Planned":
                PAGE.Run(PAGE::"Firm Planned Prod. Order", ProductionOrder);
            Rec."Status"::Released:
                PAGE.Run(PAGE::"Released Production Order", ProductionOrder);
            Rec."Status"::Finished:
                PAGE.Run(PAGE::"Finished Production Order", ProductionOrder);
        end;
    end;

    local procedure ProdOrderAvailabilityOnAfterValidate()
    begin
        BuildForm;
    end;

    local procedure ProdOrderStatusOnAfterValidate()
    begin
        BuildForm;
    end;

    local procedure StartingDateOnAfterValidate()
    begin
        BuildForm;
    end;

    local procedure EndingDateOnAfterValidate()
    begin
        BuildForm;
    end;

    local procedure GetOperationNo()
    var
        ProdLine: Record "Prod. Order Line";
        ProductionLine: Record "Prod. Order Line";
        RecCapacityLedgerEntry: Record "Capacity Ledger Entry";
        RecCapacityLedgerEntry3: Record "Capacity Ledger Entry";
        RecProdOrderRoutingLine: Record "Prod. Order Routing Line";
        RecMachineCenter: Record "Machine Center";
        RecWorkCenter: Record "Work Center";
        RecProdOrderRoutingLine2: Record "Prod. Order Routing Line";
        LastProdline: integer;
    begin
        LastOperationNo := '';
        RecCapacityLedgerEntry.Reset();
        RecCapacityLedgerEntry.setcurrentkey("Order Type", "Order No.", "Order Line No.");
        RecCapacityLedgerEntry.SetRange("Order Type", RecCapacityLedgerEntry."Order Type"::Production);
        RecCapacityLedgerEntry.SetRange("Order No.", Rec."No.");
        if RecCapacityLedgerEntry.findfirst() then begin
            RecCapacityLedgerEntry3.reset;
            RecCapacityLedgerEntry3.setcurrentkey("Order Type", "Order No.", "Operation No.");
            RecCapacityLedgerEntry3.SetRange("Order Type", RecCapacityLedgerEntry."Order Type"::Production);
            RecCapacityLedgerEntry3.SetRange("Order No.", Rec."No.");
            RecCapacityLedgerEntry3.SetRange("Order Line No.", RecCapacityLedgerEntry."Order Line No.");
            if RecCapacityLedgerEntry3.FindLast() then begin
                LastOperationNo := RecCapacityLedgerEntry3."Operation No.";
                LastProdline := RecCapacityLedgerEntry3."Order Line No.";
                case RecCapacityLedgerEntry.Type of
                    RecCapacityLedgerEntry.Type::"Machine Center":
                        begin
                            RecMachineCenter.Reset();
                            RecMachineCenter.SetRange("No.", RecCapacityLedgerEntry."No.");
                            if RecMachineCenter.FindFirst() then LastOperationName := RecMachineCenter.Name;
                        end;
                    RecCapacityLedgerEntry.Type::"Work Center":
                        begin
                            RecWorkCenter.Reset();
                            RecWorkCenter.SetRange("No.", RecCapacityLedgerEntry."No.");
                            if RecWorkCenter.FindFirst() then LastOperationName := RecWorkCenter.Name;
                        end;
                end;
                CurrenctOperationNo := '';
                RecProdOrderRoutingLine.Reset();
                RecProdOrderRoutingLine.SetRange("Routing No.", RecCapacityLedgerEntry3."Routing No.");
                RecProdOrderRoutingLine.SetRange("Prod. Order No.", RecCapacityLedgerEntry3."Order No.");
                RecProdOrderRoutingLine.SetRange("Routing Reference No.", RecCapacityLedgerEntry3."Order Line No.");
                RecProdOrderRoutingLine.SetRange("Operation No.", LastOperationNo);
                RecProdOrderRoutingLine.SetRange(Status, Rec.Status);
                if RecProdOrderRoutingLine.FindLast() then begin
                    CurrenctOperationNo := RecProdOrderRoutingLine."Next Operation No.";
                    if CurrenctOperationNo = '' then begin
                        if RecProdOrderRoutingLine."Routing Reference No." > 10000 then begin
                            LastProdline := RecProdOrderRoutingLine."Routing Reference No." - 10000;
                            RecProdOrderRoutingLine2.Reset();
                            RecProdOrderRoutingLine2.SetRange("Prod. Order No.", Rec."No.");
                            RecProdOrderRoutingLine2.SetRange("Routing Reference No.", LastProdline);
                            RecProdOrderRoutingLine2.SetRange(Status, Rec.Status);
                            if RecProdOrderRoutingLine2.FindFirst() then begin
                                CurrenctOperationNo := RecProdOrderRoutingLine2."Operation No.";
                            end;
                        end;
                    end
                end;
            end;
            ProductionLine.Reset();
            ProductionLine.SetRange("Prod. Order No.", Rec."No.");
            ProductionLine.SetRange(Status, Rec.Status);
            ProductionLine.SetRange("Line No.", LastProdline);
            if ProductionLine.FindFirst() then CurrentItem := ProductionLine.Description;
            if CurrenctOperationNo = '' then CurrentItem := '';
        end;
        if (LastOperationNo = '') and (CurrenctOperationNo = '') then begin
            ProdLine.reset;
            ProdLine.SetRange("Prod. Order No.", Rec."No.");
            ProdLine.SetRange(Status, Rec.Status);
            if ProdLine.FindLast() then begin
                CurrentItem := ProdLine.Description;
                RecProdOrderRoutingLine.Reset();
                RecProdOrderRoutingLine.SetRange("Routing No.", ProdLine."Routing No.");
                RecProdOrderRoutingLine.SetRange("Routing Reference No.", ProdLine."Routing Reference No.");
                RecProdOrderRoutingLine.SetRange(Status, Rec.Status);
                RecProdOrderRoutingLine.SetRange("Prod. Order No.", Rec."No.");
                if RecProdOrderRoutingLine.FindFirst() then begin
                    CurrenctOperationNo := RecProdOrderRoutingLine."Operation No.";
                end;
            end;
        end;
        if CurrenctOperationNo <> '' then begin
            RecProdOrderRoutingLine2.Reset();
            RecProdOrderRoutingLine2.SetRange("Routing No.", RecProdOrderRoutingLine."Routing No.");
            RecProdOrderRoutingLine2.SetRange("Prod. Order No.", RecProdOrderRoutingLine."Prod. Order No.");
            RecProdOrderRoutingLine2.SetRange("Operation No.", CurrenctOperationNo);
            if (LastOperationNo = '') then
                RecProdOrderRoutingLine2.SetRange("Routing Reference No.", ProdLine."Routing Reference No.")
            else
                RecProdOrderRoutingLine2.SetRange("Routing Reference No.", LastProdline);
            if RecProdOrderRoutingLine2.findfirst() then begin
                case RecProdOrderRoutingLine2.Type of
                    RecProdOrderRoutingLine2.Type::"Machine Center":
                        begin
                            RecMachineCenter.Reset();
                            RecMachineCenter.SetRange("No.", RecProdOrderRoutingLine2."No.");
                            if RecMachineCenter.FindFirst() then CurrentOperationName := RecMachineCenter.Name;
                        end;
                    RecProdOrderRoutingLine2.Type::"Work Center":
                        begin
                            RecWorkCenter.Reset();
                            RecWorkCenter.SetRange("No.", RecProdOrderRoutingLine2."No.");
                            if RecWorkCenter.FindFirst() then CurrentOperationName := RecWorkCenter.Name;
                        end;
                end;
            end;
            Commit();
        end
    end;

    local procedure CheckEligibility(Var ProductionOrder: Record "Production Order")
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        Text0001: Label 'Production Order %1 cannot be released as it has some shortages.';
    begin
        ManufacturingSetup.Get();
        IF (NOT ManufacturingSetup."ONT Release Shortages") AND (Rec."ONT Shortages" > 0) THEN
            Error(Text0001, ProductionOrder."No.")
    end;

    Procedure ChangeProdOrderStatus(Var ProductionOrder: Record "Production Order";
    NewStatus: Enum "Production Order Status"; NewPostingDate: Date;
                   NewUpdateUnitCost: Boolean)
    var
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
    begin
        ProdOrderStatusMgt.ChangeProdOrderStatus(ProductionOrder, NewStatus, NewPostingDate, NewUpdateUnitCost);
    end;

    Procedure PrintJobCard(PrintOutBatchNo: code[20])
    var
        ReportSelection: Record "Report Selections";
        ReportID: integer;
        ProductionOrder: Record "Production Order";
    begin
        ReportSelection.SetRange(Usage, ReportSelection.Usage::M1);
        ReportSelection.SetRange(Sequence, '1');
        if ReportSelection.FindFirst() then
            ReportID := ReportSelection."Report ID";
        ProductionOrder.Reset();
        ProductionOrder.SetRange("ONT Print Batch No.", PrintOutBatchNo);
        report.run(ReportID, false, true, ProductionOrder);
    end;


    Procedure GetPrintBatchNo() PrintOutBatchNo: code[20];
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        ManufacturingSetup.Get();
        ManufacturingSetup.TestField("ONT Rele. Ord Print Batch Nos.");
        PrintOutBatchNo := NoSeriesMgt.GetNextNo(ManufacturingSetup."ONT Rele. Ord Print Batch Nos.", WorkDate(), true);
        exit(PrintOutBatchNo);
    end;

    Procedure AssignPrintBatchNo(Var ProductionOrder: Record "Production Order"; Status: enum "Production Order Status"; PrintOutBatchNo: code[20])
    VAR
    begin
        ProductionOrder."ONT Print Batch No." := PrintOutBatchNo;
        ProductionOrder.modify(true);
    end;

    //To be deleted++
    local procedure DeleteONTRegistrationRecord()
    Var
        ONTRegistrationHeader: Record "ONT Registration Header";
        ONTRegistrationLine: Record "ONT Registration Line";
    begin
        IF ONTRegistrationHeader.FindSet() THEN
            REPEAT
                ONTRegistrationHeader.Delete();
            UNTIL ONTRegistrationHeader.Next() = 0;

        IF ONTRegistrationLine.FindSet() THEN
            REPEAT
                ONTRegistrationLine.Delete();
            UNTIL ONTRegistrationLine.Next() = 0;
    end;
    //To be deleted-
}
