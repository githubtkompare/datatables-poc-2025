# Database Schema Documentation

This document describes the MySQL database structure for the Software Product Tracking System, running in the `application` folder.

## Database Information

- **Database Name**: `datatables_db`
- **Character Set**: `utf8mb4`
- **Collation**: `utf8mb4_unicode_ci`
- **Engine**: InnoDB
- **MySQL Version**: 8.0+

## Table Overview

The database consists of 6 main tables with comprehensive stored procedure support:

### Core Tables

1. [university_units](#university_units-table) - Organizational units (created first due to foreign key dependencies)
2. [employees](#employees-table) - Employee information with university unit association
3. [software_products](#software_products-table) - Software product catalog with university unit association
4. [operating_systems](#operating_systems-table) - Supported operating systems
5. [software_operating_systems](#software_operating_systems-table) - Software-OS compatibility (many-to-many)
6. [software_roles](#software_roles-table) - Software ownership and management roles

### Database Views

No views are currently implemented. Previous views (v_software_with_roles, v_employee_roles, v_unit_software_summary) have been removed during schema migration in favor of stored procedures.

### Database Procedures

The database includes 24 comprehensive stored procedures. See the [Stored Procedures](#stored-procedures) section below for complete details.

---

## Table Definitions

### employees Table

Stores employee information including contact details and organizational association with university units.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| first_name | VARCHAR(100) | NO | | NULL | |
| last_name | VARCHAR(100) | NO | MUL | NULL | |
| email | VARCHAR(255) | NO | UNI | NULL | |
| phone | VARCHAR(20) | YES | | NULL | |
| university_unit_id | INT | YES | MUL | NULL | |
| job_title | VARCHAR(150) | YES | | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |

**Primary Key**: `id`

**Indexes**:

- `idx_email` on `email`
- `idx_name` on `(last_name, first_name)`
- `idx_university_unit_id` on `university_unit_id`

**Foreign Keys**:

- `university_unit_id` → `university_units(id)` ON DELETE SET NULL

**Relationships**: Referenced by `software_roles` table for role assignments.

---

### university_units Table

Represents organizational units within the university (departments, colleges, etc.) with hierarchical structure support.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| unit_name | VARCHAR(200) | NO | MUL | NULL | |
| unit_code | VARCHAR(50) | YES | UNI | NULL | |
| description | TEXT | YES | | NULL | |
| parent_unit_id | INT | YES | MUL | NULL | |
| unit_type | ENUM('department','college','administrative','support','research') | YES | MUL | 'department' | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |

**Primary Key**: `id`

**Foreign Keys**:

- `parent_unit_id` → `university_units(id)` ON DELETE SET NULL (self-referencing for hierarchy)

**Indexes**:

- `idx_unit_name` on `unit_name`
- `idx_unit_code` on `unit_code`
- `idx_unit_type` on `unit_type`

**Relationships**:

- Self-referencing for hierarchical structure

---

### software_products Table

Catalog of software products with vendor and licensing information, associated with university units.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| software_name | VARCHAR(200) | NO | MUL | NULL | |
| version | VARCHAR(50) | YES | | NULL | |
| description | TEXT | YES | | NULL | |
| vendor_managed | BOOLEAN | YES | MUL | FALSE | |
| vendor_name | VARCHAR(200) | YES | MUL | NULL | |
| license_type | VARCHAR(100) | YES | | NULL | |
| installation_notes | TEXT | YES | | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |
| university_unit_id | INT | YES | MUL | NULL | |

**Primary Key**: `id`

**Indexes**:

- `idx_software_name` on `software_name`
- `idx_vendor_managed` on `vendor_managed`
- `idx_vendor_name` on `vendor_name`
- `fk_software_university_unit` on `university_unit_id`

**Foreign Keys**:

- `university_unit_id` → `university_units(id)` ON DELETE SET NULL

**Relationships**: Referenced by multiple tables for software associations.

---

### operating_systems Table

Catalog of operating systems that software can run on.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| os_name | VARCHAR(100) | NO | UNI | NULL | |
| os_version | VARCHAR(50) | YES | | NULL | |
| os_family | ENUM('Windows','macOS','Linux','Unix','Other') | NO | MUL | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |

**Primary Key**: `id`

**Indexes**:

- `idx_os_name` on `os_name` (unique)
- `idx_os_family` on `os_family`

**Relationships**: Referenced by `software_operating_systems` for compatibility mapping.

---

### software_operating_systems Table

Many-to-many relationship table mapping software products to compatible operating systems.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| software_id | INT | NO | MUL | NULL | |
| os_id | INT | NO | MUL | NULL | |
| minimum_version | VARCHAR(50) | YES | | NULL | |
| notes | TEXT | YES | | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |

**Primary Key**: `id`

**Foreign Keys**:

- `software_id` → `software_products(id)` ON DELETE CASCADE
- `os_id` → `operating_systems(id)` ON DELETE CASCADE

**Unique Constraints**:

- `unique_software_os` on `(software_id, os_id)`

---

### software_roles Table

Defines business and technical ownership roles for each software product. All role fields are required.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| software_id | INT | NO | | NULL | |
| business_owner_id | INT | NO | MUL | NULL | |
| technical_owner_id | INT | NO | MUL | NULL | |
| technical_manager_id | INT | NO | MUL | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |

**Primary Key**: `id`

**Foreign Keys**:

- `software_id` → `software_products(id)` ON DELETE CASCADE
- `business_owner_id` → `employees(id)` ON DELETE RESTRICT
- `technical_owner_id` → `employees(id)` ON DELETE RESTRICT
- `technical_manager_id` → `employees(id)` ON DELETE RESTRICT

**Note**: The unique constraint on `software_id` has been removed to allow multiple role instances for the same software. All role fields are now required (NOT NULL) and use RESTRICT on delete to prevent orphaning.

---

## Views Reference

The database currently has no views implemented. Previous views (v_software_with_roles, v_employee_roles, v_unit_software_summary) have been removed during schema migration and cleanup.

---

## Stored Procedures

The database includes 24 comprehensive stored procedures for enhanced security, performance, and maintainability:

### Employee Procedures

- `sp_get_all_employees` - Paginated employee listing with search and sorting
- `sp_get_employee_by_id` - Individual employee details
- `sp_get_employee_software_roles` - Employee's software role assignments
- `sp_create_employee` - Create new employee record
- `sp_update_employee` - Update existing employee
- `sp_delete_employee` - Delete employee record
- `sp_get_employee_total_count` - Total employee count for pagination

### Software Procedures

- `sp_get_all_software` - Paginated software listing with search and sorting
- `sp_get_software_by_id` - Individual software product details
- `sp_get_software_operating_systems` - Software OS compatibility
- `sp_get_software_unit` - Software university unit association
- `sp_create_software` - Create new software product
- `sp_update_software` - Update existing software product
- `sp_delete_software` - Delete software product
- `sp_get_software_total_count` - Total software count for pagination
- `sp_get_unique_software_names` - Autocomplete suggestions

### University Unit Procedures

- `sp_get_all_units` - Paginated unit listing with search and sorting
- `sp_get_unit_by_id` - Individual unit details
- `sp_get_unit_software` - Unit's associated software products
- `sp_create_unit` - Create new university unit
- `sp_update_unit` - Update existing unit
- `sp_delete_unit` - Delete university unit
- `sp_get_unit_total_count` - Total unit count for pagination
- `sp_get_all_units_for_dropdown` - Units for form dropdowns

### Key Features

The stored procedures implement:

- **Pagination**: `LIMIT` and `OFFSET` for efficient data retrieval
- **Search**: Dynamic filtering across relevant fields
- **Sorting**: Flexible ordering by column with ASC/DESC support
- **Security**: Parameter binding to prevent SQL injection
- **Consistency**: Standardized input/output patterns across all procedures
- **Validation**: Comprehensive error handling and data validation

### Data Relationships

- **employees** → **employee_software_roles** (One-to-Many): Employee software assignments
- **software_products** → **employee_software_roles** (One-to-Many): Software role assignments
- **software_products** → **software_operating_systems** (One-to-Many): OS compatibility
- **university_units** → **software_products** (One-to-Many): Unit software ownership
- **employees** ↔ **university_units** (Many-to-Many via roles): Employee unit associations

## Security Considerations

- All user inputs are processed through stored procedures with parameter binding
- No direct SQL queries are executed from the application layer
- Stored procedures provide an additional security boundary
- Input validation is handled at both application and database levels

## Performance Optimization

- Indexed columns for efficient searching and sorting
- Stored procedures reduce network overhead
- Prepared statement benefits through procedure reuse
- Optimized queries for common operations like pagination and search

---

## Entity Relationships

### Primary Relationships

1. **Employees → University Units**: Many-to-one relationship where employees belong to organizational units
2. **Software Products → University Units**: Many-to-one relationship where software is associated with organizational units
3. **Employees → Software Roles**: One-to-many relationship where employees can have multiple role assignments
4. **Software Products → Software Roles**: One-to-many relationship where each software can have multiple role assignment records (unique constraint removed)
5. **Software Products ↔ Operating Systems**: Many-to-many relationship through `software_operating_systems`
6. **University Units**: Self-referencing hierarchy through `parent_unit_id`

### Cascade Behavior

- **ON DELETE CASCADE**: Deleting a software product will automatically remove all related records in junction tables
- **ON DELETE SET NULL**: Deleting a university unit will set foreign key references to NULL in employees and software_products tables
- **ON DELETE RESTRICT**: Deleting an employee referenced in software_roles will be prevented to maintain data integrity

### Data Integrity

- All tables use InnoDB engine for ACID compliance and foreign key support
- Unique constraints prevent duplicate relationships in junction tables
- Enum fields constrain values to valid options
- Timestamp fields automatically track creation and modification times
- Required role assignments ensure all software has proper ownership defined

---

## Schema Migration History

The database schema has undergone several migrations to reach its current state:

### Migration Files Applied

1. **`add_employee_university_unit.sql`**: Added `university_unit_id` column to the `employees` table with foreign key constraint to `university_units(id)`
2. **`remove_department_column.sql`**: Removed the deprecated `department` column from the `employees` table after migrating to university unit associations
3. **`cleanup_deprecated_objects.sql`**: Removed deprecated database objects including:
   - Views: `v_software_with_roles`, `v_employee_roles`, `v_unit_software_summary`
   - Tables: `software_unit_assignments`, `audit_log`

### Key Schema Changes

- **Employee Organization**: Migrated from a simple `department` varchar field to proper foreign key relationships with `university_units`
- **Software Organization**: Software products are now directly associated with university units via `university_unit_id`
- **Role Constraints**: Removed unique constraint on `software_roles.software_id` to allow multiple role instances per software
- **Role Requirements**: All role fields in `software_roles` are now required (NOT NULL) with RESTRICT cascade behavior
- **Simplified Structure**: Removed complex views and audit logging in favor of direct table relationships

### Current State Summary

The database is now in a simplified, normalized state with 6 core tables focused on:

- Hierarchical organizational structure via `university_units`
- Employee management with unit associations
- Software product catalog with unit associations  
- Operating system compatibility tracking
- Required role assignments for software ownership
