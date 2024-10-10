# Projeto de Data Warehouse de Commodities

Data Warehouse (DW) para armazenar e analisar dados de commodities, utilizando uma arquitetura moderna de ELT (Extract, Load and Transform).

![](imagens/fluxograma-elt.jpeg)

## Índice

- [Sobre o projeto](#sobre-o-projeto)
- [Como funciona](#como-funciona)
   - [Estrutura de diretórios](#estrutura-de-diretórios)
- [Como executar](#como-executar)

## Sobre o projeto

Este projeto tem como objetivo criar um Data Warehouse (DW) para armazenar e analisar dados de commodities. Esses dados são extraídos da [API do Yahoo Finance](https://github.com/ranaroussi/yfinance), carregados diretamente no banco de dados [PostgreSQL](https://www.postgresql.org/download/) e posteriormente são tratados pelo [DBT Core](https://github.com/dbt-labs/dbt-core). O dashboard é implementado em [Streamlit](https://github.com/streamlit/streamlit) e permite visualizar os dados das commodities armazenados no Data Warehouse, criando tabelas e gráficos interativos para análise dos dados.

A plataforma [Render](https://render.com/) foi utilizada para subir um PostgreSQL Server na nuvem.

## Como funciona

**<u>Task 01:</u> Extrair os dados da API e carregar no banco de dados**

O script `extrair_carregar` é responsável por extrair os dados de commodities da API do Yahoo Finance e carregar diretamente no banco de dados PostgreSQL, criando uma tabela `commodities` no banco de dados.

**<u>Task 02:</u> Transformar os dados**

O DBT Core é responsável pela limpeza e transformação dos dados. Após instalar o `dbt-postgres` e configurar o arquivo `profiles.yml`, o DBT se conecta ao banco de dados PostgreSQL para ter acesso as tabelas.

A pasta `models` define as transformações dos dados usando SQL. As transformações foram divididas em três camadas: bronze, silver e gold.

A pasta `seeds` é utilizada para carregar dados de movimentações das commodities a partir de arquivos CSV.

![](imagens/fluxograma-dbt.jpeg)

Para mais informações, acesse as pastas `dbt_commodities/docs` onde contém toda a documentação do projeto DBT.

**<u>Task 03:</u> Criar o dashboard**

O script `dashboard` é responsável por se conectar ao banco de dados PostgreSQL e criar o dashboard através da biblioteca Streamlit.

### Estrutura de diretórios

```
.
├── LICENSE
├── README.md
├── dbt_commodities
│   ├── docs
│   │   └── homepage.md
│   ├── models
│   │   ├── bronze
│   │   │   ├── bronze_commodities.sql
│   │   │   ├── bronze_movimentacao_commodities.sql
│   │   │   └── schema.yml
│   │   ├── gold
│   │   │   ├── gold_datamart_commodities.sql
│   │   │   └── schema.yml
│   │   ├── silver
│   │   │   ├── schema.yml
│   │   │   ├── silver_commodities.sql
│   │   │   └── silver_movimentacao_commodities.sql
│   │   └── sources.yml
│   ├── seeds
│   │   ├── movimentacao_commodities.csv
│   │   └── schema.yml
│   └── dbt_project.yml
├── exemplo.env
├── imagens
│   ├── fluxograma-dbt.jpeg
│   └── fluxograma-elt.jpeg
├── profiles.yml
├── pyproject.toml
├── requirements.txt
└── src
    ├── dashboard.py
    ├── database.py
    └── extrair_carregar.py
```

## Como executar

Todas as etapas foram executadas no terminal `bash`.

### Passos para execução:

1. Clone o repositório localmente:
   ```bash
   git clone https://github.com/ianlucasch/dw-de-commodities.git
   ```


2. Acesse a pasta do projeto:
   ```bash
   cd dw-de-commodities
   ```


3. Instale o python versão 3.12.3:
   ```bash
   pyenv install 3.12.3
   ```


4. Defina a versão local do python para 3.12.3:
   ```bash
   pyenv local 3.12.3
   ```


5. Crie um ambiente virtual e ative-o:
   ```bash
   python -m venv .venv
   source .venv/Scripts/activate
   ```


6. Instale todas as dependências do projeto:
   ```bash
   pip install -r requirements.txt
   ```


7. Execute o script `extrair_carregar`:
   ```bash
   python src/extrair_carregar.py
   ```


8. Configure o DBT:

   Configure o arquivo `profiles.yml` com suas variáveis de ambiente para se conectar ao seu Data Warehouse. O arquivo deve estar no diretório `~/.dbt/` ou no diretório especificado pela variável de ambiente `DBT_PROFILES_DIR`.

   Exemplo de `profiles.yml`:
   ```yaml
   dbt_commodities:
      outputs:
         dev:
            dbname: <DB_NAME>
            host: <DB_HOST>
            pass: <DB_PASS>
            port: <DB_PORT>
            schema: public
            threads: 1
            type: postgres
            user: <DB_USER>
      target: dev
   ```


9. Acesse a pasta do projeto DBT:
   ```bash
   cd dbt_commodities
   ```


10. Verifique o estado do projeto:
      ```bash
      dbt debug
      ```


11. Execute os seeds do DBT:
      ```bash
      dbt seed
      ```


12. Execute as transformações do DBT:
      ```bash
      dbt run
      ```


13. Execute o script `dashboard`:
      ```bash
      streamlit run src/dashboard.py
      ```