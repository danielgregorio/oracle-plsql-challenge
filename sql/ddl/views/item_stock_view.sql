-- =========================================================
--  VIEWS FOR OPTIMIZED QUERIES
-- =========================================================
--  Author      : Daniel Gregorio
--  Created On  : 2025-02-07
--  Description : This script defines views for simplified and
--                optimized queries.
-- =========================================================
CREATE VIEW item_stock_view AS
    SELECT 
        i.item_id, 
        i.item_desc, 
        l.loc_desc, 
        s.unit_cost, 
        s.stock_on_hand
    FROM item i
    JOIN item_loc_soh s ON i.item_id = s.item_id
    JOIN loc l ON s.loc_id = l.loc_id;
/
