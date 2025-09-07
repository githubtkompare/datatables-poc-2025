-- Software Product Tracking System Database Schema
-- MySQL 8.0+ Compatible

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Create database (if not exists via Docker environment)
CREATE DATABASE IF NOT EXISTS datatables_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE datatables_db;

-- 1. Employees Table
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100),
    job_title VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_name (last_name, first_name),
    INDEX idx_department (department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. University Units Table
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
    INDEX idx_software_name (software_name),
    INDEX idx_vendor_managed (vendor_managed),
    INDEX idx_vendor_name (vendor_name)
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

-- 7. Software Unit Assignments (Many-to-Many)
CREATE TABLE software_unit_assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    software_id INT NOT NULL,
    unit_id INT NOT NULL,
    assignment_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('active', 'inactive', 'pending', 'retired') DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (software_id) REFERENCES software_products(id) ON DELETE CASCADE,
    FOREIGN KEY (unit_id) REFERENCES university_units(id) ON DELETE CASCADE,
    UNIQUE KEY unique_software_unit (software_id, unit_id),
    INDEX idx_status (status),
    INDEX idx_assignment_date (assignment_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Audit Log Table (for tracking changes)
CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    record_id INT NOT NULL,
    action ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values JSON,
    new_values JSON,
    changed_by VARCHAR(100),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_table_record (table_name, record_id),
    INDEX idx_action (action),
    INDEX idx_changed_at (changed_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- Create views for common queries

-- View: Software with all role assignments
CREATE VIEW v_software_with_roles AS
SELECT 
    sp.id,
    sp.software_name,
    sp.version,
    sp.vendor_managed,
    sp.vendor_name,
    CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
    bo.email as business_owner_email,
    CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
    to_emp.email as technical_owner_email,
    CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager,
    tm.email as technical_manager_email
FROM software_products sp
LEFT JOIN software_roles sr ON sp.id = sr.software_id
LEFT JOIN employees bo ON sr.business_owner_id = bo.id
LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
LEFT JOIN employees tm ON sr.technical_manager_id = tm.id;

-- View: Employee role summary
CREATE VIEW v_employee_roles AS
SELECT 
    e.id,
    e.first_name,
    e.last_name,
    e.email,
    e.department,
    COUNT(DISTINCT CASE WHEN sr.business_owner_id = e.id THEN sr.software_id END) as business_owner_count,
    COUNT(DISTINCT CASE WHEN sr.technical_owner_id = e.id THEN sr.software_id END) as technical_owner_count,
    COUNT(DISTINCT CASE WHEN sr.technical_manager_id = e.id THEN sr.software_id END) as technical_manager_count
FROM employees e
LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)
GROUP BY e.id, e.first_name, e.last_name, e.email, e.department;

-- View: Unit software summary
CREATE VIEW v_unit_software_summary AS
SELECT 
    u.id,
    u.unit_name,
    u.unit_code,
    u.unit_type,
    COUNT(sua.software_id) as software_count,
    COUNT(CASE WHEN sua.status = 'active' THEN 1 END) as active_software_count
FROM university_units u
LEFT JOIN software_unit_assignments sua ON u.id = sua.unit_id
GROUP BY u.id, u.unit_name, u.unit_code, u.unit_type;
