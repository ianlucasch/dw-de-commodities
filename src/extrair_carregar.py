import pandas as pd
import yfinance as yf
from database import engine

commodities = ["CL=F", "GC=F", "SI=F", "HG=F", "PL=F"]

def buscar_dados_commodities(ticker, periodo="5d", intervalo="1d"):
    ticket = yf.Ticker(ticker)
    dados = ticket.history(period=periodo, interval=intervalo)[["Close"]]
    dados["Ticker"] = ticker
    return dados

def buscar_todos_dados_commodities(commodities):
    todos_dados = []
    for tickers in commodities:
        dados = buscar_dados_commodities(tickers)
        todos_dados.append(dados)
    return pd.concat(todos_dados)

def salvar_no_postgres(df, schema="public"):
    df.to_sql("commodities", engine, if_exists="replace", index=True, index_label="Date", schema=schema)

if __name__ == "__main__":
    dados_concatenados = buscar_todos_dados_commodities(commodities)
    salvar_no_postgres(dados_concatenados, schema="public")