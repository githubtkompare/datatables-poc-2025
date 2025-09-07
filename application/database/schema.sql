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
