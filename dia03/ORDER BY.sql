-- Databricks notebook source
-- DBTITLE 1,ORDER BY
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco

-- COMMAND ----------

-- DBTITLE 1,ORDER BY + LIMIT
SELECT *
FROM silver.olist.item_pedido
ORDER BY vlPreco DESC, vlFrete DESC
LIMIT 3

-- COMMAND ----------

-- DBTITLE 1,ORDER BY + WHERE
SELECT *
FROM silver.olist.produto
WHERE descCategoria = 'perfumaria'
ORDER BY nrTamanhoNome DESC
LIMIT 5

-- COMMAND ----------

-- DBTITLE 1,ORCER BY + Cálculos
SELECT *,
       vlComprimentoCm * vlAlturaCm * vlLarguraCm as volumeCm

FROM silver.olist.produto
WHERE descCategoria = 'perfumaria'
ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC
LIMIT 5
