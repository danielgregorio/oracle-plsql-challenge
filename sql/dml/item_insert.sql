-- =========================================================
--  ITEM INSERTION SCRIPT
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script inserts 10,000 random records 
--                into the 'item' table. It generates:
--                - A unique 'item_id' using SYS_GUID().
--                - A random 'dept_id' between 1 and 100.
--                - A random 20-character 'item_desc' string.
-- =========================================================

INSERT INTO item (item_id, dept_id, item_desc)
SELECT SUBSTR(SYS_GUID(), 1, 25),  -- Limita o GUID para 25 caracteres
       ROUND(DBMS_RANDOM.VALUE(1, 100)), 
       TRANSLATE(DBMS_RANDOM.STRING('a', 20), 'abcXYZ', LEVEL)
FROM dual
CONNECT BY LEVEL <= 10000;
/
