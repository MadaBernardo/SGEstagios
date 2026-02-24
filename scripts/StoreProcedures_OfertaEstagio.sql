--1.
CREATE PROCEDURE SP_ListarOfertasAtivas
AS
BEGIN
    SELECT
        O.Id_Estagio,
        O.Titulo,
        O.Descricao,
        O.Data_Publicacao,
        O.Data_Limite,
        O.N_Vagas,
        O.Vagas_Ocupadas,
        (O.N_Vagas - O.Vagas_Ocupadas) AS Vagas_Disponiveis,
        E.Nome AS Empresa
    FROM Oferta_Estagio O, Empresa E
    WHERE O.Id_Empresa = E.Id
      AND O.Estado = 'ATIVA'
      AND O.N_Vagas IS NOT NULL
      AND O.Vagas_Ocupadas IS NOT NULL
      AND O.Vagas_Ocupadas < O.N_Vagas
      AND (O.Data_Limite IS NULL OR O.Data_Limite >= CONVERT(date, GETDATE()))
    ORDER BY O.Data_Publicacao DESC
END

EXEC SP_ListarOfertasAtivas


--2. (depende da view vw_EmpresasAtivas)
CREATE PROCEDURE SP_CriarOfertaEstagio
    @Id_Empresa INT,
    @Titulo VARCHAR(50),
    @Descricao NVARCHAR(200) = NULL,
    @N_Vagas INT,
    @Data_Limite DATE = NULL
AS
BEGIN
    IF @Id_Empresa IS NULL
        PRINT 'Id_Empresa é obrigatório.'
    ELSE IF NOT EXISTS (SELECT * FROM vw_EmpresasAtivas WHERE Id = @Id_Empresa)
        PRINT 'Empresa inválida ou inativa.'
    ELSE IF @Titulo IS NULL
        PRINT 'Título é obrigatório.'
    ELSE IF @N_Vagas IS NULL OR @N_Vagas <= 0
        PRINT 'Número de vagas inválido.'
    ELSE
    BEGIN
        INSERT INTO Oferta_Estagio
            (Titulo, Descricao, Estado, N_Vagas, Vagas_Ocupadas, Data_Publicacao, Data_Limite, Id_Empresa)
        VALUES
            (@Titulo, @Descricao, 'ATIVA', @N_Vagas, 0, GETDATE(), @Data_Limite, @Id_Empresa)

        PRINT 'Oferta criada com sucesso.'
    END
END

EXEC SP_CriarOfertaEstagio 1, 'Multimedia', 'Teste defesa', 2, '2026-12-31'

EXEC SP_ListarOfertasAtivas

--3. Ranking
CREATE PROCEDURE SP_EstagiosComMaisProcura
AS
BEGIN
    SELECT
        O.Id_Estagio,
        O.Titulo,
        E.Nome AS Empresa,
        COUNT(C.Id_Candidatura) AS Total_Candidaturas
    FROM Oferta_Estagio O, Empresa E, Candidatura C
    WHERE O.Id_Empresa = E.Id
      AND C.Id_Estagio = O.Id_Estagio
    GROUP BY O.Id_Estagio, O.Titulo, E.Nome
    ORDER BY Total_Candidaturas DESC
END

EXEC SP_EstagiosComMaisProcura

SELECT *
FROM Candidatura

--4.
CREATE PROCEDURE SP_ListarCandidaturasPorEmpresa
    @Id_Empresa INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Empresa WHERE Id = @Id_Empresa)
        PRINT 'Empresa não existe.'
    ELSE
        SELECT
            C.Id_Candidatura,
            C.Data_Submissao,
            C.Estado,
            A.Numero AS N_Aluno,
            A.Nome AS Nome_Aluno,
            O.Id_Estagio,
            O.Titulo
        FROM Oferta_Estagio O, Candidatura C, Aluno A
        WHERE O.Id_Empresa = @Id_Empresa
          AND C.Id_Estagio = O.Id_Estagio
          AND A.Numero = C.N_Aluno
        ORDER BY C.Data_Submissao DESC
END

EXEC SP_ListarCandidaturasPorEmpresa 1

--5.
CREATE PROCEDURE SP_AtualizarEstadoCandidatura
    @Id_Candidatura INT,
    @NovoEstado NVARCHAR(10),
    @OBS NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EstadoAnterior NVARCHAR(10);
    -- Validações
    IF @NovoEstado NOT IN ('ACEITE', 'RECUSADO', 'PENDENTE')
    BEGIN
        RAISERROR('Erro: Estado inválido.', 16, 1);
        RETURN;
    END

    SELECT @EstadoAnterior = Estado 
    FROM Candidatura 
    WHERE Id_Candidatura = @Id_Candidatura;

    IF @EstadoAnterior IS NULL
    BEGIN
        RAISERROR('Erro: Candidatura não encontrada.', 16, 1);
        RETURN;
    END

    UPDATE Candidatura
    SET Estado = @NovoEstado,
        OBS = @OBS -- opcional
    WHERE Id_Candidatura = @Id_Candidatura;
END
GO


exec SP_AtualizarEstadoCandidatura 12, 'RECUSADO', 'TESTEADMIN'

SELECT * 
FROM Candidatura 
--WHERE Id_Candidatura = 1

SELECT * 
FROM Historico_Candidatura 
WHERE Id = 12

update Candidatura
set 

--6.
CREATE PROCEDURE SP_EstatisticasGerais
AS
BEGIN
    SELECT
        (SELECT COUNT(*) FROM Aluno) AS Total_Alunos,
        (SELECT COUNT(*) FROM Empresa) AS Total_Empresas,
        (SELECT COUNT(*) FROM Oferta_Estagio) AS Total_Ofertas,

        (SELECT COUNT(*) FROM Oferta_Estagio WHERE Estado = 'ATIVA') AS Ofertas_Ativas,
        (SELECT COUNT(*) FROM Oferta_Estagio WHERE Estado = 'FECHADA') AS Ofertas_Fechadas,

        (SELECT COUNT(*)
         FROM Oferta_Estagio
         WHERE Estado = 'ATIVA'
            AND N_Vagas IS NOT NULL
            AND Vagas_Ocupadas IS NOT NULL
            AND Vagas_Ocupadas < N_Vagas
            AND (Data_Limite IS NULL OR Data_Limite >= CONVERT(date, GETDATE()))
        ) AS Ofertas_Disponiveis,

        (SELECT COUNT(*) FROM Candidatura) AS Total_Candidaturas,
        (SELECT COUNT(*) FROM Candidatura WHERE Estado = 'PENDENTE') AS Candidaturas_Pendentes,
        (SELECT COUNT(*) FROM Candidatura WHERE Estado = 'ACEITE') AS Candidaturas_Aceites,
        (SELECT COUNT(*) FROM Candidatura WHERE Estado = 'RECUSADO') AS Candidaturas_Recusadas
END

EXEC SP_EstatisticasGerais

--7
CREATE PROCEDURE SP_ListarCandidaturasPorAluno
    @N_Aluno INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Aluno WHERE Numero = @N_Aluno)
        PRINT 'Aluno não existe.'
    ELSE
        SELECT
            C.Id_Candidatura,
            C.Data_Submissao,
            C.Estado,
            C.OBS,
            O.Id_Estagio,
            O.Titulo,
            E.Nome AS Empresa
        FROM Candidatura C, Oferta_Estagio O, Empresa E
        WHERE C.N_Aluno = @N_Aluno
            AND O.Id_Estagio = C.Id_Estagio
            AND E.Id = O.Id_Empresa
        ORDER BY C.Data_Submissao DESC
END

EXEC SP_ListarCandidaturasPorAluno 2024001
