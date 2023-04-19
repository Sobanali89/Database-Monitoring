--Long running queries

SET LINESIZE 180
SET PAGESIZE 9999

col uname format a5 WORD_WRAPPED
col OSUSER format a7 WORD_WRAPPED
col prog format a15 WORD_WRAPPED
col target format a20 WORD_WRAPPED
col MACHINE format a10 WORD_WRAPPED
col opname format a6 WORD_WRAPPED
col progress format a5 WORD_WRAPPED



select a.inst_id inst,
       a.sid,
       a.username uname,
       c.OSUSER OSUSER,
       c.program  prog,
	   c.MACHINE MACHINE,
       a.target target,
       RPAD(a.opname,17,' ') opname,
       a.sql_hash_value hash_value,
       round(sofar/elapsed_seconds/128,2) "Speed(M)",
       round(sofar * 100 / decode(totalwork, 0, 1, totalwork), 0) || '%' as progress,
       elapsed_seconds time_used,
       time_remaining time_left,
       round(totalwork/128,1) "all(M)" 
 from gv$session_longops a, gv$session c
 where time_remaining > 0
   and elapsed_seconds!=0
   and a.inst_id = c.inst_id
   and a.sid = c.sid
   and a.sql_address = c.sql_address
   and a.sql_hash_value = c.sql_hash_value
 order by inst, uname,prog,target
/
