-- Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.

SELECT * FROM consulta WHERE YEAR(data_consulta) = 2020 OR id_convenio = 1;
SELECT AVG(valor) FROM consulta WHERE YEAR(data) = 2020 OR convenio = 1;

-- Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

SELECT * FROM internacao WHERE data_alta > data_prev_alta;

-- Receituário completo da primeira consulta registrada com receituário associado.

SELECT * FROM receita WHERE consulta_id = (SELECT MIN(id_receita) FROM consulta);

-- Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).

SELECT * FROM consulta WHERE id_convenio = NULL ORDER BY valor DESC;
SELECT * FROM consulta WHERE id_convenio = NULL ORDER BY valor ASC;

-- Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.

SELECT i.id_internacao, i.data_entrada, i.data_prev_alta, i.data_alta, i.procedimento,
       q.numero AS numero_quarto, t.valor_diaria,
       DATEDIFF(i.data_alta, i.data_entrada) AS num_dias,
       DATEDIFF(i.data_alta, i.data_entrada) * t.valor_diaria AS total_internacao
FROM internacao i
JOIN quarto q ON i.id_internacao = q.id_quarto
JOIN tipo_quarto t ON q.id_tipoquarto = t.id_tipoquarto;

-- Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.

SELECT p.nome AS nome_paciente, c.data_consulta, e.nome AS especialidade
FROM consulta c
JOIN paciente p ON c.id_paciente = p.id_paciente
JOIN especialidade e ON c.especialidade_id = e.id_especialidade
WHERE TIMESTAMPDIFF(YEAR, STR_TO_DATE(p.data_nascimento, '%Y-%m-%d'), c.data_consulta) < 18
AND e.nome != 'Pediatria'
ORDER BY c.data_consulta;

-- Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.

SELECT p.nome AS NomePaciente, m.nome AS NomeMedico, i.data_internacao, i.procedimentos
FROM internacao i
JOIN medico m ON i.id_medico = m.id_medico
JOIN paciente p ON i.id_paciente = p.id_paciente
JOIN especialidade_medico em ON m.id_medico = em.id_medico
JOIN especialidade e ON em.id_especialidade = e.id_especialidade
WHERE e.nome_especialidade = 'gastroenterologia'
AND i.local_internacao = 'enfermaria'

-- Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.

SELECT m.nome AS NomeMedico, m.CRM, COUNT(c.id_consulta) AS QuantidadeConsultas
FROM medico m
LEFT JOIN consulta c ON m.id_medico = c.id_medico
GROUP BY m.id_medico

-- Todos os médicos que tenham "Gabriel" no nome. 

SELECT * FROM medico WHERE nome = "Gabriel";

-- Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.

SELECT e.nome AS NomeEnfermeiro, e.crm AS CRM, COUNT(i.id_internacao) AS NumeroInternacoes
FROM enfermeiro e
JOIN participacao p ON e.id_enfermeiro = p.id_enfermeiro
JOIN internacao i ON p.id_internacao = i.id_internacao
GROUP BY e.nome, e.crm
HAVING COUNT(i.id_internacao) > 1
