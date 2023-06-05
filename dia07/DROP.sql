-- Databricks notebook source
DROP TABLE IF EXISTS sandbox.linuxtips.top5_pedido;

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top5_pedido AS
  SELECT *
  FROM silver.olist.pedido
  ORDER BY RAND()
  LIMIT 5
;

-- COMMAND ----------

select * from sandbox.linuxtips.top5_pedido

-- e481f51cbdc54678b7cc49136f2d6af7
-- 62faf07dbae1258c108166ee7b2ba6c8
-- 12905797f6a5f67c41d036a0ea9a40be
