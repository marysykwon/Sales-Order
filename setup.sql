set echo on
spool e:setup.txt

drop table inventory;
drop table counter;
drop table orders;
drop table customers;
drop table product;
drop table warehouse;

create table customers (
	cnum number(3),
	clastname varchar2(15),
	cfirstname varchar2(10),
	caddress varchar2(30),
	city varchar2(20),
	state varchar2(2),
	zip varchar2(5),
	cphone varchar2(10),
	primary key (cnum));

insert into customers values ('101', 'King', 'Andy', '61 Vintage', 'Irvine', 'CA', '92618', '3234958603');
insert into customers values ('102', 'Smith', 'Henry', '45 Vista', 'Santa Ana', 'CA', '91517', '5631589621');
insert into customers values ('103', 'Cho', 'Kenny', '293 Monroe', 'Dallas', 'TX', '75024', '7144019895');
insert into customers values ('104', 'Kim', 'Sue', '2342 Catalina St', 'Boston', 'MA', '02108', '2135053982');
insert into customers values ('105', 'Kwon', 'Mary', '57 Serenity', 'San Francisco', 'CA', '94102', '6613128364');

create table product (
	pnum varchar2(4),
	pdescription varchar2(25),
	unitprice number(6,2),
	primary key (pnum));

insert into product values ('p1', 'Pencil', '2.00');
insert into product values ('p2', 'Pen', '3.00');
insert into product values ('p3', 'Paper', '0.99');
insert into product values ('p4', 'Stapler', '9.00');
insert into product values ('p5', 'Paper Clip', '1.00');
insert into product values ('p6', 'White-Out', '4.00');




create table warehouse (
	wcode varchar2(4),
	waddress varchar2(30),
	city varchar2(20),
	state varchar2(2),
	zip varchar2(5),
	wphone varchar2(10),
	primary key (wcode));

insert into warehouse values ('w1', '111 Warehouse Rd', 'San Diego', 'CA', '92808', '5074593943');
insert into warehouse values ('w2', '2309 Commerce Rd', 'Plano', 'TX', '72938', '2834928474');
insert into warehouse values ('w3', '1903 Highland Shores Dr', 'Frisco', 'TX', '72045', '9725869705');
insert into warehouse values ('w4', '893 Turnpike', 'Jamestown', 'VA', '20101', '4561754892');
insert into warehouse values ('w5', '25506 Wharton Dr', 'Valencia', 'CA', '91381', '6613126365');




create table orders (
	onum number(4),
	cnum number(3),
	ostatus varchar2(10),
	odate date,
	pnum varchar2(4),
	qty number(6),
	amt number(8,2),
	wcode varchar2(4),
	shipdate date,
	shipqty number(6),
	shipamt number(8,2),
	primary key (onum),
	constraint fk_orders_cnum foreign key (cnum) references customers(cnum),
	constraint fk_orders_pnum foreign key (pnum) references product(pnum),
	constraint fk_orders_wcode foreign key (wcode) references warehouse (wcode));

insert into orders values ('9001', '101', 'Open', '04-april-16', 'p4', '5', '45.00', 'w4', null, null, null);
insert into orders values ('9002', '103', 'Open', '10-may-16', 'p1', '10', '20.00', 'w5', null, null, null);
insert into orders values ('9003', '105', 'Closed', '17-aug-16', 'p2', '3', '9.00', 'w3', '21-aug-16', '3', '9.00');
insert into orders values ('9004', '102', 'Closed', '11-jan-16', 'p5', '15', '15.00', 'w4', '23-jan-16', '10', '10.00');
insert into orders values ('9005', '101', 'Closed', '27-feb-16', 'p1', '20', '40.00', 'w5', '02-march-16', '19', '38.00');
insert into orders values ('9006', '104', 'Canceled', '25-dec-16', 'p6', '6', '24.00', null, null, null, null);

create table counter(
	maxnum number(5));
insert into counter values ('1000');


create table inventory (
	wcode varchar2(4),
	pnum varchar2(4),
	inventoryqty number(6),
	primary key (wcode, pnum),
	constraint fk_inventory_wcode foreign key (wcode) references warehouse(wcode),
	constraint fk_inventory_pnum foreign key (pnum) references product(pnum));

insert into inventory values ('w2', 'p3', '390');
insert into inventory values ('w2', 'p4', '50');
insert into inventory values ('w1', 'p6', '15');
insert into inventory values ('w5', 'p1', '100');
insert into inventory values ('w3', 'p2', '150');
insert into inventory values ('w4', 'p5', '250');
insert into inventory values ('w3', 'p1', '625');
insert into inventory values ('w5', 'p6', '89');
insert into inventory values ('w1', 'p3', '75');
insert into inventory values ('w4', 'p4', '50');

spool off;
