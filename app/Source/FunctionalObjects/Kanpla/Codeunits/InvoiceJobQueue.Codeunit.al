codeunit 60003 "Invoice Job Queue_EVAS"
{
    trigger OnRun()
    var
        KanplaCompanyID: Record "Kanpla Company ID_EVAS";
        InvoiceStagingHeader: Record "Invoice Staging Header_EVAS";
        JobJournalLine: Record "Job Journal Line";
        SerwizSetup: Record "Serwiz Setup_EVAS";
        KanplaFunctions: Codeunit "Kanpla Functions_EVAS";
        JobJnlPostBatch: Codeunit "Job Jnl.-Post Batch";
        POSDataInterface: Interface "POS Data Interface_EVAS";
    begin
        SerwizSetup.Get();
        KanplaFunctions.GetCompanyIDsFromKanpla();
        KanplaCompanyID.SetRange(Imported, false);
        if KanplaCompanyID.FindSet() then
            repeat
                KanplaFunctions.GetInvoicesFromCompanyID(KanplaCompanyID.ID, SerwizSetup."Last Job Queue Ending Date", Today);
                KanplaCompanyID.Imported := true;
                KanplaCompanyID.Modify(true);
            until KanplaCompanyID.Next() = 0;

        if InvoiceStagingHeader.FindSet() then
            repeat
                case InvoiceStagingHeader."POS System" of
                    'Kanpla':
                        begin
                            POSDataInterface := enum::"POS Data Handler_EVAS"::Kanpla;
                            POSDataInterface.Validate(InvoiceStagingHeader);
                            Commit();

                            if InvoiceStagingHeader.Errors = false then begin
                                POSDataInterface.Create(InvoiceStagingHeader);
                                Commit();
                            end;
                        end;
                end;
            until InvoiceStagingHeader.Next() = 0;

        JobJournalLine."Journal Template Name" := SerwizSetup."Journal Template Name";
        JobJournalLine."Journal Batch Name" := SerwizSetup."Journal Batch Name";
        if JobJnlPostBatch.Run(JobJournalLine) then begin
            InvoiceStagingHeader.SetRange(Errors, false);
            if InvoiceStagingHeader.FindSet() then
                InvoiceStagingHeader.DeleteAll();
        end;

        SerwizSetup."Last Job Queue Ending Date" := Today;
        SerwizSetup.Modify(true);
    end;
}