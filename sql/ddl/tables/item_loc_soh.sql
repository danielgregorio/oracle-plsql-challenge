-- =========================================================
--  TABLE CREATION SCRIPTS
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script contains table definitions for
--                the Oracle challenge database.
-- =========================================================
CREATE TABLE item_loc_soh (
    item_id VARCHAR2(25) NOT NULL,
    loc_id NUMBER(10) NOT NULL,
    unit_cost NUMBER(20,4) NOT NULL,
    stock_on_hand NUMBER(12,4) NOT NULL,
    PRIMARY KEY (item_id, loc_id),
    CONSTRAINT fk_item_loc_soh_item FOREIGN KEY (item_id) REFERENCES item(item_id),
    CONSTRAINT fk_item_loc_soh_loc FOREIGN KEY (loc_id) REFERENCES loc(loc_id)
);

/

