-- Databricks notebook source
SELECT descUF,
       count(distinct idVendedor)

FROM silver.olist.vendedor

GROUP BY descUF
ORDER BY 2 DESC

-- COMMAND ----------

SELECT descUF,
       count(distinct idVendedor)

FROM silver.olist.vendedor

GROUP BY descUF
ORDER BY count(distinct idVendedor) DESC

-- COMMAND ----------

SELECT descUF,
       count(distinct idVendedor) AS qtVendedor

FROM silver.olist.vendedor

GROUP BY descUF
ORDER BY qtVendedor DESC

-- COMMAND ----------

SELECT descCategoria ,
       
       count(idProduto) AS qtProduto,
       avg(vlPesoGramas) AS avgPeso,
       percentile(vlPesoGramas, 0.5) AS medianaPeso,
       
       avg(vlComprimentoCm * vlAlturaCm * vlLarguraCm) AS avgVolume,
       percentile(vlComprimentoCm * vlAlturaCm * vlLarguraCm, 0.5) AS medianaVolume
       
FROM silver.olist.produto

GROUP BY descCategoria

ORDER BY medianaPeso DESC

-- COMMAND ----------

SELECT year(dtPedido),
       count(idPedido)

FROM silver.olist.pedido

GROUP BY year(dtPedido)
ORDER BY year(dtPedido)

-- COMMAND ----------

SELECT year(dtPedido) || '-' || month(dtPedido) AS anoMes,
       count(idPedido)

FROM silver.olist.pedido

GROUP BY anoMes
ORDER BY anoMes

-- COMMAND ----------

SELECT date(date_trunc('month', dtPedido)) AS anoMes,
       count(idPedido)

FROM silver.olist.pedido

GROUP BY anoMes
ORDER BY anoMes
