WITH source AS (
    SELECT
        "date",
        "symbol",
        "action",
        "quantity"
    FROM
        {{ source ('db_hvob', 'movimentacao_commodities') }}
),

renamed AS (
    SELECT
        CAST("date" AS Date) AS "data",
        "symbol" AS "simbolo",
        "action" AS "acao",
        "quantity" AS "quantidade"
    FROM
        source
)

SELECT
    *
FROM
    renamed