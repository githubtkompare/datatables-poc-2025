<?php

namespace App\Models;

use App\Config\Database;
use PDO;
use PDOException;

/**
 * Software Product model for managing software product data and operations
 * 
 * This model handles all database operations related to software products including
 * CRUD operations, role assignments, operating system relationships, and advanced
 * querying with filtering and sorting capabilities.
 * 
 * The model manages complex relationships between software products, employees
 * (through role assignments), university units, and operating systems. All
 * database operations use stored procedures for security and consistency.
 * 
 * Features:
 * - Full CRUD operations for software product records
 * - Role assignment management (business owner, technical owner, technical manager)
 * - Operating system compatibility tracking
 * - University unit association management
 * - Advanced search and filtering capabilities
 * - Vendor management and licensing information
 * - Comprehensive error handling and logging
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class SoftwareProduct
{
    /**
     * PDO database connection instance
     * @var PDO
     */
    private $db;
    
    /**
     * Initialize SoftwareProduct model with database connection
     * 
     * Establishes connection to the database through the Database singleton
     * to ensure consistent connection handling across the application.
     */
    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function getAllSoftware($limit = null, $offset = null, $search = null, $orderBy = null, $orderDir = 'ASC'): array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_all_software(?, ?, ?, ?, ?)");
            $stmt->bindValue(1, $limit, PDO::PARAM_INT);
            $stmt->bindValue(2, $offset, PDO::PARAM_INT);
            $stmt->bindValue(3, $search, PDO::PARAM_STR);
            $stmt->bindValue(4, $orderBy, PDO::PARAM_STR);
            $stmt->bindValue(5, $orderDir, PDO::PARAM_STR);
            
            $stmt->execute();
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching software: " . $e->getMessage());
            return [];
        }
    }
    
    public function getSoftwareById($id): ?array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_software_by_id(?)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute();
            
            $result = $stmt->fetch();
            return $result ?: null;
            
        } catch (PDOException $e) {
            error_log("Error fetching software by ID: " . $e->getMessage());
            return null;
        }
    }
    
    public function getSoftwareOperatingSystems($softwareId): array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_software_operating_systems(?)");
            $stmt->bindParam(1, $softwareId, PDO::PARAM_INT);
            $stmt->execute();
            
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching software operating systems: " . $e->getMessage());
            return [];
        }
    }
    
    public function getSoftwareUnit($softwareId): ?array
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_software_unit(?)");
            $stmt->bindParam(1, $softwareId, PDO::PARAM_INT);
            $stmt->execute();
            
            return $stmt->fetch() ?: null;
            
        } catch (PDOException $e) {
            error_log("Error fetching software unit: " . $e->getMessage());
            return null;
        }
    }
    
    public function createSoftware($data): ?int
    {
        try {
            // Validate that all required role assignments are provided
            if (empty($data['business_owner_id']) || empty($data['technical_owner_id']) || empty($data['technical_manager_id'])) {
                throw new \InvalidArgumentException("All three roles (business owner, technical owner, and technical manager) are required");
            }
            
            $stmt = $this->db->prepare("CALL sp_create_software(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @software_id)");
            $stmt->bindParam(1, $data['software_name'], PDO::PARAM_STR);
            $stmt->bindParam(2, $data['version'], PDO::PARAM_STR);
            $stmt->bindParam(3, $data['description'], PDO::PARAM_STR);
            $stmt->bindParam(4, $data['vendor_managed'], PDO::PARAM_BOOL);
            $stmt->bindParam(5, $data['vendor_name'], PDO::PARAM_STR);
            $stmt->bindParam(6, $data['license_type'], PDO::PARAM_STR);
            $stmt->bindParam(7, $data['installation_notes'], PDO::PARAM_STR);
            $stmt->bindParam(8, $data['business_owner_id'], PDO::PARAM_INT);
            $stmt->bindParam(9, $data['technical_owner_id'], PDO::PARAM_INT);
            $stmt->bindParam(10, $data['technical_manager_id'], PDO::PARAM_INT);
            
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @software_id as software_id");
            $row = $result->fetch();
            
            return $row['software_id'] ? (int)$row['software_id'] : null;
            
        } catch (PDOException $e) {
            error_log("Error creating software: " . $e->getMessage());
            return null;
        } catch (\InvalidArgumentException $e) {
            error_log("Validation error creating software: " . $e->getMessage());
            return null;
        }
    }
    
    public function updateSoftware($id, $data): bool
    {
        try {
            // Validate that all required role assignments are provided
            if (empty($data['business_owner_id']) || empty($data['technical_owner_id']) || empty($data['technical_manager_id'])) {
                throw new \InvalidArgumentException("All three roles (business owner, technical owner, and technical manager) are required");
            }
            
            $stmt = $this->db->prepare("CALL sp_update_software(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->bindParam(2, $data['software_name'], PDO::PARAM_STR);
            $stmt->bindParam(3, $data['version'], PDO::PARAM_STR);
            $stmt->bindParam(4, $data['description'], PDO::PARAM_STR);
            $stmt->bindParam(5, $data['vendor_managed'], PDO::PARAM_BOOL);
            $stmt->bindParam(6, $data['vendor_name'], PDO::PARAM_STR);
            $stmt->bindParam(7, $data['license_type'], PDO::PARAM_STR);
            $stmt->bindParam(8, $data['installation_notes'], PDO::PARAM_STR);
            $stmt->bindParam(9, $data['business_owner_id'], PDO::PARAM_INT);
            $stmt->bindParam(10, $data['technical_owner_id'], PDO::PARAM_INT);
            $stmt->bindParam(11, $data['technical_manager_id'], PDO::PARAM_INT);
            
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error updating software: " . $e->getMessage());
            return false;
        } catch (\InvalidArgumentException $e) {
            error_log("Validation error updating software: " . $e->getMessage());
            return false;
        }
    }
    
    public function deleteSoftware($id): bool
    {
        try {
            $stmt = $this->db->prepare("CALL sp_delete_software(?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error deleting software: " . $e->getMessage());
            return false;
        }
    }
    
    public function getTotalCount($search = null): int
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_software_total_count(?, @total_count)");
            $stmt->bindParam(1, $search, PDO::PARAM_STR);
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @total_count as total_count");
            $row = $result->fetch();
            
            return (int) $row['total_count'];
            
        } catch (PDOException $e) {
            error_log("Error getting software count: " . $e->getMessage());
            return 0;
        }
    }
    
    public function getUniqueSoftwareNames($search = null): array
    {
        try {
            if (!empty($search)) {
                $sql = "SELECT DISTINCT software_name 
                        FROM software_products 
                        WHERE software_name LIKE CONCAT('%', ?, '%')
                        ORDER BY software_name ASC 
                        LIMIT 5";
                $stmt = $this->db->prepare($sql);
                $stmt->bindParam(1, $search, PDO::PARAM_STR);
            } else {
                $sql = "SELECT DISTINCT software_name 
                        FROM software_products 
                        ORDER BY software_name ASC 
                        LIMIT 5";
                $stmt = $this->db->prepare($sql);
            }
            
            $stmt->execute();
            $results = $stmt->fetchAll(PDO::FETCH_COLUMN);
            return $results;
            
        } catch (PDOException $e) {
            error_log("Error getting unique software names: " . $e->getMessage());
            return [];
        }
    }
}
