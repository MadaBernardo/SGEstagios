
INSERT INTO Empresa (NIF, Nome, Telefone, Email, Morada, Codigo_Postal, Pais, Estado_Empresa) 
VALUES 
('501111111', 'TechSolutions Lda', '210123456', 'rh@techsolutions.pt', 'Av. da Liberdade, 100', '1250-144', 'Portugal', 1),
('502222222', 'Construções Norte S.A.', '220987654', 'geral@construnorte.pt', 'Rua de Santa Catarina, 50', '4000-001', 'Portugal', 1),
('503333333', 'Marketing 360', '253112233', 'jobs@mkt360.pt', 'Praça da República, 5', '4710-251', 'Portugal', 1),
('504444444', 'BioPharma Lab', '239445566', 'recrutamento@biopharma.pt', 'Parque Tecnológico, Lt 3', '3040-500', 'Portugal', 1),
('505555555', 'Antiga Papelaria', '211000000', 'info@antiga.pt', 'Rua Velha, 2', '1000-001', 'Portugal', 0);


INSERT INTO Aluno (Numero, Nome, Data_Nascimento, Nacionalidade, Telemovel, Email, Morada, Codigo_Postal, Estado_Aluno, N_Curso) 
VALUES 
(2024001, 'João Silva', '2002-05-15', 'Portuguesa', '912345678', 'a2024001@aluno.pt', 'Rua das Flores, 10', '4000-001', 1, 1),
(2024002, 'Beatriz Costa', '2003-08-20', 'Portuguesa', '923456789', 'a2024002@aluno.pt', 'Av. da Liberdade, 55', '1250-001', 1, 1),
(2024003, 'Carlos Mendes', '2001-12-10', 'Portuguesa', '934567890', 'a2024003@aluno.pt', 'Praceta do Sol, 3', '4700-111', 1, 1),
(2024004, 'Ana Oliveira', '2003-02-28', 'Portuguesa', '965432109', 'a2024004@aluno.pt', 'Rua do Comércio, 88', '3000-222', 1, 2),
(2024005, 'Lucas Pereira', '2002-11-05', 'Brasileira', '911223344', 'a2024005@aluno.pt', 'Bairro Alto, Tv 2', '1100-333', 1, 2),
(2024006, 'Mariana Santos', '2004-01-15', 'Portuguesa', '922334455', 'a2024006@aluno.pt', 'Estrada Nova, 12', '2400-444', 1, 3),
(2024007, 'Rui Ferreira', '2000-07-30', 'Portuguesa', '933445566', 'a2024007@aluno.pt', 'Largo da Sé, 1', '4900-555', 0, 3), -- Estado 0 (Ex: Desistiu/Inativo)
(2024008, 'Sofia Martins', '2003-09-12', 'Portuguesa', '966778899', 'a2024008@aluno.pt', 'Rua das Artes, 9', '5300-666', 1, 4),
(2024009, 'Tiago Rodrigues', '2002-04-25', 'Espanhola', '919887766', 'a2024009@aluno.pt', 'Av. Central, 100', '4710-777', 1, 4),
(2024010, 'Inês Gomes', '2003-06-18', 'Angolana', '925556677', 'a2024010@aluno.pt', 'Rua Verde, 4', '6000-888', 1, 1);


INSERT INTO Curso (Numero, Titulo, Grau) 
VALUES 
(1, 'Engenharia Informática', 'Licenciatura'),
(2, 'Gestão de Empresas', 'Licenciatura'),
(3, 'Marketing Digital', 'Mestrado'),
(4, 'Design Gráfico', 'CTeSP'),
(5, 'Ciência de Dados', 'Mestrado');

INSERT INTO Oferta_Estagio 
(Titulo, Descricao, Estado, N_Vagas, Vagas_Ocupadas, Data_Publicacao, Data_Limite, Id_Empresa) 
VALUES 
('Desenvolvedor Backend Java', 'Desenvolvimento de APIs REST e manutenção de base de dados. Requer conhecimentos de SQL.', 'Ativa', 2, 0, '2024-05-01 09:00:00', '2024-09-30', 1),
('Suporte Técnico Helpdesk', 'Apoio de primeira linha a clientes e configuração de hardware.', 'Ativa', 1, 0, '2024-05-15 10:30:00', '2024-08-31', 1),
('Acompanhamento de Obra Civil', 'Estágio em ambiente de obra, leitura de projetos e gestão de equipas.', 'Ativa', 1, 0, '2024-06-01 08:00:00', '2024-09-15', 2),
('Gestão de Redes Sociais', 'Criação de copy, agendamento de posts e análise de métricas.', 'Ativa', 3, 1, '2024-05-20 14:00:00', '2024-10-01', 3),
('Designer Gráfico Júnior', 'Apoio à criação de identidade visual. Estágio já finalizado.', 'Fechada', 1, 1, '2024-01-10 09:00:00', '2024-03-01', 3),
('Técnico de Laboratório', 'Análises químicas e controlo de qualidade de produtos farmacêuticos.', 'Ativa', 2, 1, '2024-05-05 11:00:00', '2024-12-31', 4),
('Assistente Administrativo', 'Organização de arquivo digital e faturação.', 'Ativa', 1, 0, '2024-06-10 09:30:00', '2024-08-30', 5),
('Estágio de Verão em Vendas', 'Atendimento ao público em época alta. Vaga preenchida.', 'Fechada', 2, 2, '2023-05-01 10:00:00', '2023-08-31', 5);


INSERT INTO Candidatura (Estado, Data_Submissao, OBS, Id_Estagio, N_Aluno) 
VALUES 
-- 1. João Silva candidata-se a Java (Fica PENDENTE)
('PENDENTE', '2024-05-02 09:00:00', 'Tenho muito interesse em Backend.', 1, 2024001),

-- 2. Tiago Costa candidata-se a Java também (Fica ACEITE - Ganhou a vaga)
('ACEITE', '2024-05-03 10:30:00', 'Disponibilidade imediata.', 1, 2024005);

INSERT INTO Historico_Candidatura (Estado_Atual, Estado_Anterior, Data_Alteracao, OBS, Id_Candidatura) 
VALUES 
-- PARA A CANDIDATURA 1 (João - PENDENTE)
('PENDENTE', NULL, '2024-05-02 09:00:00', 'Candidatura submetida pelo aluno.', 1),

-- PARA A CANDIDATURA 2 (Tiago - ACEITE)
('PENDENTE', NULL, '2024-05-03 10:30:00', 'Candidatura submetida.', 2),
('ACEITE', 'PENDENTE', '2024-05-10 15:00:00', 'Perfil ideal. Selecionado após entrevista.', 2)














