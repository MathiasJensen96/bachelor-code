interface "POS Data Interface_EVAS"
{
    procedure Validate(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS");
    procedure Create(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS");
    procedure Log(var JobJournalLine: Record "Job Journal Line");
    procedure ErrorHandle(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS"; ErrorMsg: Text[1024]);
}