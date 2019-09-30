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
