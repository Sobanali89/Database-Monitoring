set lines 9999
set pages 9999
column MESSAGE_TEXT Format a120
col ORIGINATING_TIMESTAMP Format a35
select distinct 
   originating_timestamp,
   message_text 
from 
   x$dbgalertext 
where 
   originating_timestamp > sysdate-4
and
( message_text like '%ORA-%' 
--   or 
--   message_text like '%Fatal%'
);

