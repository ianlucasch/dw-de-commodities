import pandas as pd
import streamlit as st
from database import engine

def buscar_dados_db():
    query = f"""
    SELECT
        *
    FROM
        public.gold_datamart_commodities;
    """
    df = pd.read_sql(query, engine)
    return df

st.title("Dashboard de Commodities")
st.write("Este dashboard mostra os dados de commodities.")

df = buscar_dados_db()

st.dataframe(df)