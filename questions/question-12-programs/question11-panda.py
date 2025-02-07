import pandas as pd
import oracledb

# Configuração da conexão ao Oracle APEX
dsn = oracledb.makedsn(
    host="dbtoolsprod-phx-apex-ext-mt-01",  # Insira seu host aqui
    port=1521,  # Porta padrão do Oracle
    service_name="aextpdb.dbtoolsprdphxae.dbtoolsprod.oraclevcn.com"  # Insira seu service name
)

# Conectar ao banco de dados
conn = oracledb.connect(user="SEU_USUARIO", password="SUA_SENHA", dsn=dsn)

# Query para recuperar os dados
query = "SELECT * FROM item_loc_soh"

# Carregar os dados no Pandas
df = pd.read_sql(query, conn)

# Fechar conexão
conn.close()

# Exibir os 10 primeiros resultados
print(df.head())

# Salvar em CSV para visualizar depois
df.to_csv("dados_oracle_apex.csv", index=False)
print("Dados salvos em 'dados_oracle_apex.csv'")
