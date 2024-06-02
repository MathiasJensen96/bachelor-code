pageextension 60000 "Project Card_EVAS" extends "Project Card (PGS)"
{
    layout
    {
        modify("Person Responsible")
        {
            Caption = 'Person Responsible', Comment = 'DAN="Driftsansvarlig"';
        }
        modify("Project Managerx PGS")
        {
            Caption = 'Project Manager', Comment = 'DAN="Driftsleder"';
        }
        addlast(Posting)
        {
            field("Invoice EAN_EVAS"; Rec."Invoice EAN_EVAS")
            {
                ApplicationArea = All;
                ToolTip = 'Specify which EAN No. that should be invoiced', Comment = 'DAN="Specificer hvilket EAN nummer der skal faktureres"';
            }
        }
    }
}