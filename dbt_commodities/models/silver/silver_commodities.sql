{{ config(materialized="view") }}

WITH fonte AS (
    SELECT
        "Date",
        "Close",
        "Ticker"
    FROM
        {{ ref("bronze_commodities") }}
),

dados_transformados AS (
    SELECT
        DATE("Date") AS "data",
        "Ticker" AS "ticker",
        CAST("Close" AS DECIMAL(10, 2)) AS "valor_fechamento"
    FROM
        fonte
)

SELECT
    *
FROM
    dados_transformados