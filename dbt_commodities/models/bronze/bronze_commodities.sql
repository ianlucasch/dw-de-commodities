{{ config(materialized="view") }}

WITH dados_brutos AS (
    SELECT
        *
    FROM
        {{ source("commodities_source", "commodities") }}
)

SELECT
    *
FROM
    dados_brutos