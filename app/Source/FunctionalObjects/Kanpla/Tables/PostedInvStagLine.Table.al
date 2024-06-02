table 60003 "Posted Inv. Stag. Line_EVAS"
{
    DataClassification = CustomerContent;
    Caption = 'Posted Invoice Staging Lines', Comment = 'DAN="Bogførte Invoice Staging Lines"';

    fields
    {
        field(1; name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name', Comment = 'DAN="Navn"';
        }
        field(2; pricePerItem; Decimal)
        {
            Caption = 'Price Per Item', Comment = 'DAN="Pris per vare"';
        }
        field(3; amount; Integer)
        {
            Caption = 'Amount', Comment = 'DAN="Antal"';
        }
        field(4; productId; Text[100])
        {
            Caption = 'Product ID', Comment = 'DAN="Produkt ID"';
        }
        field(5; "Header ID"; Text[100])
        {
            Caption = 'Header ID', Comment = 'DAN="Header ID"';
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'DAN="Linje nr."';
        }
    }

    keys
    {
        key(PK; "Header ID", "Line No.")
        {
            Clustered = true;
        }
    }
}