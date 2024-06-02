table 60004 "Module ID Linked With Task No."
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Module ID"; Code[20])
        {
            Caption = 'Module ID', Comment = 'DAN="Modul id"';
        }
        field(2; "Task No."; Code[20])
        {
            Caption = 'Task No.', Comment = 'DAN="Opgave nr."';
        }
    }

    keys
    {
        key(PK; "Module ID")
        {
            Clustered = true;
        }
    }
}