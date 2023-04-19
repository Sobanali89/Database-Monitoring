col event format a30
SELECT inst_id, event,state,count(*) 
FROM gv$session_wait 
WHERE wait_class!='Idle' 
GROUP BY inst_id, event,state 
ORDER BY 1,4 desc;
