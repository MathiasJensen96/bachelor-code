page 60002 "Kanpla Company ID_EVAS"
{
    Caption = 'Kanpla Company ID List', Comment = 'DAN="Kanpla Company ID List"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Kanpla Company ID_EVAS";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = 'DAN="Navn"';
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
                field(Invoiced; Rec.Imported)
                {
                    ToolTip = 'Specifies the value of the Invoiced field.', Comment = 'DAN="Faktureret"';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Company ID")
            {
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Imports Company IDs From Kanpla', Comment = 'DAN="Henter virksomheds id fra kanpla"';

                trigger OnAction()
                var
                    KanplaFunctions: Codeunit "Kanpla Functions_EVAS";
                begin
                    KanplaFunctions.GetCompanyIDsFromKanpla();
                end;
            }
        }
    }
}