table 60002 "Invoice Staging Header_EVAS"
{
    DataClassification = CustomerContent;
    Caption = 'Invoice Staging Header', Comment = 'DAN="Invoice Staging Header"';

    fields
    {
        field(1; id; Code[20])
        {
            Caption = 'ID', Comment = 'DAN="ID"';
        }
        field(2; paymentMethod; Text[100])
        {
            Caption = 'Payment Method', Comment = 'DAN="Betallings metode"';
        }
        field(3; createdTimestamp; DateTime)
        {
            Caption = 'Created Timestamp', Comment = 'DAN="Oprettelses tidsstempel"';
        }
        field(4; moduleId; Text[100])
        {
            Caption = 'Module ID', Comment = 'DAN="Modul id"';
        }
        field(5; moduleName; Text[100])
        {
            Caption = 'Module Name', Comment = 'DAN="Modul navn"';
        }
        field(6; schoolId; Text[100])
        {
            Caption = 'School ID', Comment = 'DAN="Skole ID"';
        }
        field(7; schoolName; Text[100])
        {
            Caption = 'School Name', Comment = 'DAN="Skole navn"';
        }
        field(8; "date"; Date)
        {
            Caption = 'Date', Comment = 'DAN="Dato"';
        }
        field(9; billedDate; Date)
        {
            Caption = 'Billed Date', Comment = 'DAN="Faktureret dato"';
        }
        field(10; "userId"; Text[100])
        {
            Caption = 'User ID', Comment = 'DAN="Bruger id"';
        }
        field(11; groupName; Text[100])
        {
            Caption = 'Group Name', Comment = 'DAN="Gruppe navn"';
        }
        field(12; displayName; Text[100])
        {
            Caption = 'Display Name', Comment = 'DAN="Viste navn"';
        }
        field(13; "Project ID"; Code[20])
        {
            Caption = 'Project ID', Comment = 'DAN="Projekt id"';
        }
        field(14; "Item ID"; Code[20])
        {
            Caption = 'Item ID', Comment = 'DAN="Vare id"';
        }
        field(15; "POS System"; Text[20])
        {
            Caption = 'POS System', Comment = 'DAN="POS system"';
        }
        field(16; Errors; Boolean)
        {
            Caption = 'Errors', Comment = 'DAN="Errors"';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        InvoiceStagingLine: Record "Invoice Staging Line_EVAS";
        ErrorMessage: Record "Error Message_EVAS";
    begin
        InvoiceStagingLine.SetRange("Header ID", Rec.id);
        if InvoiceStagingLine.FindSet() then
            InvoiceStagingLine.DeleteAll();

        ErrorMessage.SetRange("Header ID", Rec.id);
        if ErrorMessage.FindSet() then
            ErrorMessage.DeleteAll();
    end;
}