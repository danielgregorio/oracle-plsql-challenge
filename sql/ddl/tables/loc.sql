-- =========================================================
--  TABLE CREATION SCRIPTS
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script contains table definitions for
--                the Oracle challenge database.
-- =========================================================
CREATE TABLE loc (
    loc_id NUMBER(10) NOT NULL,
    loc_desc VARCHAR2(100) NOT NULL,
    PRIMARY KEY (loc_id)
);
/