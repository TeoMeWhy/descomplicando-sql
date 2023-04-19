-- Databricks notebook source
SELECT date(date_trunc('month', dtPedido)) AS anoMes,
       count(idPedido) AS qtPedido

FROM silver.olist.pedido

GROUP BY anoMes
ORDER BY anoMes

-- COMMAND ----------

SELECT descCategoria,
       count(idProduto) AS qtProduto

FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY qtProduto DESC

LIMIT 10
