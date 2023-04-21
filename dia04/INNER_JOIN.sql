-- Databricks notebook source
SELECT t1.idPedido,
       t1.idCliente,
       t4.descUF AS descUFCliente,
       t3.idVendedor,
       t3.descUF AS descUFVendedor

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

LEFT JOIN silver.olist.cliente AS t4
ON t1.idCliente = t4.idCliente
