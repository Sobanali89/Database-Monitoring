col event format a30
SELECT event,state,count(*) 
FROM v$session_wait 
WHERE wait_class!='Idle' 
GROUP BY event,state 
ORDER BY 3 desc;
