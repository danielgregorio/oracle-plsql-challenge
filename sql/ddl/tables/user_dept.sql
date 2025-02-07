-- =========================================================
--  TABLE CREATION SCRIPTS
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script contains table definitions for
--                the Oracle challenge database.
-- =========================================================
CREATE TABLE user_dept (
    user_id NUMBER(10) NOT NULL,
    dept_id NUMBER(4) NOT NULL,
    PRIMARY KEY (user_id, dept_id),
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES item(dept_id)
);
/