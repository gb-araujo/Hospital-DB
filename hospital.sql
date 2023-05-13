CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- CRIANDO TABELAS

CREATE TABLE IF NOT EXISTS `especialidade` (
    `id_especialidade` int PRIMARY KEY AUTO_INCREMENT,
    `nome` varchar(255)
);

CREATE TABLE IF NOT EXISTS `consulta` (
   `id_consulta` int PRIMARY KEY AUTO_INCREMENT,
   `especialidade_id` int,
   FOREIGN KEY (especialidade_id) REFERENCES `especialidade`(`id_especialidade`),
   `id_medico` varchar(255),
   `id_paciente` varchar(255),
   `valor` float,
   `data_consulta` timestamp,
   `hora_consulta` time
);

CREATE TABLE IF NOT EXISTS `medico` (
    `id_medico` int PRIMARY KEY AUTO_INCREMENT,
    `especialidade` int,
    FOREIGN KEY (especialidade) REFERENCES `especialidade`(`id_especialidade`),
    `nome` varchar(255),
    `CPF` varchar(255),
    `CRM` int,
    `telefone` varchar(255)
);

CREATE TABLE IF NOT EXISTS `receita` (
  `id_receita` int PRIMARY KEY AUTO_INCREMENT,
  `paciente` varchar(255),
  `medico` varchar(255),
  `consulta` varchar(255),
  `quantidade` varchar(255),
  `medicamento` varchar(255)
);

CREATE TABLE IF NOT EXISTS `paciente` (
  `id_paciente` int PRIMARY KEY AUTO_INCREMENT,
  `rg_paciente` varchar(11),
  `cpf_paciente` varchar(11),
  `nome` varchar(255),
  `email_paciente` varchar(255),
  `data_nascimento` varchar(255),
  `telefone` varchar(255),
  `endereco` varchar(255),
  `id_convenio` int
);

CREATE TABLE IF NOT EXISTS `convenio` (
  `id_convenio` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255),
  `CNPJ` int,
  `tempo_carencia` timestamp
);

CREATE TABLE IF NOT EXISTS `enfermeiro` (
  `id_enfermeiro` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(255),
  `CPF` int,
  `CRE` int
);

CREATE TABLE IF NOT EXISTS `internacao` (
  `id_internacao` int PRIMARY KEY AUTO_INCREMENT,
  `data_entrada` timestamp,
  `data_prev_alta` timestamp,
  `data_alta` timestamp,
  `procedimento` varchar(255),
  `enfermeiro_id` int,
  FOREIGN KEY (enfermeiro_id) REFERENCES `enfermeiro`(`id_enfermeiro`)
);

CREATE TABLE IF NOT EXISTS `tipo_quarto` (
  `id_tipoquarto` int PRIMARY KEY AUTO_INCREMENT,
  `descricao` varchar(255),
  `valor_diaria` float
);

CREATE TABLE IF NOT EXISTS `quarto` (
  `id_quarto` int PRIMARY KEY AUTO_INCREMENT,
  `numero` int,
  `id_tipoquarto` int,
  FOREIGN KEY (`id_tipoquarto`) REFERENCES `tipo_quarto` (`id_tipoquarto`)
);

  
CREATE TABLE IF NOT EXISTS `internacao_enfermeiro` (
  `id_internacao` int,
  `id_enfermeiro` int,
  PRIMARY KEY (`id_internacao`, `id_enfermeiro`),
  FOREIGN KEY (`id_internacao`) REFERENCES `internacao` (`id_internacao`),
  FOREIGN KEY (`id_enfermeiro`) REFERENCES `enfermeiro` (`id_enfermeiro`)
);

-- INSERINDO DADOS NAS TABELAS

INSERT INTO medico (nome) VALUES
  ('Rebeca'),
  ('Carlos'),
  ('João'),
  ('Maria'),
  ('Rodolfo'),
  ('Sofia'),
  ('Lucas'),
  ('Gabriel'),
  ('Mariana'),
  ('Julia');


INSERT INTO especialidade (nome) VALUES
('Pediatria'),
('Clínica Geral'),
('Gastrenterologia'),
('Dermatologia'),
('Ortopedia'),
('Neurologia'),
('Cardiologia');

INSERT INTO paciente (nome, data_nascimento, telefone, endereco) VALUES
('Ana', '2000-01-01', '11 1111-1111', 'Rua A, 123'),
('Bruno', '1995-05-20', '11 2222-2222', 'Rua B, 456'),
('Carla', '1980-12-31', '11 3333-3333', 'Rua C, 789'),
('Daniel', '1999-02-15', '11 4444-4444', 'Rua D, 1011'),
('Elisa', '1992-10-10', '11 5555-5555', 'Rua E, 1213'),
('Fernando', '1985-07-07', '11 6666-6666', 'Rua F, 1415'),
('Giovanna', '2005-11-30', '11 7777-7777', 'Rua G, 1617'),
('Hugo', '1998-04-25', '11 8888-8888', 'Rua H, 1819'),
('Isabela', '1990-09-09', '11 9999-9999', 'Rua I, 2021'),
('João', '2002-03-18', '11 1010-1010', 'Rua J, 2223'),
('Karine', '1996-08-12', '11 1212-1212', 'Rua K, 2425'),
('Lucas', '1997-06-23', '11 1313-1313', 'Rua L, 2627'),
('Marina', '1987-03-04', '11 1414-1414', 'Rua M, 2829'),
('Nathalia', '1994-12-15', '11 1515-1515', 'Rua N, 3031'),
('Otávio', '1983-09-26', '11 1616-1616', 'Rua O, 3233'),
('Paula', '2000-11-20', '11 1717-1717', 'Rua P, 3435');


INSERT INTO convenio (nome, cnpj) VALUES
('Unimed', '123456789'),
('Amil', '123456789'),
('SulAmérica', '123456789'),
('Bradesco Saúde', '123456789');

INSERT INTO consulta (data_consulta, hora_consulta, id_paciente, id_medico) VALUES
 ('2016-02-15', '09:30', 1, 1),
 ('2017-05-22', '15:45', 2, 2),
 ('2018-01-10', '11:15', 3, 3),
 ('2019-03-03', '14:30', 4, 4),
 ('2016-07-12', '10:00', 5, 5),
 ('2017-08-21', '11:45', 6, 6),
 ('2018-06-09', '16:15', 7, 7),
 ('2019-10-30', '08:30', 8, 8),
 ('2020-02-18', '09:30', 9, 9),
 ('2016-05-05', '11:00', 10, 1),
 ('2017-04-18', '12:30', 11, 2),
 ('2018-07-07', '15:00', 12, 3),
 ('2019-11-02', '09:00', 13, 4),
 ('2020-12-10', '14:30', 14, 5),
 ('2016-09-25', '08:15', 15, 6),
 ('2017-07-11', '10:45', 16, 7);
 
  INSERT INTO `tipo_quarto` (`descricao`, `valor_diaria`) VALUES
  ('Apartamento', 500.00),
  ('Quarto Duplo', 300.00),
  ('Enfermaria', 200.00);
  
 INSERT INTO `quarto` (`numero`, `id_tipoquarto`) VALUES
  (101, 1),
  (102, 1),
  (201, 2),
  (202, 2),
  (301, 3),
  (302, 3);
 
  INSERT INTO `enfermeiro` (`nome`, `CPF`, `CRE`) VALUES
  ('Enf. Ana', 123456789, 12345),
  ('Enf. Bruno', 234567890, 23456),
  ('Enf. Carla', 345678901, 34567),
  ('Enf. Daniel', 456789012, 45678),
  ('Enf. Elisa', 567890123, 56789),
  ('Enf. Fernando', 678901234, 67890),
  ('Enf. Giovanna', 789012345, 78901),
  ('Enf. Hugo', 890123456, 89012),
  ('Enf. Isabela', 901234567, 90123),
  ('Enf. João', 123456780, 12340);
 
 INSERT INTO internacao (data_entrada, data_prev_alta, data_alta, procedimento, enfermeiro_id) VALUES
('2022-01-01 10:00:00', '2022-01-03 10:00:00', NULL, 'Cirurgia de apendicite', 1),
('2022-01-02 10:00:00', '2022-01-06 10:00:00', NULL, 'Cirurgia de vesícula', 2),
('2022-01-03 10:00:00', '2022-01-07 10:00:00', NULL, 'Cirurgia de hérnia', 3),
('2022-01-04 10:00:00', '2022-01-09 10:00:00', NULL, 'Cirurgia de tireoide', 4),
('2022-01-05 10:00:00', '2022-01-08 10:00:00', NULL, 'Cirurgia de próstata', 5),
('2022-01-06 10:00:00', '2022-01-10 10:00:00', NULL, 'Cirurgia de joelho', 6),
('2022-01-07 10:00:00', '2022-01-11 10:00:00', NULL, 'Cirurgia de coluna', 7),
('2022-01-08 10:00:00', '2022-01-12 10:00:00', NULL, 'Cirurgia de coração', 8),
('2022-01-09 10:00:00', '2022-01-13 10:00:00', NULL, 'Cirurgia de pulmão', 9),
('2022-01-10 10:00:00', '2022-01-14 10:00:00', NULL, 'Cirurgia de rim', 10);
 
 -- ALGUNS AJUSTES, SETANDO FOREIGN KEY, ADICIONADO COLUNA E ATUALIZANDO PACIENTE.
 
ALTER TABLE paciente ADD FOREIGN KEY (id_convenio) REFERENCES convenio(id_convenio);
ALTER TABLE consulta ADD COLUMN id_convenio int;
ALTER TABLE consulta ADD FOREIGN KEY (id_convenio) REFERENCES convenio(id_convenio);
UPDATE paciente SET id_convenio = 1 WHERE nome = 'Ana';

-- SETANDO MAIS UMA COLUNA NA TABELA MÉDICO - PARTE 4
ALTER TABLE medico ADD COLUMN em_atividade VARCHAR(20);
UPDATE medico SET em_atividade = 'Inativo' WHERE id_medico = 1;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 2;
UPDATE medico SET em_atividade = 'Inativo' WHERE id_medico = 3;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 4;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 5;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 6;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 7;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 8;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 9;
UPDATE medico SET em_atividade = 'Em atividade' WHERE id_medico = 10;

ALTER TABLE medico ALTER COLUMN em_atividade SET DEFAULT 'Em atividade';


