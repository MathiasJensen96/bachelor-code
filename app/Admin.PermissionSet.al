permissionset 60000 "Admin_EVAS"
{
    Assignable = true;
    Permissions = tabledata "EAN Address_EVAS" = RIMD,
        tabledata "Error Message_EVAS" = RIMD,
        tabledata "Invoice Staging Header_EVAS" = RIMD,
        tabledata "Invoice Staging Line_EVAS" = RIMD,
        tabledata "Kanpla Company ID_EVAS" = RIMD,
        tabledata "Module ID Linked With Task No." = RIMD,
        tabledata "Posted Inv. Stag. Header_EVAS" = RIMD,
        tabledata "Posted Inv. Stag. Line_EVAS" = RIMD,
        tabledata "Serwiz Setup_EVAS" = RIMD,
        table "EAN Address_EVAS" = X,
        table "Error Message_EVAS" = X,
        table "Invoice Staging Header_EVAS" = X,
        table "Invoice Staging Line_EVAS" = X,
        table "Kanpla Company ID_EVAS" = X,
        table "Module ID Linked With Task No." = X,
        table "Posted Inv. Stag. Header_EVAS" = X,
        table "Posted Inv. Stag. Line_EVAS" = X,
        table "Serwiz Setup_EVAS" = X,
        codeunit "Kanpla Data Handler_EVAS" = X,
        codeunit "Kanpla Functions_EVAS" = X,
        page "Error Message_EVAS" = X,
        page "Invoice Staging Header_EVAS" = X,
        page "Invoice Staging Lines_EVAS" = X,
        page "Kanpla Company ID_EVAS" = X,
        page "Module ID Linked With Task No." = X,
        page MyRequestPage_EVAS = X,
        page "Serwiz Setup_EVAS" = X;
}