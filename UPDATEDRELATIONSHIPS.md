# Database Update Instructions

This document provides structured instructions for updating the database schema and data according to new requirements. Follow these steps in order to ensure data integrity and proper relationship maintenance.

## Prerequisites

Before making any database changes:

1. **Backup Current Database**

   ```bash
   docker exec datatables_mysql mysqldump -u root -proot_password datatables_db > backup_$(date +%Y%m%d_%H%M%S).sql
   ```

2. **Verify Current Schema State**

   ```bash
   docker exec datatables_mysql mysql -u root -proot_password datatables_db -e "SHOW TABLES;"
   ```

3. **Check Existing Data Counts**

   ```bash
   docker exec datatables_mysql mysql -u root -proot_password datatables_db -e "
   SELECT 'employees' as table_name, COUNT(*) as record_count FROM employees
   UNION ALL
   SELECT 'university_units', COUNT(*) FROM university_units
   UNION ALL
   SELECT 'software_products', COUNT(*) FROM software_products
   UNION ALL
   SELECT 'software_roles', COUNT(*) FROM software_roles;"
   ```

## Database Update Process

### Step 1: Schema Analysis and Planning

1. **Identify New Requirements**
   - Document all new fields, tables, or relationships needed
   - Identify any breaking changes that require data migration
   - Plan for backward compatibility if needed

2. **Review Current Relationships**
   - Verify existing foreign key constraints
   - Check for orphaned records that might prevent updates
   - Document any relationship changes needed

### Step 2: Schema Modifications

#### Adding New Tables

```sql
-- Template for new table creation
CREATE TABLE new_table_name (
    id INT AUTO_INCREMENT PRIMARY KEY,
    -- Add columns here
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- Add foreign keys and indexes
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### Modifying Existing Tables

```sql
-- Template for adding columns
ALTER TABLE existing_table 
ADD COLUMN new_column_name DATA_TYPE [CONSTRAINTS];

-- Template for modifying columns
ALTER TABLE existing_table 
MODIFY COLUMN existing_column NEW_DATA_TYPE [CONSTRAINTS];

-- Template for adding indexes
CREATE INDEX idx_column_name ON table_name(column_name);

-- Template for adding foreign keys
ALTER TABLE table_name 
ADD CONSTRAINT fk_constraint_name 
FOREIGN KEY (column_name) REFERENCES referenced_table(id);
```

### Step 3: Data Migration

#### Backup Critical Data Before Migration

```sql
-- Create temporary backup tables for critical data
CREATE TABLE employees_backup AS SELECT * FROM employees;
CREATE TABLE software_products_backup AS SELECT * FROM software_products;
CREATE TABLE software_roles_backup AS SELECT * FROM software_roles;
```

#### Data Transformation Scripts

```sql
-- Template for data migration
INSERT INTO new_table (column1, column2, ...)
SELECT transformed_column1, transformed_column2, ...
FROM old_table
WHERE conditions;

-- Template for updating existing data
UPDATE existing_table 
SET column_name = new_value
WHERE conditions;
```

### Step 4: Relationship Updates

#### Adding New Relationships

```sql
-- For many-to-many relationships
CREATE TABLE entity1_entity2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity1_id INT NOT NULL,
    entity2_id INT NOT NULL,
    -- Additional relationship attributes
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (entity1_id) REFERENCES entity1(id) ON DELETE CASCADE,
    FOREIGN KEY (entity2_id) REFERENCES entity2(id) ON DELETE CASCADE,
    UNIQUE KEY unique_relationship (entity1_id, entity2_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

#### Updating Foreign Key Constraints

```sql
-- Drop existing constraint
ALTER TABLE table_name DROP FOREIGN KEY constraint_name;

-- Add new constraint
ALTER TABLE table_name 
ADD CONSTRAINT new_constraint_name 
FOREIGN KEY (column_name) REFERENCES referenced_table(id) ON DELETE [CASCADE|SET NULL];
```

### Step 5: Views and Stored Procedures

#### Update Database Views

```sql
-- Drop and recreate views that depend on modified tables
DROP VIEW IF EXISTS v_software_with_roles;

CREATE VIEW v_software_with_roles AS
SELECT 
    sp.id,
    sp.software_name,
    -- Add new columns as needed
    bo.first_name AS business_owner_first_name,
    bo.last_name AS business_owner_last_name
FROM software_products sp
LEFT JOIN software_roles sr ON sp.id = sr.software_id
LEFT JOIN employees bo ON sr.business_owner_id = bo.id;
```

### Step 6: Testing and Validation

#### Data Integrity Checks

```sql
-- Check for orphaned records
SELECT 'software_roles' as table_name, COUNT(*) as orphaned_count
FROM software_roles sr
LEFT JOIN software_products sp ON sr.software_id = sp.id
WHERE sp.id IS NULL;

-- Validate foreign key relationships
SELECT 
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'datatables_db'
    AND REFERENCED_TABLE_NAME IS NOT NULL;
```

#### Application Testing

1. **Test Core Functionality**
   - Verify CRUD operations work for all entities
   - Test relationship queries and joins
   - Validate data display in web interface

2. **Performance Testing**
   ```sql
   -- Check query performance on modified tables
   EXPLAIN SELECT * FROM modified_table WHERE conditions;
   
   -- Analyze table statistics
   ANALYZE TABLE modified_table;
   ```

### Step 7: Cleanup and Documentation

#### Remove Backup Tables (After Successful Testing)

```sql
-- Only after confirming everything works correctly
DROP TABLE IF EXISTS employees_backup;
DROP TABLE IF EXISTS software_products_backup;
DROP TABLE IF EXISTS software_roles_backup;
```

#### Update Documentation

1. Update `DATABASE.md` with new schema information
2. Update `REQUIREMENTS.md` if business logic changes
3. Document any breaking changes in application code
4. Update API documentation if endpoints change

## Rollback Process

If issues are discovered after deployment:

### Quick Rollback

```sql
-- Restore from backup
mysql -u root -proot_password datatables_db < backup_YYYYMMDD_HHMMSS.sql
```

### Selective Rollback

```sql
-- Restore specific tables from backup
-- (Requires more careful planning based on specific changes)
```

## Post-Update Checklist

- [ ] All tests pass
- [ ] Web interface displays data correctly
- [ ] No orphaned records exist
- [ ] Foreign key constraints are properly enforced
- [ ] Indexes are optimized for new query patterns
- [ ] Documentation is updated
- [ ] Backup files are stored securely
- [ ] Team is notified of changes

## Common Issues and Solutions

### Foreign Key Constraint Errors

```sql
-- Temporarily disable foreign key checks during migration
SET FOREIGN_KEY_CHECKS = 0;
-- Perform migration operations
SET FOREIGN_KEY_CHECKS = 1;
```

### Data Type Conversion Issues

```sql
-- Use explicit data type conversion
UPDATE table_name 
SET column_name = CAST(old_column AS NEW_DATA_TYPE)
WHERE conditions;
```

### Performance Issues After Updates

```sql
-- Rebuild table statistics
ANALYZE TABLE table_name;

-- Add missing indexes
CREATE INDEX idx_new_column ON table_name(new_column);
```

## Usage Instructions for AI Assistant

When updating this database based on new requirements:

1. **Always read this file first** to understand the structured approach
2. **Follow the steps in order** - don't skip the backup and analysis phases
3. **Test each change incrementally** rather than making all changes at once
4. **Validate data integrity** after each major modification
5. **Update related documentation** when schema changes are made
6. **Consider impact on existing application code** before implementing changes

### Command Templates for Common Operations

```bash
# Connect to database
docker exec -it datatables_mysql mysql -u root -proot_password datatables_db

# Run SQL file
docker exec -i datatables_mysql mysql -u root -proot_password datatables_db < file.sql

# Export specific table
docker exec datatables_mysql mysqldump -u root -proot_password datatables_db table_name > table_backup.sql

# Check container status
docker ps | grep datatables

# View recent logs
docker logs --tail=20 datatables_mysql
```
