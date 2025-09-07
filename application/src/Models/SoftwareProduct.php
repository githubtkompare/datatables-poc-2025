<?php

namespace App\Models;

use App\Config\Database;
use PDO;
use PDOException;

class SoftwareProduct
{
    private $db;
    
    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function getAllSoftware($limit = null, $offset = null, $search = null, $orderBy = null, $orderDir = 'ASC'): array
    {
        $sql = "SELECT 
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
                    -- Add unit_count (1 if business owner has a university unit, 0 if not)
                    CASE WHEN bo_unit.id IS NOT NULL THEN 1 ELSE 0 END as unit_count,
                    CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
                    bo.email as business_owner_email,
                    bo_unit.unit_name as business_owner_department,
                    CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
                    to_emp.email as technical_owner_email,
                    CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager,
                    tm.email as technical_manager_email,
                    GROUP_CONCAT(DISTINCT os.os_name ORDER BY os.os_name SEPARATOR ', ') as operating_systems,
                    -- Check for missing role assignments
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
                LEFT JOIN operating_systems os ON sos.os_id = os.id";
        
        $params = [];
        
        if ($search) {
            $sql .= " WHERE (sp.software_name LIKE :search1 OR sp.vendor_name LIKE :search2 OR sp.description LIKE :search3 
                      OR bo_unit.unit_name LIKE :search4 OR CONCAT(bo.first_name, ' ', bo.last_name) LIKE :search5)";
            $params['search1'] = "%{$search}%";
            $params['search2'] = "%{$search}%";
            $params['search3'] = "%{$search}%";
            $params['search4'] = "%{$search}%";
            $params['search5'] = "%{$search}%";
        }
        
        $sql .= " GROUP BY sp.id, sp.software_name, sp.version, sp.description, sp.vendor_managed, sp.vendor_name, sp.license_type, 
                  sp.created_at, sp.updated_at, bo_unit.unit_name, bo_unit.unit_code,
                  bo.first_name, bo.last_name, bo.email, bo_unit.unit_name, to_emp.first_name, to_emp.last_name, to_emp.email,
                  tm.first_name, tm.last_name, tm.email, sr.id, sr.business_owner_id, sr.technical_owner_id, sr.technical_manager_id";
        
        // Apply dynamic ordering
        if ($orderBy) {
            $sql .= " ORDER BY {$orderBy} {$orderDir}";
        } else {
            $sql .= " ORDER BY sp.updated_at DESC";
        }
        
        if ($limit) {
            $sql .= " LIMIT :limit";
            $params['limit'] = $limit;
            
            if ($offset) {
                $sql .= " OFFSET :offset";
                $params['offset'] = $offset;
            }
        }
        
        try {
            $stmt = $this->db->prepare($sql);
            
            foreach ($params as $key => $value) {
                if (in_array($key, ['limit', 'offset'])) {
                    $stmt->bindValue(":{$key}", $value, PDO::PARAM_INT);
                } else {
                    $stmt->bindValue(":{$key}", $value, PDO::PARAM_STR);
                }
            }
            
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
            $sql = "SELECT sp.*, 
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
                    WHERE sp.id = :id";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
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
            $sql = "SELECT os.id, os.os_name, os.os_version, os.os_family
                    FROM operating_systems os
                    JOIN software_operating_systems sos ON os.id = sos.os_id
                    WHERE sos.software_id = :software_id
                    ORDER BY os.os_name";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':software_id', $softwareId, PDO::PARAM_INT);
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
            $sql = "SELECT u.id, u.unit_name, u.unit_code, u.unit_type
                    FROM software_products sp
                    LEFT JOIN university_units u ON sp.university_unit_id = u.id
                    WHERE sp.id = :software_id";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':software_id', $softwareId, PDO::PARAM_INT);
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
            
            $this->db->beginTransaction();
            
            // Get the university unit based on business owner's university unit
            $unitSql = "SELECT e.university_unit_id
                       FROM employees e 
                       WHERE e.id = :business_owner_id 
                       LIMIT 1";
            
            $unitStmt = $this->db->prepare($unitSql);
            $unitStmt->bindParam(':business_owner_id', $data['business_owner_id'], PDO::PARAM_INT);
            $unitStmt->execute();
            $unitResult = $unitStmt->fetch();
            $universityUnitId = $unitResult ? $unitResult['university_unit_id'] : null;
            
            // Insert software product with calculated university_unit_id
            $sql = "INSERT INTO software_products (software_name, version, description, vendor_managed, vendor_name, license_type, installation_notes, university_unit_id) 
                    VALUES (:software_name, :version, :description, :vendor_managed, :vendor_name, :license_type, :installation_notes, :university_unit_id)";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':software_name', $data['software_name']);
            $stmt->bindParam(':version', $data['version']);
            $stmt->bindParam(':description', $data['description']);
            $stmt->bindParam(':vendor_managed', $data['vendor_managed'], PDO::PARAM_BOOL);
            $stmt->bindParam(':vendor_name', $data['vendor_name']);
            $stmt->bindParam(':license_type', $data['license_type']);
            $stmt->bindParam(':installation_notes', $data['installation_notes']);
            $stmt->bindParam(':university_unit_id', $universityUnitId, PDO::PARAM_INT);
            
            $stmt->execute();
            $softwareId = $this->db->lastInsertId();
            
            // Insert software roles (all three are required)
            $roleSql = "INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) 
                       VALUES (:software_id, :business_owner_id, :technical_owner_id, :technical_manager_id)";
            
            $roleStmt = $this->db->prepare($roleSql);
            $roleStmt->bindParam(':software_id', $softwareId, PDO::PARAM_INT);
            $roleStmt->bindParam(':business_owner_id', $data['business_owner_id'], PDO::PARAM_INT);
            $roleStmt->bindParam(':technical_owner_id', $data['technical_owner_id'], PDO::PARAM_INT);
            $roleStmt->bindParam(':technical_manager_id', $data['technical_manager_id'], PDO::PARAM_INT);
            $roleStmt->execute();
            
            $this->db->commit();
            return $softwareId;
            
        } catch (PDOException $e) {
            $this->db->rollBack();
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
            
            $this->db->beginTransaction();
            
            // Get the university unit based on business owner's university unit
            $unitSql = "SELECT e.university_unit_id
                       FROM employees e 
                       WHERE e.id = :business_owner_id 
                       LIMIT 1";
            
            $unitStmt = $this->db->prepare($unitSql);
            $unitStmt->bindParam(':business_owner_id', $data['business_owner_id'], PDO::PARAM_INT);
            $unitStmt->execute();
            $unitResult = $unitStmt->fetch();
            $universityUnitId = $unitResult ? $unitResult['university_unit_id'] : null;
            
            // Update software product including university_unit_id
            $sql = "UPDATE software_products 
                    SET software_name = :software_name, 
                        version = :version, 
                        description = :description, 
                        vendor_managed = :vendor_managed, 
                        vendor_name = :vendor_name, 
                        license_type = :license_type,
                        installation_notes = :installation_notes,
                        university_unit_id = :university_unit_id,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = :id";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->bindParam(':software_name', $data['software_name']);
            $stmt->bindParam(':version', $data['version']);
            $stmt->bindParam(':description', $data['description']);
            $stmt->bindParam(':vendor_managed', $data['vendor_managed'], PDO::PARAM_BOOL);
            $stmt->bindParam(':vendor_name', $data['vendor_name']);
            $stmt->bindParam(':license_type', $data['license_type']);
            $stmt->bindParam(':installation_notes', $data['installation_notes']);
            $stmt->bindParam(':university_unit_id', $universityUnitId, PDO::PARAM_INT);
            
            $stmt->execute();
            
            // Update software roles (delete and recreate since no unique constraint exists)
            $deleteRolesSql = "DELETE FROM software_roles WHERE software_id = :software_id";
            $deleteStmt = $this->db->prepare($deleteRolesSql);
            $deleteStmt->bindParam(':software_id', $id, PDO::PARAM_INT);
            $deleteStmt->execute();
            
            // Insert new roles
            $roleSql = "INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) 
                       VALUES (:software_id, :business_owner_id, :technical_owner_id, :technical_manager_id)";
            
            $roleStmt = $this->db->prepare($roleSql);
            $roleStmt->bindParam(':software_id', $id, PDO::PARAM_INT);
            $roleStmt->bindParam(':business_owner_id', $data['business_owner_id'], PDO::PARAM_INT);
            $roleStmt->bindParam(':technical_owner_id', $data['technical_owner_id'], PDO::PARAM_INT);
            $roleStmt->bindParam(':technical_manager_id', $data['technical_manager_id'], PDO::PARAM_INT);
            $roleStmt->execute();
            
            $this->db->commit();
            return true;
            
        } catch (PDOException $e) {
            $this->db->rollBack();
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
            $stmt = $this->db->prepare("DELETE FROM software_products WHERE id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            return $stmt->rowCount() > 0;
            
        } catch (PDOException $e) {
            error_log("Error deleting software: " . $e->getMessage());
            return false;
        }
    }
    
    public function getTotalCount($search = null): int
    {
        $sql = "SELECT COUNT(DISTINCT sp.id) as total 
                FROM software_products sp
                LEFT JOIN university_units u ON sp.university_unit_id = u.id
                LEFT JOIN software_roles sr ON sp.id = sr.software_id
                LEFT JOIN employees bo ON sr.business_owner_id = bo.id
                LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
                LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
                LEFT JOIN employees tm ON sr.technical_manager_id = tm.id";
        $params = [];
        
        if ($search) {
            $sql .= " WHERE (sp.software_name LIKE :search1 OR sp.vendor_name LIKE :search2 OR sp.description LIKE :search3 
                      OR u.unit_name LIKE :search4 OR CONCAT(bo.first_name, ' ', bo.last_name) LIKE :search5)";
            $params['search1'] = "%{$search}%";
            $params['search2'] = "%{$search}%";
            $params['search3'] = "%{$search}%";
            $params['search4'] = "%{$search}%";
            $params['search5'] = "%{$search}%";
        }
        
        try {
            $stmt = $this->db->prepare($sql);
            
            foreach ($params as $key => $value) {
                $stmt->bindValue(":{$key}", $value, PDO::PARAM_STR);
            }
            
            $stmt->execute();
            $result = $stmt->fetch();
            
            return (int) $result['total'];
            
        } catch (PDOException $e) {
            error_log("Error getting software count: " . $e->getMessage());
            return 0;
        }
    }
    
    public function getUniqueSoftwareNames($search = null): array
    {
        $sql = "SELECT DISTINCT software_name 
                FROM software_products 
                WHERE 1=1";
        $params = [];
        
        if ($search) {
            $sql .= " AND software_name LIKE :search";
            $params['search'] = "%{$search}%";
        }
        
        $sql .= " ORDER BY software_name ASC LIMIT 5";
        
        try {
            $stmt = $this->db->prepare($sql);
            
            foreach ($params as $key => $value) {
                $stmt->bindValue(":{$key}", $value, PDO::PARAM_STR);
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
