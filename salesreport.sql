set echo off
set heading on
set feedback off
set verify off

spool e:salesreport.txt

prompt
prompt ******* Monthly Sales Report **********
prompt
column omonth heading 'Order Month' format a15
column pnum heading 'Product No.' format a12
column pdescription heading 'Product Name' format a15
column totalorders heading 'No of Orders' format 999,999
column totalunits heading 'Total Units' format 999,999
column totalamt heading 'Total Amount' format $999,999.99
select to_char(odate,'mm/yyyy') omonth, orders.pnum, pdescription, count(onum) totalorders, sum(qty) totalunits, sum(amt) totalamt
	from orders, product where orders.pnum=product.pnum
	group by to_char(odate,'mm/yyyy'), orders.pnum, pdescription
	order by to_char(odate,'mm/yyyy'), orders.pnum;

spool off