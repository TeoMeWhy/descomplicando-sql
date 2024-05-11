-- Databricks notebook source
-- DBTITLE 1,Contagem de vendedores
SELECT count(idVendedor),
       count(distinct idVendedor)

FROM silver.olist.vendedor

WHERE descUF = 'RJ'

-- COMMAND ----------

-- DBTITLE 1,Contagem de Clientes
SELECT count(distinct idCliente), -- clientes não únicos
       count(distinct idClienteUnico), -- cliente únicos
       count(distinct descCidade) -- cidades distintas

FROM silver.olist.cliente
WHERE descUF = 'AC'

-- COMMAND ----------

-- DBTITLE 1,Estatísticas de produtos
SELECT count(*),
       avg(vlPesoGramas),
       percentile(vlPesoGramas, 0.5),
       std(vlPesoGramas),
       min(vlPesoGramas),
       max(vlPesoGramas),
       max(vlPesoGramas) - min(vlPesoGramas)

FROM silver.olist.produto

WHERE descCategoria = 'perfumaria'
