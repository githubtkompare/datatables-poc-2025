# Database Schema Documentation

This document describes the MySQL database structure for the Software Product Tracking System, running in the `application` folder.

## Database Information

- **Database Name**: `datatables_db`
- **Character Set**: `utf8mb4`
- **Collation**: `utf8mb4_unicode_ci`
- **Engine**: InnoDB
- **MySQL Version**: 8.0+

## Table Overview

The database consists of 8 main tables and 3 views:

### Core Tables

1. [employees](#employees-table) - Employee information
2. [university_units](#university_units-table) - Organizational units
3. [software_products](#software_products-table) - Software product catalog
4. [operating_systems](#operating_systems-table) - Supported operating systems
5. [software_operating_systems](#software_operating_systems-table) - Software-OS compatibility (many-to-many)
6. [software_roles](#software_roles-table) - Software ownership and management roles

### Database Views

- [v_software_with_roles](#v_software_with_roles) - Software with role assignments
- [v_employee_roles](#v_employee_roles) - Employee role summaries
- [v_unit_software_summary](#v_unit_software_summary) - Unit software counts

---

## Table Definitions

### employees Table

Stores employee information including contact details and organizational information.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| first_name | VARCHAR(100) | NO | | NULL | |
| last_name | VARCHAR(100) | NO | MUL | NULL | |
| email | VARCHAR(255) | NO | UNI | NULL | |
| phone | VARCHAR(20) | YES | | NULL | |
| department | VARCHAR(100) | YES | MUL | NULL | |
| job_title | VARCHAR(150) | YES | | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |

**Primary Key**: `id`

**Indexes**:

- `idx_email` on `email`
- `idx_name` on `(last_name, first_name)`
- `idx_department` on `department`

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

Catalog of software products with vendor and licensing information.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| software_name | VARCHAR(200) | NO | MUL | NULL | |
| version | VARCHAR(50) | YES | | NULL | |
| description | TEXT | YES | | NULL | |
| vendor_managed | TINYINT(1) | YES | MUL | 0 | |
| vendor_name | VARCHAR(200) | YES | MUL | NULL | |
| license_type | VARCHAR(100) | YES | | NULL | |
| installation_notes | TEXT | YES | | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |

**Primary Key**: `id`

**Indexes**:

- `idx_software_name` on `software_name`
- `idx_vendor_managed` on `vendor_managed`
- `idx_vendor_name` on `vendor_name`

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

Defines business and technical ownership roles for each software product.

| Field | Data Type | Null | Key | Default | Extra |
|-------|-----------|------|-----|---------|-------|
| id | INT | NO | PRI | NULL | auto_increment |
| software_id | INT | NO | UNI | NULL | |
| business_owner_id | INT | YES | MUL | NULL | |
| technical_owner_id | INT | YES | MUL | NULL | |
| technical_manager_id | INT | YES | MUL | NULL | |
| created_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | TIMESTAMP | YES | | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update |

**Primary Key**: `id`

**Foreign Keys**:

- `software_id` → `software_products(id)` ON DELETE CASCADE
- `business_owner_id` → `employees(id)` ON DELETE SET NULL
- `technical_owner_id` → `employees(id)` ON DELETE SET NULL
- `technical_manager_id` → `employees(id)` ON DELETE SET NULL

**Unique Constraints**:

- `unique_software_roles` on `software_id` (one role record per software)

---

## Views Reference

The database includes three views that provide convenient access to commonly queried data:

### v_software_with_roles

Combines software products with their assigned roles and employee details.

### v_employee_roles

Summarizes role counts per employee (business owner, technical owner, technical manager).

### v_unit_software_summary

Provides software counts per university unit, including active vs total software assignments.

---

## Entity Relationships

### Primary Relationships

1. **Employees → Software Roles**: One-to-many relationship where employees can have multiple role assignments
2. **Software Products → Software Roles**: One-to-one relationship where each software has exactly one role assignment record
3. **Software Products ↔ Operating Systems**: Many-to-many relationship through `software_operating_systems`
4. **University Units**: Self-referencing hierarchy through `parent_unit_id`

### Cascade Behavior

- **ON DELETE CASCADE**: Deleting a software product will automatically remove all related records in junction tables
- **ON DELETE SET NULL**: Deleting an employee or parent unit will set foreign key references to NULL rather than failing

### Data Integrity

- All tables use InnoDB engine for ACID compliance and foreign key support
- Unique constraints prevent duplicate relationships
- Enum fields constrain values to valid options
- Timestamp fields automatically track creation and modification times
