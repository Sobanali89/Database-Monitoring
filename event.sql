set linesize 200
SET PAGESIZE 1000
COLUMN username FORMAT A8
COLUMN event FORMAT A40
COLUMN wait_class FORMAT A10

SELECT NVL(s.username, '(oracle)') AS username,
       s.inst_id,
       s.sid,
       s.serial#,
       sw.event,
       sw.wait_class,
       sw.seconds_in_wait,
       sw.state,
       s.sql_id,
       s.sql_hash_value
FROM   gv$session_wait sw,
       gv$session s
WHERE  s.sid = sw.sid
AND sw.event like '%&wait_event%'
ORDER BY sw.seconds_in_wait DESC;
