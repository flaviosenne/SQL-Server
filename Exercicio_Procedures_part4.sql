create database ExercSP03
go
use ExercSP03

create table Disciplina(
	codDisciplina int constraint pk_codDisci primary key identity(1,1),
	disciplina varchar (30) not null
)

create table Curso(
	codCurso int constraint pk_codCurso primary key identity(1,1),
	curso varchar (30) not null
)

create table Aluno(
	codAluno int constraint pk_codAluno primary key,
	nome varchar (30) not null,
	codCurso int 
constraint fk_Aluno_Curso foreign key references Curso(codCurso)
)


create table Nota(
	codNota int constraint pk_codNota primary key identity(1,1),
	nota numeric not null,
	codAluno int 
constraint fk_Nota_Aluno foreign key references Aluno(codAluno),
	codDisciplina int 
constraint fk_Nota_Disciplina foreign key references 
Disciplina(codDisciplina)
)

insert into Disciplina
values('Matemática'),
('Português'),
('Quimica')

insert into Curso
values('Exatas'),
('Humanas'),
('Linguagem')

--a
alter procedure inserir_aluno
	@nome varchar(100),
	@codCurso int
as

begin
	
	insert into Aluno(codAluno, nome, codCurso)
	values((select top 1 codAluno from Aluno
	order by codAluno desc)+1, @nome, @codCurso)

	select * from Aluno
end

select * from Curso

exec inserir_aluno 'jose', 1

 --b
create procedure inserir_dados
	@tabela varchar(40),
	@disciplina varchar(50) = null,
	@curso varchar(50) = null,
	@nota decimal = 0,
	@codAluno int = null,
	@codDisciplina int = null
as

begin

	if(@tabela ='nota')
	insert into Nota
	values(@nota, @codAluno, @codDisciplina)

else if (@tabela = 'disciplina')
	insert into Disciplina
	values(@disciplina)
	

	else if(@tabela ='curso')
	insert into Curso
	values(@curso)

end

--c
exec inserir_dados @tabela = 'nota',@nota = 10, @codAluno=1, @codDisciplina = 2

exec inserir_dados @tabela = 'nota',@nota = 7.34,@codAluno=1, @codDisciplina = 3

exec inserir_dados @tabela = 'nota',@nota = 9.8, @codAluno=1, @codDisciplina = 1

exec inserir_dados @tabela = 'nota',@nota = 8.5, @codAluno=1, @codDisciplina = 2

exec inserir_dados @tabela = 'curso', @curso = 'Português para iniciantes'
exec inserir_dados @tabela = 'curso', @curso = 'Quimica para iniciantes'
exec inserir_dados @tabela = 'curso', @curso = 'Matemática para iniciantes'
exec inserir_dados @tabela = 'curso', @curso = 'Calculo para iniciantes'
exec inserir_dados @tabela = 'curso', @curso = 'Logica para iniciantes'


exec inserir_dados @tabela = 'disciplina', @disciplina = 'logica'
exec inserir_dados @tabela = 'disciplina', @disciplina = 'matemática 1'
exec inserir_dados @tabela = 'disciplina', @disciplina = 'fisica 1'
exec inserir_dados @tabela = 'disciplina', @disciplina = 'historia brasil'
exec inserir_dados @tabela = 'disciplina', @disciplina = 'historia geral'

select * from Disciplina
select * from Curso
select * from Nota
select * from Aluno

--d
create procedure curso_qnt_aluno
as
begin
	select c.curso, count(*) as quantidade_alunos from Curso as c
	inner join Aluno as a
	on a.codCurso = c.codCurso
	group by c.curso

end

exec curso_qnt_aluno

--e

create procedure media_aluno
	@codigo int
as

begin

	select A.nome, avg(N.nota) media from Aluno as A
	inner join Nota as N
	on A.codAluno = N.codAluno
	where N.codAluno = @codigo
	group by A.nome

end

exec media_aluno 1

select * from Nota
--f 
alter procedure aluno_do_curso
	@codigo int
as

begin 
	select C.curso, A.nome, D.disciplina, N.nota from Nota as N
	inner join Aluno as A
	on N.codAluno = A.codAluno
	inner join Disciplina as D
	on D.codDisciplina = N.codDisciplina
	inner join Curso C
	on C.codCurso = A.codCurso
	where C.codCurso = @codigo
end

exec aluno_do_curso 1