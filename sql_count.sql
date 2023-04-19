--Finding count of Most executed SQL

select inst_id,sql_hash_value, count(*) from gv$session
where status = 'ACTIVE' group by inst_id, sql_hash_value order by 3 desc;

