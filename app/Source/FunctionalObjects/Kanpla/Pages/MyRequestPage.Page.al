page 60011 "MyRequestPage_EVAS"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Kanpla Company ID_EVAS";

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                field("Starting Date"; StartingDate)
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; EndingDate)
                {
                    ApplicationArea = All;
                }
                field("Company ID"; CompanyID)
                {
                    ApplicationArea = All;
                    LookupPageId = "Kanpla Company ID_EVAS";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        KanplaCompanyID: Page "Kanpla Company ID_EVAS";
                    begin
                        KanplaCompanyID.RunModal();
                    end;
                }
            }
        }
    }

    procedure GetStartingDate(): Date
    begin
        exit(StartingDate);
    end;

    procedure GetEndingDate(): Date
    begin
        exit(EndingDate);
    end;

    procedure GetCompanyID(): Text[50]
    begin
        exit(CompanyID);
    end;

    protected var
        StartingDate: Date;
        EndingDate: Date;
        CompanyID: Text[50];
}