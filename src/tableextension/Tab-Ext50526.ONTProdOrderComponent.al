tableextension 50526 "ONT Prod. Order Component" extends "Prod. Order Component"
{
    fields
    {
        // field(60102; "ONT Item Model"; Code[20])
        // {
        //     Caption = 'Item Model';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Production Order"."Source No." WHERE("No." = FIELD("Prod. Order No.")));
        //     Editable = false;
        // }
        field(60103; "ONT Bike Model No."; Code[20])
        {
            Caption = 'Bike Model No.';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.ModelNo WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(60104; "ONT Business Unit"; Code[20])
        {
            Caption = 'Business Unit';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.BuAssignment WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(60105; "ONT Availability Status"; Option)
        {
            Caption = 'Availability Status';
            OptionMembers = "None","On Time","Too Late","Too Early";
            OptionCaption = 'No Supply,On Time,Too Late,Too Early';
            DataClassification = CustomerContent;
        }
        // field(60107; "ONT Component Description"; Text[100])
        // {
        //     Caption = 'Component Description';
        //     DataClassification = CustomerContent;
        // }
        // field(60108; "ONT Replenishment System"; Enum "Replenishment System")
        // {
        //     Caption = 'Replenishment System';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Item."Replenishment System" WHERE("No." = FIELD("Item No.")));
        //     Editable = false;
        // }
        // field(60109; "ONT Buyer"; Code[20])
        // {
        //     Caption = 'Buyer';
        //     DataClassification = CustomerContent;
        // }
        // field(60110; "ONT Required Quantity"; Decimal)
        // {
        //     Caption = 'Required Qty';
        //     DecimalPlaces = 0 : 5;
        //     DataClassification = SystemMetadata;
        // }
        field(60111; "ONT Supply Reference No."; Code[20])
        {
            Caption = 'Supply Reference No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Header"."No.";
        }
        field(60112; "ONT Supply Reference Line No."; Integer)
        {
            Caption = 'Supply Reference Line No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Line"."Line No." where("No." = field("ONT Supply Reference No."));
        }
        field(60113; "ONT Required Date"; Date)
        {
            Caption = 'Required Date';
            DataClassification = SystemMetadata;
        }
        field(60114; "ONT Supply Due Date"; Date)
        {
            Caption = 'Supply Due Date';
            DataClassification = CustomerContent;
        }
        field(60115; "ONT Days Late"; Integer)
        {
            Caption = 'Days Late';
            DataClassification = CustomerContent;
        }
        field(60116; "ONT Days Early"; Integer)
        {
            Caption = 'Days Early';
            DataClassification = CustomerContent;
        }
        field(60120; "ONT Promise Date"; Date)
        {
            Caption = 'Promise Date';
            DataClassification = CustomerContent;
        }
        field(60121; "ONT Confirmed Date"; Date)
        {
            Caption = 'Confirmed Date';
            DataClassification = CustomerContent;
        }
        field(60123; "ONT Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("ONT Vendor No.")));
            Editable = false;
        }
        field(60124; "ONT Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Receipt Line"."No.";
        }
        field(60125; "ONT Receipt Description"; Text[100])
        {
            Caption = 'Receipt Description';
            DataClassification = CustomerContent;
        }
        field(60126; "ONT Route Name"; Text[50])
        {
            Caption = 'Route Name';
            DataClassification = CustomerContent;
        }
        field(60127; "ONT ETD"; Date)
        {
            Caption = 'ETD';
            DataClassification = CustomerContent;
        }
        field(60128; "ONT ETA"; Date)
        {
            Caption = 'ETA';
            DataClassification = CustomerContent;
        }
        field(60129; "ONT ATD"; Date)
        {
            Caption = 'ATD';
            DataClassification = CustomerContent;
        }
        field(60130; "ONT ATA"; Date)
        {
            Caption = 'ATA';
            DataClassification = CustomerContent;
        }
        field(60131; "Item Category Code"; Code[20])
        {
            Caption = 'Family Code';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(60132; "ONT Item PLM Status"; Code[20])
        {
            Caption = 'Item PLM Status';
            DataClassification = CustomerContent;
        }
        field(60133; "ONT Maker Lead Time"; dateformula)
        {
            Caption = 'Manufacturing Lead Time';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Vendor"."Manufacturing Lead Time" WHERE("Item No." = FIELD("Item No."), "Variant Code" = field("Variant Code")));
            Editable = false;
        }
        // field(60134; "ONT Transit Time"; Integer)
        // {
        //     Caption = 'Transit Lead Time';
        //     DataClassification = CustomerContent;
        // }
        field(60135; "ONT Container Shipping Agent"; Code[20])
        {
            Caption = 'Container Shipping Agent';
            DataClassification = CustomerContent;
        }

        // Vessel or carrier identifier.
        field(60136; "ONT Vessel"; Code[20])
        {
            Caption = 'Vessel ID';
            DataClassification = CustomerContent;
        }

        // Tracking or reference number for the shipment.
        field(60137; "ONT Reference"; Code[30])
        {
            Caption = 'Tracking No.';
            DataClassification = CustomerContent;
        }

        // Shipment status (e.g. Booked, Shipped, Delivered).
        // field(60138; "ONT Shipping Status"; Code[20])
        // {
        //     Caption = 'Status';
        //     DataClassification = CustomerContent;
        // }

        // // Release date – date on which the shipping order was released.
        // field(60139; "ONT Release Date"; Date)
        // {
        //     Caption = 'Release Date';
        //     DataClassification = CustomerContent;
        // }

        // // Pickup date – date on which the goods were collected by the carrier.
        // field(60140; "ONT Pickup Date"; Date)
        // {
        //     Caption = 'Pickup Date';
        //     DataClassification = CustomerContent;
        // }

        // Delivery date – date on which the goods were delivered.
        field(60141; "ONT Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            DataClassification = CustomerContent;
        }

        // Balance or remaining quantity to be delivered. This can be used for
        // shipping reconciliation.
        // field(60142; "ONT Balance"; Decimal)
        // {
        //     Caption = 'Balancé';
        //     DecimalPlaces = 0 : 5;
        //     DataClassification = CustomerContent;
        // }

        // Unit cost in CAD. FlowField to the Item Unit Cost.
        field(60143; "ONT Unit Cost (CAD)"; Decimal)
        {
            Caption = 'Unit Cost (CAD)';
            DecimalPlaces = 0 : 5;
        }

        // Extended cost = Unit Cost * Required Quantity. Calculated on the page.
        field(60144; "ONT Extended Cost"; Decimal)
        {
            Caption = 'Extended Cost';
        }

        // Extended cost in CAD if foreign currency. Use this field if you need
        // currency conversion.
        field(60145; "ONT Ext Cost CAD"; Decimal)
        {
            Caption = 'Ext Cost CAD';
        }

        // Financial cost – for example carrying or financing cost. Calculated
        // externally.
        // field(60146; "ONT Financial Cost"; Decimal)
        // {
        //     Caption = 'Financial Cost';
        // }
        field(60147; "ONT Demand Forecast"; Code[20])
        {
            Caption = 'Demand Forecast';
            FieldClass = FlowField;
            // Join to Production Order by Status + No.
            CalcFormula = lookup("Production Order"."ONT Demand Forecast"
                                 where(Status = field(Status),
                                       "No." = field("Prod. Order No.")));
            Editable = false;
        }
        field(60148; "ONT Family No."; Code[20])
        {
            Caption = 'Family No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Source No." where("No." = field("Prod. Order No.")));
            Editable = false;
        }

        // Planned date for the model (normally the due date of the production plan).
        // field(60149; "ONT Model Planned Date"; Date)
        // {
        //     Caption = 'Model Planned Date';
        //     DataClassification = CustomerContent;
        // }
        field(60150; "ONT Transfer Created"; Boolean)
        {
            Caption = 'Transfer Created';
            DataClassification = CustomerContent;
        }
        field(60152; "Item Status"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Status" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(60151; "ONT Transfer No."; Code[20])
        {
            Caption = 'Transfer No.';
            TableRelation = "Transfer Header"."No.";
            DataClassification = CustomerContent;
        }
        // field(60153; "ONT Transfer Created At"; DateTime)
        // {
        //     Caption = 'Transfer Created At';
        //     DataClassification = CustomerContent;
        // }
        field(60154; "Earliest Avail. Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("OTG Demand Buffer"."Earliest Avail. Date" where("Source Type" = const("OTG Demand Source"::"Prod. Order Comp."),
                                                                                    "Source No." = field("Prod. Order No."),
                                                                                    "Source Line No." = field("Line No."),
                                                                                    "Prod. Order Line No." = field("Prod. Order Line No."),
                                                                                    "Entry No." = field("Demand Entry No.")));
            Editable = false;
        }
        field(60155; "Demand Entry No."; Integer)
        {
            TableRelation = "OTG Demand Buffer"."Entry No.";
        }
        field(60156; "Allocated Qty (Base)"; Decimal)
        {
            Editable = false;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = sum("OTG Allocation Result"."Allocated Qty (Base)" where("Demand Entry No." = field("Demand Entry No.")));
        }
        field(60157; "Bike Model Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(ModelDSF.BuildKitName where("No." = field("ONT Bike Model No.")));
            Editable = false;
        }
        field(60158; "ONT Transit Lead Time"; dateformula)
        {
            Caption = 'Manufacturing Lead Time';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Vendor"."Transit Lead Time" WHERE("Item No." = FIELD("Item No."), "Variant Code" = field("Variant Code")));
            Editable = false;
        }
        field(60159; "ONT Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Open,Prepared,Loaded,Shipped,"Arrived at Destination",Delivered;
            OptionCaptionML = FRC = 'Ouvert,Préparé,Chargé,Parti,Arrivé à destination,Livré', ENU = 'Open,Prepared,Loaded,Shipped,Arrived at Destination,Delivered', ENC = 'Open,Prepared,Loaded,Shipped,Arrived at Destination,Delivered';
        }
        field(60160; "Release Date"; Date)
        {
            Caption = 'Release Date';
            DataClassification = CustomerContent;
        }
        field(60161; "Pickup Date"; Date)
        {
            Caption = 'Pickup Date';
            DataClassification = CustomerContent;
        }
        field(90200; "ONT Sales Order No."; code[20])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Production Order"."ONT Sales Order No." where("No." = field("Prod. Order No."), Status = field(Status)));
        }
        field(90202; "ONT Shortage"; Boolean)
        {
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(90203; "ONT Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."), "Location Code" = field("Location Code"), "Variant Code" = FIELD("Variant Code")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 7;
            Editable = false;
        }
        // field(90204; "ONT Item Reordering Policy"; enum "Reordering Policy")
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Item."Reordering Policy" where("No." = field("Item No.")));
        // }
        // field(90205; "ONT Auto Reserve DateFormula"; DateFormula)
        // {
        //     DataClassification = CustomerContent;
        // }
        // field(90206; "ONT Remaining Output"; Decimal)
        // {
        //     Caption = 'Remaining Output';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Prod. Order Line"."Remaining Quantity" where("Prod. Order No." = field("Prod. Order No."), Status = field(Status), "Line No." = field("Prod. Order Line No.")));
        // }
        // field(90207; "ONT Item Type"; Enum "Item Type")
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Item.Type where("No." = field("Item No.")));
        //     Editable = false;
        //     Caption = 'Item Type';
        // }
        field(90208; "ONT Sales Line No."; Integer)
        {
            Caption = 'Sales Line No,';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Production Order"."ONT Sales Line No." where("No." = field("Prod. Order No."), Status = field(Status)));
        }
        field(90209; "ONT Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Sales Line"."Shipment Date" where("Document No." = field("ONT Sales Order No."), "Document Type" = const(Order), "Line No." = field("ONT Sales Line No.")));
        }
        // field(90210; "ONT Planned Shipment Date"; Date)
        // {
        //     Caption = 'Planned Shipment Date';
        //     FieldClass = FlowField;
        //     Editable = false;
        //     CalcFormula = lookup("Sales Line"."Planned Shipment Date" where("Document No." = field("ONT Sales Order No."), "Document Type" = const(Order), "Line No." = field("ONT Sales Line No.")));
        // }
        // field(90211; "ONT Prod. Order Item No."; code[20])
        // {
        //     Caption = 'Prod Order Item No.';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Prod. Order Line"."Item No." where("Prod. Order No." = field("Prod. Order No."), "Line No." = field("Prod. Order Line No."), Status = field(Status)));
        //     Editable = false;
        // }
        // field(90212; "ONT Prod. Order Line Variant Code"; code[20])
        // {
        //     Caption = 'Prod Order Line Variant Code';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Prod. Order Line"."Variant Code" where("Prod. Order No." = field("Prod. Order No."), "Line No." = field("Prod. Order Line No."), Status = field(Status)));
        //     Editable = false;
        // }
        // field(90213; "ONT Prod. Order Item Desc."; Text[100])
        // {
        //     Caption = 'Prod Order Item Description';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Prod. Order Line".Description where("Prod. Order No." = field("Prod. Order No."), "Line No." = field("Prod. Order Line No."), Status = field(Status)));
        //     Editable = false;
        // }
        // field(90214; "ONT Prod Order Starting Date"; Date)
        // {
        //     Caption = 'Prod Order Starting Date';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Production Order"."Starting Date" where("No." = field("Prod. Order No."), Status = field(Status)));
        //     Editable = false;
        // }
        // field(90215; "ONT Inventory"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
        //                                                           "Location Code" = field("Location Code"),
        //                                                           "Variant Code" = field("Variant Code"),
        //                                                           "Unit of Measure Code" = field("Unit of Measure Code")));
        // }
        // field(90215; "ONT ETA Notes"; text[200])
        // {
        //     Caption = 'ETA Notes';
        //     DataClassification = ToBeClassified;
        // }
        // field(90216; "ONT Root Cause"; text[200])
        // {
        //     Caption = 'Root Cause';
        //     DataClassification = ToBeClassified;
        // }
        field(90217; "ONT Vendor No."; code[20])
        {
            Caption = 'Vendor No.';
        }
        // field(90218; "Reserved From Inventory"; Boolean)
        // {

        //     FieldClass = FlowField;
        //     CalcFormula = exist("Reservation Entry" where("Reservation Status" = const(Reservation),
        //                                                 "Source Type" = const(32),
        //                                                 "Source ID" = field("Prod. Order No."),
        //                                                 "Item No." = field("Item No."),
        //                                                 "Source Prod. Order Line" = field("Prod. Order Line No."),
        //                                                 "Source Subtype" = const(1),
        //                                                 "ONT Related Source ID" = field("Prod. Order No."),
        //                                                 "ONT Related Src Prod Ord. Line" = field("Prod. Order Line No."),
        //                                                 "ONT Related Source Ref. No." = field("Line No.")));
        // }
        // field(90219; "Reserved Qty. on Inventory"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Reservation Entry".Quantity where("Reservation Status" = const(Reservation),
        //                                                 "Source Type" = const(32),
        //                                                 "Source ID" = field("Prod. Order No."),
        //                                                 "Item No." = field("Item No."),
        //                                                 "Source Prod. Order Line" = field("Prod. Order Line No."),
        //                                                 "Source Subtype" = const("0"),
        //                                                 Positive = const(true)));

        // }
        // field(70120; "Planning Worksheet (Qty.)"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Requisition Line".Quantity where("Prod. Order Line No." = field("Prod. Order Line No."),
        //                                                         "Prod. Order No." = field("Prod. Order No."),
        //                                                         "No." = field("Item No."),
        //                                                         "Location Code" = field("Location Code"),
        //                                                         "Sales Order No." = field("ONT Sales Order No."),
        //                                                         "Sales Order Line No." = field("ONT Sales Line No.")));
        // }
        // field(70121; "ONT Item Replenishment System"; Enum "Replenishment System")
        // {
        //     FieldClass = FlowField;
        //     Caption = 'Item Replenishment System';
        //     CalcFormula = lookup(Item."Replenishment System" where("No." = field("Item No.")));
        // }
        // field(70122; "ONT Delay Reason Code"; text[200])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Delay Reason Code';
        // }
        field(70123; "ONT Work Center No."; code[20])
        {
            FieldClass = FlowField;
            Caption = 'Work Center No.';
            CalcFormula = lookup("Prod. Order Routing Line"."Work Center No." where("Prod. Order No." = field("Prod. Order No."), "Routing Link Code" = field("Routing Link Code"), Status = field(Status), Type = const("Work Center"), "Routing Reference No." = field("Prod. Order Line No.")));
        }
        // field(70124; "ONT Qty on Purch. Line"; Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order), Type = CONST(Item), "No." = FIELD("Item No."), "Location Code" = FIELD("Location Code"), "Variant Code" = FIELD("Variant Code"), "Unit of Measure Code" = FIELD("Unit of Measure Code")));
        //     Caption = 'Qty. on Purch. Order';
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(70125; "Planning Worksheet (Qty.)"; Decimal)
        // {
        //     CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE("Planning Line Origin" = CONST(Planning), Type = CONST(Item), "No." = FIELD("Item No."), "Location Code" = FIELD("Location Code"), "Variant Code" = FIELD("Variant Code")));
        //     Caption = 'Planning Worksheet (Qty.)';
        //     Editable = false;
        //     FieldClass = FlowField;
        // } 
        // field(70125; "Remaining Output"; Decimal)
        // {
        //     Caption = 'Remaining Output';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Prod. Order Line"."Remaining Quantity" where("Prod. Order No." = field("Prod. Order No."), Status = field(Status), "Line No." = field("Prod. Order Line No.")));
        // }
        // field(70126; "Work Center Name"; Text[100])
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Work Center".Name where("No." = field("ONT Work Center No.")));
        //     TableRelation = "Work Center".Name;
        // }
        // field(70127; "Vendor Name"; Text[100])
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Vendor."Name" where("No." = field("ONT Vendor No.")));
        // }
        // field(70128; "ONT Qty. on Subcontract Order"; Decimal)
        // {
        //     CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("Document Type" = CONST(Order),
        //                                                                     Type = CONST(Item), "No." = FIELD("Item No."),
        //                                                                     "Variant Code" = FIELD("Variant Code"),
        //                                                                     "Prod. Order No." = Filter(<> '')));
        //     Caption = 'Qty. on Subcontract Order';
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(70130; "ONT New ETA"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'New ETA';
        //     trigger OnValidate()
        //     var
        //     begin
        //         rec."ONT ETA Last Modified" := CurrentDateTime;
        //     end;
        // }
        // field(70131; "ONT ETA Last Modified"; DateTime)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(70132; "ONT Label Layout"; Option)
        {
            // DataClassification = ToBeClassified;
            OptionMembers = "","Raw Material","Finished Product";
            FieldClass = FlowField;
            CalcFormula = lookup(Item."ONT Label Layout" where("No." = field("Item No.")));

        }
        field(70133; "ONT Component Transferred"; Boolean)
        {
            Caption = 'Component Transferred';
        }
    }
}