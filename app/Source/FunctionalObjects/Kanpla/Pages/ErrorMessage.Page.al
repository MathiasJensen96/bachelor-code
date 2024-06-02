page 60010 "Error Message_EVAS"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Error Message_EVAS";

    layout
    {
        area(Content)
        {
            repeater("Error List")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Header ID"; Rec."Header ID")
                {
                    ToolTip = 'Specifies the value of the Header ID field.', Comment = 'DAN="Header id"';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ToolTip = 'Specifies the value of the Error Message field.', Comment = 'DAN="Error besked"';
                }
            }
        }
    }
}