table 60000 "EAN Address_EVAS"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "EAN No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'EAN No.', Comment = 'DAN="EAN nummer"';
        }
        field(2; Description; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', Comment = 'DAN="Beskrivelse"';
        }
    }
    keys
    {
        key(Key1; "EAN No.")
        {
            Clustered = true;
        }
    }
}