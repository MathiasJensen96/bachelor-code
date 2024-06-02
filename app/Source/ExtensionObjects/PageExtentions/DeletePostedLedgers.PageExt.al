pageextension 60006 "DeletePostedLedgers_EVAS" extends "Project Ledger Entries (PGS)"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast("F&unctions")
        {
            action(nuke_EVAS)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    JobLedgerEntry: Record "Job Ledger Entry";
                begin
                    JobLedgerEntry.SetRange("Job No.", '23501010249');
                    if JobLedgerEntry.FindSet() then
                        JobLedgerEntry.DeleteAll(true);
                end;
            }
        }
    }
}