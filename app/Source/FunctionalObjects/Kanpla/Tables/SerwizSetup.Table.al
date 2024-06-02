table 60006 "Serwiz Setup_EVAS"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PK; Code[10])
        {
            Caption = 'PK', Comment = 'DAN="PK"';
        }
        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name', Comment = 'DAN="Kladde template navn"';
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name', Comment = 'DAN="Kladde batch navn"';
        }
        field(4; "Last Job Queue Ending Date"; Date)
        {
            Caption = 'Last Job Queue Ending Date', Comment = 'DAN="Sidste job kø slut dato"';
        }
    }

    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}