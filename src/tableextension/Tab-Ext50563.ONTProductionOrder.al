tableextension 50525 "ONT Production Order" extends "Production Order"
{
    fields
    {
        field(90200; "ONT Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = CustomerContent;
        }
        field(90201; "ONT Remaining Qty. Exist"; Boolean)
        {
            Caption = 'Remaining Qty Exists';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Prod. Order Line" where("Prod. Order No." = field("No."), Status = field("Status"), "Remaining Quantity" = filter('<>0')));
        }
        field(90202; "ONT Next Operation No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90203; "ONT Next Operation Name"; text[1024])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90204; "ONT Availability Status"; Enum "ONT Availability Status")
        {
            InitValue = " ";
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(90205; "ONT Variant Code Lines"; text[1027])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90206; "ONT Shortages"; Integer)
        {
            Caption = 'Shortages';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Prod. Order Component" where("ONT Shortage" = const(true), "Prod. Order No." = field("No."), Status = field(Status)));
        }
        field(90207; "ONT Print Batch No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(90208; "ONT Item Has Variant"; Boolean)
        {
            Caption = 'Item Has Variant';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Item Variant" where("Item No." = field("Source No.")));
        }
        field(90209; "ONT Current Item"; text[100])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = SystemMetadata;
        }
        field(90210; "ONT Missing Consumption"; boolean)
        {
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(90211; "ONT Previous Operation No."; code[20])
        {
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(90212; "ONT Previous Operation Name"; text[1024])
        {
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(90213; "ONT Component No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(90214; "ONT Component Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(90215; "ONT Missing Consumption Reason"; enum "ONT Missing Consumption Reason")
        {
            DataClassification = CustomerContent;
        }
        field(90216; "ONT Next Work Center Grp Code"; Code[10])
        {
            Editable = false;
            DataClassification = SystemMetadata;
            TableRelation = "Work Center Group";
            trigger OnLookup()
            var
                ProdOrderRoutingLine: record "Prod. Order Routing Line";
                ProdOrderRouting: PAGE "Prod. Order Routing";
            begin
                ProdOrderRoutingLine.SetRange(Status, Status);
                ProdOrderRoutingLine.SetRange("Prod. Order No.", "No.");
                ProdOrderRoutingLine.SetRange("Work Center Group Code", "ONT Next Work Center Grp Code");
                ProdOrderRouting.SetTableView(ProdOrderRoutingLine);
                ProdOrderRouting.Run();
            end;
        }
        field(90217; "ONT Next Work Center No."; Code[20])
        {
            Editable = false;
            TableRelation = "Work Center";
            DataClassification = SystemMetadata;
            trigger OnLookup()
            var
                ProdOrderRoutingLine: record "Prod. Order Routing Line";
                ProdOrderRouting: PAGE "Prod. Order Routing";
            begin
                ProdOrderRoutingLine.SetRange(Status, Status);
                ProdOrderRoutingLine.SetRange("Prod. Order No.", "No.");
                ProdOrderRoutingLine.SetRange("Work Center No.", "ONT Next Work Center No.");
                ProdOrderRouting.SetTableView(ProdOrderRoutingLine);
                ProdOrderRouting.Run();
            end;
        }
        field(90218; "ONT Current Work Center No."; Text[100])
        {
            Caption = 'Current Work Center No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Prod. Order Routing Line"."Work Center No." where("Prod. Order No." = field("No."), Status = field("Status"), "Routing Status" = const("In Progress")));
        }
        field(90219; "ONT Subcontracts"; Integer)
        {
            Caption = 'Subcontracts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Line" where("Prod. Order No." = field("No.")));
        }
        field(70120; "ONT Current Operation"; Text[100])
        {
            Caption = 'Current Operation';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Prod. Order Routing Line".Description where("Prod. Order No." = field("No."), Status = field("Status"), "Routing Status" = const("In Progress")));
        }
        field(70121; "ONT Finished Operations"; Integer)
        {
            Caption = 'Finished Operations';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Prod. Order Routing Line" where("Prod. Order No." = field("No."), Status = field("Status"), "Routing Status" = const("Finished")));
        }
        field(70122; "ONT Output Exists"; boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Item Ledger Entry" where("Order Type" = const(Production), "Order No." = field("No."), "Entry Type" = const(Output)));
        }
        field(70123; "ONT Sales Order Line Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document No." = field("ONT Sales Order No."), "Document Type" = filter(Order), "No." = field("Source No."), "Variant Code" = field("Variant Code"), Type = const(Item)));
            Editable = false;
        }
        field(70124; "ONT Sales Line No."; Integer)
        {
            Caption = 'Sales Line No.';
            TableRelation = "Sales Line"."Line No." where("Document No." = field("ONT Sales Order No."));
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70125; "ONT Icon"; Blob)
        {
            Subtype = Bitmap;
            DataClassification = SystemMetadata;
        }
        field(70126; "ONT Remaining Operations"; Integer)
        {
            Caption = 'Remaining Operations';
            FieldClass = FlowField;
            CalcFormula = Count("Prod. Order Line" Where("Prod. Order No." = field("No."), Status = field("Status"), "Remaining Quantity" = filter('<>0')));
        }
        field(70127; "ONT Remaining Consumption"; Integer)
        {
            Caption = 'Remaining Consumption';
            FieldClass = FlowField;
            CalcFormula = Count("Prod. Order Component" Where("Prod. Order No." = field("No."), Status = field("Status"), "Remaining Quantity" = filter('<>0')));
        }
        field(70128; "ONT Priority"; enum "ONT Order Priority")
        {
            DataClassification = CustomerContent;
        }
        field(70129; "Children Updated"; Boolean)
        {
        }
        field(70130; "ONT Prod Order Notes"; text[2000])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SalesOrder: Record "Sales Header";
                SalesOrderLines: Record "Sales Line";
            begin
                SalesOrderLines.SetRange("Document Type", SalesOrderLines."Document Type"::Order);
                SalesOrderLines.SetRange("Document No.", rec."ONT Sales Order No.");
                SalesOrderLines.SetRange("Line No.", rec."ONT Sales Line No.");
                if SalesOrderLines.FindFirst() then begin
                    SalesOrderLines."ONT Planning Notes" := rec."ONT Prod Order Notes";
                    SalesOrderLines.Modify();
                end;
            end;
        }
        field(70131; "ONT Special Insturction"; text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Special Instruction';
        }
        field(70132; "ONT Remaining Output"; Decimal)
        {
            Caption = 'Remaining Output';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("Prod. Order Line"."Remaining Quantity" where("Prod. Order No." = field("No."), Status = field(Status)));
        }
        field(70133; "ONT Total Quatity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line".Quantity where("Prod. Order No." = field("No."), Status = field(Status)));
        }
        
    }
}