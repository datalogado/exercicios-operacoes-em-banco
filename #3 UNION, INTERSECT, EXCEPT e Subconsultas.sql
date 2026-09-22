-- Aqui eu criei a tabela que vou usar pras minhas consultas, não tem nada de novo.

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

-- UNION: unifica selects diferentes, mas chama cada um individualmente. Então, nesse caso, ele não chama todas as roupa P pretas, ele chama todas as pretas e depois todas as P. Pelo que pesquisei não é muito útil.

SELECT * FROM roupas WHERE cor = 'preto'
UNION
SELECT * FROM roupas WHERE tamanho = 'P';

-- INTERSECT: traz todas as linhas que estão em A e B, basicamente o que eu achei que UNION faria. Beeem mais útil.

SELECT * FROM roupas WHERE cor = 'preto'
INTERSECT
SELECT * FROM roupas WHERE tamanho = 'P';

-- EXCEPT: traz o que está no A mas não está em B. Nesse caso todas as roupas pretas que NÃO são p. 

SELECT * FROM roupas WHERE cor = 'preto'
EXCEPT
SELECT * FROM roupas WHERE tamanho = 'P';

-- Subconsulta Escalar: to fazendo uma consulta que vai retornar um único valor que será usado na minha consulta principal. Nesse caso eu tô pegando o preco mais caro na tabela de roupas e trazendo todas as peças que tenham esse preco.

SELECT * FROM roupas WHERE preco = (SELECT MAX(preco) FROM roupas);

-- Subconsulta Lista: busco uma lista de IDs de peças que aparecem em compras realizadas por homens e depois trago todos os dados das roupas que tem um ID que apareça nessa lista.

SELECT * FROM roupas WHERE id IN (SELECT id_peca FROM vendas WHERE genero = 'M');





