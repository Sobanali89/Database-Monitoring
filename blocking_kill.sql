--Blocking sessions with KILL command
set linesize 200
set pages 999
col program format a10 WORD_WRAPPED
col event format a10 WORD_WRAPPED
col KIL_CMD format a50
SELECT /*+ ordered*/ sn.inst_id, sn.sid, sn.PROGRAM, DECODE(request, 0, 'Holder ', 'Waiter ') Locker, lo.type, id1 object_id, ctime time, lmode, request, sn.
event, sn.SQL_HASH_VALUE,'ALTER SYSTEM KILL SESSION ' || ''''||sn.sid ||',' ||sn.serial# ||''''||' IMMEDIATE;' AS KIL_CMD
FROM gV$LOCK lo, gv$session sn
WHERE (id1, id2, lo.type) IN (SELECT id1, id2, type FROM gV$LOCK WHERE request > 0) and lo.INST_ID = sn.INST_ID and lo.SID = sn.SID
ORDER BY id1, request;
