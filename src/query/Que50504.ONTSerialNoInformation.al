query 50504 "ONT.Serial No Information"
{
    QueryType = Normal;

    elements
    {
        dataitem(Serial_No__Information; "Serial No. Information")
        {
            column(Serial_No_; "Serial No.")
            {
            }
            column(Item_No_; "Item No.") { }
            column(ONT_Expiration_Date; "ONT Expiration Date") { }
            column(ONT_Last_Maintenance_Date; "ONT Last Maintenance Date") { }
            column(ONT_Maintenance_Interval; "ONT Maintenance Interval") { }
            column(ONT_Maintenance_Required; "ONT Maintenance Required") { }
            column(ONT_On_Hand__Base_; "ONT On Hand (Base)") { }
            column(Description; Description) { }
            column(ONT_Use_Expiration_Dates; "ONT Use Expiration Dates") { }
            column(ONT_Child_Item_No_; "ONT Child Item No.") { }
            column(ONT_Child_Expiration_Date; "ONT Child Expiration Date") { }
            column(ONT_Child_Last_maintenace_Date; "ONT Child Last maintenace Date") { }
            column(ONT_Child_Lot_No_; "ONT Child Lot No.") { }
            column(ONT_Child_Maintenance_Interval; "ONT Child Maintenance Interval") { }
            column(ONT_Child_Next_Maint__Date; "ONT Child Next Maint. Date") { }
            // filter(ONT_Last_Maintenance_Date_filter; "ONT Last Maintenance Date") { }
            // filter(ONT_Maintenance_Required_Filter; "ONT Maintenance Required") { }
            // filter(ONT_On_Hand__Base_Filter; "ONT On Hand (Base)") { }


        }
    }


}