# Database Directory

This directory contains the database schema and backup files for the DataTables POC 2025 project.

## Files

### `schema.sql`
- **Purpose**: Contains the complete database schema including table structures and stored procedures
- **Content**: 
  - Table definitions for all 6 tables (university_units, employees, software_products, operating_systems, software_operating_systems, software_roles)
  - 24 stored procedures for data operations
  - Indexes and foreign key constraints
  - Character set and collation settings
- **Usage**: Use this file to recreate the database structure from scratch
- **Last Updated**: September 7, 2025

### `datatables_db_backup.sql`
- **Purpose**: Complete database backup including structure, data, and stored procedures
- **Content**:
  - All table structures (identical to schema.sql)
  - All current data from all tables
  - All 24 stored procedures
  - Triggers and routines
- **Usage**: Use this file to restore the complete database with data
- **Created**: September 11, 2025 18:44 UTC
- **Size**: ~130KB

### `backup_YYYYMMDD_HHMMSS.sql`
- **Purpose**: Timestamped backup files for historical tracking
- **Content**: Same as datatables_db_backup.sql but with timestamp
- **Usage**: Historical reference and recovery

## Database Statistics (as of backup date)

- **Tables**: 6 core tables
- **Stored Procedures**: 24 procedures
- **Data Records**: Contains comprehensive mock data including:
  - 100+ employees across various university units
  - 200+ software products with role assignments
  - 20+ university units in hierarchical structure
  - Operating system compatibility data

## Restoration Instructions

### Restore Structure Only (New Database)
```bash
mysql -u username -p database_name < schema.sql
```

### Restore Complete Database with Data
```bash
mysql -u username -p database_name < datatables_db_backup.sql
```

### Docker Environment
```bash
docker exec datatables_mysql mysql -u root -proot_password datatables_db < /path/to/backup.sql
```

## Backup Instructions

### Create New Backup
```bash
docker exec datatables_mysql mysqldump -u root -proot_password --routines --triggers --single-transaction datatables_db > backup_$(date +%Y%m%d_%H%M%S).sql
```

## Schema Verification

The schema.sql file has been verified to match the current database structure as of September 11, 2025. All tables, columns, data types, constraints, and stored procedures are accurately represented.