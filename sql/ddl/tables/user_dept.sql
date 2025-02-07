-- =========================================================
--  TABLE CREATION SCRIPTS
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script contains table definitions for
--                the Oracle challenge database.
-- =========================================================
CREATE TABLE user_item (
    user_id NUMBER(10) NOT NULL,
    item_id VARCHAR2(25) NOT NULL,
    PRIMARY KEY (user_id, item_id),
    CONSTRAINT fk_user_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);
/