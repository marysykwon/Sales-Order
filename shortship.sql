set echo off
set heading on
set feedback off
set verify off

spool e:shortship.txt

prompt
prompt ******* Short Ship Report **********
prompt
column pnum heading 'Product No.' format a12
column pdescription heading 'Product Name' format a15
column shortshipqty heading 'ShortShip Qty' format 999,999
column shortshipamt heading 'ShortShip Amount' format $999,999.99
select orders.pnum, pdescription, sum(qty-shipqty) shortshipqty, sum(amt-shipamt) shortshipamt
	from orders, product where orders.pnum=product.pnum
	group by orders.pnum, pdescription;

spool off;