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
CONSTRAINT pkId PRIMARY KEY(ID),
CONSTRAINT ukLogin UNIQUE(login));
GO

CREATE TABLE Coordenador
(ID TINYINT IDENTITY,
id_usuario TINYINT,
Nome VARCHAR(50) NOT NULL,
Email VARCHAR(50) NOT NULL, 
Celular TINYINT NOT NULL,
CONSTRAINT pkIdCoordenador PRIMARY KEY(ID),
CONSTRAINT ukEmail UNIQUE(Email),
CONSTRAINT ukCelular UNIQUE(Celular),
CONSTRAINT fkIdUsuario FOREIGN KEY(id_usuario)
REFERENCES Usuario(ID)); 
GO

CREATE TABLE Aluno
(ID TINYINT IDENTITY,
id_usuario TINYINT,
Nome VARCHAR(50)NOT NULL,
Email VARCHAR(50) NOT NULL, 
Celular TINYINT NOT NULL,
RA CHAR(7) NOT NULL,
Foto VARCHAR(100), 
CONSTRAINT pkIdAluno PRIMARY KEY(ID),
CONSTRAINT ukEmailAluno UNIQUE(Email),
CONSTRAINT ukCelularAluno UNIQUE(Celular),
CONSTRAINT fkIdUsuarioAluno FOREIGN KEY(id_usuario)
REFERENCES Usuario(ID)); 
GO

CREATE TABLE Professor (
ID TINYINT IDENTITY,
id_usuario TINYINT,
Email VARCHAR(50) NOT NULL,
Celular TINYINT NOT NULL,
Apelido VARCHAR(10),
CONSTRAINT pkIdProfessor PRIMARY KEY(ID),
CONSTRAINT ukEmailProfessor UNIQUE(Email),
CONSTRAINT ukCelularProfessor UNIQUE(Celular),
CONSTRAINT fkIdUsuarioProfessor FOREING KEY(id_usuario) REFERENCES Usuario(ID)
);
GO

CREATE TABLE Disciplina (
ID TINYINT IDENTITY,
Nome VARCHAR(50) NOT NULL,
DataDisciplina DATE CONSTRAINT dfDataDisciplina DEFAULT getdate(),
StatusDisciplina VARCHAR(7) NOT NULL CONSTRAINT dfStatusDisciplina DEFAULT 'Aberta',
PlanoDeEnsino VARCHAR(100),
CargaHoraria TINYINT NOT NULL,
Competencias VARCHAR(100),
Habilidades VARCHAR(100),
Ementa VARCHAR(100),
ConteudoProgramatico VARCHAR(100),
BibliografiaBasica VARCHAR(100),
BibliografiaComplementar VARCHAR(100),
PercentualPratico TINYINT,
PercentualTeorico TINYINT,
IdCoordenador TINYINT,
CONSTRAINT pkDisciplina PRIMARY KEY(ID), 
CONSTRAINT ukNomeDisciplina UNIQUE(Nome),
CONSTRAINT fkIdCoordenadorDisciplina FOREIGN KEY(IdCoordenador) REFERENCES Coordenador(id),
CONSTRAINT ckStatusDisciplina CHECK (StatusDisciplina = 'Aberta' OR StatusDisciplina = 'Fechada'),
CONSTRAINT ckCargaHoraria CHECK (CargaHoraria = 40 OR CargaHoraria = 80),
CONSTRAINT ckPercentualPratico CHECK (PercentualPratico BETWEEN 0 AND  100),
CONSTRAINT ckPercentualTeorico CHECK (PercentualTeorico BETWEEN 0 AND 100)
);
GO

CREATE TABLE Curso (
ID TINYINT IDENTITY,
Nome VARCHAR(50) NOT NULL,
CONSTRAINT ukNomeCurso UNIQUE(Nome),
CONSTRAINT pkIdCurso PRIMARY KEY(ID)
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
Semestre TYNIINT NOT NULL,
Turma CHAR(1) NOT NULL,
IdProfessor TINYINT,
Metodologia VARCHAR(100),
Recursos VARCHAR(100),
CriterioAvaliacao VARCHAR(100),
PlanoDeAulas VARCHAR(100)
CONSTRAINT pkIdDisciplinaOfertada PRIMARY KEY (ID),
CONSTRAINT fkIdCoordenador FOREIGN KEY (IdCoordenador) REFERENCES Coordenador(ID),
CONSTRAINT fkIdDisciplina FOREIGN KEY (idDisciplina) REFERENCES Disciplina (ID),
CONSTRAINT fkIdCurso FOREIGN KEY (IdCurso) REFERENCES Curso (ID),
CONSTRAINT idProfessor FOREIGN KEY (IdProfessor) REFERENCES Professor (ID),
CONSTRAINT ckAno CHECK (Ano BETWEEN 1900 AND 2100),
CONSTRAINT ckSemestre CHECK (Semestre = 1 OR Semestre = 2), 
CONSTRAINT cKTurma CHECK (Turma LIKE '[A-Z]'));
GO

CREATE TABLE SolicitacaoMatricula
(
ID						TINYINT IDENTITY, 
IdAluno					TINYINT,				 
IdDisciplinaOfertada	TINYINT,				 
DtSolicitacao			DATE		NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT (GETDATE()),
IdCoordenador			TINYINT NULL,				 			 
[Status]				VARCHAR(10)	NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT 'Solicitada',
CONSTRAINT pkID PRIMARY KEY (ID),
CONSTRAINT fkIdAluno FOREIGN KEY (idAluno) REFERENCES Aluno (ID),
CONSTRAINT fkIdDisciplinaOfertada FOREIGN KEY (IdDisciplinaOfertada) REFERENCES DisciplinaOfertada (ID),
CONSTRAINT fkIdCoordenador FOREIGN KEY (IdCoordenador) REFERENCES Coordenador (ID),
CONSTRAINT ckStatus CHECK ([Status] IN ('Solicitada', 'Aprovada','Rejeitada', 'Cancelada')

GO

--• IdCoordenador não é obrigatório de ser preenchido no momento da solicitação de matricula, porém,
--quando o coordenador aprová-la ( ie:alterar o status da mesma ), seu ID deve ser preenchido.
--Eventualmente o professor daquela disciplina pode alterar o status para Cancelada.


CREATE TABLE SolicitacaoMatricula
(
ID						TINYINT IDENTITY, 
IdAluno					TINYINT,				 
IdDisciplinaOfertada	TINYINT,				 
DtSolicitacao			DATE		NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT (GETDATE()),
IdCoordenador			TINYINT NULL,				 			 
[Status]				VARCHAR(10)	NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT 'Solicitada',
CONSTRAINT pkID PRIMARY KEY (ID),
CONSTRAINT fkIdAluno FOREIGN KEY (idAluno) REFERENCES Aluno (ID),
CONSTRAINT fkIdDisciplinaOfertada FOREIGN KEY (IdDisciplinaOfertada) REFERENCES DisciplinaOfertada (ID),
CONSTRAINT fkIdCoordenador FOREIGN KEY (IdCoordenador) REFERENCES Coordenador (ID),
CONSTRAINT ckStatus CHECK ([Status] IN ('Solicitada', 'Aprovada','Rejeitada', 'Cancelada')

GO

CREATE TABLE Atividade
(
ID TINYINT IDENTITY,
Titulo VARCHAR(15),
Descricao VARCHAR (100),
Conteudo VARCHAR (100),
Tipo VARCHAR(15),
Extras VARCHAR(100),
IdProfessor TINYINT, 
CONSTRAINT pkIdAtividade PRIMARY KEY (ID),
CONSTRAINT ukTituloAtividade UNIQUE (Titulo),
CONSTRAINT ckTipoAtividade CHECK (Tipo IN ('Resposta Aberta', 'Teste')),
CONSTRAINT fkIdProfessorAtividade FOREIGN KEY (IdProfessor) REFERENCES Professor(ID)
);
GO 

CREATE TABLE AtividadeVinculada
(ID TINYINT IDENTITY,
IdAtividade TINYINT,
IdProfessor	TINYINT,
IdDisciplinaOfertada TINYINT,
Rotulo VARCHAR(4) NOT NULL,
[Status] VARCHAR(15) NOT NULL,
DtInicioRespostas DATE NOT NULL,
DtFimRespostas DATE NOT NULL,
CONSTRAINT pkAtividadeVinculada PRIMARY KEY (ID),
CONSTRAINT fkIdAtividadeAtividadeVinculada FOREIGN KEY (IdAtividade) REFERENCES Atividade(ID),
CONSTRAINT fkIdProfessorAtividadeVinculada FOREIGN KEY (IdProfessor) REFERENCES Professor(ID),
CONSTRAINT fkIdDisciplinaOfertadaAtividadeVinculada FOREIGN KEY (IdDisciplinaOfertada) REFERENCES DisciplinaOfertada(ID),
CONSTRAINT ckRotulo CHECK (Rotulo IN ('AC1', 'AC2', 'AC3','AC4', 'AC5', 'AC6','AC7', 'AC8', 'AC9', 'AC10')),
CONSTRAINT ckStatus CHECK ([Status] IN ('Disponibilizada', 'Aberta', 'Fechada', 'Prorrogada', 'Encerrada')));
GO

CREATE TABLE Entrega
(
ID						TINYINT IDENTITY, 
IdAluno					TINYINT,				 
IdAtividadeVinculada	TINYINT,
Titulo					VARCHAR(MAX),
Resposta				VARCHAR(MAX),				 
DtEntrega				DATE		NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT (GETDATE()), 			 
[Status]				VARCHAR(9)	NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT 'Entregue',
IdProfessor				TINYINT,
Nota					INT,	
DtAvaliacao				DATE		NOT NULL CONSTRAINT dfDtSolicitacao DEFAULT (GETDATE()),
Obs						VARCHAR(MAX),	

CONSTRAINT pkIDEntrega PRIMARY KEY (ID),
CONSTRAINT fkIdAlunoEntrega FOREIGN KEY (idAluno) REFERENCES Aluno (ID),
CONSTRAINT fkIdAtividadeVinculadaEntrega FOREIGN KEY (IdAtividadeVinculada) REFERENCES Atividade (ID),
CONSTRAINT ckStatusEntrega CHECK ([Status] IN ('Entregue','Corrigido')
CONSTRAINT fkIdProfessorEntrega FOREIGN KEY (IdProfessor) REFERENCES Professor (ID),
CONSTRAINT ckNotaEntrega CHECK (Nota BETWEEN 0.00 AND 10.00);

GO

CREATE TABLE Mensagem(
ID TINYINT identity,
IdAluno TINYINT NOT NULL,
IdProfessor TINYINT NOT NULL,
Assunto VARCHAR(50) NOT NULL,
Referencia VARCHAR(50) NOT NULL,
Conteudo varchar(100) NOT NULL,
[Status] varchar(10) CONSTRAINT dfStatusMensagem DEFAULT ‘Enviado’ not null,
CONSTRAINT pkIdMensagem PRIMARY KEY (ID),
CONSTRAINT fkIdAlunoMensagem FOREING KEY(idAluno) REFERENCES Aluno(ID),
CONSTRAINT fkIdProfessorMensagem FOREING KEY(idProfessor) REFERENCES Professor(ID)
CONSTRAINT ckStatusMensagem CHECK ([Status] in ('Enviado', 'Lido','Respondido'))
DtEnvio DATE CONSTRAINT dfDtEnvioMensagem DEFAULT (getdate()) NOT NULL,
DtResposta DATE not null,
Resposta varchar(50) not null);

GO

--Ao realizar uma entrega, devo informar o aluno e qual atividade vinculada ( por referência indireta sei
--qual a atividade e a disciplina ofertada ).

--• Não preciso preencher os campos referentes à avaliação do professor, porém, quando este a
--realizar, devo preencher o IdProfessor, Nota, DtAvaliacao e [opcionalmente] o Obs;

--Além de alterar o status da Entrega para ‘Corrigido’.

--1 Mesmo aluno não pode responder a mesma
--atividade vinculada mais de uma vez.
