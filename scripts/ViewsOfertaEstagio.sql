--csript para views

-- Esconde empresas que já não são parceiras (Ativo = 0)
CREATE VIEW vw_EmpresasAtivas AS
SELECT 
    Id,
    NIF,
    Nome,
    Telefone,
    Email,
    Morada,
    Codigo_Postal,
    Pais
FROM Empresa 
WHERE Estado_Empresa = 1;
GO


-- Esconde alunos que desistiram ou acabaram o curso (Ativo = 0)
CREATE VIEW vw_AlunosAtivos AS
SELECT 
    Numero, 
    Nome,
    Data_Nascimento,
    Nacionalidade,
    Telemovel,
    Email,
    Morada,
    Codigo_Postal,
    N_Curso
FROM Aluno 
WHERE Estado_Aluno = 1;
GO

