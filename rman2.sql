set linesize 200
SELECT sid, serial#, context, sofar, totalwork,
round(sofar/totalwork*100,2) "% Complete"
FROM gv$session_longops
WHERE opname LIKE 'RMAN%'
AND opname NOT LIKE '%aggregate%'
AND totalwork != 0
AND sofar <> totalwork order by 6 desc;
