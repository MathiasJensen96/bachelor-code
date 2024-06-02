page 60009 "Module ID Linked With Task No."
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Module ID Linked With Task No.";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Module ID"; Rec."Module ID")
                {
                    ToolTip = 'Specifies the value of the Module ID field.', Comment = 'DAN="Modul id"';
                }
                field("Task No."; Rec."Task No.")
                {
                    ToolTip = 'Specifies the value of the Task No. field.', Comment = 'DAN="Opgave nr."';
                }
            }
        }
    }
}