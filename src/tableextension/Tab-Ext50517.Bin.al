tableextension 50517 "Bin" extends Bin
{
    fields
    {
        field(80000; "No Reference"; Code[50])
        {
            Caption = 'No Reference';
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'No need it';
        }
    }
}
