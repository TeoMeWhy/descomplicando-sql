-- Databricks notebook source
SELECT descCategoria,
       avg(vlPesoGramas) AS avgPeso
       
FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria like '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100
AND avgPeso > 1000

ORDER BY avgPeso DESC

