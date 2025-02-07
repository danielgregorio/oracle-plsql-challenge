CREATE OR REPLACE PACKAGE BODY stock_management_pkg AS

  -- Procedure: Save stock history
  PROCEDURE save_item_loc_soh_history(p_loc_id NUMBER DEFAULT NULL) IS
  BEGIN
    INSERT INTO item_loc_soh_history (item_id, loc_id, dept_id, stock_on_hand, unit_cost, stock_value, created_at)
    SELECT item_id, loc_id, dept_id, stock_on_hand, unit_cost, (unit_cost * stock_on_hand), SYSTIMESTAMP
    FROM item_loc_soh
    WHERE p_loc_id IS NULL OR loc_id = p_loc_id;
    
    -- Removemos o COMMIT aqui, para que o controle de transações seja feito externamente
  END save_item_loc_soh_history;

  -- Function: Filter data by department
  FUNCTION filter_data_by_dept(p_dept_id NUMBER) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR
    SELECT item_id, loc_id, dept_id, stock_on_hand, unit_cost
    FROM item_loc_soh
    WHERE dept_id = p_dept_id;

    RETURN v_cursor;
  END filter_data_by_dept;

  -- Pipeline Function: Returns location list
  FUNCTION get_location_list RETURN SYS.ODCIVARCHAR2LIST PIPELINED IS
  BEGIN
    FOR rec IN (SELECT DISTINCT loc_id FROM item_loc_soh ORDER BY loc_id) LOOP
      PIPE ROW (rec.loc_id);
    END LOOP;
    RETURN;
  END get_location_list;

END stock_management_pkg;
/
