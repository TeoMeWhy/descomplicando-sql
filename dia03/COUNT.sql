-- Databricks notebook source
-- DBTITLE 1,Contagem de linhas da tabela
SELECT
    count(*),
    count(1)
FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,Contagem de um campo
SELECT count(descSituacao), -- linhas não nulas deste campo (descSituacao)
       count(distinct descSituacao) -- linhas disitnctas do campo descSituacao
FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,Contagem de uma tabela com chave primária
SELECT count(idPedido), -- linhas não nulas para idPedido
       count(distinct idPedido), -- linhas distinctas para idPedido
       count(*), -- linhas totais da tabela
       count(1) -- linhas totais da tabela
FROM silver.olist.pedido
