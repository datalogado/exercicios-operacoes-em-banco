CREATE TABLE pocoes (
	id_pocao SERIAL PRIMARY KEY,
	nome_pocao VARCHAR(30) NOT NULL,
	descricao_pocao VARCHAR(60),
	preco NUMERIC(10,2) NOT NULL,
	nivel_seguranca SMALLINT NOT NULL
)

CREATE TABLE vendas (
	id_venda SERIAL PRIMARY KEY,
	nome_cliente VARCHAR(60) NOT NULL,
	data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	id_pocao INT, FOREIGN KEY (id_pocao) REFERENCES pocoes(id_pocao),
	valor_venda NUMERIC(10,2) NOT NULL
)

INSERT INTO pocoes (nome_pocao, descricao_pocao, preco, nivel_seguranca) VALUES
('Suco de Meleca de Ogro', 'Deixa a pele verde e brilhante por duas horas.', 15.50, 1),
('Chá de Cócegas Eternas', 'Provoca risadas incontroláveis e espasmos leves.', 22.00, 2),
('Poção do Soluço Explosivo', 'Cada soluço solta uma pequena bolha de sabão.', 12.99, 1),
('Xarope do Ronco Musical', 'Faz a pessoa roncar na melodia de uma ópera famosa.', 35.40, 2),
('Essência de Gambá Cheiroso', 'Tem cheiro de lavanda, mas atrai moscas gigantes.', 45.00, 3),
('Fluido Flamejante', 'Cuidado ao usar perto de cortinas inflamáveis.', 89.90, 4),
('Fórmula do Cabelo de Nuvem', 'O cabelo flutua e muda de cor conforme o humor.', 60.00, 3),
('Soro da Fofoca Sincera', 'Obriga a falar a verdade, mas apenas sobre vizinhos.', 120.50, 4),
('Orvalho do Pulo de Sapo', 'Permite saltar até 5 metros de altura por um minuto.', 55.00, 2),
('Lágrima de Unicórnio', 'Cura resfriados, mas faz o nariz brilhar no escuro.', 250.00, 3),
('Poção da Invisibilidade', 'Deixa o corpo invisível, mas as roupas continuam visíveis.', 99.99, 3),
('Elixir do Bafo de Dragão', 'Permite cuspir fogo real. Não use em ambientes fechados.', 450.00, 5),
('Gás do Chulé Paralisante', 'Deixa os inimigos tontos em um raio de 3 metros.', 180.00, 4),
('Destilado da Sorte Duvidosa', 'Você ganha uma moeda de ouro, mas perde uma meia.', 75.00, 2),
('Extrato de Caos Absoluto', 'Inverte a gravidade apenas para quem bebeu a poção.', 999.99, 5);

INSERT INTO vendas (nome_cliente, id_pocao, valor_venda) VALUES
('Verde Esmeralda', 3, 12.99),
('Amarelo Mostarda', 4, 35.40),
('Roxo Ametista', 5, 45.00),
('Laranja Queimado', 6, 89.90),
('Azul Turquesa', 8, 120.50),
('Verde Oliva', 9, 55.00),
('Branco Pérola', 10, 250.00),
('Vermelho Rubi', 12, 450.00),
('Cinza Chumbo', 13, 180.00),
('Marrom Café', 14, 75.00),
('Azul Índigo', 15, 999.99);

-- ANY: traz os valores que são verdadeiros em pelo menos uma das comparações. Tipo, traz os precos que são maiores que pelo menos uma das linhas. Não sei bem a utilidade....

SELECT * FROM vendas WHERE valor_venda > ANY(SELECT valor_venda FROM vendas);

-- ALL: traz os valores que são verdadeiros em TODAS as comparações, muito mais útil.

SELECT * FROM vendas WHERE valor_venda >= ALL(SELECT valor_venda FROM vendas);

-- EXISTS: eu ainda não saquei muito bem a diferença dele com IN, mas eu sei que ele é mais indicado pra tableas grandes e que IN aceita valores fixos tipo IN(1, 2, 3).

SELECT id_pocao, nome_pocao, preco FROM pocoes p WHERE EXISTS(
	SELECT 1
	FROM vendas v
	WHERE p.id_pocao = v.id_pocao
)
