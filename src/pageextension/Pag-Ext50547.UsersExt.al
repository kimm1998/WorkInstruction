pageextension 50547 UsersExt extends Users
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Permission Set by User")
        {
            action("Permission Set by Active User")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Permission Set by Active User';
                Image = Permission;
                RunObject = Page "Permission Set by Active User";
                ToolTip = 'View or edit the available permission sets and apply permission sets to Active users.';
            }

        }
    }

    var
        myInt: Integer;
}