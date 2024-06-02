page 60003 "Invoice Staging Header_EVAS"
{
    Caption = 'Invoice Straging Header', Comment = 'DAN="Faktura staging header"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Invoice Staging Header_EVAS";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("date"; Rec."date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = 'DAN="Dato"';
                }
                field(billedDate; Rec.billedDate)
                {
                    ToolTip = 'Specifies the value of the Billed Date field.', Comment = 'DAN="Faktureret dato"';
                }
                field(createdTimestamp; Rec.createdTimestamp)
                {
                    ToolTip = 'Specifies the value of the Created Timestamp field.', Comment = 'DAN="Oprettelses tidsstempel"';
                }
                field(displayName; Rec.displayName)
                {
                    ToolTip = 'Specifies the value of the Display Name field.', Comment = 'DAN="Viste navn"';
                }
                field(groupName; Rec.groupName)
                {
                    ToolTip = 'Specifies the value of the Group Name field.', Comment = 'DAN="Gruppe navn"';
                }
                field(moduleId; Rec.moduleId)
                {
                    ToolTip = 'Specifies the value of the Module ID field.', Comment = 'DAN="Modul id"';
                }
                field(moduleName; Rec.moduleName)
                {
                    ToolTip = 'Specifies the value of the Module Name field.', Comment = 'DAN="Modul navn"';
                }
                field(paymentMethod; Rec.paymentMethod)
                {
                    ToolTip = 'Specifies the value of the Payment Method field.', Comment = 'DAN="Betallings metode"';
                }
                field(schoolId; Rec.schoolId)
                {
                    ToolTip = 'Specifies the value of the School ID field.', Comment = 'DAN="Skole ID"';
                }
                field(schoolName; Rec.schoolName)
                {
                    ToolTip = 'Specifies the value of the School Name field.', Comment = 'DAN="Skole navn"';
                }
                field("userId"; Rec.userId)
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = 'DAN="Bruger id"';
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = 'DAN="ID"';
                }
                field("Project ID"; Rec."Project ID")
                {
                    ToolTip = 'Specifies the value of the Project ID field.', Comment = 'DAN="Projekt id"';
                }
                field("Item ID"; Rec."Item ID")
                {
                    ToolTip = 'Specifies the value of the Item ID field.', Comment = 'DAN="Vare id"';
                }
                field("POS System"; Rec."POS System")
                {
                    ToolTip = 'Specifies the value of the POS System field.', Comment = 'DAN="POS system"';
                }
                field(Errors; Rec.Errors)
                {
                    ToolTip = 'Specifies the value of the Errors field.', Comment = 'DAN="Errors"';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        ErrorMessageEVAS: Record "Error Message_EVAS";
                    begin
                        ErrorMessageEVAS.SetRange("Header ID", Rec.id);
                        if ErrorMessageEVAS.FindSet() then
                            Page.RunModal(Page::"Error Message_EVAS", ErrorMessageEVAS)
                    end;
                }
            }
            part(Lines; "Invoice Staging Lines_EVAS")
            {
                ApplicationArea = All;
                SubPageLink = "Header ID" = field(id);
                UpdatePropagation = SubPart;
                Caption = 'Invoice Lines', Comment = 'DAN="Faktura linjer"';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Invoices From Kanpla")
            {
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Imports new invoices for a given company id', Comment = 'DAN="Importere de nye faktura for et givent virksomheds id"';

                trigger OnAction()
                var
                    KanplaFunctions: Codeunit "Kanpla Functions_EVAS";
                    MyRequestPage: Page MyRequestPage_EVAS;
                begin
                    if MyRequestPage.RunModal() = Action::OK then
                        KanplaFunctions.GetInvoicesFromCompanyID(MyRequestPage.GetCompanyID(), MyRequestPage.GetStartingDate(), MyRequestPage.GetEndingDate());
                end;
            }
            action("Create Project Journal Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Generates project journal lines based on the imported invoices', Comment = 'DAN="Opretter projekt kladde linjer ud fra de importeret faktura"';
                Image = Import;

                trigger OnAction()
                var
                    InvoiceStagingHeader: Record "Invoice Staging Header_EVAS";
                    JobJournalLine: Record "Job Journal Line";
                    SerwizSetup: Record "Serwiz Setup_EVAS";
                    JobJnlPostBatch: Codeunit "Job Jnl.-Post Batch";
                    POSDataInterface: Interface "POS Data Interface_EVAS";
                begin
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

                    SerwizSetup.Get();
                    JobJournalLine."Journal Template Name" := SerwizSetup."Journal Template Name";
                    JobJournalLine."Journal Batch Name" := SerwizSetup."Journal Batch Name";
                    if JobJnlPostBatch.Run(JobJournalLine) then begin
                        InvoiceStagingHeader.SetRange(Errors, false);
                        if InvoiceStagingHeader.FindSet() then
                            InvoiceStagingHeader.DeleteAll();
                    end;
                end;
            }
        }
    }
}