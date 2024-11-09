{{ config(materialized="view") }}

WITH commodities AS (
    SELECT
        "data",
        "ticker",
        "valor_fechamento"
    FROM
        {{ ref("silver_commodities") }}
),

movimentacao AS (
    SELECT
        "data",
        "ticker",
        "acao",
        "quantidade"
    FROM
        {{ ref("silver_movimentacao_commodities") }}
),

juncao AS (
    SELECT
        c."data",
        c."ticker",
        c."valor_fechamento",
        m."acao",
        m."quantidade",
        (m."quantidade" * c."valor_fechamento") AS "valor",
        CASE
            WHEN m."acao" = 'sell' THEN (m."quantidade" * c."valor_fechamento")
            ELSE - (m."quantidade" * c."valor_fechamento")
        END AS "ganho"
    FROM
        commodities c
    INNER JOIN
        movimentacao m
    ON
        c."data" = m."data"
    AND
        c."ticker" = m."ticker"
),

ultimo_dia AS (
    SELECT
        MAX("data") AS "ultima_data"
    FROM
        juncao
),

dados_filtrados AS (
    SELECT
        *
    FROM
        juncao
    WHERE
        data = (SELECT "ultima_data" FROM ultimo_dia)
)

SELECT
    "data",
    "ticker",
    "valor_fechamento",
    "acao",
    "quantidade",
    "valor",
    "ganho"
FROM
    dados_filtrados