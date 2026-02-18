pageextension 50552 "OTG.LicensePlateList" extends "IWX License Plate"
{
    layout
    {
        addlast(General)
        {
            field("Pick to Prod. Order No."; Rec."Pick to Prod. Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Production Order No. to which the License Plate is picked.';
            }
        }
    }

}