page 60014 "Posted Inv. Stag. Lines_EVAS"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Inv. Stag. Line_EVAS";
    Caption = 'Posted Inv. Stag. Lines', Comment = 'DAN="Bogførte faktura staging linjer"';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(productId; Rec.productId)
                {
                    ToolTip = 'Specifies the value of the Product ID field.', Comment = 'DAN="Produkt ID"';
                }
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = 'DAN="Navn"';
                }
                field(amount; Rec.amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = 'DAN="Antal"';
                }
                field(pricePerItem; Rec.pricePerItem)
                {
                    ToolTip = 'Specifies the value of the Price Per Item field.', Comment = 'DAN="Pris per vare"';
                }
            }
        }
    }
}