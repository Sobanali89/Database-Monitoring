set linesize 200
set pages 0
SELECT  s.sid,s.serial#, p.spid, s.username, s.program,s.inst_id, 'ALTER SYSTEM KILL SESSION ' ||''''||s.sid||','||s.serial#||''''||' IMMEDIATE;','kill -9 ' || p.spid
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND' 
and s.username not in ('SYS','SYSTEM')
and s.sid=&sid;
