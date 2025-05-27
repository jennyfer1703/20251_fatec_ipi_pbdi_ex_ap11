-- 1.1 – Cria tabela de log e ajusta procedimentos para registrar data e nome
CREATE TABLE log_sistema (
    log_data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nome_procedimento VARCHAR(200)
);

INSERT INTO log_sistema (nome_procedimento)
VALUES ('sp_total_pedido_clientes');