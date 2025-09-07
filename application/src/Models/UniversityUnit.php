<?php

namespace App\Models;

use App\Config\Database;
use PDO;
use PDOException;

class UniversityUnit
{
    private $db;
    
    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function getAllUnits($limit = null, $offset = null, $search = null, $orderBy = null, $orderDir = null): array
    {
        $sql = "SELECT 
                    u.id,
                    u.unit_name,
                    u.unit_code,
                    u.description,
                    u.unit_type,
                    u.created_at,
                    u.updated_at,
                    parent.unit_name as parent_unit_name,
                    COUNT(DISTINCT sp.id) as software_count,
                    COUNT(DISTINCT sp.id) as active_software_count
                FROM university_units u
                LEFT JOIN university_units parent ON u.parent_unit_id = parent.id
                LEFT JOIN employees e ON u.id = e.university_unit_id
                LEFT JOIN software_roles sr ON e.id = sr.business_owner_id
                LEFT JOIN software_products sp ON sr.software_id = sp.id";
        
        $params = [];
        
        if ($search) {
            $sql .= " WHERE (u.unit_name LIKE :search1 OR u.unit_code LIKE :search2 OR u.description LIKE :search3)";
            $params['search1'] = "%{$search}%";
            $params['search2'] = "%{$search}%";
            $params['search3'] = "%{$search}%";
        }
        
        $sql .= " GROUP BY u.id, u.unit_name, u.unit_code, u.description, u.unit_type, u.created_at, u.updated_at, parent.unit_name";
        
        // Handle ordering
        $validColumns = [
            'unit_name' => 'u.unit_name',
            'unit_code' => 'u.unit_code', 
            'unit_type' => 'u.unit_type',
            'parent_unit_name' => 'parent.unit_name',
            'software_count' => 'software_count',
            'updated_at' => 'u.updated_at'
        ];
        
        if ($orderBy && isset($validColumns[$orderBy])) {
            $orderDir = strtoupper($orderDir) === 'DESC' ? 'DESC' : 'ASC';
            $sql .= " ORDER BY " . $validColumns[$orderBy] . " " . $orderDir;
        } else {
            $sql .= " ORDER BY u.updated_at DESC";
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
            error_log("Error fetching university units: " . $e->getMessage());
            return [];
        }
    }
    
    public function getUnitById($id): ?array
    {
        try {
            $sql = "SELECT u.*, parent.unit_name as parent_unit_name
                    FROM university_units u
                    LEFT JOIN university_units parent ON u.parent_unit_id = parent.id
                    WHERE u.id = :id";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
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
            $sql = "SELECT 
                        sp.id as software_id,
                        sp.software_name,
                        sp.version,
                        sp.vendor_managed,
                        sp.vendor_name,
                        sp.created_at,
                        CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
                        CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
                        CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager
                    FROM software_products sp
                    LEFT JOIN software_roles sr ON sp.id = sr.software_id
                    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
                    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
                    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
                    WHERE sp.university_unit_id = :unit_id
                    ORDER BY sp.software_name, sp.version";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':unit_id', $unitId, PDO::PARAM_INT);
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
            $sql = "INSERT INTO university_units (unit_name, unit_code, description, parent_unit_id, unit_type) 
                    VALUES (:unit_name, :unit_code, :description, :parent_unit_id, :unit_type)";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':unit_name', $data['unit_name']);
            $stmt->bindParam(':unit_code', $data['unit_code']);
            $stmt->bindParam(':description', $data['description']);
            $stmt->bindParam(':parent_unit_id', $data['parent_unit_id'], PDO::PARAM_INT);
            $stmt->bindParam(':unit_type', $data['unit_type']);
            
            $stmt->execute();
            return $this->db->lastInsertId();
            
        } catch (PDOException $e) {
            error_log("Error creating unit: " . $e->getMessage());
            return null;
        }
    }
    
    public function updateUnit($id, $data): bool
    {
        try {
            $sql = "UPDATE university_units 
                    SET unit_name = :unit_name, 
                        unit_code = :unit_code, 
                        description = :description, 
                        parent_unit_id = :parent_unit_id, 
                        unit_type = :unit_type,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = :id";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->bindParam(':unit_name', $data['unit_name']);
            $stmt->bindParam(':unit_code', $data['unit_code']);
            $stmt->bindParam(':description', $data['description']);
            $stmt->bindParam(':parent_unit_id', $data['parent_unit_id'], PDO::PARAM_INT);
            $stmt->bindParam(':unit_type', $data['unit_type']);
            
            $stmt->execute();
            return $stmt->rowCount() > 0;
            
        } catch (PDOException $e) {
            error_log("Error updating unit: " . $e->getMessage());
            return false;
        }
    }
    
    public function deleteUnit($id): bool
    {
        try {
            $stmt = $this->db->prepare("DELETE FROM university_units WHERE id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            return $stmt->rowCount() > 0;
            
        } catch (PDOException $e) {
            error_log("Error deleting unit: " . $e->getMessage());
            return false;
        }
    }
    
    public function getTotalCount($search = null): int
    {
        $sql = "SELECT COUNT(*) as total FROM university_units";
        $params = [];
        
        if ($search) {
            $sql .= " WHERE (unit_name LIKE :search1 OR unit_code LIKE :search2 OR description LIKE :search3)";
            $params['search1'] = "%{$search}%";
            $params['search2'] = "%{$search}%";
            $params['search3'] = "%{$search}%";
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
            $sql = "SELECT 
                        id,
                        unit_name,
                        unit_code,
                        unit_type
                    FROM university_units 
                    ORDER BY unit_name ASC";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching units for dropdown: " . $e->getMessage());
            return [];
        }
    }
}
