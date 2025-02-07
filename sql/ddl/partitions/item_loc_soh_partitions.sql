-- =========================================================
--  PARTITIONING STRATEGY
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script implements table partitioning to
--                optimize concurrent access.
-- =========================================================
CREATE TABLE item_loc_soh_partitioned (
    item_id VARCHAR2(25) NOT NULL,
    loc_id NUMBER(10) NOT NULL,
    dept_id NUMBER(4) NOT NULL,
    unit_cost NUMBER(20,4) NOT NULL,
    stock_on_hand NUMBER(12,4) NOT NULL
) PARTITION BY HASH (loc_id) PARTITIONS 4;
/