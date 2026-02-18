query 50502 "ONT.API Item Avail. Buffer"
{
    QueryType = API;
    APIPublisher = 'OnTarget';
    APIGroup = 'supplyChain';
    APIVersion = 'v2.0';
    EntityName = 'itemAvailabilityBuffer';
    EntitySetName = 'itemAvailabilityBuffers';

    elements
    {
        dataitem(Buffer; ONT_ItemAvailabilityBuffer)
        {
            // Use camelCase for API columns as per standard JSON conventions
            column(entryNo; "Entry No.")
            {
            }
            column(itemNo; "Item No.")
            {
            }
            column(date; "Date")
            {
            }
            column(sourceType; "Source Type")
            {
            }
            column(documentNo; "Source ID")
            {
            }
            column(description; Description)
            {
            }
            column(qtyIn; "Qty. In")
            {
            }
            column(qtyOut; "Qty. Out")
            {
            }
            column(availabilityAtDate; Availability)
            {
            }
            column(minAvailNextIn; "Min. Avail. Next In")
            {
            }
            column(minAvailEnd; "Min. Avail. End")
            {
            }
        }
    }
}