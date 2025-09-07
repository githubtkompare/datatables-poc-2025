-- =====================================================
-- Database Cleanup Script - Remove Deprecated Objects
-- =====================================================
-- This script removes all deprecated database tables, views, and constraints
-- that are no longer needed after migrating to the new structure where:
-- - Software products are directly linked to university units via university_unit_id
-- - Role assignments are managed through software_roles table
-- - Audit logging is not implemented

-- Drop deprecated views first (dependent on tables)
DROP VIEW IF EXISTS v_unit_software_summary;
DROP VIEW IF EXISTS v_employee_roles;
DROP VIEW IF EXISTS v_software_with_roles;

-- Drop deprecated tables (remove foreign key constraints automatically)
DROP TABLE IF EXISTS software_unit_assignments;
DROP TABLE IF EXISTS audit_log;

-- Verify cleanup
SELECT 'Cleanup completed. Remaining tables:' as Status;
SHOW TABLES;

SELECT 'Cleanup completed. Remaining views:' as Status;
SHOW FULL TABLES WHERE Table_type = 'VIEW';
