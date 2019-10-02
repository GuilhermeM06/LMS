/*
Brando de Oliveira Veridiano, 1901003
Guilherme Alves dos Santos, 1900785
Guilherme Marques D'Albuquerque Silva, 1900823
Hadnan Basilio, 1901020
Victor Sanches Barbosa, 1900982
*/

CREATE TABLE Usuario
(ID TINYINT IDENTITY(1,1),
Login varchar(10) not null,
Senha varchar(10) not null,
DtExpiracao DATE CONSTRAINT dfDataVenda DEFAULT ('1900-01-01'),
CONSTRAINT pkId primary key(ID),
constraint ukLogin unique(login));
GO

create table Coordenador
(ID tinyint identity,
id_usuario tinyint,
Nome varchar(50)NOT NULL,
Email varchar(50) NOT NULL, 
Celular tinyint NOT NULL,
constraint pkIdCoordenador primary key(id),
constraint ukEmail unique(Email),
constraint ukCelular unique(Celular),
constraint fkIdUsuario foreign key(id_usuario)
references Usuario(ID)); 
 select * from Coordenador
GO


create table Aluno
(ID tinyint identity,
id_usuario tinyint,
Nome varchar(50)NOT NULL,
Email varchar(50) NOT NULL, 
Celular tinyint NOT NULL,
RA char(7) NOT NULL,
Foto varchar(100), 
constraint pkIdAluno primary key(ID),
constraint ukEmailAluno unique(Email),
constraint ukCelularAluno unique(Celular),
constraint fkIdUsuarioAluno foreign key(id_usuario)
references Usuario(ID)); 
GO

create table Professor (
ID tinyint identity,
id_usuario tinyint,
Email varchar(50) NOT NULL,
Celular tinyint NOT NULL,
Apelido varchar(10),
constraint pkIdProfessor primary key (ID),
constraint ukEmailProfessor unique (Email),
constraint ukCelularProfessor unique (Celular),
constraint fkIdUsuarioProfessor foreign key (id_usuario) references Usuario(ID)
);
GO

create table Disciplina (
ID tinyint identity,
Nome varchar(50) NOT NULL,
DataDisciplina date constraint dfDataDisciplina default getdate(),
StatusDisciplina varchar(7) NOT NULL constraint dfStatusDisciplina default 'Aberta',
PlanoDeEnsino varchar(100),
CargaHoraria tinyint NOT NULL,
Competencias varchar(200),
Habilidades varchar(200),
Ementa varchar(100),
ConteudoProgramatico varchar(100),
BibliografiaBasica varchar(100),
BibliografiaComplementar varchar(100),
PercentualPratico tinyint,
PercentualTeorico tinyint,
IdCoordenador tinyint,
constraint pkDisciplina primary key (ID), 
constraint ukNomeDisciplina unique (Nome),
constraint fkIdCoordenadorDisciplina foreign key (IdCoordenador) references Coordenador(id),
constraint ckStatusDisciplina check (StatusDisciplina = 'Aberta' or StatusDisciplina = 'Fechada'),
constraint ckCargaHoraria check (CargaHoraria = 40 or CargaHoraria = 80),
constraint ckPercentualPratico check (PercentualPratico >= 0 and PercentualPratico <= 100),
constraint ckPercentualTeorico check (PercentualTeorico >= 0 and PercentualTeorico <= 100)
);
GO

create table Curso(
ID tinyint identity,
Nome varchar(50) NOT NULL,
constraint ukNomeCurso unique (Nome),
CONSTRAINT pkIdCurso PRIMARY KEY (ID)
);
GO 

create table DisciplinaOfertada
(ID tinyint identity,
IdCoordenador tinyint NOT NULL,
DtInicioMatricula date, 
DtFimMatricula date,
IdDisciplina tinyint NOT NULL,
IdCurso tinyint NOT NULL,
Ano SMALLINT NOT NULl, 
Semestre tinyint NOT NULL,
Turma char(1) NOT NULL,
IdProfessor tinyint,
Metodologia varchar (100),
Recursos varchar(100),
CriterioAvaliacao varchar (100),
PlanoDeAulas varchar (100)
CONSTRAINT pkIdDisciplinaOfertada PRIMARY KEY (ID),
CONSTRAINT fkIdCoordenador FOREIGN KEY (IdCoordenador) REFERENCES Coordenador(ID),
CONSTRAINT fkIdDisciplina FOREIGN KEY (idDisciplina) REFERENCES Disciplina (ID),
CONSTRAINT fkIdCurso FOREIGN KEY (IdCurso) REFERENCES Curso (ID),
CONSTRAINT idProfessor FOREIGN KEY (IdProfessor) REFERENCES Professor (ID),
CONSTRAINT ckAno CHECK (Ano Between 1900 and 2100),
CONSTRAINT ckSemestre CHECK (Semestre = 1 or Semestre = 2), 
CONSTRAINT cKTurma CHECK (Turma like '[A-Z]'));
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
CONSTRAINT ckRotulo CHECK (Rotulo in ('AC1', 'AC2', 'AC3','AC4', 'AC5', 'AC6','AC7', 'AC8', 'AC9', 'AC10')),
CONSTRAINT ckStatus CHECK ([Status] in ('Disponibilizada', 'Aberta', 'Fechada', 'Prorrogada', 'Encerrada')));
GO