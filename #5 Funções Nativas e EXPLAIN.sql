-- CRIAÇÃO DA ESTRUTURA INCIAL DO MEU TREINO

CREATE DOMAIN timestamp_dm TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

CREATE PROCEDURE criar_base()
LANGUAGE plpgsql
AS $$
BEGIN
	CREATE TABLE rosquinhas (
		id SERIAL PRIMARY KEY,
		nome VARCHAR(30) NOT NULL,
		descricao VARCHAR(60) DEFAULT 'Sem Descrição',
		preco NUMERIC(10,2) NOT NULL,
		fabricacao DATE DEFAULT CURRENT_DATE,
		validade DATE NOT NULL
	);
	
	CREATE TABLE vendas (
		id SERIAL PRIMARY KEY,
		cliente VARCHAR (30) NOT NULL,
		genero CHAR(1) CHECK (genero IN ('M', 'F') OR genero IS null),
		id_produto INT, FOREIGN KEY (id_produto) REFERENCES rosquinhas(id),
		data_venda timestamp_dm
	);
	
	INSERT INTO rosquinhas (nome, descricao, preco, validade) VALUES
	('Chocolate Amargo', 'Rosquinha de trigo com cobertura de chocolate amargo', 5.50, '2026-09-28'),
	('Baunilha Clássica', 'Rosquinha de trigo com cobertura de baunilha', 4.50, '2026-09-29'),
	('Morango Especial', 'Rosquinha de trigo com cobertura de morango', 5.00, '2026-09-30'),
	('Doce de Leite', 'Rosquinha de trigo com recheio de doce de leite', 6.00, '2026-09-28'),
	('Coco Ralado', 'Rosquinha de trigo com cobertura de coco ralado', 5.00, '2026-09-29'),
	('Avelã com Cacau', 'Rosquinha de trigo com creme de avelã e cacau', 6.50, '2026-09-30'),
	('Limão Siciliano', 'Rosquinha de trigo com glacê de limão siciliano', 5.00, '2026-09-28'),
	('Canela e Açúcar', 'Rosquinha de trigo polvilhada com canela e açúcar', 4.00, '2026-09-29'),
	('Maracujá', 'Rosquinha de trigo com cobertura de maracujá', 5.50, '2026-09-30'),
	('Chocolate Branco', 'Rosquinha de trigo com cobertura de chocolate branco', 5.50, '2026-09-28');
	
	INSERT INTO vendas (cliente, genero, id_produto) VALUES
	('Azul Marinho', 'M', 1),
	('Amarelo Canário', 'F', 2),
	('Verde Menta', NULL, 3), -- Não binário (1)
	('Vermelho Carmim', 'M', 4),
	('Rosa Choque', 'F', 5),
	('Roxo Lavanda', 'F', 6),
	('Cinza Chumbo', 'M', 7),
	('Marrom Café', 'F', 8),
	('Laranja Cenoura', 'M', 9),
	('Preto Onix', 'F', 10),
	('Branco Gelo', 'M', 1),
	('Vinho Bordo', 'F', 2),
	('Azul Turquesa', 'M', 3),
	('Verde Olivas', 'M', 4),
	('Rosa Bebê', 'F', 5),
	('Amarelo Mostarda', 'M', 6),
	('Cinza Prata', 'F', 7),
	('Bege Palha', 'M', 8),
	('Vermelho Coral', 'F', 9),
	('Roxo Lilás', NULL, 10);
END;
$$;

CREATE PROCEDURE resetar()
LANGUAGE plpgsql
AS $$
BEGIN
	DROP TABLE IF EXISTS vendas CASCADE;
    DROP TABLE IF EXISTS rosquinhas CASCADE;
    DROP SEQUENCE IF EXISTS id_sequence CASCADE;
	DROP PROCEDURE IF EXISTS criar_base();
END;
$$;

-- FUNÇÕES NATIVAS: basicamente funções que já existem e eu posso só usar. Existem muitas então ao invés de tentar decorar todas vou só saber que elas existem e eu posso pesquisar especificamente pelo o que eu quero quando for necessário.

	SELECT
		version(),
		now(), localtimestamp, current_date, current_time,
		current_user, 
		current_database(); 

	SELECT age('2005/03/16'::date);

	SELECT CURRENT_DATE - '2005-03-16'::DATE AS dias_de_vida;

	SELECT to_char(now(), 'HH24:MI')

	SELECT
		upper('PostgreSQL'), lower('PostgreSQL'),
		char_length('PostgreSQL'), initcap('postgreSQL');

	-- |/ 25 é o operador pra raíz quadrada, aparentemente. Feião.

-- EXPLAIN: retorna uns dados que eu ainda não sei bem pra que usaria. Tipo, eu sei que se alguns deles vinherem muito alto o meu código tá gastando tempo demais mas pros meus estudos atuais ainda nãoé muito relevante.

	EXPLAIN SELECT * FROM rosquinhas;
	EXPLAIN SELECT id FROM rosquinhas WHERE (id IN('1', '2', '3')); 

		



