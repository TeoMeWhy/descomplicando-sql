-- Databricks notebook source
-- DBTITLE 1,Categoria de produtos vendidos
SELECT t1.*,
       t2.descCategoria
        
FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

-- COMMAND ----------

-- DBTITLE 1,Vendedor e item pedidos
SELECT t1.*,
       t2.descUF

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

-- COMMAND ----------

SELECT t1.*,
       t2.descUF AS descUFvendedor,
       t3.descCategoria,
       t3.vlPesoGramas

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

LEFT JOIN silver.olist.produto AS t3
ON t1.idProduto = t3.idProduto
