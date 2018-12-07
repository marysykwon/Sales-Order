set echo off
set heading off
set feedback off
set verify off

spool e:close.txt

prompt
prompt ******* C L O S E    O R D E R **********
prompt
accept vonum prompt 'Please enter the Order Number: ';
prompt
select 'Order Number: ', onum 
	from orders where &vonum=onum;
select 'Order Date:	', odate
	from orders where &vonum=onum;
select 'Customer Number: ', cnum
	from orders where &vonum=onum;
select '	', rtrim(initcap(clastname))||', '||rtrim(initcap(cfirstname))
	from customers, orders
	where customers.cnum=orders.cnum and &vonum=onum;
select '	', caddress
	from customers, orders
	where customers.cnum=orders.cnum and &vonum=onum;
select '	', rtrim(initcap(city))||', '||upper(state)||' '||zip
	from customers, orders
	where customers.cnum=orders.cnum and &vonum=onum;
select '	', '('||substr(cphone,1,3)||') '||substr(cphone,4,3)||'-'||substr(cphone,7) 
	from customers, orders
	where customers.cnum=orders.cnum and &vonum=onum;
select 'Item Number: ', pnum
	from orders where &vonum=onum;
select '	Item description: ', pdescription
	from product, orders where product.pnum=orders.pnum and &vonum=onum;
select '	Unit Price: ', unitprice
	from product, orders where product.pnum=orders.pnum and &vonum=onum;
select 'Quantity Ordered: ', qty
	from orders where &vonum=onum;
select 'Amount Ordered: ', '$'||unitprice*qty 
	from product, orders where product.pnum=orders.pnum and &vonum=onum;
select 'Shipping Warehouse: ', wcode
	from orders where &vonum=onum;
select '	', waddress
	from warehouse, orders
	where warehouse.wcode=orders.wcode and &vonum=onum;
select '	', rtrim(initcap(city))||', '||upper(state)||' '||zip
	from warehouse, orders
	where warehouse.wcode=orders.wcode and &vonum=onum;
select '	', '('||substr(wphone,1,3)||') '||substr(wphone,4,3)||'-'||substr(wphone,7) 
	from warehouse, orders
	where warehouse.wcode=orders.wcode and &vonum=onum;
prompt
accept vshipdate prompt 'Please enter the shipping date (mm/dd/yyyy): '
accept vshipqty prompt 'Please enter the shipping quantity: '
prompt
update orders
	set shipdate=to_date('&vshipdate','mm/dd/yyyy') where &vonum=onum;
update orders 
	set shipqty=&vshipqty where &vonum=onum;
update orders
	set shipamt=shipqty*(select unitprice from product, orders where product.pnum=orders.pnum and &vonum=onum)
	where &vonum=onum;
update orders
	set ostatus='Closed' where &vonum=onum;
update inventory
	set inventoryqty=inventoryqty-(select shipqty from orders where &vonum=onum)
	where wcode in (select wcode from orders where &vonum=onum);
commit;

prompt************************************
prompt Order is now ----->  CLOSED
select 'Date Shipped: ', shipdate from orders where &vonum=onum;
select 'Quantity Shipped: ', shipqty from orders where &vonum=onum;
select 'Amount Shipped: ', '$'||unitprice*shipqty
	from product, orders where product.pnum=orders.pnum and &vonum=onum;

spool off