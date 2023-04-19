set linesize 200
set pages 1000
col STATUS format a15
col hrs format 999.99
col TIME_TAKEN_DISPLAY format a15
col INPUT_BYTES_PER_SEC_DISPLAY format a10
col OUTPUT_BYTES_PER_SEC_DISPLAY format a10
col START_TIME format a15
col END_TIME format a15
col INPUT_BYTES_DISPLAY format a10
col OUTPUT_BYTES_DISPLAY format a10
select
INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi') end_time,
ELAPSED_SECONDS,
elapsed_seconds/3600 hrs,
TIME_TAKEN_DISPLAY,
INPUT_BYTES_PER_SEC_DISPLAY,
OUTPUT_BYTES_PER_SEC_DISPLAY,
INPUT_BYTES_DISPLAY,
OUTPUT_BYTES_DISPLAY
from V$RMAN_BACKUP_JOB_DETAILS
where START_TIME > trunc(sysdate-14)     
order by 3 desc;
