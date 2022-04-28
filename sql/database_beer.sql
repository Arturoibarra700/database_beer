
create table beers
(
		beer_id serial primary key NOT NULL,
		Product_name varchar(50)NOT NULL unique,
		price numeric(4,2) NOT NULL
);

create table notes
(
	beer_id int primary key,
	note varchar(200)
);
create table accounts(
	account_id serial,
	amount numeric(12,2)
);

create table sales(
	 sales_id uuid not null primary key,
     date1  date time with time zone not null
); 

create table bills(
	sales_id uuid not null,
	beer_id int not null
	
);

create table accounts(
	account_id serial primary key not null,
	capital numeric(10,2) not null,
	accounts_name varchar(50)not null
);


--foreign key 
alter table bills
add constraint fk_sales_sale_id
foreign key(sales_id)
references sales (sales_id)

alter table bills
add constraint fk_beers_beer_id
foreign key(beer_id)
references beers (beer_id)

alter table notes
add constraint fk_notes_beers_id
foreign key(beer_id)
references beers (beer_id)

--insert into beers
insert into beers("product_name","price")values ('Indio',18);
insert into beers("product_name","price")values ('Corona',26);
insert into beers("product_name","price")values ('Tecate',15);
insert into beers("product_name","price")values ('Carta Blanca',23);
select * from beers

--insert into notas
insert into notes("beer_id","note")values (4,'se prendio el cerro');

select* from notes

--insert into sales 
insert into sales("id_sales","date") values ('45998208-6505-4454-a9b6-1f71e364aba9','2022-04-25T22:00:00.00-05');
insert into sales("id_sales","date") values ('f8c3d6e6-56bb-4fe4-8c83-07a3dda90caa','2022-04-25T21:30:00.00-05');
insert into sales("id_sales","date") values ('c29df417-ee71-4e1e-8f36-e7800f0c7fdc','2022-04-25T21:31:00.00-05');
insert into sales("id_sales","date") values ('b11c4b0b-5815-40b4-bf6f-93a57fdbec82','2022-04-25T21:31:00.00-05');
select*from sales
--insert into bills
insert into bills("sale_id","beer_id") values ('45998208-6505-4454-a9b6-1f71e364aba9',4);
insert into bills("sale_id","beer_id") values ('f8c3d6e6-56bb-4fe4-8c83-07a3dda90caa',2);
insert into bills("sale_id","beer_id") values ('c29df417-ee71-4e1e-8f36-e7800f0c7fdc',3);
insert into bills("sale_id","beer_id") values ('b11c4b0b-5815-40b4-bf6f-93a57fdbec82',1);
--insert into accounts
insert into accounts("capital","accounts_name") values (0,'abarrotes poncho');
insert into accounts("capital","accounts_name") values (0,'abarrotes Dr.Goku');
insert into accounts("capital","accounts_name") values (0,'abarrotes karina 1');
insert into accounts("capital","accounts_name") values (0,'abarrotes karina 2');
select* from accounts
