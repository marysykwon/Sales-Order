set echo off
set heading off
set feedback off
set verify off

spool e:lookup.txt

prompt
prompt ******* O R D E R    D E T A I L **********
prompt
accept vonum prompt 'Please enter the Order Number: ';
select 'Order Number: ', onum 
	from orders where &vonum=onum;
select 'Order Status: ', ostatus
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
select 'Product Number: ', pnum
	from orders where &vonum=onum;
select '	Item description: ', pdescription
	from product, orders where product.pnum=orders.pnum and &vonum=onum;
select '	Unit Price: ', unitprice
	from product, orders where product.pnum=orders.pnum and &vonum=onum;
select 'Order Date: ', odate
	from orders where &vonum=onum;
select 'Shipping Date: ', shipdate from orders where &vonum=onum;
select 'Quantity Ordered: ', qty
	from orders where &vonum=onum; 
select 'Amount Ordered: ', '$'||unitprice*qty 
	from product, orders where product.pnum=orders.pnum and &vonum=onum;
select 'Quantity Shipped: ', shipqty 
	from orders where &vonum=onum;
select 'Amount Shipped: ', '$'||unitprice*shipqty 
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
spool off