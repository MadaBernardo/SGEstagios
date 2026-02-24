--Logins 
CREATE LOGIN Login_Admin WITH PASSWORD = 'SenhaAdmin123!'; -- Admin
CREATE LOGIN Login_Empresa WITH PASSWORD = 'SenhaEmpresa123!';-- Empresas  
CREATE LOGIN Login_Aluno WITH PASSWORD = 'SenhaAluno123!';--Alunos

--Users
CREATE USER User_Admin FOR LOGIN Login_Admin;
CREATE USER User_Empresa FOR LOGIN Login_Empresa;
CREATE USER User_Aluno FOR LOGIN Login_Aluno;

--Roles 
CREATE ROLE Role_Administrador;
CREATE ROLE Role_Recrutador; -- Para as Empresas
CREATE ROLE Role_Candidato;  -- Para os Alunos

-- PERMISSÕES DO ADMINISTRADOR
ALTER ROLE db_owner ADD MEMBER User_Admin; --Admin (leitura, escrita, apagar)

--PERMISSÕES DA EMPRESA (Role_Recrutador)
-- Pode ver (SELECT) ofertas, candidaturas e alunos
GRANT SELECT ON Empresa TO Role_Recrutador;
GRANT SELECT ON Curso TO Role_Recrutador;
GRANT SELECT ON Historico_Candidatura TO Role_Recrutador;
GRANT SELECT ON Oferta_Estagio TO Role_Recrutador;
GRANT SELECT ON Candidatura TO Role_Recrutador;
GRANT SELECT ON Aluno TO Role_Recrutador; -- Para ver quem se candidatou
--Pode criar (INSERT) novas ofertas
GRANT UPDATE, INSERT ON Oferta_Estagio TO Role_Recrutador;
--Pode alterar (UPDATE) apenas o estado das candidaturas (Aceitar/Recusar)
GRANT UPDATE (Estado) ON Candidatura TO Role_Recrutador;
DENY UPDATE, DELETE, INSERT ON Aluno TO Role_Recrutador;
DENY UPDATE, DELETE, INSERT ON Historico_Candidatura TO Role_Recrutador;
DENY UPDATE, DELETE, INSERT ON Curso TO Role_Recrutador;
DENY UPDATE, DELETE, INSERT ON Empresa TO Role_Recrutador;
DENY DELETE, INSERT ON Candidatura TO Role_Recrutador;

--PERMISSÕES DO ALUNO (Role_Candidato)
-- Pode ver (SELECT) ofertas, empresas e os seus próprios dados
GRANT SELECT ON Oferta_Estagio TO Role_Candidato;
GRANT SELECT ON Empresa TO Role_Candidato;
GRANT SELECT ON Curso TO Role_Candidato;
GRANT SELECT ON Aluno TO Role_Candidato;
GRANT SELECT ON Candidatura TO Role_Candidato;
GRANT INSERT ON Candidatura TO Role_Candidato;
GRANT SELECT ON Historico_Candidatura TO Role_Candidato;
DENY UPDATE, DELETE, INSERT ON Oferta_Estagio TO Role_Candidato;
DENY UPDATE, DELETE, INSERT ON Empresa TO Role_Candidato;
DENY UPDATE, DELETE ON Candidatura TO Role_Candidato;
DENY UPDATE, DELETE, INSERT ON Aluno TO Role_Candidato;
DENY UPDATE, DELETE, INSERT ON Curso TO Role_Candidato;
DENY UPDATE, DELETE, INSERT ON Historico_Candidatura TO Role_Candidato;

-- Adicionar o User_Empresa à Role_Recrutador e User_Aluno à Role_Estudante
ALTER ROLE Role_Recrutador ADD MEMBER User_Empresa;
ALTER ROLE Role_Candidato ADD MEMBER User_Aluno;