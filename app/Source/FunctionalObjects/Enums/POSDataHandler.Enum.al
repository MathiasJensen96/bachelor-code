enum 60000 "POS Data Handler_EVAS" implements "POS Data Interface_EVAS"
{
    Extensible = true;

    value(0; Kanpla)
    {
        Implementation = "POS Data Interface_EVAS" = "Kanpla Data Handler_EVAS";
    }
}