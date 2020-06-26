create database Escola

use Escola

create table Curso(
	codCur int primary key,
	nomeCurso varchar(50),
	numero_vagas int,
	codDep int
)

create table Departamento(
	codDep int primary key,
	depto varchar(50),
	codPes int
)

create table bibiliografa(
	codLivro int,
	codDis int
)

create table Disciplina(
	codDis int primary key,
	nomeDisc varchar(50),
	codCurso int
)

create table livro(
	codLivro int primary key,
	titulo varchar(50)
)

create table Pessoa(
	codPessoa int primary key,
	nomePessoa varchar(50)
)

create table Escreve(
	codLivro int primary key,
	titulo varchar(50)
)
create table EssaAqui(
	codesse int primary key,
	titulo varchar(50)
)


insert into Pessoa values(1, 'Joao')
insert into Pessoa values(2, 'Jose')
insert into Pessoa values(3, 'Maria')
insert into Pessoa values(4, 'Rogerio')

insert into Pessoa(codPessoa, nomePessoa)
values (5, 'Ana');

insert into EssaAqui values(1, 'bla')
insert into Departamento values(21, 'TI', 1)
insert into Departamento values(31, 'MK', 2)
insert into Departamento values(41, 'Administrativo', 4)

insert into Departamento(codDep, depto, codPes)
values (51, 'Vendas', 5);



insert into Livro values(2, 'Metamorfose')
insert into Livro values(4, 'Pearcy Jackson ladrão de raios');
insert into Livro values(3, 'historia para quem tem pressa');
insert into Livro values(5, 'Cronicas de Narnia');

insert into Livro(codLivro)
values (20);


insert into Curso values(12, 'matematica', 30, 11);
insert into Curso values(14, 'portugues', 20, 31);
insert into Curso values(13, 'historia', 20, 51)
insert into Curso(codCur, numero_vagas)
values (5, 11, 30);

insert into Curso(codCur, nomeCurso)
values (11, 'informatica');

insert into Disciplina values(2, 'calculo', 12);
insert into Disciplina values(4, 'redacao', 14);
insert into Disciplina values(3, 'historia do brasil', 13);
insert into Disciplina values(5, 'Cronicas de Narnia', 11);

insert into Disciplina(codDis, nomeDisc)
values (1, 'pacote Office');




update Departamento depto set = "Marketing" where codDep = 31;

update Pessoa nomePessoa set = "Ana" where codPessoa = 1;
update Pessoa nomePessoa set = "Eva" where codPessoa = 2;
update Pessoa nomePessoa set = "Ivo" where codPessoa = 3;
update Pessoa nomePessoa set = "Oto" where codPessoa = 4;
update Pessoa nomePessoa set = "Manoel" where codPessoa = 5;



insert into Pessoa values(7, 'Joao'); 


alter table Pessoa
add fone varchar(20);


select * from Disciplina;

alter table Disciplina
add situacao char(2);

update Pessoa fone set = "111111111" where codPessoa = 1;
update Pessoa fone set = "222222222" where codPessoa = 2;
update Pessoa fone set = "333333333" where codPessoa = 3;
update Pessoa fone set = "444444444" where codPessoa = 4;
update Pessoa fone set = "555555555" where codPessoa = 5;


update Disciplina situacao set = 'A';

update Departamento depto set = 'EXATAS' where codDep = 51;

select nomePessoa from Pessoa;


update Disciplina situacao set = 'I' 
	where codDisc = 1 OR 
	where codDisc = 3 OR
	where codDisc = 5;


select * from Livro;

select * from Departamento where codPes = 3;
