
create database AulaStoredProc

go

use AulaStoredProc

-- CRIAR TABELAS

create table departamento(

idDepto int constraint pk_depto primary key identity(1,1),

depto varchar(40) NOT NULL

)

create table funcionario(

idFun int constraint pk_fun primary key identity(1,1),

nome varchar(50) NOT NULL,

cpf varchar(20),

rg varchar(50),

e_mail varchar(50),

dt_nasc datetime,

dt_admissao datetime,

senhaDesc varchar(20),

idDepto int constraint fk_fun_depto foreign key references departamento(idDepto)

)

create table salario(

idSalario int constraint pk_salario primary key identity(1,1),

valor money constraint chkValor check(valor > 0),

dtPagto datetime,

obs varchar(1000),

idFun int constraint fk_sal_fun foreign key references funcionario(idFun)

)

--INSERIR DADOS

set dateformat dmy

insert into departamento

values ('ADMINISTRATIVO'), ('COMPRAS')

insert into funcionario(nome, idDepto)

values ('Andre', 1),('Jose', 1)

insert into salario

values

(2050.49, '25/01/2014', 'Sem faltas no per�odo', 1),

(2534.00, '15/02/2014', 'Inclui b�nus por equipe - atingimento de meta', 1),

(1998.40, '18/03/2014', NULL, 1)

--###################################

create table MediaSalarial(

idVlMedio int

constraint pk_mediaSal primary key

identity(1,1),

idFun int

constraint fk_mediaSal foreign key

references funcionario(idFun),

VlMedio money

)

--a
SELECT	* FROM departamento

alter procedure sp_quantidade_funcionario_no_departamento
	@departamento int 
as

BEGIN
	select count(nome) from funcionario
	where idDepto = @departamento
END

EXEC sp_quantidade_funcionario_no_departamento 1


--b

alter procedure alterar_excluir_inserir
	@metodo varchar(30),
	@dado varchar(40),
	@condicao int

as

begin
	if @metodo = 'inserir'
		insert into departamento
		values(@dado)
	
	if @metodo = 'excluir'
		delete departamento
		where idDepto = @condicao


	if @metodo = 'alterar'
		update departamento
		set depto = @dado 
		where idDepto = @condicao



	select * from departamento

end



-- insira na seguinte ordem
--1 metodo: inserir, alterar, deletar
--2: qual valor
--3: condicao - qual id do departamento
exec alterar_excluir_inserir 'alterar', 'VENDA', 4




--c

alter procedure selecionar_departamento
	@codigo int = null,
	@departamento varchar(40) = null

as

begin
	select * from departamento
	where
	idDepto = @codigo
	OR
	depto like '%' + @departamento +'%'

end

exec selecionar_departamento @departamento = 'Ven'

--d

create table loog(
	id int constraint pk_log primary key identity(1,1),
	codigo int,
	data_agora datetime constraint data_agora default(getdate()) not null
)


create procedure guardar_log
	@id int
as
begin
 
	select idDepto from departamento
	where idDepto = @id

	insert into loog(codigo)
	values(@id)

	select * from loog
end

select * from departamento

exec guardar_log 1