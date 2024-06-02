tableextension 60003 "Customer_EVAS" extends Customer
{
    fields
    {
        field(60000; "Invoice EAN_EVAS"; Integer)
        {
            Caption = 'Invoice EAN', Comment = 'DAN="Fakturerings EAN"';
        }
    }
}