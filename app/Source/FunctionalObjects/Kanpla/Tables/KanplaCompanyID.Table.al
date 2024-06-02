table 60001 "Kanpla Company ID_EVAS"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.', Comment = 'DAN="Løbe nr."';
        }
        field(2; ID; Text[100])
        {
            Caption = 'ID', Comment = 'DAN="ID"';
        }

        field(3; Name; Text[100])
        {
            Caption = 'Name', Comment = 'DAN="Navn"';
            DataClassification = CustomerContent;
        }
        field(4; "Project ID"; Code[20])
        {
            Caption = 'Project ID', Comment = 'DAN="Projekt id"';
        }
        field(5; "Item ID"; Code[20])
        {
            Caption = 'Item ID', Comment = 'DAN="Vare id"';
        }
        field(6; Imported; Boolean)
        {
            Caption = 'Imported', Comment = 'DAN="Importeret"';
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