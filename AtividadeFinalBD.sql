create table empresa (
    CNPJ varchar(14) not null,
    nome varchar(120) UNIQUE not null,
    
    constraint pk_empresa primary key(CNPJ)
);

create sequence filial_codigo_seq;

create table filial (
    codigo integer default nextval('filial_codigo_seq'),
    nome varchar(120) not null,
    tipo varchar(50) not null,
    rua text not null,
    bairro text not null,
    cidade text not null,
    CNPJ_empresa varchar(14) not null,
    
    constraint pk_filial primary key(codigo),
    constraint fk_filial_empresa foreign key(CNPJ_empresa) references empresa(CNPJ)
);

create sequence telefoneFilial_codigo_seq;

create table telefone_filial (
    codigo_filial int default nextval('telefoneFilial_codigo_seq') not null,
    telefone varchar(14) not null,
    
    constraint pk_telefoneFilial primary key(telefone, codigo_filial),
    constraint fk_telefone_filial foreign key(codigo_filial) references filial(codigo)
);

create sequence departamento_codigo_seq;

create table departamento (
    codigo integer default nextval('departamento_codigo_seq'),
    nome varchar(80) not null,
    email varchar(256) not null,
    codigo_filial integer not null,
    
    constraint pk_departamento primary key(codigo),
    constraint fk_departamento_filial foreign key(codigo_filial) references filial(codigo)
);

create table funcionario (
    CPF varchar(11) unique not null,
    nome varchar(120) not null,
    telefone varchar(14) not null,
    email varchar(256) not null,
    idade integer not null,
    funcao varchar(250) not null,
    codigo_departamento integer not null,
    
    constraint pk_funcionario primary key(CPF),
    constraint fk_funcionario_departamento foreign key(codigo_departamento) references departamento(codigo)
);

create sequence categoria_codigo_seq;

create table categoria (
    codigo integer default nextval('categoria_codigo_seq'),
    nome varchar(80) not null,
    
    constraint pk_categoria primary key(codigo)
);

create sequence produto_codigo_seq;

create table produto (
    codigo integer default nextval('produto_codigo_seq'),
    nome varchar(150) not null,
    quantidade integer not null,
    valor float not null,
    descricao text not null,
    codigo_categoria integer not null,
    codigo_filial integer not null,
    
    constraint pk_produto primary key(codigo),
    constraint fk_produto_filial foreign key(codigo_filial) references filial(codigo),
    constraint fk_produto_categoria foreign key(codigo_categoria) references categoria(codigo)
);

create table cliente (
    CPF varchar(14) unique not null,
    nome varchar(120) not null,
    telefone varchar(14) not null,
    rua text not null,
    bairro text not null,
    cidade text not null,
    numero int not null,
    
    constraint pk_cliente primary key(CPF)
);

create sequence tipoPagamento_codigo_seq;

create table tipo_pagamento (
    codigo int default nextval('tipoPagamento_codigo_seq'),
    nome varchar(80) not null,
    
    constraint pk_tipoPagamento primary key(codigo)
);

create table pagamento (
    codigo varchar(32) not null,
    valor_total float not null,
    codigo_tipo_pagamento int not null,
    
    constraint pk_pagamento primary key(codigo),
    constraint fk_pagamento_tipo foreign key(codigo_tipo_pagamento) references tipoPagamento(codigo)
);

create table compra (
    codigo varchar(32) not null,
    CPF_cliente varchar(11) not null,
    CPF_funcionario varchar(11) not null,
    codigo_pagamento varchar(32) not null,
    codigo_filial integer not null,
    data_compra DATE not null,
    
    constraint pk_compra primary key(codigo),
    constraint fk_compra_cliente foreign key(CPF_cliente) references cliente(CPF),
    constraint fk_compra_filial foreign key(codigo_filial) references filial(codigo),
    constraint fk_compra_pagamento foreign key(codigo_pagamento) references pagamento(codigo),
    constraint fk_compra_funcionario foreign key(CPF_funcionario) references funcionario(CPF)
);

create table compra_produto(
    codigo_produto int not null,
    codigo_compra varchar(32) not null,
    quantidade int not null,

    constraint pk_compraProduto primary key(codigo_compra, codigo_produto),
    constraint fk_compraProduto_compra foreign key(codigo_compra) references compra(codigo),
    constraint fk_compraProduto_produto foreign key(codigo_produto) references produto(codigo)
);

insert into empresa(CNPJ, nome) 
values ('70966892000165', 'Moorse');

insert into empresa(CNPJ, nome) 
values ('89912327000143', 'Baruel');

insert into filial(nome, tipo, rua, bairro, cidade, CNPJ_empresa)
values ('IF', 'nacional', 'Edite Pereira', 'Augusto dos Anjos', 'Sapé', '70966892000165');

insert into filial(nome, tipo, rua, bairro, cidade, CNPJ_empresa)
values ('UF', 'nacional', 'Edite Pereira', 'Augusto dos Anjos', 'Sapé', '70966892000165');

insert into filial(nome, tipo, rua, bairro, cidade, CNPJ_empresa)
values ('Tenys', 'nacional', 'Edite Pereira', 'Augusto dos Anjos', 'Sapé', '89912327000143');

insert into telefone_filial(codigo_filial, telefone) 
values (4, '55839677359717');
insert into telefone_filial(codigo_filial, telefone) 
values (4, '55839143361920');

insert into departamento(nome, email, codigo_filial)
values ('front', 'moorse.front@moorse.io', 4);

insert into departamento(nome, email, codigo_filial)
values ('back', 'moorse.front@moorse.io', 4);

insert into funcionario(CPF, nome, telefone, email, idade, funcao, codigo_departamento)
values ('26122290009', 'Joalison', '55839762901324', 'jooj@gmail.com', 20, 'desenvolvedor', 3);

insert into funcionario(CPF, nome, telefone, email, idade, funcao, codigo_departamento)
values ('50775583022', 'Lilia', '55839266389787', 'lilia@gmail.com', 21, 'desenvolvedor', 4);

insert into funcionario(CPF, nome, telefone, email, idade, funcao, codigo_departamento)
values ('11815685018', 'Samira', '55839814226179', 'samira@gmail.com', 20, 'desenvolvedor', 4);

insert into categoria(nome)
values ('Mensagem');

insert into produto(nome, quantidade, valor, descricao, codigo_categoria, codigo_filial) 
values ('Whatsapp 2', 1, 197.00, 'whatsapp 2', 1, 4);

insert into cliente(CPF, nome, telefone, rua, bairro, cidade, numero)
values ('11815685018', 'Matheus', '55839303311001', 'São Sebastião', 'Centro', 'Exu', 100);

insert into tipo_pagamento(nome)
values ('boleto');

insert into pagamento(codigo, valor_total, codigo_tipo_pagamento)
values ('f2a80d21-ae65-4bdc-a41a-1fb1d034', 197.00, 1);

insert into compra(codigo, CPF_cliente, CPF_funcionario, codigo_filial, codigo_pagamento, data_compra)
values ('6a8d8bc9-7e91-44b4-afd1-c236a111', '11815685018', '26122290009', 4, 'f2a80d21-ae65-4bdc-a41a-1fb1d034', '2022-08-21');

insert into compra_produto(codigo_produto, codigo_compra, quantidade)
values(2, '6a8d8bc9-7e91-44b4-afd1-c236a111', 1);

/*Quantidade de filiais da empresa*/
select COUNT(f.*) as "Quantidade de filiais"
from empresa e
inner join filial f
on e.cnpj = f.CNPJ_empresa 
where e.cnpj = '70966892000165';

/*Todos os departamentos da filial*/
select d.*
from filial f
inner join departamento d
on f.codigo = d.codigo_filial 
where f.codigo = 4;

/*Quantos funcionários tem no departamento*/
select COUNT(f.*) as "quantidade de funcionarios no departamento"
from departamento d
inner join funcionario f
on d.codigo = f.codigo_departamento
where d.codigo = 4;

/*Quantos funcionários tem na filial*/
select COUNT(fun.*) as "quantidade de funcionarios na filial"
from filial fil
inner join departamento dep on fil.codigo = dep.codigo_filial
inner join funcionario fun on dep.codigo = fun.codigo_departamento
where fil.codigo = 4;

/*Todos os produtos*/
select *from produto;

/*Quantidade de um produto*/
select quantidade from produto where codigo = 2;

/*Quantas compras foram realizadas por dia na filial*/
/*Colocar atributo data na tabela compra*/
select COUNT (c.*) as "compras na filial realizadas no dia"
from filial f
inner join compra c
on f.codigo = c.codigo_filial
where c.data_compra = '2022-08-20';


/*Todos os clientes da filial*/
select cli.*
from filial fil
inner join compra comp on fil.codigo = comp.codigo_filial
inner join cliente cli on comp.CPF_cliente = CPF;

/*Pagamentos de um cliente*/
select cli.CPF as "CPF cliente", pag.*
from cliente cli
inner join compra comp on cli.CPF = comp.CPF_cliente
inner join pagamento pag on comp.codigo_pagamento = pag.codigo
where cli.CPF = '11815685018';

/*Todos os pagamentos*/
select * from pagamento;

/*Quantidades de vendas por filial*/
select COUNT(c.*) as "Quantidade de vendas da filial"
from filial f
inner join compra c
on f.codigo = c.codigo_filial
where f.codigo = 4;

/*Valor total da compra do cliente*/
select comp.codigo as "codigo da compra", pag.valor_total
from cliente cli
inner join compra comp  on  cli.CPF = comp.CPF_cliente
inner join pagamento pag on comp.codigo_pagamento = pag.codigo
where cli.CPF = '11815685018';