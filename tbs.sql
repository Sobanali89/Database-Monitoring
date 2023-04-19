set linesize 200
set pages 25
col CUR_PCT_FULL format a10
col CUR_USAGE_PCT format a15
col PCT_FULL format a15
SELECT tablespace_name,
ROUND(SUM(total_mb)-SUM(free_mb),3) CUR_USAGE,
ROUND(SUM(total_mb),3) CUR_SZ_MB,
ROUND((SUM(total_mb)-SUM(free_mb))/SUM(total_mb)*100,3)||'%' CUR_USAGE_PCT,
ROUND(SUM(max_mb) - (SUM(total_mb)-SUM(free_mb)),3) FREE_SPACE_MB,
ROUND(SUM(max_mb),3) MAX_SZ_MB,
ROUND((SUM(total_mb)-SUM(free_mb))/SUM(max_mb)*100,3)||'%' PCT_FULL
FROM (
  SELECT tablespace_name, SUM(bytes)/1024/1024 FREE_MB,
  0 TOTAL_MB, 0 MAX_MB
  FROM dba_free_space
  GROUP BY tablespace_name
  UNION
  SELECT tablespace_name, 0 CURRENT_MB,
  SUM(bytes)/1024/1024 TOTAL_MB,
  SUM(DECODE(maxbytes,0,bytes, maxbytes))/1024/1024 MAX_MB
FROM dba_data_files
  GROUP BY tablespace_name)
--  HAVING ROUND((SUM(total_mb)-SUM(free_mb))/SUM(max_mb)*100,3) >=50
GROUP BY tablespace_name
ORDER BY ROUND((SUM(total_mb)-SUM(free_mb))/SUM(max_mb)*100,3) desc;
