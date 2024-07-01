WITH commodities AS (
    SELECT
        "data",
        "simbolo",
        "valor_fechamento"
    FROM
        {{ ref ('stg_commodities') }}
),

movimentacao AS (
    SELECT
        "data",
        "simbolo",
        "acao",
        "quantidade"
    FROM
        {{ ref ('stg_movimentacao_commodities') }}
),

joined AS (
    SELECT
        c.data,
        c.simbolo,
        c.valor_fechamento,
        m.acao,
        m.quantidade,
        (m.quantidade * c.valor_fechamento) AS "valor",
        CASE
            WHEN m.acao = 'sell' THEN (m.quantidade * c.valor_fechamento)
            ELSE -(m.quantidade * c.valor_fechamento)
        END AS "ganho"
    FROM
        commodities c
    INNER JOIN
        movimentacao m
    ON
        c.data = m.data
    AND
        c.simbolo = m.simbolo
),

last_day AS (
    SELECT
        MAX(data) AS "max_date"
    FROM
        joined
),

filtered AS (
    SELECT
        *
    FROM
        joined
    WHERE
        data = (SELECT max_date FROM last_day)
)

SELECT
    "data",
    "simbolo",
    "valor_fechamento",
    "acao",
    "quantidade",
    "valor",
    "ganho"
FROM
    filtered