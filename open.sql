set echo off
set heading off
set feedback off
set verify off

spool e:open.txt

prompt
prompt ******* O P E N    O R D E R **********
prompt
select 'Today''s Date:' , sysdate from dual;

accept vcnum prompt 'Enter the Customer Number: ';
select '	Customer Name: ', rtrim(initcap(clastname))||', '||rtrim(initcap(cfirstname))
	from customers
	where cnum='&vcnum';
select '	Shipping Address: ', caddress from customers where cnum='&vcnum';
select '	City, State Zip: ', rtrim(initcap(city))||', '||upper(state)||' '||zip
	from customers
	where cnum='&vcnum';
select '	Phone: ', '('||substr(cphone,1,3)||') '||substr(cphone,4,3)||'-'||substr(cphone,7) 
	from customers 
	where cnum='&vcnum';

accept vpnum prompt 'Enter the Product number:'
select '	Product Number: ', pnum
	from product
	where lower('&vpnum')=pnum;
select '	Product Description: ', pdescription
	from product 
	where lower('&vpnum')=pnum;
select '	Unit Price: ', '$'||unitprice
	from product 
	where lower('&vpnum')=pnum;
accept vqty prompt 'Enter the quantity ordered: '
select '	Amount Ordered: ', '$'||unitprice*&vqty 
	from product 
	where lower('&vpnum')=pnum;
prompt 
prompt Please choose from the following warehouses:

set heading on

column wcode heading 'Warehouse'
column citystate heading 'City,State'
column inventoryqty heading 'InventoryQty' format 999,999
select inventory.wcode, rtrim(initcap(warehouse.city))||', '||upper(warehouse.state) citystate, inventoryqty
	from warehouse, inventory
	where warehouse.wcode=inventory.wcode
	and inventory.pnum=lower('&vpnum');
prompt
accept vwcode prompt 'Enter the warehouse code: '

insert into orders (onum, cnum, odate, ostatus, pnum, qty, wcode)
	select maxnum, '&vcnum', sysdate, 'Open','&vpnum', &vqty, '&vwcode' from counter;
update orders
	set amt=&vqty*(select unitprice from product where '&vpnum'=pnum);
commit;

set heading off

prompt
prompt ******** Order Status:  OPEN
select '******** Order Number is ----->  ', maxnum from counter;
update counter set maxnum=maxnum+1;
commit;
spool off
