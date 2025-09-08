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
     * Get all university units for dropdown selection
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
