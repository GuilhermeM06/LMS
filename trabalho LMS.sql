create TABLE Usuario
(ID tinyint identity(1,1),
Login varchar(10) not null,
Senha varchar(10) not null,
DtExpiracao DATE CONSTRAINT dfDataVenda DEFAULT ('1900-01-01'),
CONSTRAINT pkId primary key(ID),
constraint ukLogin unique(login));
 
 select * from Usuario