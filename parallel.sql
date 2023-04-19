--Finding Parallel SQL for email snap (single instance)

set linesize 200
set pages 999
col program format a25 WORD_WRAPPED
col sql_text format a50 WORD_WRAPPED
select sn.sid,sn.program,sn.SQL_HASH_VALUE, sl.SQL_TEXT SQL_TEXT
                  from v$session sn, v$sqlarea sl
                  where sn.SQL_ADDRESS = sl.ADDRESS
                  and sn.SQL_HASH_VALUE = sl.HASH_VALUE
                  and sn.sql_id is not null
                  and upper(sl.SQL_TEXT) like '%PARALLEL%'
                  and upper(sl.SQL_TEXT) not like '%ALTER SYSTEM KILL SESSION%';
