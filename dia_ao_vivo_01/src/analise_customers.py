# %%
import pandas as pd
import sqlalchemy
import matplotlib.pyplot as plt
import dotenv
import os

# %%

dotenv.load_dotenv(".env")

# %%
user = os.getenv("MARIADB_USER")
password = os.getenv("MARIADB_PASSWORD")
host = os.getenv("MARIADB_HOST")
port = os.getenv("MARIADB_PORT")
database = os.getenv("MARIADB_DATABASE")

# %%
str_con = f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}"
engine = sqlalchemy.create_engine(str_con)

# %%

def read_query(path):
    with open(path, "r") as open_file:
        return open_file.read()

query = read_query("summary_customers.sql")

print(query)

# %%

df = pd.read_sql(query, engine)
df

# %%

df['qtTransacao'].hist()
plt.show()