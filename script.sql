-- 1.4 – Procedimento com parâmetro INOUT

DO $$
DECLARE
    v_cod_cliente INT := 1;
BEGIN
    CALL sp_total_pedido_inout(v_cod_cliente);
    RAISE NOTICE 'O cliente fez % pedidos', v_cod_cliente;
END;
$$

CREATE OR REPLACE PROCEDURE sp_total_pedido_inout (
    INOUT p_cod_cliente INT
)
LANGUAGE plpgsql
AS 
$$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM tb_pedido
    WHERE cod_cliente = p_cod_cliente;
    p_cod_cliente := v_total;

    INSERT INTO log_sistema (nome_procedimento) VALUES ('sp_total_pedido_inout');
END;
$$
-----------------------------------------------------------------------------------------

-- 1.3 - Procedimento com parâmetro de saída (OUT)
-- ---------------------------------------------------------------------------------------
-- DO 
-- $$
-- DECLARE 
--   v_total_de_pedidos INT;
--   v_cod_cliente INT;
--   v_nome_cliente VARCHAR(200) :=  'Ana Silva';
-- BEGIN
--   CALL sp_total_pedido_clientes(v_cod_cliente, v_nome_cliente, v_total_de_pedidos);
--   RAISE NOTICE 'O cliente % tem % pedidos', v_nome_cliente , v_total_de_pedidos;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_total_pedido_clientes (
--   OUT p_cod_cliente INT, 
--   IN p_nome_cliente VARCHAR(200),
--   OUT p_total_de_pedidos INT
-- )
-- LANGUAGE plpgsql
-- AS
-- $$
-- BEGIN
--   SELECT 
--     cod_cliente
--     ,count(p.cod_pedido) as total_de_pedidos
--   FROM tb_pedido p 
--   INNER JOIN tb_cliente as c ON 1=1
--     AND p.cod_cliente = c.cod_cliente
--   WHERE c.nome = p_nome_cliente 
--   GROUP BY 1
--   INTO $1, $3;
-- END;
-- $$

-- 1.2 – Procedimento com parâmetro de entrada (IN)
---------------------------------------------------------------------------------------
-- DO 
-- $$
-- DECLARE 
--   v_total_de_pedidos INT;
--   v_cod_cliente INT := 1;
--   v_nome_cliente VARCHAR(200);
-- BEGIN
--   CALL sp_total_pedido_clientes(v_cod_cliente, v_nome_cliente, v_total_de_pedidos);
--   RAISE NOTICE 'O cliente % tem % pedidos', v_nome_cliente , v_total_de_pedidos;
-- END;
-- $$

-- CREATE OR REPLACE PROCEDURE sp_total_pedido_clientes (
--   IN p_cod_cliente INT, 
--   OUT p_nome_cliente VARCHAR(200),
--   OUT p_total_de_pedidos INT
-- )
-- LANGUAGE plpgsql
-- AS
-- $$
-- BEGIN
--   SELECT 
--     nome
--     ,count(p.cod_pedido) as total_de_pedidos
--   FROM tb_pedido p 
--   INNER JOIN tb_cliente as c ON 1=1
--     AND p.cod_cliente = c.cod_cliente
--   WHERE p.cod_cliente = p_cod_cliente
--   GROUP BY 1
--   INTO $2, $3;
-- END;
-- $$
---------------------------------------------------------------------------------------

-- 1.1 – Cria tabela de log e ajusta procedimentos para registrar data e nome
-- CREATE TABLE log_sistema (
--     log_data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     nome_procedimento VARCHAR(200)
-- );

-- INSERT INTO log_sistema (nome_procedimento)
-- VALUES ('sp_total_pedido_clientes');