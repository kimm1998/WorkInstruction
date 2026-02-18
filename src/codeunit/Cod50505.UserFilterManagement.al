codeunit 50505 "User Filter Management"
{
 
    procedure GetUserFilter(TableID: Integer): Text[2048]
    var
        UserTableFilter: Record "User Table Filter";
        ListFilter: Record "List Filter";
        CurrentUserID: Text[50];
    begin
        // Retrieve the current user's ID
        CurrentUserID := UserId();
 
        // Search for the filter for the current user and the specified table ID
        if UserTableFilter.Get(CurrentUserID, TableID) then
            if ListFilter.Get(TableID, UserTableFilter."Filter Code") then
                exit(ListFilter.Filter); // Return the filter
 
 
        // Return an empty string if no filter is found
        exit('');
    end;
 
    procedure ApplyListFilter(Rec: RecordRef; TableID: Integer)
    var
        Filter: Text[2048];
    begin
        // Retrieve the user filter for the specified table
        Filter := GetUserFilter(TableID);
 
        if Filter <> '' then begin
            // Apply the filter to the provided RecordRef
            Rec.SetView(Filter);
        end;
    end;
}