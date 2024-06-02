codeunit 60002 "Kanpla Data Handler_EVAS" implements "POS Data Interface_EVAS"
{
    procedure Validate(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS")
    begin
        ValidateModuleID(InvoiceStagingHeader);
        ValidateProjectID(InvoiceStagingHeader);
        ValidateItemID(InvoiceStagingHeader);
    end;

    procedure Create(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS")
    var
        InvoiceStagingLine: Record "Invoice Staging Line_EVAS";
        JobJournalLine: Record "Job Journal Line";
        LineNo: Integer;
    begin
        InvoiceStagingLine.SetRange("Header ID", InvoiceStagingHeader.id);
        if InvoiceStagingLine.FindSet() then
            repeat
                LineNo := 10000;
                if JobJournalLine.FindLast() then
                    LineNo := JobJournalLine."Line No." + 10000;

                CreateJobJournalLine(InvoiceStagingHeader, InvoiceStagingLine, LineNo);
            until InvoiceStagingLine.Next() = 0;
    end;

    procedure Log(var JobJournalLine: Record "Job Journal Line")
    var
        PostedInvStagHeader: Record "Posted Inv. Stag. Header_EVAS";
        PostedInvStagLine: Record "Posted Inv. Stag. Line_EVAS";
        InvoiceStagingHeader: Record "Invoice Staging Header_EVAS";
        InvoiceStagingLine: Record "Invoice Staging Line_EVAS";
        JobJnlLine: Record "Job Journal Line";
    begin
        JobJnlLine.CopyFilters(JobJournalLine);
        if JobJnlLine.FindSet() then
            repeat
                PostedInvStagHeader.SetRange(id, JobJnlLine."Document No.");
                if PostedInvStagHeader.IsEmpty then
                    if InvoiceStagingHeader.Get(JobJnlLine."Document No.") then begin
                        PostedInvStagHeader.Init();
                        PostedInvStagHeader.TransferFields(InvoiceStagingHeader);
                        PostedInvStagHeader.Insert(true);

                        InvoiceStagingLine.SetRange("Header ID", InvoiceStagingHeader.id);
                        if InvoiceStagingLine.FindSet() then
                            repeat
                                PostedInvStagLine.Init();
                                PostedInvStagLine.TransferFields(InvoiceStagingLine);
                                PostedInvStagLine.Insert(true);
                            until InvoiceStagingLine.Next() = 0;
                    end;
            until JobJnlLine.Next() = 0;
    end;

    procedure ErrorHandle(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS"; ErrorMsg: Text[1024])
    var
        ErrorMessage: Record "Error Message_EVAS";
    begin
        ErrorMessage.Init();
        ErrorMessage."Header ID" := InvoiceStagingHeader.id;
        ErrorMessage."Error Message" := ErrorMsg;
        ErrorMessage.Insert(true);

        if InvoiceStagingHeader.Errors = false then begin
            InvoiceStagingHeader.Errors := true;
            InvoiceStagingHeader.Modify(true);
        end;
    end;

    local procedure ValidateModuleID(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS")
    var
        ModuleIDLinkedWithTaskNo: Record "Module ID Linked With Task No.";
        ErrorMsgLbl: Label 'Module ID does not exist in the link table', Comment = 'DAN="Modul id eksistere ikke i link tabellen"';
    begin
        ModuleIDLinkedWithTaskNo.SetRange("Module ID", InvoiceStagingHeader.moduleId);
        if ModuleIDLinkedWithTaskNo.IsEmpty then
            ErrorHandle(InvoiceStagingHeader, ErrorMsgLbl);
    end;

    local procedure ValidateProjectID(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS")
    var
        Job: Record Job;
        ErrorMsgLbl: Label 'There is no project with the given ID', Comment = 'DAN="Der er ikke noget projekt med det givne id"';
    begin
        Job.SetRange("No.", InvoiceStagingHeader."Project ID");
        if Job.IsEmpty then
            ErrorHandle(InvoiceStagingHeader, ErrorMsgLbl);
    end;

    local procedure ValidateItemID(var InvoiceStagingHeader: Record "Invoice Staging Header_EVAS")
    var
        Item: Record Item;
        ErrorMsgLbl: Label 'There is no item with the given ID', Comment = 'DAN="Der er ikke nogen vare med det givne id"';
    begin
        Item.SetRange("No.", InvoiceStagingHeader."Item ID");
        if Item.IsEmpty then
            ErrorHandle(InvoiceStagingHeader, ErrorMsgLbl);
    end;

    local procedure CreateJobJournalLine(InvoiceStagingHeader: Record "Invoice Staging Header_EVAS"; InvoiceStagingLine: Record "Invoice Staging Line_EVAS"; LineNo: Integer)
    var
        ModuleIDLinkedWithTaskNo: Record "Module ID Linked With Task No.";
        SerwizSetup: Record "Serwiz Setup_EVAS";
        JobJournalLine: Record "Job Journal Line";
    begin
        JobJournalLine.Init();
        if SerwizSetup.Get() then begin
            JobJournalLine.Validate("Journal Template Name", SerwizSetup."Journal Template Name");
            JobJournalLine.Validate("Journal Batch Name", SerwizSetup."Journal Batch Name");
        end;
        JobJournalLine.Validate("Line No.", LineNo);
        JobJournalLine.Validate("Posting Date", InvoiceStagingHeader.billedDate);
        JobJournalLine.Validate("Document Date", InvoiceStagingHeader.date);
        JobJournalLine.Validate("Document No.", InvoiceStagingHeader.id);
        JobJournalLine.Validate("Job No.", InvoiceStagingHeader."Project ID");

        ModuleIDLinkedWithTaskNo.SetRange("Module ID", InvoiceStagingHeader.moduleId);
        if ModuleIDLinkedWithTaskNo.Get(InvoiceStagingHeader.moduleId) then
            JobJournalLine.Validate("Job Task No.", ModuleIDLinkedWithTaskNo."Task No.");
        JobJournalLine.Validate(Type, JobJournalLine.Type::Item);
        JobJournalLine.Validate("No.", InvoiceStagingHeader."Item ID");
        JobJournalLine.Validate(Description, InvoiceStagingHeader.moduleName);
        JobJournalLine.Validate(Quantity, InvoiceStagingLine.amount);
        JobJournalLine.Validate("Unit Price", InvoiceStagingLine.pricePerItem);
        JobJournalLine.Validate("Expense Date PGS", InvoiceStagingHeader.billedDate);

        JobJournalLine.Insert(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Batch", 'OnBeforeUpdateAndDeleteLines', '', false, false)]
    local procedure SubscrubeToOnBeforeUpdateAndDeleteLinesEvent(var JobJournalLine: Record "Job Journal Line")
    begin
        Log(JobJournalLine);
    end;
}