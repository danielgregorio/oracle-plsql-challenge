-- =========================================================
--  TABLE CREATION SCRIPTS
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script contains table definitions for
--                the Oracle challenge database.
-- =========================================================

-- Table: item
CREATE TABLE item (
    item_id VARCHAR2(25) NOT NULL,
    dept_id NUMBER(4) NOT NULL,
    item_desc VARCHAR2(100) NOT NULL,
    PRIMARY KEY (item_id),
    CONSTRAINT uq_dept UNIQUE (dept_id)
);
/