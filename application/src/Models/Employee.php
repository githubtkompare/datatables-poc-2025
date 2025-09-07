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
        try {
            $stmt = $this->db->prepare("CALL sp_get_all_employees(?, ?, ?, ?, ?)");
            $stmt->bindValue(1, $limit, PDO::PARAM_INT);
            $stmt->bindValue(2, $offset, PDO::PARAM_INT);
            $stmt->bindValue(3, $search, PDO::PARAM_STR);
            $stmt->bindValue(4, $orderBy, PDO::PARAM_STR);
            $stmt->bindValue(5, $orderDir, PDO::PARAM_STR);
            
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
            $stmt = $this->db->prepare("CALL sp_get_employee_by_id(?)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
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
            $stmt = $this->db->prepare("CALL sp_get_employee_software_roles(?)");
            $stmt->bindParam(1, $employeeId, PDO::PARAM_INT);
            $stmt->execute();
            
            return $stmt->fetchAll();
            
        } catch (PDOException $e) {
            error_log("Error fetching employee software roles: " . $e->getMessage());
            return [];
        }
    }
    
    public function createEmployee($data): ?int
    {
        try {
            $stmt = $this->db->prepare("CALL sp_create_employee(?, ?, ?, ?, ?, ?, @employee_id)");
            $stmt->bindParam(1, $data['first_name'], PDO::PARAM_STR);
            $stmt->bindParam(2, $data['last_name'], PDO::PARAM_STR);
            $stmt->bindParam(3, $data['email'], PDO::PARAM_STR);
            $stmt->bindParam(4, $data['phone'], PDO::PARAM_STR);
            $stmt->bindValue(5, $data['university_unit_id'] ?: null, PDO::PARAM_INT);
            $stmt->bindParam(6, $data['job_title'], PDO::PARAM_STR);
            
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @employee_id as employee_id");
            $row = $result->fetch();
            
            return $row['employee_id'] ? (int)$row['employee_id'] : null;
            
        } catch (PDOException $e) {
            error_log("Error creating employee: " . $e->getMessage());
            return null;
        }
    }
    
    public function updateEmployee($id, $data): bool
    {
        try {
            $stmt = $this->db->prepare("CALL sp_update_employee(?, ?, ?, ?, ?, ?, ?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->bindParam(2, $data['first_name'], PDO::PARAM_STR);
            $stmt->bindParam(3, $data['last_name'], PDO::PARAM_STR);
            $stmt->bindParam(4, $data['email'], PDO::PARAM_STR);
            $stmt->bindParam(5, $data['phone'], PDO::PARAM_STR);
            $stmt->bindValue(6, $data['university_unit_id'] ?: null, PDO::PARAM_INT);
            $stmt->bindParam(7, $data['job_title'], PDO::PARAM_STR);
            
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error updating employee: " . $e->getMessage());
            return false;
        }
    }
    
    public function deleteEmployee($id): bool
    {
        try {
            $stmt = $this->db->prepare("CALL sp_delete_employee(?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error deleting employee: " . $e->getMessage());
            return false;
        }
    }
    
    public function getTotalCount($search = null): int
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_employee_total_count(?, @total_count)");
            $stmt->bindParam(1, $search, PDO::PARAM_STR);
            $stmt->execute();
            
            // Get the output parameter
            $result = $this->db->query("SELECT @total_count as total_count");
            $row = $result->fetch();
            
            return (int) $row['total_count'];
            
        } catch (PDOException $e) {
            error_log("Error getting employee count: " . $e->getMessage());
            return 0;
        }
    }
}
