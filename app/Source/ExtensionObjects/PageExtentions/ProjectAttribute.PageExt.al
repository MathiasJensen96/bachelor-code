pageextension 60002 "Project Attribute_EVAS" extends "Project Attribute PGS"
{
    layout
    {
        addafter(Type)
        {
            field(Standard_EVAS; Rec.Standard_EVAS)
            {
                ApplicationArea = All;
                ToolTip = 'Should this attribute be standard', Comment = 'DAN="Skal den her attribut være standard"';
            }
        }
    }
}