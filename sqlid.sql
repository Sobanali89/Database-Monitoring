set linesize 200
col program format a20 WORD_WRAPPED
col sql_text format a40 WORD_WRAPPED
col KIL_CMD format a50
select sn.sid,sn.program,sn.SQL_HASH_VALUE, sl.SQL_TEXT SQL_TEXT,'ALTER SYSTEM KILL SESSION ' || ''''||sn.sid ||',' ||sn.serial# ||''''||' IMMEDIATE;' AS KIL_CMD
                  from v$session sn, v$sqlarea sl
                  where sn.SQL_ADDRESS = sl.ADDRESS
                  and sn.SQL_HASH_VALUE = sl.HASH_VALUE
                  and sn.sql_id='&sql_id';
