{{ config(materialized="view") }}

WITH fonte AS (
    SELECT
        "date",
        "symbol",
        "action",
        "quantity"
    FROM
        {{ ref("bronze_movimentacao_commodities") }}
),

dados_transformados AS (
    SELECT
        "date" AS "data",
        "symbol" AS "ticker",
        "action" AS "acao",
        "quantity" AS "quantidade"
    FROM
        fonte
)

SELECT
    *
FROM
    dados_transformados