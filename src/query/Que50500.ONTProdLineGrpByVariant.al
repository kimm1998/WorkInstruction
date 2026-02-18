query 50500 "ONT Prod Line Grp By Variant"
{
    QueryType = Normal;

    elements
    {
        dataitem(Prod__Order_Line; "Prod. Order Line")
        {
            column(Variant_Count)
            {
                Method = Count;
            }
            column(Variant_Code;
            "Variant Code")
            {
            }
            filter(FilterProd__Order_No_;
            "Prod. Order No.")
            {
            }
            filter(Filter_Status;
            Status)
            {
            }
            filter(Filter_Line_No_;
            "Line No.")
            {
            }
            filter(Filter_Variant_Code;
            "Variant Code")
            {
            }
        }
    }
}
