CREATE DATABASE Viagens;

CREATE TABLE usuarios (
id INT,
nome VARCHAR(255) NOT NULL COMMENT 'Nome do usuário',
email VARCHAR(100) NOT NULL UNIQUE,
endereco VARCHAR(50) NOT NULL,
data_nascimento DATE NOT NULL
);

CREATE TABLE destinos (
id INT ,
nome VARCHAR(255) NOT NULL UNIQUE COMMENT 'Nome do destino',
descricao VARCHAR(255) NOT NULL COMMENT 'Sescrição do destino'
);

CREATE TABLE viagens_reservas (
id INT COMMENT 'Identficado único da reserva',
id_usuario INT COMMENT 'Referencia ao ID do usuario que fez a reserva',
id_destino INT COMMENT 'Referencia ao ID do destino da reserva',
data DATE COMMENT 'Data da reserva',
status VARCHAR(255) DEFAULT 'pendente' COMMENT 'Status da reserva (confirmada,pendente,cancelada)'
);

#---------INSERÇÃO DE VALORES-----------------#

INSERT INTO usuarios(id, nome, email,data_nascimento, endereco)
values (1,"Murilo Furlaneto", "teste@gmail.com", "2003-05-28", "Rua Princesa Isabel, 1418 - Araraquara/SP");

INSERT INTO usuarios(id, nome, email,data_nascimento, endereco)
values (2,"Gabriel Silva", "gabriel@gmail.com", "2006-09-12", "Av Bento de Abreu, 1720 - Araraquara/SP");

INSERT INTO usuarios(id, nome, email,data_nascimento, endereco)
values (3,"Lucas Rodrigues", "lucas@gmail.com", "2010-02-21", "Rua Treze de Maio, 2012 - Araraquara/SP");

INSERT INTO usuarios(id, nome, email,data_nascimento, endereco)
values (3,"Andre Caipira", "caipira123@gmail.com", "2013-07-13", "Rua Doce Aegria, 1140 - Araraquara/SP");

INSERT INTO destinos (id,nome,descricao) VALUES (1, 'Praia da Rosa', 'Linda Praia');

INSERT INTO destinos (id,nome,descricao) VALUES (2,'Praia de Pitangueiras', 'Praia brava');

INSERT INTO viagens_reservas (id,id_usuario, id_destino, status,data) 
VALUES (1,1,1,'Pendente', "2023-11-11");

INSERT INTO viagens_reservas (id,id_usuario, id_destino, status,data) 
VALUES (2,3,3,'Confirmado', "2023-07-10");

#---------LEITURA DE VALORES-----------------#
SELECT * FROM usuarios;

SELECT * FROM destinos;

SELECT * FROM viagens_reservas;

SELECT * FROM `usuarios`
WHERE id = 1 or nome LIKE "%MURILO%";

SELECT * FROM usuarios
WHERE id = 2 or nome LIKE "%lUIS";

#------------CRUD UPDATE E DELETE---------------#
UPDATE usuarios
SET id = 4
WHERE email= "caipira123@gmail.com";

DELETE FROM destinos
WHERE nome = "Praia de Pitangueiras";

#------------CRUD ALTER E DROP---------------#
CREATE TABLE usuarios_nova (
id INT,
nome VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
data_nascimento DATE NOT NULL,
endereco VARCHAR(100) NOT NULL 
);

#------------MIGRAÇÃO DE DADOS----------------#
INSERT INTO usuarios_nova (id,nome,email,data_nascimento,endereco)
SELECT id,nome,email, data_nascimento, endereco 
FROM usuarios;

DROP TABLE usuarios;
#--------- ALTERA O NOME DA COLUNA----------#
ALTER TABLE usuarios_nova RENAME usuarios;

ALTER TABLE usuarios MODIFY COLUMN endereco VARCHAR(150); 

ALTER TABLE usuarios
MODIFY COLUMN id INT  AUTO_INCREMENT,
ADD PRIMARY KEY (id);

ALTER TABLE destinos
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

ALTER TABLE viagens_reservas
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);


#-----------ADICIONA CHAVE ESTRANGUEIRA NA TABELA DE RESERVAS -------------#
ALTER TABLE viagens_reservas
ADD CONSTRAINT fk_reservas_usuarios
FOREIGN KEY (id_usuario) REFERENCES usuarios(id);

ALTER TABLE destinos
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

ALTER TABLE viagens_reservas
ADD CONSTRAINT fk_reservas_destinos
FOREIGN KEY (id_destino) REFERENCES destinos(id);


ALTER TABLE viagens_reservas
ADD CONSTRAINT fk_reservas_destinos
FOREIGN KEY (id_destino) REFERENCES destinos(id);

INSERT INTO viagens_reservas(id_usuario,id_destino, data,status)
VALUES (1,1,"2023-11-11","pendente");

ALTER TABLE viagens_reservas DROP CONSTRAINT fk_reservas_usuarios;
ALTER TABLE viagens_reservas DROP CONSTRAINT fk_usuarios;

#-----METODO EM CASCATA, APAGA O PAI E CONSEQUENTEMENTE APAGA OS FILHOS--------#
ALTER TABLE viagens_reservas 
ADD CONSTRAINT fk_usuarios
FOREIGN KEY (id_usuario) REFERENCES usuarios (id)
ON DELETE CASCADE;

#-----NORMALIZAÇÃO D DADOS É UM PROCESSO NO QUAL SE ORGANIZA E ESTRUTURA UM BD RELACIONAL
#---- DE FORMA A ELIMINAR REDUNDANCIAS E ANOMALIAS--------#

#----ATOMICIDADE - VALOR INDIVISIVEL - NENHUM CAMPO DEVE CONTER MULTIPLOS VALORES OU LSITAS---#
# ----O CAMPO "ENDERECO" DEVE SER DIVIDIDO EM COLUNAS SEPARADAS ----------#

ALTER TABLE usuarios
ADD rua VARCHAR (100),
ADD numero VARCHAR(10),
ADD cidade VARCHAR(50),
ADD estado VARCHAR(50);

SELECT * FROM usuarios;

ALTER TABLE usuarios
DROP COLUMN  endereco;

#------ COMBINAR DADOS DE 2 OU MAIS TABELAS----------#

#---- INNER JOIN - RETORNA AS LINHAS QUE TEM CORRESPONDENCIA EM AMBAS AS TABELAS ENVOLVIDAS---#
SELECT * FROM tabela1
INNER JOIN tabela2 ON tabela1.coluna = tabela2.coluna;

SELECT * FROM  usuarios  us
INNER JOIN viagens_reservas rs ON us.id = rs.id_usuario
INNER JOIN destinos ds ON rs.id_destino = ds.id;

INSERT INTO usuarios(nome,email,data_nascimento, rua,numero,cidade,estado) VALUES
("sem reservas", "dio@teste.com", "1992-05-05", "rua","12","cidade","estado");

SELECT COUNT(*) as total_usuarios FROM usuarios us
INNER JOIN viagens_reservas rs ON us.id = rs.id_usuario;





