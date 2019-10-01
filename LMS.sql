/*
Brando de Oliveira Veridiano, 1901003
Guilherme Alves dos Santos, 1900785
Guilherme Marques D'Albuquerque Silva, 1900823
Hadnan Basilio, 1901020
Victor Sanches Barbosa, 
*/

create TABLE Usuario
(ID tinyint identity(1,1),
Login varchar(10) not null,
Senha varchar(10) not null,
DtExpiracao DATE CONSTRAINT dfDataVenda DEFAULT ('1900-01-01'),
CONSTRAINT pkId primary key(ID),
constraint ukLogin unique(login));

create table Coordenador
(id tinyint identity,
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

create table Aluno
(ID tinyint identity,
id_usuario tinyint,
Nome varchar(50)NOT NULL,
Email varchar(50) NOT NULL, 
Celular tinyint NOT NULL,
RA char(7) NOT NULL,
Foto varchar(200), 
constraint pkIdAluno primary key(ID),
constraint ukEmailAluno unique(Email),
constraint ukCelularAluno unique(Celular),
constraint fkIdUsuarioAluno foreign key(id_usuario)
references Usuario(ID)); 

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

create table Disciplina (
ID tinyint identity,
Nome varchar(50) NOT NULL,
DataDisciplina date constraint dfDataDisciplina default getdate(),
StatusDisciplina varchar(7) NOT NULL constraint dfStatusDisciplina default 'Aberta',
PlanoDeEnsino varchar(200),
CargaHoraria tinyint NOT NULL,
Competencias varchar(200),
Habilidades varchar(200),
Ementa varchar(200),
ConteudoProgramatico varchar(200),
BibliografiaBasica varchar(200),
BibliografiaComplementar varchar(200),
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