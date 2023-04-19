SET LINESIZE 333

SELECT
    distinct name                            group_name
  , sector_size                              sector_size
  , block_size                               block_size
  , allocation_unit_size                  allocation_unit_size
  , state                                        state
  , type                                         type
  , round(total_mb/1024)                              "total_gb"
  , round(free_mb/1024)                               "free_gb"
  , round((total_mb - free_mb) / 1024)          "used_gb"
  , round((1- (free_mb / total_mb))*100, 2)  "pct_used"
from v$asm_diskgroup where name not like '%DSG%' and  name not like '%ACFS%' ORDER BY 10 desc;
