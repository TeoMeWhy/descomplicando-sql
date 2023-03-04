-- Databricks notebook source
SELECT DISTINCT descUF
FROM silver.olist.vendedor
ORDER BY descUF

-- COMMAND ----------

SELECT DISTINCT descCidade, descUF
FROM silver.olist.vendedor
ORDER BY descUF, descCidade

-- COMMAND ----------

SELECT DISTINCT *
FROM silver.olist.vendedor

-- COMMAND ----------

SELECT DISTINCT descCategoria
FROM silver.olist.produto
WHERE descCategoria is not null
ORDER BY descCategoria
