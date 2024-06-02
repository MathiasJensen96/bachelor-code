pageextension 60001 "Project Attributes_EVAS" extends "Project Attributes PGS"
{
    layout
    {
        addafter(Values)
        {
            field(Standard_EVAS; Rec.Standard_EVAS)
            {
                ApplicationArea = All;
                ToolTip = 'Should this attribute be standard', Comment = 'DAN="Skal den her attribut være standard"';
            }
        }
    }
}