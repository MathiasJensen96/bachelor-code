pageextension 60003 "Customer Card_EVAS" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Invoice EAN_EVAS"; Rec."Invoice EAN_EVAS")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice EAN field.', Comment = 'DAN="Fakturerings EAN"';
            }
        }
    }
}