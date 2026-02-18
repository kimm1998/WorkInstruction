query 50503 "ONT.LOT No Information"
{
    QueryType = Normal;

    elements
    {
        dataitem(Lot_No__Information; "Lot No. Information")
        {
            column(Lot_No_; "Lot No.")
            {
            }
            column(Item_No_; "Item No.") { }
            column(ONT_Expiration_Date; "ONT Expiration Date") { }
            column(ONT_Last_Maintenance_Date; "ONT Last Maintenance Date") { }
            column(Description; Description) { }
            column(ONT_Maintenance_Interval; "ONT Maintenance Interval") { }
            column(ONT_Maintenance_Required; "ONT Maintenance Required") { }
            column(ONT_On_Hand__Base_; "ONT On Hand (Base)") { }
            column(ONT_Use_Expiration_Dates; "ONT Use Expiration Dates") { }
            // filter(ONT_Last_Maintenance_Date_filter; "ONT Last Maintenance Date") { }
            // filter(ONT_Maintenance_Required_Filter; "ONT Maintenance Required") { }
            // filter(ONT_On_Hand__Base_Filter; "ONT On Hand (Base)") { }


        }
    }


}