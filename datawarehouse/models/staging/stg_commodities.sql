WITH source AS (
    SELECT
        "Date",
        "Close",
        "Simbolo"
    FROM
        {{ source ('db_hvob', 'commodities') }}
),

renamed AS (
    SELECT
        CAST("Date" AS Date) AS "data",
        "Close" AS "valor_fechamento",
        "Simbolo" AS "simbolo"
    FROM
        source
)

SELECT
    *
FROM
    renamed