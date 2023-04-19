SET LINESIZE 333
--SET PAGESIZE 9999
--SET VERIFY off
--COLUMN group_name             FORMAT a20           HEAD 'Disk Group|Name'
--COLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'
--COLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'
--COLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'
--COLUMN state                  FORMAT a11           HEAD 'State'
--COLUMN type                   FORMAT a6            HEAD 'Type'
--COLUMN total_mb               FORMAT 999,999,999   HEAD 'Total Size (GB)'
--COLUMN free_mb                FORMAT 999,999,999   HEAD 'Free Size (GB)'
--COLUMN used_mb                FORMAT 999,999,999   HEAD 'Used Size (GB)'
--COLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'

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
