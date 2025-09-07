-- Add university_unit_id column to employees table
-- This allows employees to be associated with university units

USE datatables_db;

-- Add the university_unit_id column
ALTER TABLE employees 
ADD COLUMN university_unit_id INT NULL AFTER department,
ADD INDEX idx_university_unit_id (university_unit_id),
ADD FOREIGN KEY fk_employee_university_unit (university_unit_id) 
    REFERENCES university_units(id) ON DELETE SET NULL;

-- Optional: Update existing records to have some university unit associations
-- This is just sample data to make the demo work better
UPDATE employees 
SET university_unit_id = (
    SELECT id FROM university_units 
    WHERE unit_name LIKE CONCAT('%', 
        CASE 
            WHEN department LIKE '%Engineering%' OR department LIKE '%IT%' THEN 'Engineering'
            WHEN department LIKE '%Business%' OR department LIKE '%Admin%' THEN 'Business'
            WHEN department LIKE '%Research%' THEN 'Research'
            WHEN department LIKE '%Marketing%' THEN 'Marketing'
            ELSE 'General'
        END, '%')
    LIMIT 1
);
