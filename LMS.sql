/*
Brando de Oliveira Veridiano, 1901003
Guilherme Alves dos Santos, 1900785
Guilherme Marques D'Albuquerque Silva, 1900823
Hadnan Basilio, 1901020
Victor Sanches Barbosa, 1900982
*/

CREATE TABLE Usuario
(ID TINYINT IDENTITY(1,1),
Login VARCHAR(10) NOT NULL,
Senha VARCHAR(10) NOT NULL,
DtExpiracao DATE CONSTRAINT dfDataVenda DEFAULT ('1900-01-01'),
CONSTRAINT pkIDUsuario PRIMARY KEY(ID),
CONSTRAINT ukLoginUsuario UNIQUE(login));
GO

CREATE TABLE Coordenador
(ID TINYINT IDENTITY,
id_usuario TINYINT,
Nome VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL, 
Celular CHAR(11) NOT NULL,
CONSTRAINT pkIDCoordenador PRIMARY KEY(ID),
CONSTRAINT ukEmailCoordenador UNIQUE(Email),
CONSTRAINT ukCelularCoordenador UNIQUE(Celular),
CONSTRAINT fkid_usuarioCoordenador FOREIGN KEY(id_usuario)
REFERENCES Usuario(ID)); 
GO

CREATE TABLE Aluno
(ID TINYINT IDENTITY,
id_usuario TINYINT,
Nome VARCHAR(50)NOT NULL,
Email VARCHAR(50) NOT NULL, 
Celular CHAR(11) NOT NULL,
RA CHAR(7) NOT NULL,
Foto VARCHAR(100), 
CONSTRAINT pkIDAluno PRIMARY KEY(ID),
CONSTRAINT ukEmailAluno UNIQUE(Email),
CONSTRAINT ukCelularAluno UNIQUE(Celular),
CONSTRAINT fkid_usuarioAluno FOREIGN KEY(id_usuario)
REFERENCES Usuario(ID)); 
GO

CREATE TABLE Professor (
ID TINYINT IDENTITY,
id_usuario TINYINT,
Email VARCHAR(50) NOT NULL,
Celular CHAR(11) NOT NULL,
Apelido VARCHAR(10) NOT NULL,
CONSTRAINT pkIDProfessor PRIMARY KEY(ID),
CONSTRAINT ukEmailProfessor UNIQUE(Email),
CONSTRAINT ukCelularProfessor UNIQUE(Celular),
CONSTRAINT fkid_usuarioProfessor FOREIGN KEY(id_usuario) REFERENCES Usuario(ID)
);
GO

CREATE TABLE Disciplina (
ID TINYINT IDENTITY,
Nome VARCHAR(50) NOT NULL,
DataDisciplina DATE CONSTRAINT dfDataDisciplina DEFAULT (GETDATE()) NOT NULL,
StatusDisciplina VARCHAR(7) NOT NULL CONSTRAINT dfStatusDisciplina DEFAULT ('Aberta'),
PlanoDeEnsino VARCHAR(100) NOT NULL,
CargaHoraria TINYINT NOT NULL,
Competencias VARCHAR(100) NOT NULL,
Habilidades VARCHAR(100) NOT NULL,
Ementa VARCHAR(100) NOT NULL,
ConteudoProgramatico VARCHAR(100) NOT NULL,
BibliografiaBasica VARCHAR(100) NOT NULL,
BibliografiaComplementar VARCHAR(100) NOT NULL,
PercentualPratico TINYINT NOT NULL,
PercentualTeorico TINYINT NOT NULL,
IdCoordenador TINYINT NOT NULL,
CONSTRAINT pkIDDisciplina PRIMARY KEY(ID), 
CONSTRAINT ukNomeDisciplina UNIQUE(Nome),
CONSTRAINT fkIdCoordenadorDisciplina FOREIGN KEY(IdCoordenador) REFERENCES Coordenador(ID),
CONSTRAINT ckStatusDisciplinaDisciplina CHECK (StatusDisciplina IN ('Aberta','Fechada')),
CONSTRAINT ckCargaHorariaDisciplina CHECK (CargaHoraria = 40 OR CargaHoraria = 80),
CONSTRAINT ckPercentualPraticoDisciplina CHECK (PercentualPratico BETWEEN 0 AND 100),
CONSTRAINT ckPercentualTeoricoDisciplina CHECK (PercentualTeorico BETWEEN 0 AND 100)
);
GO

CREATE TABLE Curso (
ID TINYINT IDENTITY,
Nome VARCHAR(50) NOT NULL,
CONSTRAINT ukNomeCurso UNIQUE(Nome),
CONSTRAINT pkIDCurso PRIMARY KEY(ID)
);
GO 

CREATE TABLE DisciplinaOfertada
(ID TINYINT IDENTITY,
IdCoordenador TINYINT NOT NULL,
DtInicioMatricula DATE, 
DtFimMatricula DATE,
IdDisciplina TINYINT NOT NULL,
IdCurso TINYINT NOT NULL,
Ano SMALLINT NOT NULl, 
Semestre TINYINT NOT NULL,
Turma CHAR(1) NOT NULL,
IdProfessor TINYINT,
Metodologia VARCHAR(100),
Recursos VARCHAR(100),
CriterioAvaliacao VARCHAR(100),
PlanoDeAulas VARCHAR(100)
CONSTRAINT pkIDDisciplinaOfertada PRIMARY KEY (ID),
CONSTRAINT fkIdCoordenadorDisciplinaOfertada FOREIGN KEY (IdCoordenador) REFERENCES Coordenador(ID),
CONSTRAINT fkIdDisciplinaDisciplinaOfertada FOREIGN KEY (idDisciplina) REFERENCES Disciplina (ID),
CONSTRAINT fkIdCursoDisciplinaOfertada FOREIGN KEY (IdCurso) REFERENCES Curso (ID),
CONSTRAINT fkidProfessorDisciplinaOfertada FOREIGN KEY (IdProfessor) REFERENCES Professor (ID),
CONSTRAINT ckAnoDisciplinaOfertada CHECK (Ano BETWEEN 1900 AND 2100),
CONSTRAINT ckSemestreDisciplinaOfertada CHECK (Semestre = 1 OR Semestre = 2), 
CONSTRAINT cKTurmaDisciplinaOfertada CHECK (Turma LIKE '[A-Z]'));
GO

CREATE TABLE SolicitacaoMatricula
(
ID						TINYINT IDENTITY, 
IdAluno					TINYINT NOT NULL,				 
IdDisciplinaOfertada	TINYINT NOT NULL,				 
DtSolicitacao			DATE	NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT (GETDATE()),
IdCoordenador			TINYINT,				 			 
[Status]				VARCHAR(10)	CONSTRAINT dfDtStatus DEFAULT 'Solicitada',
CONSTRAINT pkIDSolicitacaoMatricula PRIMARY KEY (ID),
CONSTRAINT fkIdAlunoSolicitacaoMatricula FOREIGN KEY (IdAluno) REFERENCES Aluno (ID),
CONSTRAINT fkIdDisciplinaOfertadaSolicitacaoMatricula FOREIGN KEY (IdDisciplinaOfertada) REFERENCES DisciplinaOfertada (ID),
CONSTRAINT fkIdCoordenadorSolicitacaoMatricula FOREIGN KEY (IdCoordenador) REFERENCES Coordenador (ID),
CONSTRAINT ckStatusSolicitacaoMatricula CHECK ([Status] IN ('Solicitada', 'Aprovada','Rejeitada', 'Cancelada'))
);

GO

CREATE TABLE Atividade
(
ID TINYINT IDENTITY,
Titulo VARCHAR(15) NOT NULL,
Descricao VARCHAR (100),
Conteudo VARCHAR (100) NOT NULL,
Tipo VARCHAR(15) NOT NULL,
Extras VARCHAR(100),
IdProfessor TINYINT NOT NULL,
CONSTRAINT pkIDAtividade PRIMARY KEY (ID),
CONSTRAINT ukTituloAtividade UNIQUE (Titulo),
CONSTRAINT ckTipoAtividade CHECK (Tipo IN ('Resposta Aberta', 'Teste')),
CONSTRAINT fkIdProfessorAtividade FOREIGN KEY (IdProfessor) REFERENCES Professor(ID)
);
GO 

CREATE TABLE AtividadeVinculada
(ID TINYINT IDENTITY,
IdAtividade TINYINT NOT NULL,
IdProfessor	TINYINT NOT NULL,
IdDisciplinaOfertada TINYINT NOT NULL,
Rotulo VARCHAR(4) NOT NULL,
[Status] VARCHAR(15) NOT NULL,
DtInicioRespostas DATE NOT NULL,
DtFimRespostas DATE NOT NULL,
CONSTRAINT pkIDAtividadeVinculada PRIMARY KEY (ID),
CONSTRAINT fkIdAtividadeAtividadeVinculada FOREIGN KEY (IdAtividade) REFERENCES Atividade(ID),
CONSTRAINT fkIdProfessorAtividadeVinculada FOREIGN KEY (IdProfessor) REFERENCES Professor(ID),
CONSTRAINT fkIdDisciplinaOfertadaAtividadeVinculada FOREIGN KEY (IdDisciplinaOfertada) REFERENCES DisciplinaOfertada(ID),
CONSTRAINT ckRotulo CHECK (Rotulo IN ('AC1', 'AC2', 'AC3','AC4', 'AC5', 'AC6','AC7', 'AC8', 'AC9', 'AC10')),
CONSTRAINT ckStatus CHECK ([Status] IN ('Disponibilizada', 'Aberta', 'Fechada', 'Prorrogada', 'Encerrada')));
GO

CREATE TABLE Entrega
(
ID											TINYINT								IDENTITY, 
IdAluno										TINYINT								NOT NULL,				 
IdAtividadeVinculada						TINYINT								NOT NULL,
Titulo										VARCHAR(100),
Resposta									VARCHAR(100),								 
DtEntrega									DATE								NOT NULL CONSTRAINT dfDtSolicitacaoEntrega DEFAULT (GETDATE()), 			 
[Status]									VARCHAR(9)							NOT NULL CONSTRAINT dfDtStatusEntrega DEFAULT 'Entregue',
IdProfessor									TINYINT,
Nota										DECIMAL,	
DtAvaliacao									DATE								CONSTRAINT dfDtAvaliacaoEntrega DEFAULT (GETDATE()),
Obs											VARCHAR(100),	
CONSTRAINT pkIDEntrega						PRIMARY KEY (ID),
CONSTRAINT fkIdAlunoEntrega					FOREIGN KEY (idAluno)				REFERENCES Aluno (ID),
CONSTRAINT fkIdAtividadeVinculadaEntrega	FOREIGN KEY (IdAtividadeVinculada)  REFERENCES Atividade (ID),
CONSTRAINT ckStatusEntrega					CHECK								([Status] IN ('Entregue','Corrigido')),
CONSTRAINT fkIdProfessorEntrega				FOREIGN KEY (IdProfessor)			REFERENCES Professor (ID),
CONSTRAINT ckNotaEntrega					CHECK								(Nota BETWEEN 0.00 AND 10.00));

GO

CREATE TABLE Mensagem(
ID TINYINT identity,
IdAluno TINYINT NOT NULL,
IdProfessor TINYINT NOT NULL,
Assunto VARCHAR(50) NOT NULL,
Referencia VARCHAR(50) NOT NULL,
Conteudo varchar(100) NOT NULL,
[Status] varchar(10) CONSTRAINT dfStatusMensagem DEFAULT 'Enviado' not null,
DtEnvio DATE CONSTRAINT dfDtEnvioMensagem DEFAULT (getdate()) NOT NULL,
DtResposta DATE,
Resposta varchar(50),
CONSTRAINT pkIDMensagem PRIMARY KEY (ID),
CONSTRAINT fkIdAlunoMensagem FOREiGN KEY(idAluno) REFERENCES Aluno(ID),
CONSTRAINT fkIdProfessorMensagem FOREIGN KEY(idProfessor) REFERENCES Professor(ID),
CONSTRAINT ckStatusMensagem CHECK ([Status] in ('Enviado', 'Lido','Respondido')));
GO
