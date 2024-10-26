{% docs __overview__ %}

# Projeto DBT Core para Data Warehouse de Commodities

Este projeto utiliza DBT (Data Build Tool) para gerenciar e transformar dados de um Data Warehouse (DW) de commodities. O objetivo é criar um pipeline de dados robusto e eficiente que trata e organiza os dados de commodities e suas movimentações para análise.

## Estrutura de diretórios

```plaintext
├── models
│   ├── bronze
│   │   ├── bronze_commodities.sql
│   │   ├── bronze_movimentacao_commodities.sql
│   │   └── schema.yml
│   ├── gold
│   │   ├── gold_datamart_commodities.sql
│   │   └── schema.yml
│   ├── silver
│   │   ├── schema.yml
│   │   ├── silver_commodities.sql
│   │   └── silver_movimentacao_commodities.sql
│   └── sources.yml
├── seeds
│   ├── movimentacao_commodities.csv
│   └── schema.yml
└── dbt_project.yml
```

## Estrutura do projeto

### 1. Models

Os models definem as transformações dos dados usando SQL. Eles são divididos em três camadas principais: bronze, silver e gold.

#### Bronze

A camada bronze é responsável por carregar os dados brutos para que posteriormente sejam transformados.

- **bronze_commodities.sql**: Carrega os dados brutos da tabela commodities.
- **bronze_movimentacao_commodities.sql**: Carrega os dados brutos do seed movimentacao_commodities.

#### Silver

A camada silver é responsável por limpar e transformar os dados antes que eles sejam carregados nas tabelas finais de análise.

- **silver_commodities.sql**: Recebe os dados da view bronze_commodities e faz as devidas transformações.
- **silver_movimentacao_commodities.sql**: Recebe os dados da view bronze_movimentacao_commodities e faz as devidas transformações.

#### Gold

A camada gold é onde os dados finais de análise são armazenados. Eles são baseados nos dados transformados pela camada silver.

- **gold_datamart_commodities.sql**: Integra os dados das views silver_commodities e silver_movimentacao_commodities, criando um modelo de dados final para análise.

### 2. Sources

Os sources são as tabelas ou arquivos de origem dos dados que o DBT utiliza para realizar as transformações.

### 3. Seeds

Os seeds são dados estáticos que são carregados no Data Warehouse a partir de arquivos CSV. Neste projeto, usamos seeds para carregar dados de movimentações das commodities.

## Executando o projeto

### Requisitos

- Python 3.12.3
- PostgreSQL
- DBT

### Passos para execução

1. Clone o repositório localmente:
   ```bash
   git clone https://github.com/ianlucasch/dw-de-commodities.git
   ```


2. Acesse a pasta do projeto:
   ```bash
   cd dw-de-commodities
   ```


3. Crie um ambiente virtual e ative-o:
   ```bash
   python -m venv .venv
   source .venv/Scripts/activate
   ```


4. Instale o DBT:
   ```bash
   pip install dbt-postgres
   ```


5. Crie um novo projeto DBT:
   ```bash
   dbt init dbt_commodities
   cd dbt_commodities
   ```


6. Configure a conexão com PostgreSQL:

   Configure o arquivo `profiles.yml` com suas variáveis de ambiente para conectar o DBT ao PostgreSQL. O arquivo deve estar no diretório `~/.dbt/` ou no diretório especificado pela variável de ambiente `DBT_PROFILES_DIR`.

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


7. Verifique o estado do projeto:
   ```bash
   dbt debug
   ```


8. Execute os seeds do DBT:
   ```bash
   dbt seed
   ```


9. Execute as transformações do DBT:
   ```bash
   dbt run
   ```

{% enddocs %}