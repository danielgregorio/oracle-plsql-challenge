-- =========================================================
--  LOCATION INSERTION SCRIPT
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script inserts 1,000 random records 
--                into the 'loc' table. It generates:
--                - A unique 'loc_id' starting from 101.
--                - A random 'loc_name' string of 20 characters.
-- =========================================================

insert into loc(loc_id,loc_name)
select level+100, translate(dbms_random.string('a', 20), 'abcXYZ', level) from dual connect by level <= 1000;
/


