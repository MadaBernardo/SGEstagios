--  Tabela CURSO
CREATE TABLE Curso (
    Numero INT PRIMARY KEY, 
	Titulo NVARCHAR(50),
    Grau NVARCHAR(20)
);
GO

-- Tabela EMPRESA 
CREATE TABLE Empresa (
    Id INT PRIMARY KEY IDENTITY(1,1), 
    NIF NVARCHAR(20) NOT NULL, 
    Nome NVARCHAR(50) NOT NULL,
    Telefone NVARCHAR(20),
    Email NVARCHAR(50),
    Morada NVARCHAR(50),
    Codigo_Postal NVARCHAR(10),
    Pais NVARCHAR(20),
	Estado_Empresa BIT DEFAULT 1, --para Soft Delete (1=Ativa, 0=Inativa/Histórico)
    
    CONSTRAINT UK_Empresa_NIF UNIQUE(NIF) 
);
GO

-- Tabela ALUNO 
CREATE TABLE Aluno (
    Numero INT PRIMARY KEY, 
    Nome NVARCHAR(50) NOT NULL,
    Data_Nascimento DATE,
    Nacionalidade NVARCHAR(50),
    Telemovel NVARCHAR(20),
    Email NVARCHAR(50),
    Morada NVARCHAR(50),
    Codigo_Postal NVARCHAR(10),
	Estado_Aluno BIT DEFAULT 1, -- para Soft Delete (1=ativo, 0=Desistiu/Acabou)
    N_Curso INT,
    CONSTRAINT FK_Aluno_Curso FOREIGN KEY (N_Curso) 
	REFERENCES Curso(Numero) ON DELETE SET NULL

);
GO

-- Tabela OFERTA_ESTÁGIO
CREATE TABLE Oferta_Estagio (
    Id_Estagio INT PRIMARY KEY IDENTITY(1,1),
    Titulo NVARCHAR(50) NOT NULL, 
    Descricao NVARCHAR(200),
    Estado NVARCHAR(10) CHECK (Estado IN ('Ativa', 'Fechada')) DEFAULT 'Ativa',
    N_Vagas INT DEFAULT 1,
    Vagas_Ocupadas INT DEFAULT 0,
    Data_Publicacao DATETIME DEFAULT SYSDATETIME(),
    Data_Limite DATE,
    Id_Empresa INT,
    CONSTRAINT FK_Oferta_Empresa FOREIGN KEY (Id_Empresa) 
	REFERENCES Empresa(Id) ON DELETE CASCADE,

	-- Data Limite não pode ser antes da publicação
    CONSTRAINT CK_Datas_Validas CHECK (Data_Limite >= CAST(Data_Publicacao AS DATE))
);
GO

ALTER TABLE Oferta_Estagio
ADD CONSTRAINT CK_LimiteVagas CHECK (Vagas_Ocupadas <= N_Vagas);

--Tabela CANDIDATURA 
CREATE TABLE Candidatura (
    Id_Candidatura INT PRIMARY KEY IDENTITY(1,1),
    Estado NVARCHAR(10) CHECK (Estado IN ('PENDENTE', 'RECUSADO', 'ACEITE')) DEFAULT 'PENDENTE',
    Data_Submissao DATETIME DEFAULT SYSDATETIME(),
    OBS NVARCHAR(200),
    Id_Estagio INT NOT NULL,
    N_Aluno INT NOT NULL,
    
    -- Um aluno só pode ter uma candidatura por estágio 
    CONSTRAINT UK_Candidatura_Aluno_Estagio UNIQUE(Id_Estagio, N_Aluno),
    
    CONSTRAINT FK_Candidatura_Estagio FOREIGN KEY (Id_Estagio) REFERENCES Oferta_Estagio(Id_Estagio) ON DELETE CASCADE, -- Se apaga oferta, apaga candidatura

    CONSTRAINT FK_Candidatura_Aluno FOREIGN KEY (N_Aluno) REFERENCES Aluno(Numero) ON DELETE CASCADE -- se o aluno deixa de existir, as candidaturas dele também
);
GO

-- Tabela HISTÓRICO_CANDIDATURA 
CREATE TABLE Historico_Candidatura (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Estado_Atual NVARCHAR(10),
    Estado_Anterior NVARCHAR(10),
    Data_Alteracao DATETIME DEFAULT SYSDATETIME(),
    OBS NVARCHAR(200),
    Id_Candidatura INT NOT NULL,

    CONSTRAINT FK_Historico_Candidatura FOREIGN KEY (Id_Candidatura) REFERENCES Candidatura(Id_Candidatura)
);
GO
