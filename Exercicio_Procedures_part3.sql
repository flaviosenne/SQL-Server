create database ExercSP01
go
use ExercSP01

CREATE TABLE Contribuinte (
  CodContribuinte int CONSTRAINT pk_contr primary key identity(1,1),
  Nome varchar(70),
  Email varchar(30),
  DtNasc datetime
)

CREATE TABLE Tributo (
  CodTributo int CONSTRAINT pk_trib primary key identity(1,1),
  Descricao varchar(50)
)

CREATE TABLE Pagamento (
  CodPagto int CONSTRAINT pk_pag primary key identity(1,1),
  CodContribuinte int CONSTRAINT fk_pag_contr 
                  FOREIGN KEY REFERENCES Contribuinte (CodContribuinte),
  CodTributo int CONSTRAINT fk_pag_trib
                  FOREIGN KEY REFERENCES Tributo (CodTributo),
  DtVencto datetime,
  DtPagto datetime,
  Multa money,
  Valor money,
  Juros money
)


--1
--a

create procedure inserir_dados_contribuinte
	@nome varchar(40) = null,
	@email varchar(40) = null,
	@dataNascimento date = null
as

begin
	insert into Contribuinte
	values(@nome, @email, @dataNascimento)

	select * from Contribuinte

end


create procedure inserir_dados_tributos
	@descricao varchar(40) = null
as

begin
	insert into Tributo
	values(@descricao)

	select * from Tributo

end



create procedure inserir_dados_pagamentos
	@contribuinte int = null,
	@tributo int = null,
	@dataVencimento date = null,
	@dataPagamento date = null,
	@multa money = 0,
	@valor money = 0,
	@juros money = 0
as

begin
	insert into Pagamento
	values(@contribuinte, @tributo, @dataVencimento, @dataPagamento, @multa, @valor, @juros)

	select * from Pagamento

end

exec inserir_dados_contribuinte 'joao', 'joao@email', '1990-05-21'
exec inserir_dados_tributos 'tributo 2'
exec inserir_dados_pagamentos 1, 2, '2020-11-15', null, @valor = 93, @multa =20



--b
alter procedure alterar_pagamento
	@codigo int = null,
	@contribuinte int = null,
	@tributo int = null,
	@dataVencimento date= null,
	@dataPagamento date = null,
	@multa money = null,
	@valor money = null,
	@juros money= null
as

begin
	update Pagamento
	set 
	CodContribuinte = ISNULL(@contribuinte, CodContribuinte),
	CodTributo = ISNULL(@tributo, CodTributo),
	DtVencto = ISNULL(@dataVencimento, DtVencto),
	DtPagto = ISNULL(@dataPagamento, DtPagto),
	Multa = ISNULL(@multa, Multa),
	Valor = ISNULL(@valor, Valor),
	Juros = ISNULL(@juros, Juros)
	where CodPagto = @codigo

	select * from Pagamento
end


exec alterar_pagamento @dataVencimento = '2020-12-10', @valor =160, @codigo=1



--c
alter procedure efetuar_pagamento
	@codigo int,
	@dataPagamento date,
	@valor money,
	@multa money = 0,
	@juros money = 0
as

begin
	update Pagamento
	set 
	DtPagto = @dataPagamento,
	Valor = @valor,
	Multa = @multa,
	Juros = @juros
	where CodPagto = @codigo

	select * from Pagamento
end

exec efetuar_pagamento 9,'2020-10-29', 112, @multa=15

--d
create procedure total_pagamentos
	@codigo int
as

begin

	select count(P.DtPagto) from Pagamento P
	inner join Contribuinte C on 
	P.CodContribuinte = C.CodContribuinte
	where P.CodContribuinte = @codigo

end

select * from Pagamento

exec total_pagamentos 2

--e
alter procedure media_pagamentos_tributo
	@codigo int
as

begin
	select avg(Valor) from Pagamento
	where CodTributo = @codigo and (ISNULL(DtPagto, '') <> '')

end

exec media_pagamentos_tributo 1


--f

alter procedure pagamentos_aberto
	@codigo int
as

begin

	select count(*) from Pagamento
	where CodTributo= @codigo and isnull(DtPagto, '') = ''
end

exec pagamentos_aberto 2

-- g
alter procedure contribuinte_multa
as

begin
	select top 1 sum(p.Multa) as totMulta, Nome
	from Contribuinte c inner join Pagamento
	p on c.CodContribuinte = p.CodContribuinte
	group by Nome
	order by sum(p.Multa) desc

end

exec contribuinte_multa




