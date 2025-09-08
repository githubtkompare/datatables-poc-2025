<?php

namespace App\Models;

use App\Config\Database;
use PDO;
use PDOException;

/**
 * Employee model for managing employee data and operations
 * 
 * This model handles all database operations related to employees including
 * CRUD operations, data retrieval with filtering/sorting, and relationship
 * management with software products and university units.
 * 
 * The model uses stored procedures for all database operations to ensure
 * data integrity, security, and consistent business logic enforcement.
 * 
 * Features:
 * - Full CRUD operations for employee records
 * - Advanced querying with search, sorting, and pagination
 * - Software role assignment tracking
 * - University unit relationship management
 * - Comprehensive error handling and logging
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class Employee
{
    /**
     * PDO database connection instance
     * @var PDO
     */
    private $db;
    
    /**
     * Initialize Employee model with database connection
     * 
     * Establishes connection to the database through the Database singleton
     * to ensure consistent connection handling across the application.
     */
    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }
    
    /**
     * Retrieve all employees with optional filtering, sorting, and pagination
     * 
     * Fetches employee data using stored procedure with support for DataTables
     * integration including search functionality, column sorting, and pagination.
     * Returns employee records with associated university unit information.
     * 
     * @param int|null $limit Maximum number of records to return (for pagination)
     * @param int|null $offset Number of records to skip (for pagination)
     * @param string|null $search Search term to filter employees across multiple fields
     * @param string|null $orderBy Column name to sort by
     * @param string|null $orderDir Sort direction (ASC or DESC)
     * @return array Array of employee records with associated data
     */
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
    
    /**
     * Retrieve a specific employee by their unique ID
     * 
     * Fetches complete employee information including associated university
     * unit details and software role assignments for a single employee.
     * 
     * @param int $id Unique employee identifier
     * @return array|null Employee record with associated data, or null if not found
     */
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
    
    /**
     * Retrieve all software role assignments for a specific employee
     * 
     * Gets all software products that an employee has role assignments for,
     * including the specific roles (business owner, technical owner, technical manager)
     * and associated software product details.
     * 
     * @param int $employeeId Unique employee identifier
     * @return array Array of software role assignments with product details
     */
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
    
    /**
     * Create a new employee record
     * 
     * Adds a new employee to the database using stored procedure with
     * data validation and constraint checking. Returns the newly created
     * employee's ID for further operations.
     * 
     * @param array $data Associative array of employee data including:
     *                   - first_name: Employee's first name
     *                   - last_name: Employee's last name
     *                   - email: Employee's email address (must be unique)
     *                   - phone: Employee's phone number
     *                   - university_unit_id: Associated university unit ID
     *                   - job_title: Employee's job title
     * @return int|null Newly created employee ID, or null if creation failed
     */
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
            
            // Retrieve the output parameter containing the new employee ID
            $result = $this->db->query("SELECT @employee_id as employee_id");
            $row = $result->fetch();
            
            return $row['employee_id'] ? (int)$row['employee_id'] : null;
            
        } catch (PDOException $e) {
            error_log("Error creating employee: " . $e->getMessage());
            return null;
        }
    }
    
    /**
     * Update an existing employee record
     * 
     * Modifies an existing employee's information using stored procedure
     * with data validation and constraint checking. Preserves referential
     * integrity with related records.
     * 
     * @param int $id Employee ID to update
     * @param array $data Associative array of updated employee data
     * @return bool True if update was successful, false otherwise
     */
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
            
            // Check if any rows were affected by the update
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error updating employee: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Delete an employee record
     * 
     * Removes an employee from the database using stored procedure with
     * referential integrity checks. May fail if employee has associated
     * software role assignments that need to be handled first.
     * 
     * @param int $id Employee ID to delete
     * @return bool True if deletion was successful, false otherwise
     */
    public function deleteEmployee($id): bool
    {
        try {
            $stmt = $this->db->prepare("CALL sp_delete_employee(?, @rows_affected)");
            $stmt->bindParam(1, $id, PDO::PARAM_INT);
            $stmt->execute();
            
            // Check if any rows were affected by the deletion
            $result = $this->db->query("SELECT @rows_affected as rows_affected");
            $row = $result->fetch();
            
            return $row['rows_affected'] > 0;
            
        } catch (PDOException $e) {
            error_log("Error deleting employee: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Get total count of employee records with optional search filtering
     * 
     * Returns the total number of employee records in the database, optionally
     * filtered by search criteria. Used for pagination calculations and
     * dashboard statistics.
     * 
     * @param string|null $search Optional search term to filter count
     * @return int Total number of employee records (filtered if search provided)
     */
    public function getTotalCount($search = null): int
    {
        try {
            $stmt = $this->db->prepare("CALL sp_get_employee_total_count(?, @total_count)");
            $stmt->bindParam(1, $search, PDO::PARAM_STR);
            $stmt->execute();
            
            // Retrieve the output parameter containing the count
            $result = $this->db->query("SELECT @total_count as total_count");
            $row = $result->fetch();
            
            return (int) $row['total_count'];
            
        } catch (PDOException $e) {
            error_log("Error getting employee count: " . $e->getMessage());
            return 0;
        }
    }
}
