CREATE OR REPLACE PACKAGE stock_management_pkg AS
  -- Procedure to save stock history
  PROCEDURE save_item_loc_soh_history(p_loc_id NUMBER DEFAULT NULL);

  -- Function to filter data by dept_id
  FUNCTION filter_data_by_dept(p_dept_id NUMBER) RETURN SYS_REFCURSOR;

  -- Pipeline function for location dropdown list
  FUNCTION get_location_list RETURN SYS.ODCIVARCHAR2LIST PIPELINED;
  
END stock_management_pkg;
/
