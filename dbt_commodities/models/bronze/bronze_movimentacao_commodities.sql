{{ config(materialized="view") }}

WITH dados_brutos AS (
    SELECT
        *
    FROM
        {{ ref("movimentacao_commodities") }}
)

SELECT
    *
FROM
    dados_brutos