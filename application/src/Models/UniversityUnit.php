<?php

namespace App\Models;

use App\Config\Database;
use PDO;
use PDOException;

/**
 * University Unit model for managing organizational unit data and operations
 * 
 * This model handles all database operations related to university units including
 * CRUD operations, hierarchical relationships, software associations, and employee
 * assignments. It manages the organizational structure within the university system.
 * 
 * University units can have parent-child relationships creating an organizational
 * hierarchy, and they serve as organizational containers for employees and
 * software product assignments.
 * 
 * Features:
 * - Full CRUD operations for university unit records
 * - Hierarchical unit management (parent-child relationships)
 * - Software product association tracking
 * - Employee assignment management
 * - Advanced querying with search, sorting, and pagination
 * - Unit type categorization (department, college, etc.)
 * - Comprehensive error handling and logging
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class UniversityUnit
{
    /**
     * PDO database connection instance
     * @var PDO
     */
    private $db;
    
    /**
     * Initialize UniversityUnit model with database connection
     * 
     * Establishes connection to the database through the Database singleton
     * to ensure consistent connection handling across the application.
     */
    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }
    
    /**
     * Retrieve all university units with optional filtering, sorting, and pagination
     * 
     * Fetches university unit data using stored procedure with support for DataTables
     * integration including search functionality, column sorting, and pagination.
     * Returns unit records with hierarchical relationships and associated counts.
     * 
     * @param int|null $limit Maximum number of records to return (for pagination)
     * @param int|null $offset Number of records to skip (for pagination)
     * @param string|null $search Search term to filter units across multiple fields
     * @param string|null $orderBy Column name to sort by
     * @param string|null $orderDir Sort direction (ASC or DESC)
     * @return array Array of university unit records with associated data
     */
    public function getAllUnits($limit = null, $offset = null, $search = null, $orderBy = null, $orderDir = null): array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_all_units(?, ?, ?, ?, ?)");
            $stmt->bindValue(1, $limit, PDO::PARAM_INT);
            $stmt->bindValue(2, $offset, PDO::PARAM_INT);
            $stmt->bindValue(3, $search, PDO::PARAM_STR);
            $stmt->bindValue(4, $orderBy, PDO::PARAM_STR);
            $stmt->bindValue(5, $orderDir, PDO::PARAM_STR);
            
            $stmt->execute();
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching university units: " . $e->getMessage());
            return [];
        }
    }
    
    /**
     * Retrieve a specific university unit by its unique ID
     * 
     * Fetches complete university unit information including hierarchical
     * relationships, software assignments, and employee counts for a single unit.
     * 
     * @param int $id Unique university unit identifier
     * @return array|null University unit record with associated data, or null if not found
     */
    public function getUnitById($id): ?array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_unit_by_id(?)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute();
            
            $result = $stmt->fetch();
            return $result ?: null;
            
        } catch (PDOException $e) {
            error_log("Error fetching unit by ID: " . $e->getMessage());
            return null;
        }
    }
    
    /**
     * Retrieve all software products assigned to a specific university unit
     * 
     * Gets all software products associated with a university unit through
     * business owner assignments. Includes software details and role assignment
     * information for comprehensive unit software management.
     * 
     * @param int $unitId Unique university unit identifier
     * @return array Array of software products assigned to the unit
     */
    public function getUnitSoftware($unitId): array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_unit_software(?)");
            $stmt->bindParam(1, $unitId, PDO::PARAM_INT);
            $stmt->execute();
            
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching unit software: " . $e->getMessage());
            return [];
        }
    }
    
    /**
     * Create a new university unit record
     * 
     * Adds a new university unit to the database using stored procedure with
     * data validation and constraint checking. Supports hierarchical relationships
     * through parent unit assignment. Returns the newly created unit's ID.
     * 
     * @param array $data Associative array of university unit data including:
     *                   - unit_name: Name of the university unit
     *                   - unit_code: Optional unit code/abbreviation
     *                   - description: Optional unit description
     *                   - unit_type: Type of unit (department, college, etc.)
     *                   - parent_unit_id: Optional parent unit for hierarchy
     * @return int|null Newly created university unit ID, or null if creation failed
     */
    public function createUnit($data): ?int
    {
        try {
            $stmt = $this->db->prepare("CALL sp_create_unit(?, ?, ?, ?, ?, @unit_id)");
            $stmt->bindParam(1, $data['unit_name'], PDO::PARAM_STR);
            $stmt->bindParam(2, $data['unit_code'], PDO::PARAM_STR);
            $stmt->bindParam(3, $data['description'], PDO::PARAM_STR);
            $stmt->bindParam(4, $data['parent_unit_id'], PDO::PARAM_INT);
            $stmt->bindParam(5, $data['unit_type'], PDO::PARAM_STR);
            
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @unit_id as unit_id");
            $row = $result->fetch();
            
            return $row['unit_id'] ? (int)$row['unit_id'] : null;
            
        } catch (PDOException $e) {
            error_log("Error creating unit: " . $e->getMessage());
            return null;
        }
    }
    
    /**
     * Update an existing university unit record
     * 
     * Modifies an existing university unit's information using stored procedure
     * with data validation and constraint checking. Preserves referential
     * integrity with related records and hierarchical relationships.
     * 
     * @param int $id University unit ID to update
     * @param array $data Associative array of updated university unit data
     * @return bool True if update was successful, false otherwise
     */
    public function updateUnit($id, $data): bool
    {
        try {
            $stmt = $this->db->prepare("CALL sp_update_unit(?, ?, ?, ?, ?, ?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->bindParam(2, $data['unit_name'], PDO::PARAM_STR);
            $stmt->bindParam(3, $data['unit_code'], PDO::PARAM_STR);
            $stmt->bindParam(4, $data['description'], PDO::PARAM_STR);
            $stmt->bindParam(5, $data['parent_unit_id'], PDO::PARAM_INT);
            $stmt->bindParam(6, $data['unit_type'], PDO::PARAM_STR);
            
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error updating unit: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Delete a university unit record
     * 
     * Removes a university unit from the database using stored procedure with
     * referential integrity checks. May fail if unit has associated employees
     * or software assignments that need to be handled first.
     * 
     * @param int $id University unit ID to delete
     * @return bool True if deletion was successful, false otherwise
     */
    public function deleteUnit($id): bool
    {
        try {
            $stmt = $this->db->prepare("CALL sp_delete_unit(?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error deleting unit: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Get total count of university unit records with optional search filtering
     * 
     * Returns the total number of university unit records in the database,
     * optionally filtered by search criteria. Used for pagination calculations
     * and dashboard statistics.
     * 
     * @param string|null $search Optional search term to filter count
     * @return int Total number of university unit records (filtered if search provided)
     */
    public function getTotalCount($search = null): int
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_unit_total_count(?, @total_count)");
            $stmt->bindParam(1, $search, PDO::PARAM_STR);
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @total_count as total_count");
            $row = $result->fetch();
            
            return (int) $row['total_count'];
            
        } catch (PDOException $e) {
            error_log("Error getting unit count: " . $e->getMessage());
            return 0;
        }
    }
    
    /**
     * Retrieve all available university unit types
     * 
     * Returns an array of standard university unit types for dropdown
     * and categorization purposes. Used in forms and filtering to maintain
     * consistency in unit categorization.
     * 
     * @return array Array of available unit type strings
     */
    public function getUnitTypes(): array
    {
        return [
            ['unit_type' => 'department', 'display_name' => 'Department'],
            ['unit_type' => 'college', 'display_name' => 'College'], 
            ['unit_type' => 'administrative', 'display_name' => 'Administrative'],
            ['unit_type' => 'support', 'display_name' => 'Support'],
            ['unit_type' => 'research', 'display_name' => 'Research']
        ];
    }
    
    /**
     * Retrieve all university units formatted for dropdown selection
     * 
     * Returns university units in a format suitable for HTML select dropdowns
     * and form controls. Includes hierarchical display formatting and excludes
     * unnecessary data for optimal performance.
     * 
     * @return array Array of university units formatted for dropdown display
     */
    public function getAllUnitsForDropdown(): array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_all_units_for_dropdown()");
            $stmt->execute();
            
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching units for dropdown: " . $e->getMessage());
            return [];
        }
    }
}
