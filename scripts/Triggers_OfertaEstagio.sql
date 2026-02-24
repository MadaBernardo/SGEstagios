--Atualiza a coluna Vagas_Ocupadas na tabela Oferta_Estagio automaticamente
CREATE TRIGGER trg_GerirVagasOcupadas
ON Candidatura
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
	--se alguém ocupou uma vaga (SOMA +1)
    -- caso alguém:
    -- 1. Inserir um novo já como 'ACEITE' (inserted)
    -- 2. Mudar um antigo de 'PENDENTE' para 'ACEITE' (deleted)
    IF EXISTS (SELECT * FROM inserted WHERE Estado = 'ACEITE')
    BEGIN
        UPDATE Oferta_Estagio
        SET Vagas_Ocupadas = Oferta_Estagio.Vagas_Ocupadas + 1
        FROM Oferta_Estagio
        INNER JOIN inserted ON Oferta_Estagio.Id_Estagio = inserted.Id_Estagio
        --Só soma se for novo (deleted é nulo) OU se antes não era 'ACEITE'
        LEFT JOIN deleted ON inserted.Id_Candidatura = deleted.Id_Candidatura
        WHERE deleted.Id_Candidatura IS NULL OR deleted.Estado <> 'ACEITE';
    END
    -- Apagar uma candidatura que estava 'ACEITE, Mudar de 'ACEITE' para 'RECUSADO' ou 'PENDENTE'
    IF EXISTS (SELECT * FROM deleted WHERE Estado = 'ACEITE')
    BEGIN
        UPDATE Oferta_Estagio
        SET Vagas_Ocupadas = Oferta_Estagio.Vagas_Ocupadas - 1
        FROM Oferta_Estagio
        INNER JOIN deleted ON Oferta_Estagio.Id_Estagio = deleted.Id_Estagio
        -- Só subtrai se foi apagado (inserted é nulo) OU se o novo estado já não é 'ACEITE'
        LEFT JOIN inserted ON deleted.Id_Candidatura = inserted.Id_Candidatura
        WHERE inserted.Id_Candidatura IS NULL OR inserted.Estado <> 'ACEITE';
    END
END;
GO


--Este trigger garante que tabela Historico_candidatura é preenchida sozinha. 
--Sempre que mudas o estado na tabela Candidatura, ele copia os dados para o histórico.
CREATE TRIGGER trg_LogHistorico
ON Candidatura
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- Só executa se houver alteração real na coluna Estado
    IF UPDATE(Estado)
    BEGIN
        INSERT INTO Historico_Candidatura (
            Id_Candidatura, 
            Estado_Anterior, 
            Estado_Atual, 
            Data_Alteracao, 
            OBS
        )
        SELECT 
            inserted.Id_Candidatura,
            deleted.Estado,        -- Estado Antigo (tabela deleted)
            inserted.Estado,       -- Estado Novo (tabela inserted)
            SYSDATETIME(),
            'Alteração automática de estado'
        FROM inserted
        INNER JOIN deleted ON inserted.Id_Candidatura = deleted.Id_Candidatura;
    END
END;
GO


--Impede a entrada se a vaga estiver cheia, fechada ou fora do prazo.
CREATE TRIGGER trg_ValidarCandidatura
ON Candidatura
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- Verifica se existe algum problema com a oferta associada à candidatura
    IF EXISTS (
        SELECT * FROM inserted
        INNER JOIN Oferta_Estagio ON inserted.Id_Estagio = Oferta_Estagio.Id_Estagio
        WHERE 
            Oferta_Estagio.Estado = 'Fechada' -- Vaga Fechada
            OR 
            Oferta_Estagio.Data_Limite < CAST(GETDATE() AS DATE) -- Prazo já passou
            OR 
            Oferta_Estagio.Vagas_Ocupadas >= Oferta_Estagio.N_Vagas -- Vaga já está cheia
    )
    BEGIN
        -- Se encontrar problemas, cancela tudo
        RAISERROR('ERRO: Não é possível candidatar-se. A vaga está cheia, fechada ou o prazo expirou.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


--Se a empresa mudar o estado da Oferta para 'Fechada', 
--o trigger vai automaticamente às candidaturas dessa vaga e 
--muda tudo o que estava 'PENDENTE' para 'RECUSADO'.

CREATE TRIGGER trg_FecharCandidaturasPendentes
ON Oferta_Estagio
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    --se a vaga mudou para 'Fechada'
    IF UPDATE(Estado) 
       AND EXISTS (SELECT * FROM inserted WHERE Estado = 'Fechada')
    BEGIN
        -- Vai à tabela Candidatura e recusa todos os pendentes desta vaga
        UPDATE Candidatura
        SET Estado = 'RECUSADO',
            OBS = 'Candidatura cancelada automaticamente: A vaga foi fechada pela empresa.'
        FROM Candidatura
        INNER JOIN inserted ON Candidatura.Id_Estagio = inserted.Id_Estagio
        WHERE Candidatura.Estado = 'PENDENTE';
    END
END;
GO

