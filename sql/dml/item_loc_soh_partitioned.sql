-- Migrando os dados da tabela original para a nova tabela particionada
INSERT INTO item_loc_soh_partitioned (item_id, loc_id, dept_id, unit_cost, stock_on_hand)
SELECT item_id, loc_id, dept_id, unit_cost, stock_on_hand
FROM item_loc_soh;
