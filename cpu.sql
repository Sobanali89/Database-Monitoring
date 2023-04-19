--Active Sessions other than ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP') consuming more CPU 

alter session set nls_date_format='Dd-MON-YY HH24:MI:SS';
set lines 999
set pages 999
col name format a26
col sid wra format 999,999,999
col username format a10
col status format a8
col LOGON_TIME format a10
col program format a20 WORD_WRAPPED
col SESS_CPU_SECS wra format 999,999,999.99
col LAST_CPU_SECS wra format 999,999,999.99
col logon_secs  wra format 999,999,999
col Percent  wra format 999.99
col sql_id format a15 WORD_WRAPPED
col SQL_HASH_VALUE wra format 999,999,999
col sql_text format a50 WORD_WRAPPED

select sess_cpu.sid, NVL(sess_cpu.username, 'Oracle Process') username, sess_cpu.status, sess_cpu.logon_time,  
round((sysdate - sess_cpu.logon_time)*1440*60) logon_SECS, 
sess_cpu.value/100 SESS_CPU_SECS, (sess_cpu.value - call_cpu.value)/100 LAST_CPU_SECS, 
round ((sess_cpu.value/100)/round((sysdate - sess_cpu.logon_time)*1440*60)*100,2) Percent, sess_cpu.sql_id, sq.SQL_TEXT SQL_TEXT    
from
(select se.process,se.sql_id,ss.statistic#,se.sid, se.username, se.status, se.program, se.logon_time, sn.name, ss.value from v$session se, v$sesstat ss,
v$statname sn
where se.sid=ss.sid
and sn.statistic#=ss.statistic#
and sn.name in ('CPU used by this session') ) sess_cpu,
(select ss.statistic#,se.sid, ss.value, value/100 seconds from v$session se, v$sesstat ss, v$statname sn
where se.sid=ss.sid
and sn.statistic#=ss.statistic#
and sn.name in ('CPU used when call started') ) call_cpu,
(select snn.sid,snn.program,snn.SQL_HASH_VALUE, sl.SQL_TEXT SQL_TEXT
from v$session snn, v$sqlarea sl
where snn.SQL_ADDRESS = sl.ADDRESS
and snn.SQL_HASH_VALUE = sl.HASH_VALUE
and snn.sql_id is not null) sq
where sess_cpu.sid=call_cpu.sid
and  sess_cpu.sid=sq.sid
and username NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
and sess_cpu.status='ACTIVE'
order by Percent;
