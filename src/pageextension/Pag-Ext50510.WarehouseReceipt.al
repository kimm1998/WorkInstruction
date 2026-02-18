pageextension 50510 "Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addlast(General)
        {
            group(Container)
            {
                Caption = 'Container';

                field("Container ID"; Rec."Container ID")
                {
                    ApplicationArea = All;
                }
                field("Container Type"; Rec."Container Type")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Container lifecycle: Open: Default status when new container is created. Prepared: Devinci team is preparing the container and what composes it. The status indicates the task is done. Loaded: The goods are at the port of embarkation. The status indicates that the goods are ready to go. Shipped: The goods have left and are in transit. Arrived at destination: The status indicates that the goods have arrived at their destination, end of the sea or rail journey. The goods still have to make a final local-road transit to the warehouse. Delivered: The goods are delivered and received at the warehouse.';
                }
                field("Balanced"; Rec."Balanced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Confirms packing list balances according to the items included in the container.';
                }
                field("Cleared"; Rec."Cleared")
                {
                    ApplicationArea = All;
                    ToolTip = 'Information on the status of the imported goods at the border.';
                }
                field("Route"; Rec."Route")
                {
                    ApplicationArea = All;
                    Editable = EditableRoute;
                    ToolTip = 'Code representing the different stages of the import journey. Includes the standard local transport time. This field is not editable when a value is present in one or other of the following fields: ETD, ATD, ETA, ATA, Expected Delivery Date.';
                }
                field("Container Shipping Agent"; Rec."Container Shipping Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Delivery agent who will take care of the transport of the goods included in the container, to the destination of the Route.';
                }
                field("Tracking No."; Rec."Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Container''s tracking number';
                }
                field("Cargo Control No."; Rec."Cargo Control No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'A Cargo Control Number, often abreviated as CCN, is a unique number assigned by the carrier to a shipment of goods entering Canada. It serves as a means of telling shipments apart for CBSA, while simultaneously identifying the carrier transporting the goods.';
                }
                field("Transit Warehouse"; Rec."Transit Warehouse")
                {
                    ApplicationArea = All;
                    ToolTip = 'This is the warehouse where merchandise is received for unpacking and transition.';
                }
                field("Bill of Lading No."; Rec."Bill of Lading No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The bill of lading is a legally enforceable document summarizing the terms and conditions for a specific shipment. It is an agreement between the shipping customer, or a third party, and the carrier.';
                }
                field("Vessel ID"; Rec."Vessel ID")
                {
                    ApplicationArea = All;
                }
                field("Seal No."; Rec."Seal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The seal number is used if the shipment is full truckload from the origin to destination.';
                }
                field("Package Qty."; Rec."Package Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'The value of this field must be greater than or equal to 0. This is the number of packages included in the container.';
                }
                field("Estimated Timeof Departure"; Rec."Estimated Time Departure")
                {
                    Caption = 'ETD';
                    Editable = EditableETD;
                    ApplicationArea = All;
                    ToolTip = 'Estimated Time of Departure of the container. This date must be entered manually and is usually provided by the carrier. If an actual departure date has been entered (ATD), this date cannot be edited, as it represents the initial reference date received from the carrier.';

                    trigger OnValidate()
                    begin
                        CheckEditableRoute(Rec."Estimated Time Departure");
                    end;
                }
                field("Actual Time Of Departure"; Rec."Actual Time Of Departure")
                {
                    Caption = 'ATD';
                    
                    ApplicationArea = All;
                    ToolTip = 'Actual Time of Departure of the container. This date must be entered manually and is updated each time the carrier provides an updated departure date.';

                    trigger OnValidate()
                    begin
                        CheckEditableRoute(Rec."Actual Time Of Departure");
                        CheckEditableETDOnAfterGetRecord();
                    end;
                }
                field("Estimated Time of Arrival"; Rec."Estimated Time of Arrival")
                {
                    Caption = 'ETA';
                    Editable = EditableETA;
                    ApplicationArea = All;
                    ToolTip = 'Estimated Time of Arrival of the container, at the end of its sea or rail journey. This date must be entered manually and is provided along with the scheduled departure date, by the carrier. If an actual arrival date has been entered (ATA), this date cannot be edited, because it represents the initial reference date received from the carrier. Entering a date in this field triggers the following updates: [Expected Delivery Date] = [Estimated Time of Arrival] + [Transit Delay] & [Due Date] des lignes = [Estimated Time of Arrival] + [Transit Delay]';

                    trigger OnValidate()
                    begin
                        CheckEditableRoute(Rec."Estimated Time of Arrival");
                    end;
                }
                field("Actual Time of Arrival"; Rec."Actual Time of Arrival")
                {
                    Caption = 'ATA';
                    ApplicationArea = All;
                    ToolTip = 'Actual Time of Arrival of the container at the end of its sea or rail journey. This date must be entered manually and is provided along with the scheduled departure date, by the carrier. Entering a date in this field triggers the following updates: [Expected Delivery Date] = [Actual Time of Arrival] + [Transit Delay] & [Due Date] des lignes = [Actual Time of Arrival] + [Transit Delay]';

                    trigger OnValidate()
                    begin
                        CheckEditableRoute(Rec."Actual Time of Arrival");
                        CheckEditableETA(Rec."Actual Time of Arrival");
                    end;
                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Expected delivery date of the container to the Devinci warehouse. This date considers the local transit time of the Route, and is updated each time an actual arrival date is updated (ATA).';

                    trigger OnValidate()
                    begin
                        CheckEditableRoute(Rec."Expected Delivery Date");
                    end;
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date on which the goods arrived, but not yet received. Used by handlers to report it. The inventory date will be the current date that will be postponed. The difference between the two is therefore the measure of the basketing delay.';
                }
            }
            group(Pickup)
            {
                Caption = 'Pickup';

                field("Number of Pallets"; Rec."Number of Pallets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of pallet(s) that the transit warehouse generates following receipt of the container. This value is sent to us by the warehouse that manages this package handling.';
                }
                field("Number of Exchange Pallets"; Rec."Number of Exchange Pallets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allows you to enter the number of pallet(s) that the local carrier will exchange when picking up the goods. (Pallets are not free, 1:1 exchanges are considered).';
                }
                field("Storage Date"; Rec."Storage Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'This is the deadline from which storage charges will begin to apply if the shipment has not been processed and pickup has not been arranged.';
                }
                // field("Location Code"; Rec."Location Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'The location where the goods are expected to be received.';
                // }
                field("Pickup Shipping Agent"; Rec."Pickup Shipping Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Local carrier who will pick up the merchandise to transport it to the Devinci warehouse.';
                }
                field("Pickup Confirmation No."; Rec."Pickup Confirmation No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pickup confirmation No provided by local carrier. This value indicates that the carrier is committed to picking up the goods.';
                }
                field("Release Date"; Rec."Release Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date from which the local carrier can schedule the pick-up of the goods.';
                }
                field("Pickup Date"; Rec."Pickup Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transit warehouse pickup date confirmed by local carrier.';
                }
                field("Pickup Tracking No."; Rec."Pickup Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pickup tracking number provided by the local carrier, after picking up the goods.  Allows you to track goods in transit.';
                }
            }
        }
        moveafter("No."; "Location Code")
        modify("Location Code")
        {
            ToolTip = 'The location where the goods are expected to be received.';
        }
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = all;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(7316), "No." = field("No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CheckEditableRouteOnAfterGetRecord();
        CheckEditableETAOnAfterGetRecord();
        CheckEditableETDOnAfterGetRecord();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CheckEditableETDOnAfterGetRecord();

    end;

    local procedure CheckEditableRoute(ValofTime: Date)
    begin
        if ValofTime <> 0D then
            EditableRoute := false
        else
            EditableRoute := true;
    end;

    local procedure CheckEditableRouteOnAfterGetRecord()
    begin
        if (Rec."Estimated Time Departure" <> 0D) or (Rec."Actual Time Of Departure" <> 0D) or (Rec."Estimated Time of Arrival" <> 0D) or (Rec."Actual Time of Arrival" <> 0D) or (Rec."Expected Delivery Date" <> 0D) then
            EditableRoute := false
        else
            EditableRoute := true;
    end;

    local procedure CheckEditableETA(ValofTime: Date)
    begin
        if ValofTime <> 0D then
            EditableETA := false
        else
            EditableETA := true;
    end;

    local procedure CheckEditableETAOnAfterGetRecord()
    begin
        if Rec."Actual Time of Arrival" <> 0D then
            EditableETA := false
        else
            EditableETA := true;
    end;

    local procedure CheckEditableETDOnAfterGetRecord()
    begin
        if Rec."Actual Time of Departure" <> 0D then
            EditableETD := false
        else
            EditableETD := true;
    end;

    var
        EditableRoute: Boolean;
        EditableETA: Boolean;
        EditableETD: Boolean;
}
