-- Remove department column from employees table
-- Since we now use university_unit_id for organizational structure

USE datatables_db;

-- Remove the department column and its index
ALTER TABLE employees 
DROP INDEX idx_department,
DROP COLUMN department;
