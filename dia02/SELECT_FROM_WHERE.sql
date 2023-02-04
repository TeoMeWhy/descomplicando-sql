-- Databricks notebook source
-- DBTITLE 1,Filtro para produtos mais caros ou iguais a R$500,00
SELECT *

FROM silver.olist.item_pedido

WHERE vlPreco >= 500

-- COMMAND ----------

-- DBTITLE 1,Comparando valor frete e valor produto
SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,Preco maior que 100 e frete maior que preço
SELECT *

FROM silver.olist.item_pedido

WHERE vlPreco >= 100
AND vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,Filtrando produtos de pet_shop, telefonia e bebes
SELECT *

FROM silver.olist.produto

WHERE descCategoria = 'pet_shop'
OR descCategoria = 'telefonia'
OR descCategoria = 'bebes'

-- COMMAND ----------

-- DBTITLE 1,Filtrando produtos de pet_shop, telefonia e bebes
SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('pet_shop', 'telefonia', 'bebes')

-- COMMAND ----------

-- DBTITLE 1,Pedido de jan/2017
SELECT *

FROM silver.olist.pedido

WHERE date(dtPedido) >= '2017-01-01'
AND date(dtPedido) <= '2017-01-31'

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) = 1

-- COMMAND ----------

-- DBTITLE 1,Mês 01 e 06 de 2017
SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND (month(dtPedido) = 1
OR month(dtPedido) = 6)

-- COMMAND ----------

-- DBTITLE 1,Operações matemáticas e suas ordens
SELECT 10 * (2 + 100)

-- COMMAND ----------

-- DBTITLE 1,Mês 01 e 06 de 2017 com IN
SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) IN (1, 6)
