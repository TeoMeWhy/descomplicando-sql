-- Databricks notebook source
-- DBTITLE 1,Consultando Tabelas
SELECT *
FROM silver.olist.pedido
LIMIT 10

-- COMMAND ----------

-- DBTITLE 1,Todas colunas + 1
SELECT *,
       vlPreco + vlFrete AS vlTotal

FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Algumas colunas
SELECT idPedido,
       idProduto,
       vlPreco,
       vlFrete,
       vlPreco + vlFrete AS vlTotal

FROM silver.olist.item_pedido
