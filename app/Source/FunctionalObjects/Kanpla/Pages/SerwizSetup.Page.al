page 60012 "Serwiz Setup_EVAS"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Serwiz Setup_EVAS";
    Caption = 'Serwiz Setup', Comment = 'DAN="Serwiz Setup"';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Template Name', Comment = 'DAN="Kladde template navn"';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name', Comment = 'DAN="Kladde batch navn"';
                }
                field("Last Job Queue Ending Date"; Rec."Last Job Queue Ending Date")
                {
                    ToolTip = 'Specifies the value of the Last Job Queue Ending Date field.', Comment = 'DAN="Sidste job kø slut dato"';
                }
            }
        }
    }
}