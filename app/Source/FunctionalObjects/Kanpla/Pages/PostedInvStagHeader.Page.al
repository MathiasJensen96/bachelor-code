page 60013 "Posted Inv. Stag. Header_EVAS"
{
    Caption = 'Posted Inv. Stag. Header', Comment = 'DAN="Posted Inv. Stag. Header"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Inv. Stag. Header_EVAS";
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
}