-- Tabelas que criei só pra servirem de fonte de consulta pros meus estudos.

CREATE TABLE roupas (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL,
    cor VARCHAR(30) NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    tamanho VARCHAR(5) NOT NULL
);

CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    genero CHAR(1) CHECK (genero IN ('M', 'F') OR genero IS NULL),
    data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_peca INTEGER NOT NULL,
    FOREIGN KEY (id_peca) REFERENCES roupas(id)
);

INSERT INTO roupas (tipo, cor, preco, tamanho) VALUES
('calça', 'preto', 99.90, 'P'),
('calça', 'azul', 109.90, 'M'),
('calça', 'cinza', 119.90, 'G'),
('calça', 'bege', 114.90, 'GG'),
('luva', 'preto', 29.90, 'P'),
('luva', 'cinza', 34.90, 'M'),
('luva', 'azul', 32.90, 'G'),
('luva', 'vermelho', 36.90, 'GG'),
('casaco', 'preto', 139.90, 'P'),
('casaco', 'cinza', 149.90, 'M'),
('casaco', 'verde', 159.90, 'G'),
('casaco', 'azul', 164.90, 'GG'),
('shorts', 'preto', 59.90, 'P'),
('shorts', 'branco', 64.90, 'M'),
('shorts', 'azul', 69.90, 'G'),
('shorts', 'cinza', 74.90, 'GG'),
('vestido', 'vermelho', 119.90, 'P'),
('vestido', 'preto', 129.90, 'M'),
('vestido', 'azul', 124.90, 'G'),
('vestido', 'verde', 134.90, 'GG'),
('camiseta', 'branco', 39.90, 'P'),
('camiseta', 'preto', 44.90, 'M'),
('camiseta', 'amarelo', 49.90, 'G'),
('camiseta', 'verde', 54.90, 'GG'),
('moletom', 'cinza', 109.90, 'P'),
('moletom', 'preto', 119.90, 'M'),
('moletom', 'azul', 124.90, 'G'),
('moletom', 'vermelho', 129.90, 'GG'),
('colete', 'bege', 89.90, 'M'),
('colete', 'preto', 94.90, 'G'),
('blusa', 'preto', 49.90, 'P'),
('blusa', 'branco', 54.90, 'M'),
('blusa', 'azul', 59.90, 'G'),
('blusa', 'cinza', 64.90, 'GG'),
('regata', 'preto', 39.90, 'P'),
('regata', 'vermelho', 44.90, 'M'),
('regata', 'verde', 42.90, 'G'),
('regata', 'branco', 47.90, 'GG'),
('saia', 'preto', 79.90, 'P'),
('saia', 'azul', 84.90, 'M'),
('saia', 'bege', 89.90, 'G'),
('saia', 'cinza', 94.90, 'GG');

INSERT INTO vendas (nome, genero, id_peca) VALUES
('Azul Marinho', 'M', 1),
('Vermelho Coral', 'F', 2),
('Verde Oliva', 'M', 3),
('Cinza Chumbo', 'F', 4),
('Preto Fosco', 'M', 5),
('Branco Gelo', 'F', 6),
('Azul Celeste', 'M', 7),
('Rosa Claro', 'F', 8),
('Amarelo Dourado', NULL, 9),
('Verde Musgo', 'M', 10),
('Bege Areia', 'F', 11),
('Vermelho Escuro', 'M', 12),
('Cinza Prata', 'F', 13),
('Azul Petróleo', 'M', 14),
('Marrom Terra', 'F', 15),
('Roxo Lavanda', 'M', 16),
('Laranja Queimado', 'F', 17),
('Verde Esmeralda', NULL, 18),
('Rosa Antigo', 'M', 19),
('Azul Índigo', 'F', 20);

-- INDEX: Pelo que eu estudei, ele torna a consulta mais rapida pq organiza os dados em uma ordem. Mas não vi diferença de desempenho nessa tabela miúda, depois pesquiso melhor se é isso mesmo.

CREATE INDEX vendasNome ON vendas(nome)
DROP INDEX vendasNome;
SELECT * FROM vendas ORDER BY(nome)

-- DOMAIN: cria um nome que unifica um tipo de dado com outras coisas que não sei nomear. Tipo, pro type timestamp eu sempre tenho que ficar criando o valor padrão current_timestamp, mas criando um domínio eu só unifico tudo no tipo "dm_timestamp". Além de economizar tempo, acho que me permite alterar em cadeia.

CREATE DOMAIN dm_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE vendas ALTER data_compra TYPE dm_timestamp;

CREATE TABLE teste(
	mensagem VARCHAR(30),
	data_teste dm_timestamp
)

INSERT INTO teste (mensagem) VALUES ('teste do DOMAIN');
SELECT * FROM teste;

-- VIEW: sabe aquelas informações que frequentemente são chamadas com os dados de uma tabela mas segundo as normas da normalização tem que ficar em outras? Pra eu não ter que fazer JOIN toda vez que eu for puxar os dados eu posso criar uma VIEW que vai funcionar como uma fusão entre as tabelas. Assim posso acessar ela normalmente, como se fosse uma tabela pura, mantendo as tabelas reais normalizadas. Muuuito útil!!!

CREATE VIEW receita AS
	SELECT vendas.*, roupas.preco, roupas.tamanho 
	FROM vendas
	JOIN roupas
	ON roupas.id = vendas.id_peca; 

SELECT * FROM receita;

-- SEQUENCE: É basicamente o que eu vinha fazendo com o SERIAL mas feito por mim hehe. Agora consigo alterar os valores de incremento, início, etc.

CREATE SEQUENCE id_seq 
	AS INT
	INCREMENT 2
	START 10;

ALTER TABLE teste ADD COLUMN id_teste INT DEFAULT NEXTVAL('id_seq') PRIMARY KEY;

INSERT INTO teste (mensagem) VALUES ('Teste de criação de sequência');

SELECT * FROM teste;

CREATE DOMAIN id_dm INT DEFAULT NEXTVAL('id_seq');

ALTER TABLE teste ALTER id_teste TYPE id_dm;

-- PROCEDURE: basicamente a forma de criar função em SQL, bem feijão com arroz.

CREATE PROCEDURE inserir_roupa (
	p_tipo VARCHAR,
	p_cor VARCHAR,
	p_preco NUMERIC,
	p_tamanho VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO roupas (tipo, cor, preco, tamanho) 
	VALUES (p_tipo, p_cor, p_preco, p_tamanho);
	RAISE NOTICE 'produto % adicionado com sucesso!!', p_tipo;
END;
$$;

CALL inserir_roupa('Luva Longa', 'Prateada', '270.50', 'G');
CALL inserir_roupa('Luva Longa', 'Prateada', '270.50', 'M');
CALL inserir_roupa('Luva Longa', 'Prateada', '270.50', 'P');

SELECT *  FROM roupas;

-- TRIGGER: 

CREATE TABLE precos_hitorico (
	id id_dm,
	preco_antigo NUMERIC(10,2),
	preco_novo NUMERIC(10,2),
	data_alteracao dm_timestamp
)

CREATE TRIGGER add_preco_historico
AFTER UPDATE ON roupas


