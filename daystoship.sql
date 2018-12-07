set echo off
set heading on
set feedback off
set verify off

spool e:daystoship.txt

prompt
prompt ******* Average Days to Ship Report **********
prompt
column wcode heading 'Warehouse'
column city heading 'City'
column state heading 'State'
column avgdays heading 'AvgDaystoShip' format 999.99
select wcode, city, state, avg(trunc(shipdate)-odate+1) avgdays
	from orders where shipdate is not null
	group by wcode;

spool off;