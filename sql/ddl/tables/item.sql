-- =========================================================
--  TABLE CREATION SCRIPTS
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script contains table definitions for
--                the Oracle challenge database.
-- =========================================================
CREATE TABLE item (
    item_id VARCHAR2(25) NOT NULL,
    item_desc VARCHAR2(100) NOT NULL,
    PRIMARY KEY (item_id)
);
/