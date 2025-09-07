<?php

namespace App\Models;

use App\Config\Database;
use PDO;
use PDOException;

class Employee
{
    private $db;
    
    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function getAllEmployees($limit = null, $offset = null, $search = null, $orderBy = null, $orderDir = null): array
    {
        $sql = "SELECT 
                    e.id,
                    e.first_name,
                    e.last_name,
                    e.email,
                    e.phone,
                    e.university_unit_id,
                    e.job_title,
                    e.created_at,
                    e.updated_at,
                    u.unit_name as university_unit_name,
                    COUNT(DISTINCT CASE WHEN sr.business_owner_id = e.id THEN sr.software_id END) as business_owner_count,
                    COUNT(DISTINCT CASE WHEN sr.technical_owner_id = e.id THEN sr.software_id END) as technical_owner_count,
                    COUNT(DISTINCT CASE WHEN sr.technical_manager_id = e.id THEN sr.software_id END) as technical_manager_count
                FROM employees e
                LEFT JOIN university_units u ON e.university_unit_id = u.id
                LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)";
        
        $params = [];
        
        if ($search) {
            $sql .= " WHERE (e.first_name LIKE :search1 OR e.last_name LIKE :search2 OR e.email LIKE :search3 OR u.unit_name LIKE :search4)";
            $params['search1'] = "%{$search}%";
            $params['search2'] = "%{$search}%";
            $params['search3'] = "%{$search}%";
            $params['search4'] = "%{$search}%";
        }
        
        $sql .= " GROUP BY e.id, e.first_name, e.last_name, e.email, e.phone, e.university_unit_id, e.job_title, e.created_at, e.updated_at, u.unit_name";
        
        // Handle ordering
        $validColumns = [
            'name' => 'CONCAT(e.first_name, \' \', e.last_name)',
            'first_name' => 'e.first_name',
            'last_name' => 'e.last_name', 
            'email' => 'e.email',
            'phone' => 'e.phone',
            'university_unit_name' => 'u.unit_name',
            'job_title' => 'e.job_title',
            'created_at' => 'e.created_at'
        ];
        
        if ($orderBy && isset($validColumns[$orderBy])) {
            $orderDir = strtoupper($orderDir) === 'DESC' ? 'DESC' : 'ASC';
            $sql .= " ORDER BY " . $validColumns[$orderBy] . " " . $orderDir;
        } else {
            $sql .= " ORDER BY e.updated_at DESC";
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
            error_log("Error fetching employees: " . $e->getMessage());
            return [];
        }
    }
    
    public function getEmployeeById($id): ?array
    {
        try {
            $sql = "SELECT e.*, u.unit_name as university_unit_name 
                    FROM employees e 
                    LEFT JOIN university_units u ON e.university_unit_id = u.id 
                    WHERE e.id = :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            $result = $stmt->fetch();
            return $result ?: null;
            
        } catch (PDOException $e) {
            error_log("Error fetching employee by ID: " . $e->getMessage());
            return null;
        }
    }
    
    public function getEmployeeSoftwareRoles($employeeId): array
    {
        try {
            $sql = "SELECT 
                        sp.id as software_id,
                        sp.software_name,
                        sp.version,
                        sp.vendor_managed,
                        sp.vendor_name,
                        'Business Owner' as role_type
                    FROM software_products sp
                    JOIN software_roles sr ON sp.id = sr.software_id
                    WHERE sr.business_owner_id = ?
                    
                    UNION ALL
                    
                    SELECT 
                        sp.id as software_id,
                        sp.software_name,
                        sp.version,
                        sp.vendor_managed,
                        sp.vendor_name,
                        'Technical Owner' as role_type
                    FROM software_products sp
                    JOIN software_roles sr ON sp.id = sr.software_id
                    WHERE sr.technical_owner_id = ?
                    
                    UNION ALL
                    
                    SELECT 
                        sp.id as software_id,
                        sp.software_name,
                        sp.version,
                        sp.vendor_managed,
                        sp.vendor_name,
                        'Technical Manager' as role_type
                    FROM software_products sp
                    JOIN software_roles sr ON sp.id = sr.software_id
                    WHERE sr.technical_manager_id = ?
                    
                    ORDER BY software_name, role_type";
            
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$employeeId, $employeeId, $employeeId]);
            
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching employee software roles: " . $e->getMessage());
            return [];
        }
    }
    
    public function createEmployee($data): ?int
    {
        try {
            $sql = "INSERT INTO employees (first_name, last_name, email, phone, university_unit_id, job_title) 
                    VALUES (:first_name, :last_name, :email, :phone, :university_unit_id, :job_title)";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':first_name', $data['first_name']);
            $stmt->bindParam(':last_name', $data['last_name']);
            $stmt->bindParam(':email', $data['email']);
            $stmt->bindParam(':phone', $data['phone']);
            $stmt->bindValue(':university_unit_id', $data['university_unit_id'] ?: null, PDO::PARAM_INT);
            $stmt->bindParam(':job_title', $data['job_title']);
            
            $stmt->execute();
            return $this->db->lastInsertId();
            
        } catch (PDOException $e) {
            error_log("Error creating employee: " . $e->getMessage());
            return null;
        }
    }
    
    public function updateEmployee($id, $data): bool
    {
        try {
            $sql = "UPDATE employees 
                    SET first_name = :first_name, 
                        last_name = :last_name, 
                        email = :email, 
                        phone = :phone, 
                        university_unit_id = :university_unit_id,
                        job_title = :job_title,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE id = :id";
            
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->bindParam(':first_name', $data['first_name']);
            $stmt->bindParam(':last_name', $data['last_name']);
            $stmt->bindParam(':email', $data['email']);
            $stmt->bindParam(':phone', $data['phone']);
            $stmt->bindValue(':university_unit_id', $data['university_unit_id'] ?: null, PDO::PARAM_INT);
            $stmt->bindParam(':job_title', $data['job_title']);
            
            $stmt->execute();
            return $stmt->rowCount() > 0;
            
        } catch (PDOException $e) {
            error_log("Error updating employee: " . $e->getMessage());
            return false;
        }
    }
    
    public function deleteEmployee($id): bool
    {
        try {
            // Start transaction to ensure data consistency
            $this->db->beginTransaction();
            
            // First, remove the employee from any software role assignments
            // Set business_owner_id to NULL where this employee is the business owner
            $stmt = $this->db->prepare("UPDATE software_roles SET business_owner_id = NULL WHERE business_owner_id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Set technical_owner_id to NULL where this employee is the technical owner
            $stmt = $this->db->prepare("UPDATE software_roles SET technical_owner_id = NULL WHERE technical_owner_id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Set technical_manager_id to NULL where this employee is the technical manager
            $stmt = $this->db->prepare("UPDATE software_roles SET technical_manager_id = NULL WHERE technical_manager_id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Now delete the employee
            $stmt = $this->db->prepare("DELETE FROM employees WHERE id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            
            $deletedRows = $stmt->rowCount();
            
            // Commit the transaction
            $this->db->commit();
            
            return $deletedRows > 0;
            
        } catch (PDOException $e) {
            // Rollback the transaction on error
            $this->db->rollback();
            error_log("Error deleting employee: " . $e->getMessage());
            return false;
        }
    }
    
    public function getTotalCount($search = null): int
    {
        $sql = "SELECT COUNT(DISTINCT e.id) as total 
                FROM employees e
                LEFT JOIN university_units u ON e.university_unit_id = u.id";
        $params = [];
        
        if ($search) {
            $sql .= " WHERE (e.first_name LIKE :search1 OR e.last_name LIKE :search2 OR e.email LIKE :search3 OR u.unit_name LIKE :search4)";
            $params['search1'] = "%{$search}%";
            $params['search2'] = "%{$search}%";
            $params['search3'] = "%{$search}%";
            $params['search4'] = "%{$search}%";
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
            error_log("Error getting employee count: " . $e->getMessage());
            return 0;
        }
    }
}
