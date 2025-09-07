-- Software Product Tracking System Database Schema
-- MySQL 8.0+ Compatible
-- 
-- This schema represents the current state of the database with 6 tables:
-- 1. university_units - Organizational units (created first due to foreign key dependencies)
-- 2. employees - Staff with university_unit_id foreign key
-- 3. software_products - Software inventory with university_unit_id foreign key  
-- 4. operating_systems - Supported operating systems
-- 5. software_operating_systems - Software-OS compatibility (many-to-many)
-- 6. software_roles - Software ownership and management roles

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Create database (if not exists via Docker environment)
CREATE DATABASE IF NOT EXISTS datatables_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE datatables_db;

-- 1. University Units Table
CREATE TABLE university_units (
    id INT AUTO_INCREMENT PRIMARY KEY,
    unit_name VARCHAR(200) NOT NULL,
    unit_code VARCHAR(50) UNIQUE,
    description TEXT,
    parent_unit_id INT NULL,
    unit_type ENUM('department', 'college', 'administrative', 'support', 'research') DEFAULT 'department',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_unit_id) REFERENCES university_units(id) ON DELETE SET NULL,
    INDEX idx_unit_name (unit_name),
    INDEX idx_unit_code (unit_code),
    INDEX idx_unit_type (unit_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Employees Table
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    university_unit_id INT NULL,
    job_title VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_name (last_name, first_name),
    INDEX idx_university_unit_id (university_unit_id),
    FOREIGN KEY (university_unit_id) REFERENCES university_units(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Software Products Table
CREATE TABLE software_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    software_name VARCHAR(200) NOT NULL,
    version VARCHAR(50),
    description TEXT,
    vendor_managed BOOLEAN DEFAULT FALSE,
    vendor_name VARCHAR(200),
    license_type VARCHAR(100),
    installation_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    university_unit_id INT NULL,
    INDEX idx_software_name (software_name),
    INDEX idx_vendor_managed (vendor_managed),
    INDEX idx_vendor_name (vendor_name),
    INDEX fk_software_university_unit (university_unit_id),
    FOREIGN KEY fk_software_university_unit (university_unit_id) REFERENCES university_units(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Operating Systems Table
CREATE TABLE operating_systems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    os_name VARCHAR(100) NOT NULL UNIQUE,
    os_version VARCHAR(50),
    os_family ENUM('Windows', 'macOS', 'Linux', 'Unix', 'Other') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_os_name (os_name),
    INDEX idx_os_family (os_family)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Software Operating Systems (Many-to-Many)
CREATE TABLE software_operating_systems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    software_id INT NOT NULL,
    os_id INT NOT NULL,
    minimum_version VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (software_id) REFERENCES software_products(id) ON DELETE CASCADE,
    FOREIGN KEY (os_id) REFERENCES operating_systems(id) ON DELETE CASCADE,
    UNIQUE KEY unique_software_os (software_id, os_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Software Roles Table  
-- Updated: Removed unique constraint to allow multiple instances of same software
-- Updated: All role fields are now required (NOT NULL)
CREATE TABLE software_roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    software_id INT NOT NULL,
    business_owner_id INT NOT NULL,
    technical_owner_id INT NOT NULL,
    technical_manager_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (software_id) REFERENCES software_products(id) ON DELETE CASCADE,
    FOREIGN KEY (business_owner_id) REFERENCES employees(id) ON DELETE RESTRICT,
    FOREIGN KEY (technical_owner_id) REFERENCES employees(id) ON DELETE RESTRICT,
    FOREIGN KEY (technical_manager_id) REFERENCES employees(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- STORED PROCEDURES
-- =============================================================================
-- Added: September 7, 2025
-- Purpose: Replace complex SQL queries in PHP models with stored procedures
-- Benefits: Enhanced security, performance, and maintainability

DELIMITER //

-- =============================================================================
-- EMPLOYEE PROCEDURES
-- =============================================================================

-- Get all employees with pagination, search, and sorting
DROP PROCEDURE IF EXISTS sp_get_all_employees//
CREATE PROCEDURE sp_get_all_employees(
    IN p_limit INT,
    IN p_offset INT, 
    IN p_search VARCHAR(255),
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE where_clause TEXT DEFAULT '';
    DECLARE order_clause TEXT DEFAULT ' ORDER BY e.updated_at DESC';
    DECLARE limit_clause TEXT DEFAULT '';
    
    -- Build base query
    SET sql_query = 'SELECT 
                        e.id,
                        e.first_name,
                        e.last_name,
                        e.email,
                        e.phone,
                        e.university_unit_id,
                        e.job_title,
                        e.created_at,
                        e.updated_at,
                        u.unit_name as university_unit_name,
                        COUNT(DISTINCT CASE WHEN sr.business_owner_id = e.id THEN sr.software_id END) as business_owner_count,
                        COUNT(DISTINCT CASE WHEN sr.technical_owner_id = e.id THEN sr.software_id END) as technical_owner_count,
                        COUNT(DISTINCT CASE WHEN sr.technical_manager_id = e.id THEN sr.software_id END) as technical_manager_count
                    FROM employees e
                    LEFT JOIN university_units u ON e.university_unit_id = u.id
                    LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)';
    
    -- Add search condition
    IF p_search IS NOT NULL AND p_search != '' THEN
        SET where_clause = CONCAT(' WHERE (e.first_name LIKE ''%', p_search, '%'' OR e.last_name LIKE ''%', p_search, '%'' OR e.email LIKE ''%', p_search, '%'' OR u.unit_name LIKE ''%', p_search, '%'')');
    END IF;
    
    -- Add GROUP BY
    SET sql_query = CONCAT(sql_query, where_clause, ' GROUP BY e.id, e.first_name, e.last_name, e.email, e.phone, e.university_unit_id, e.job_title, e.created_at, e.updated_at, u.unit_name');
    
    -- Add ordering
    IF p_order_by IS NOT NULL THEN
        CASE p_order_by
            WHEN 'name' THEN SET order_clause = CONCAT(' ORDER BY CONCAT(e.first_name, '' '', e.last_name) ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'first_name' THEN SET order_clause = CONCAT(' ORDER BY e.first_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'last_name' THEN SET order_clause = CONCAT(' ORDER BY e.last_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'email' THEN SET order_clause = CONCAT(' ORDER BY e.email ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'phone' THEN SET order_clause = CONCAT(' ORDER BY e.phone ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'university_unit_name' THEN SET order_clause = CONCAT(' ORDER BY u.unit_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'job_title' THEN SET order_clause = CONCAT(' ORDER BY e.job_title ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'created_at' THEN SET order_clause = CONCAT(' ORDER BY e.created_at ', IFNULL(p_order_dir, 'ASC'));
            ELSE SET order_clause = ' ORDER BY e.updated_at DESC';
        END CASE;
    END IF;
    
    -- Add limit and offset
    IF p_limit IS NOT NULL AND p_limit > 0 THEN
        SET limit_clause = CONCAT(' LIMIT ', p_limit);
        IF p_offset IS NOT NULL AND p_offset > 0 THEN
            SET limit_clause = CONCAT(limit_clause, ' OFFSET ', p_offset);
        END IF;
    END IF;
    
    -- Execute dynamic query
    SET @sql = CONCAT(sql_query, order_clause, limit_clause);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

-- Get employee by ID
DROP PROCEDURE IF EXISTS sp_get_employee_by_id//
CREATE PROCEDURE sp_get_employee_by_id(
    IN p_employee_id INT
)
BEGIN
    SELECT e.*, u.unit_name as university_unit_name 
    FROM employees e 
    LEFT JOIN university_units u ON e.university_unit_id = u.id 
    WHERE e.id = p_employee_id;
END//

-- Get employee software roles
DROP PROCEDURE IF EXISTS sp_get_employee_software_roles//
CREATE PROCEDURE sp_get_employee_software_roles(
    IN p_employee_id INT
)
BEGIN
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        'Business Owner' as role_type
    FROM software_products sp
    JOIN software_roles sr ON sp.id = sr.software_id
    WHERE sr.business_owner_id = p_employee_id
    
    UNION ALL
    
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        'Technical Owner' as role_type
    FROM software_products sp
    JOIN software_roles sr ON sp.id = sr.software_id
    WHERE sr.technical_owner_id = p_employee_id
    
    UNION ALL
    
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        'Technical Manager' as role_type
    FROM software_products sp
    JOIN software_roles sr ON sp.id = sr.software_id
    WHERE sr.technical_manager_id = p_employee_id
    
    ORDER BY software_name, role_type;
END//

-- Create employee
DROP PROCEDURE IF EXISTS sp_create_employee//
CREATE PROCEDURE sp_create_employee(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_university_unit_id INT,
    IN p_job_title VARCHAR(150),
    OUT p_employee_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_employee_id = NULL;
    END;
    
    START TRANSACTION;
    
    INSERT INTO employees (first_name, last_name, email, phone, university_unit_id, job_title) 
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_university_unit_id, p_job_title);
    
    SET p_employee_id = LAST_INSERT_ID();
    
    COMMIT;
END//

-- Update employee
DROP PROCEDURE IF EXISTS sp_update_employee//
CREATE PROCEDURE sp_update_employee(
    IN p_employee_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_university_unit_id INT,
    IN p_job_title VARCHAR(150),
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    UPDATE employees 
    SET first_name = p_first_name, 
        last_name = p_last_name, 
        email = p_email, 
        phone = p_phone, 
        university_unit_id = p_university_unit_id,
        job_title = p_job_title,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_employee_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END//

-- Delete employee (with role cleanup)
DROP PROCEDURE IF EXISTS sp_delete_employee//
CREATE PROCEDURE sp_delete_employee(
    IN p_employee_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    -- Remove the employee from any software role assignments
    UPDATE software_roles SET business_owner_id = NULL WHERE business_owner_id = p_employee_id;
    UPDATE software_roles SET technical_owner_id = NULL WHERE technical_owner_id = p_employee_id;
    UPDATE software_roles SET technical_manager_id = NULL WHERE technical_manager_id = p_employee_id;
    
    -- Delete the employee
    DELETE FROM employees WHERE id = p_employee_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END//

-- Get employee total count
DROP PROCEDURE IF EXISTS sp_get_employee_total_count//
CREATE PROCEDURE sp_get_employee_total_count(
    IN p_search VARCHAR(255),
    OUT p_total_count INT
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT COUNT(DISTINCT e.id) INTO p_total_count
        FROM employees e
        LEFT JOIN university_units u ON e.university_unit_id = u.id
        WHERE (e.first_name LIKE CONCAT('%', p_search, '%') 
               OR e.last_name LIKE CONCAT('%', p_search, '%') 
               OR e.email LIKE CONCAT('%', p_search, '%') 
               OR u.unit_name LIKE CONCAT('%', p_search, '%'));
    ELSE
        SELECT COUNT(*) INTO p_total_count FROM employees;
    END IF;
END//

-- =============================================================================
-- SOFTWARE PRODUCT PROCEDURES
-- =============================================================================

-- Get all software with pagination, search, and sorting
DROP PROCEDURE IF EXISTS sp_get_all_software//
CREATE PROCEDURE sp_get_all_software(
    IN p_limit INT,
    IN p_offset INT,
    IN p_search VARCHAR(255),
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE where_clause TEXT DEFAULT '';
    DECLARE order_clause TEXT DEFAULT ' ORDER BY sp.updated_at DESC';
    DECLARE limit_clause TEXT DEFAULT '';
    
    SET sql_query = 'SELECT 
                        sp.id,
                        sp.software_name,
                        sp.version,
                        sp.description,
                        sp.vendor_managed,
                        sp.vendor_name,
                        sp.license_type,
                        sp.created_at,
                        sp.updated_at,
                        bo_unit.unit_name as university_unit,
                        bo_unit.unit_code as university_unit_code,
                        CASE WHEN bo_unit.id IS NOT NULL THEN 1 ELSE 0 END as unit_count,
                        CONCAT(bo.first_name, '' '', bo.last_name) as business_owner,
                        bo.email as business_owner_email,
                        bo_unit.unit_name as business_owner_department,
                        CONCAT(to_emp.first_name, '' '', to_emp.last_name) as technical_owner,
                        to_emp.email as technical_owner_email,
                        CONCAT(tm.first_name, '' '', tm.last_name) as technical_manager,
                        tm.email as technical_manager_email,
                        GROUP_CONCAT(DISTINCT os.os_name ORDER BY os.os_name SEPARATOR '', '') as operating_systems,
                        CASE WHEN sr.business_owner_id IS NULL THEN 1 ELSE 0 END as missing_business_owner,
                        CASE WHEN sr.technical_owner_id IS NULL THEN 1 ELSE 0 END as missing_technical_owner,
                        CASE WHEN sr.technical_manager_id IS NULL THEN 1 ELSE 0 END as missing_technical_manager,
                        CASE WHEN sr.id IS NULL THEN 1 ELSE 0 END as missing_roles_record
                    FROM software_products sp
                    LEFT JOIN software_roles sr ON sp.id = sr.software_id
                    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
                    LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
                    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
                    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
                    LEFT JOIN software_operating_systems sos ON sp.id = sos.software_id
                    LEFT JOIN operating_systems os ON sos.os_id = os.id';
    
    -- Add search condition
    IF p_search IS NOT NULL AND p_search != '' THEN
        SET where_clause = CONCAT(' WHERE (sp.software_name LIKE ''%', p_search, '%'' OR sp.vendor_name LIKE ''%', p_search, '%'' OR sp.description LIKE ''%', p_search, '%'' OR bo_unit.unit_name LIKE ''%', p_search, '%'' OR CONCAT(bo.first_name, '' '', bo.last_name) LIKE ''%', p_search, '%'')');
    END IF;
    
    -- Add GROUP BY
    SET sql_query = CONCAT(sql_query, where_clause, ' GROUP BY sp.id, sp.software_name, sp.version, sp.description, sp.vendor_managed, sp.vendor_name, sp.license_type, sp.created_at, sp.updated_at, bo_unit.unit_name, bo_unit.unit_code, bo.first_name, bo.last_name, bo.email, bo_unit.unit_name, to_emp.first_name, to_emp.last_name, to_emp.email, tm.first_name, tm.last_name, tm.email, sr.id, sr.business_owner_id, sr.technical_owner_id, sr.technical_manager_id');
    
    -- Add ordering (simplified for stored procedure)
    IF p_order_by IS NOT NULL AND p_order_dir IS NOT NULL THEN
        SET order_clause = CONCAT(' ORDER BY ', p_order_by, ' ', p_order_dir);
    END IF;
    
    -- Add limit and offset
    IF p_limit IS NOT NULL AND p_limit > 0 THEN
        SET limit_clause = CONCAT(' LIMIT ', p_limit);
        IF p_offset IS NOT NULL AND p_offset > 0 THEN
            SET limit_clause = CONCAT(limit_clause, ' OFFSET ', p_offset);
        END IF;
    END IF;
    
    -- Execute dynamic query
    SET @sql = CONCAT(sql_query, order_clause, limit_clause);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

-- Get software by ID
DROP PROCEDURE IF EXISTS sp_get_software_by_id//
CREATE PROCEDURE sp_get_software_by_id(
    IN p_software_id INT
)
BEGIN
    SELECT sp.*, 
           u.unit_name as university_unit,
           u.unit_code as university_unit_code,
           u.unit_type as university_unit_type,
           CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
           CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
           CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager,
           sr.business_owner_id,
           sr.technical_owner_id,
           sr.technical_manager_id,
           bo.first_name as business_owner_first_name,
           bo.last_name as business_owner_last_name,
           bo.email as business_owner_email,
           bo_unit.unit_name as business_owner_department,
           to_emp.first_name as technical_owner_first_name,
           to_emp.last_name as technical_owner_last_name,
           to_emp.email as technical_owner_email,
           tm.first_name as technical_manager_first_name,
           tm.last_name as technical_manager_last_name,
           tm.email as technical_manager_email
    FROM software_products sp
    LEFT JOIN university_units u ON sp.university_unit_id = u.id
    LEFT JOIN software_roles sr ON sp.id = sr.software_id
    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
    LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
    WHERE sp.id = p_software_id;
END//

-- Get software operating systems
DROP PROCEDURE IF EXISTS sp_get_software_operating_systems//
CREATE PROCEDURE sp_get_software_operating_systems(
    IN p_software_id INT
)
BEGIN
    SELECT os.id, os.os_name, os.os_version, os.os_family
    FROM operating_systems os
    JOIN software_operating_systems sos ON os.id = sos.os_id
    WHERE sos.software_id = p_software_id
    ORDER BY os.os_name;
END//

-- Get software unit information
DROP PROCEDURE IF EXISTS sp_get_software_unit//
CREATE PROCEDURE sp_get_software_unit(
    IN p_software_id INT
)
BEGIN
    SELECT u.id, u.unit_name, u.unit_code, u.unit_type
    FROM software_products sp
    LEFT JOIN university_units u ON sp.university_unit_id = u.id
    WHERE sp.id = p_software_id;
END//

-- Create software with roles
DROP PROCEDURE IF EXISTS sp_create_software//
CREATE PROCEDURE sp_create_software(
    IN p_software_name VARCHAR(200),
    IN p_version VARCHAR(50),
    IN p_description TEXT,
    IN p_vendor_managed BOOLEAN,
    IN p_vendor_name VARCHAR(200),
    IN p_license_type VARCHAR(100),
    IN p_installation_notes TEXT,
    IN p_business_owner_id INT,
    IN p_technical_owner_id INT,
    IN p_technical_manager_id INT,
    OUT p_software_id INT
)
BEGIN
    DECLARE v_university_unit_id INT DEFAULT NULL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_software_id = NULL;
    END;
    
    START TRANSACTION;
    
    -- Get university unit from business owner
    SELECT university_unit_id INTO v_university_unit_id
    FROM employees 
    WHERE id = p_business_owner_id;
    
    -- Insert software product
    INSERT INTO software_products (software_name, version, description, vendor_managed, vendor_name, license_type, installation_notes, university_unit_id) 
    VALUES (p_software_name, p_version, p_description, p_vendor_managed, p_vendor_name, p_license_type, p_installation_notes, v_university_unit_id);
    
    SET p_software_id = LAST_INSERT_ID();
    
    -- Insert software roles
    INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) 
    VALUES (p_software_id, p_business_owner_id, p_technical_owner_id, p_technical_manager_id);
    
    COMMIT;
END//

-- Update software with roles
DROP PROCEDURE IF EXISTS sp_update_software//
CREATE PROCEDURE sp_update_software(
    IN p_software_id INT,
    IN p_software_name VARCHAR(200),
    IN p_version VARCHAR(50),
    IN p_description TEXT,
    IN p_vendor_managed BOOLEAN,
    IN p_vendor_name VARCHAR(200),
    IN p_license_type VARCHAR(100),
    IN p_installation_notes TEXT,
    IN p_business_owner_id INT,
    IN p_technical_owner_id INT,
    IN p_technical_manager_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE v_university_unit_id INT DEFAULT NULL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    -- Get university unit from business owner
    SELECT university_unit_id INTO v_university_unit_id
    FROM employees 
    WHERE id = p_business_owner_id;
    
    -- Update software product
    UPDATE software_products 
    SET software_name = p_software_name, 
        version = p_version, 
        description = p_description, 
        vendor_managed = p_vendor_managed, 
        vendor_name = p_vendor_name, 
        license_type = p_license_type,
        installation_notes = p_installation_notes,
        university_unit_id = v_university_unit_id,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_software_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    -- Update software roles (delete and recreate)
    DELETE FROM software_roles WHERE software_id = p_software_id;
    
    INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) 
    VALUES (p_software_id, p_business_owner_id, p_technical_owner_id, p_technical_manager_id);
    
    COMMIT;
END//

-- Delete software
DROP PROCEDURE IF EXISTS sp_delete_software//
CREATE PROCEDURE sp_delete_software(
    IN p_software_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    DELETE FROM software_products WHERE id = p_software_id;
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END//

-- Get software total count
DROP PROCEDURE IF EXISTS sp_get_software_total_count//
CREATE PROCEDURE sp_get_software_total_count(
    IN p_search VARCHAR(255),
    OUT p_total_count INT
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT COUNT(DISTINCT sp.id) INTO p_total_count
        FROM software_products sp
        LEFT JOIN university_units u ON sp.university_unit_id = u.id
        LEFT JOIN software_roles sr ON sp.id = sr.software_id
        LEFT JOIN employees bo ON sr.business_owner_id = bo.id
        LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
        WHERE (sp.software_name LIKE CONCAT('%', p_search, '%') 
               OR sp.vendor_name LIKE CONCAT('%', p_search, '%') 
               OR sp.description LIKE CONCAT('%', p_search, '%') 
               OR u.unit_name LIKE CONCAT('%', p_search, '%') 
               OR CONCAT(bo.first_name, ' ', bo.last_name) LIKE CONCAT('%', p_search, '%'));
    ELSE
        SELECT COUNT(*) INTO p_total_count FROM software_products;
    END IF;
END//

-- Get unique software names
DROP PROCEDURE IF EXISTS sp_get_unique_software_names//
CREATE PROCEDURE sp_get_unique_software_names(
    IN p_search VARCHAR(255)
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT DISTINCT software_name 
        FROM software_products 
        WHERE software_name LIKE CONCAT('%', p_search, '%')
        ORDER BY software_name ASC 
        LIMIT 5;
    ELSE
        SELECT DISTINCT software_name 
        FROM software_products 
        ORDER BY software_name ASC 
        LIMIT 5;
    END IF;
END//

-- =============================================================================
-- UNIVERSITY UNIT PROCEDURES
-- =============================================================================

-- Get all university units with pagination, search, and sorting
DROP PROCEDURE IF EXISTS sp_get_all_units//
CREATE PROCEDURE sp_get_all_units(
    IN p_limit INT,
    IN p_offset INT,
    IN p_search VARCHAR(255),
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE where_clause TEXT DEFAULT '';
    DECLARE order_clause TEXT DEFAULT ' ORDER BY u.updated_at DESC';
    DECLARE limit_clause TEXT DEFAULT '';
    
    SET sql_query = 'SELECT 
                        u.id,
                        u.unit_name,
                        u.unit_code,
                        u.description,
                        u.unit_type,
                        u.created_at,
                        u.updated_at,
                        parent.unit_name as parent_unit_name,
                        COUNT(DISTINCT sp.id) as software_count,
                        COUNT(DISTINCT sp.id) as active_software_count
                    FROM university_units u
                    LEFT JOIN university_units parent ON u.parent_unit_id = parent.id
                    LEFT JOIN employees e ON u.id = e.university_unit_id
                    LEFT JOIN software_roles sr ON e.id = sr.business_owner_id
                    LEFT JOIN software_products sp ON sr.software_id = sp.id';
    
    -- Add search condition
    IF p_search IS NOT NULL AND p_search != '' THEN
        SET where_clause = CONCAT(' WHERE (u.unit_name LIKE ''%', p_search, '%'' OR u.unit_code LIKE ''%', p_search, '%'' OR u.description LIKE ''%', p_search, '%'')');
    END IF;
    
    -- Add GROUP BY
    SET sql_query = CONCAT(sql_query, where_clause, ' GROUP BY u.id, u.unit_name, u.unit_code, u.description, u.unit_type, u.created_at, u.updated_at, parent.unit_name');
    
    -- Add ordering
    IF p_order_by IS NOT NULL THEN
        CASE p_order_by
            WHEN 'unit_name' THEN SET order_clause = CONCAT(' ORDER BY u.unit_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'unit_code' THEN SET order_clause = CONCAT(' ORDER BY u.unit_code ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'unit_type' THEN SET order_clause = CONCAT(' ORDER BY u.unit_type ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'parent_unit_name' THEN SET order_clause = CONCAT(' ORDER BY parent.unit_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'software_count' THEN SET order_clause = CONCAT(' ORDER BY software_count ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'updated_at' THEN SET order_clause = CONCAT(' ORDER BY u.updated_at ', IFNULL(p_order_dir, 'ASC'));
            ELSE SET order_clause = ' ORDER BY u.updated_at DESC';
        END CASE;
    END IF;
    
    -- Add limit and offset
    IF p_limit IS NOT NULL AND p_limit > 0 THEN
        SET limit_clause = CONCAT(' LIMIT ', p_limit);
        IF p_offset IS NOT NULL AND p_offset > 0 THEN
            SET limit_clause = CONCAT(limit_clause, ' OFFSET ', p_offset);
        END IF;
    END IF;
    
    -- Execute dynamic query
    SET @sql = CONCAT(sql_query, order_clause, limit_clause);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END//

-- Get unit by ID
DROP PROCEDURE IF EXISTS sp_get_unit_by_id//
CREATE PROCEDURE sp_get_unit_by_id(
    IN p_unit_id INT
)
BEGIN
    SELECT u.*, parent.unit_name as parent_unit_name
    FROM university_units u
    LEFT JOIN university_units parent ON u.parent_unit_id = parent.id
    WHERE u.id = p_unit_id;
END//

-- Get unit software
DROP PROCEDURE IF EXISTS sp_get_unit_software//
CREATE PROCEDURE sp_get_unit_software(
    IN p_unit_id INT
)
BEGIN
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        sp.created_at,
        CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
        CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
        CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager
    FROM software_products sp
    LEFT JOIN software_roles sr ON sp.id = sr.software_id
    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
    WHERE sp.university_unit_id = p_unit_id
    ORDER BY sp.software_name, sp.version;
END//

-- Create university unit
DROP PROCEDURE IF EXISTS sp_create_unit//
CREATE PROCEDURE sp_create_unit(
    IN p_unit_name VARCHAR(200),
    IN p_unit_code VARCHAR(50),
    IN p_description TEXT,
    IN p_parent_unit_id INT,
    IN p_unit_type VARCHAR(20),
    OUT p_unit_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_unit_id = NULL;
    END;
    
    START TRANSACTION;
    
    INSERT INTO university_units (unit_name, unit_code, description, parent_unit_id, unit_type) 
    VALUES (p_unit_name, p_unit_code, p_description, p_parent_unit_id, p_unit_type);
    
    SET p_unit_id = LAST_INSERT_ID();
    
    COMMIT;
END//

-- Update university unit
DROP PROCEDURE IF EXISTS sp_update_unit//
CREATE PROCEDURE sp_update_unit(
    IN p_unit_id INT,
    IN p_unit_name VARCHAR(200),
    IN p_unit_code VARCHAR(50),
    IN p_description TEXT,
    IN p_parent_unit_id INT,
    IN p_unit_type VARCHAR(20),
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    UPDATE university_units 
    SET unit_name = p_unit_name, 
        unit_code = p_unit_code, 
        description = p_description, 
        parent_unit_id = p_parent_unit_id, 
        unit_type = p_unit_type,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_unit_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END//

-- Delete university unit
DROP PROCEDURE IF EXISTS sp_delete_unit//
CREATE PROCEDURE sp_delete_unit(
    IN p_unit_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    DELETE FROM university_units WHERE id = p_unit_id;
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END//

-- Get university unit total count
DROP PROCEDURE IF EXISTS sp_get_unit_total_count//
CREATE PROCEDURE sp_get_unit_total_count(
    IN p_search VARCHAR(255),
    OUT p_total_count INT
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT COUNT(*) INTO p_total_count 
        FROM university_units 
        WHERE (unit_name LIKE CONCAT('%', p_search, '%') 
               OR unit_code LIKE CONCAT('%', p_search, '%') 
               OR description LIKE CONCAT('%', p_search, '%'));
    ELSE
        SELECT COUNT(*) INTO p_total_count FROM university_units;
    END IF;
END//

-- Get all units for dropdown
DROP PROCEDURE IF EXISTS sp_get_all_units_for_dropdown//
CREATE PROCEDURE sp_get_all_units_for_dropdown()
BEGIN
    SELECT 
        id,
        unit_name,
        unit_code,
        unit_type
    FROM university_units 
    ORDER BY unit_name ASC;
END//

DELIMITER ;

-- Grant necessary permissions for stored procedures
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_all_employees TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_employee_by_id TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_employee_software_roles TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_create_employee TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_update_employee TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_delete_employee TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_employee_total_count TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_all_software TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_software_by_id TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_software_operating_systems TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_create_software TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_update_software TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_delete_software TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_software_total_count TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_all_units TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_unit_by_id TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_unit_software TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_create_unit TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_update_unit TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_delete_unit TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_unit_total_count TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_all_units_for_dropdown TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_software_unit TO 'datatables_user'@'%';
GRANT EXECUTE ON PROCEDURE datatables_db.sp_get_unique_software_names TO 'datatables_user'@'%';
