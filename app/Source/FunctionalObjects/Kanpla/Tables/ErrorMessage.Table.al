table 60005 "Error Message_EVAS"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Header ID"; Code[20])
        {
            Caption = 'Header ID', Comment = 'DAN="Header id"';
        }
        field(3; "Error Message"; Text[1024])
        {
            Caption = 'Error Message', Comment = 'DAN="Error besked"';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}