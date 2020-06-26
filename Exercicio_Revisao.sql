create database Revisao

use Revisao
 create table Mesa(
	nroMesa int primary key identity(1,1),
	setor varchar(40),
	capacidade int,
	situacao varchar(30)
 )

 create table Produto(
	codPro int primary key identity(1,1),
	descricao varchar(50),
	preco money
)

create table Garcom(
	codGar int primary key identity(1,1),
	nome varchar(60),
	comissao char(1)
)

create table Atendimento(
	codAte int primary key identity(1,1),
	situacao varchar(50),
	dtHrChegada datetime,
	nroPeossoas int,
	nroMesas int foreign key references Mesa(nroMesa),
	codGar int foreign key references Garcom(codGar)
)

create table Consumo(
	codCon int primary key identity(1,1),
	qtde int,
	vlUnit money,
	codAte int foreign key references Atendimento(codAte),
	codPro int foreign key references Produto(codPro)
)

insert into Mesa values('Andar Superiros', 6, 'Livre')
insert into Mesa values('Andar Superior', 4, 'Livre'),
('Andar Superior', 8, 'Ocupado'),
('Andar Superior', 6, 'Ocupado')

insert into Mesa values('Lounge', 4, 'Ocupado'),
('Lounge', 6,'Livre'),('Lounge', 2, 'Livre'),
('Lounge', 3, 'Ocupado'),('Lounge', 4, 'Livre')

insert into Mesa values('Bar', 3, 'Ocupado'),
('Bar', 3, 'Ocupado'),('Bar', 3, 'Livre')


insert into Produto
values
  ('AGUA', 7.90),
  ('REFRIGERANTE', 13.80),
  ('CERVEJA', 25.90),
  ('VODKA', 19.40),
  ('COXINHA', 9.50),
  ('PASTEL CARNE', 8.50),
  ('PASTEL QUEIJO', 8.50),
  ('QUIBE', 11.90),
  ('ESPETINHO CARNE', 22.50),
  ('ESPETINHO FRANGO', 19.80)


  insert into Garcom
values
  ('Ana', 'S'),
  ('Joao', 'S'),
  ('Rafael', 'S'),
  ('Joaquim', 'S'),
  ('Pedro', 'S'),
  ('Paula', 'N'),
  ('Alberto', 'N'),
  ('Carlos', 'N')


insert into Atendimento
values
  ('EM ATENDIMENTO', '01-15-2020 19:30', 2, 4, 3),


  ('EM ATENDIMENTO', '23/01/2020 21:00', 3, 10, 4),
  ('EM ATENDIMENTO', '07/02/2020 19:30', 10, 2, 4),
  ('EM ATENDIMENTO', '11/02/2020 20:30', 8, 3, 5),
  ('EM ATENDIMENTO', '11/02/2020 20:40', 9, 5, 2),
  ('FINALIZADO', '8/01/2020 19:20', 2, 4, 1),
  ('FINALIZADO', '15/01/2020 22:40', 3, 8, 4),
  ('FINALIZADO', '19/02/2020 19:45', 5, 9, 6),
  ('FINALIZADO', '25/02/2020 20:30', 4, 7, 7),
  ('FINALIZADO', '17/03/2020 21:30', 2, 11, 3),
  ('FINALIZADO', '17/03/2020 22:00', 2, 3, 8),
  ('FINALIZADO', '21/04/2020 20:00', 5, 8, 4),
  ('FINALIZADO', '28/04/2020 20:15', 3, 7, 1),
  ('FINALIZADO', '10/05/2020 19:00', 2, 10, 3),
  ('CANCELADO', '10/02/2020 20:40', 3, 9, 2),
  ('CANCELADO', '21/04/2020 21:15', 4, 4, 5),
  ('CANCELADO', '21/04/2020 20:30', 1, 5, 7),
  ('CANCELADO', '11/05/2020 22:40', 2, 11, 8),
  ('CANCELADO', '15/05/2020 19:20', 2, 11, 8),
  ('CANCELADO', '15/05/2020 20:45', 2, 11, 8)
