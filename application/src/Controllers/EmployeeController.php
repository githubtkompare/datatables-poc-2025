<?php

namespace App\Controllers;

use App\Config\Auth;
use App\Models\Employee;
use App\Models\UniversityUnit;

/**
 * Employee management controller for CRUD operations and data display
 * 
 * Handles all employee-related functionality including listing, viewing,
 * creating, editing, and deleting employee records. Integrates with DataTables
 * for dynamic data display and includes comprehensive validation and
 * authorization controls.
 * 
 * Features:
 * - DataTables integration with server-side processing
 * - Employee CRUD operations with admin authorization
 * - University unit association management
 * - Software role assignment tracking
 * - Advanced search and filtering capabilities
 * - Comprehensive error handling and logging
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class EmployeeController extends BaseController
{
    /**
     * Employee model instance for database operations
     * @var Employee
     */
    private $employeeModel;
    
    /**
     * University unit model instance for unit data
     * @var UniversityUnit
     */
    private $unitModel;
    
    /**
     * Initialize EmployeeController with required models
     * 
     * Sets up the controller with Employee and UniversityUnit models
     * for comprehensive employee management functionality.
     */
    public function __construct()
    {
        parent::__construct();
        $this->employeeModel = new Employee();
        $this->unitModel = new UniversityUnit();
    }
    
    /**
     * Display the employee listing page
     * 
     * Renders the main employee index page with DataTables integration.
     * The actual data loading is handled by getEmployeesData() method
     * for server-side processing.
     * 
     * @return void Renders employee index template or error page
     */
    public function index()
    {
        try {
            $this->render('employees/index.twig', [
                'title' => 'Employees',
                'page' => 'employees'
            ]);
            
        } catch (\Exception $e) {
            error_log("Employee index error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load employees page.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * API endpoint for DataTables employee data
     * 
     * Provides server-side data processing for the employee DataTable including
     * pagination, sorting, searching, and filtering. Returns JSON formatted data
     * with employee information and role assignment counts.
     * 
     * @return void Outputs JSON response with DataTables formatted data
     */
    public function getEmployeesData()
    {
        header('Content-Type: application/json');
        
        try {
            // DataTables parameters
            $draw = intval($_GET['draw'] ?? 1);
            $start = intval($_GET['start'] ?? 0);
            $length = intval($_GET['length'] ?? 10);
            $search = $_GET['search']['value'] ?? '';
            
            // Parse DataTables ordering parameters
            $orderBy = null;
            $orderDir = 'ASC';
            
            if (isset($_GET['order']) && is_array($_GET['order']) && count($_GET['order']) > 0) {
                $columnIndex = intval($_GET['order'][0]['column'] ?? 0);
                $orderDir = $_GET['order'][0]['dir'] ?? 'asc';
                
                // Map DataTables column indices to database column names
                $columnMap = [
                    0 => 'name',                    // Name (combined first + last)
                    1 => 'email',                   // Email
                    2 => 'phone',                   // Phone  
                    3 => 'university_unit_name',    // University Unit
                    4 => 'job_title',               // Job Title
                    // Column 5 (Role Assignments) is not sortable
                    6 => 'created_at'               // Created
                    // Column 7 (Actions) is not sortable
                ];
                
                if (isset($columnMap[$columnIndex])) {
                    $orderBy = $columnMap[$columnIndex];
                }
            }
            
            // Get data with sorting
            $employees = $this->employeeModel->getAllEmployees($length, $start, $search, $orderBy, $orderDir);
            $totalRecords = $this->employeeModel->getTotalCount();
            $filteredRecords = $this->employeeModel->getTotalCount($search);
            
            // Format data for DataTables
            $data = [];
            foreach ($employees as $employee) {
                $data[] = [
                    'id' => $employee['id'],
                    'name' => $employee['first_name'] . ' ' . $employee['last_name'],
                    'first_name' => $employee['first_name'],
                    'last_name' => $employee['last_name'],
                    'email' => $employee['email'],
                    'phone' => $employee['phone'] ?? '',
                    'university_unit_name' => $employee['university_unit_name'] ?? null,
                    'job_title' => $employee['job_title'] ?? '',
                    'business_owner_count' => intval($employee['business_owner_count'] ?? 0),
                    'technical_owner_count' => intval($employee['technical_owner_count'] ?? 0),
                    'technical_manager_count' => intval($employee['technical_manager_count'] ?? 0),
                    'created_at' => date('Y-m-d', strtotime($employee['created_at']))
                ];
            }
            
            echo json_encode([
                'draw' => $draw,
                'recordsTotal' => $totalRecords,
                'recordsFiltered' => $filteredRecords,
                'data' => $data
            ]);
            
        } catch (\Exception $e) {
            error_log("Employee data error: " . $e->getMessage());
            
            echo json_encode([
                'draw' => intval($_GET['draw'] ?? 1),
                'recordsTotal' => 0,
                'recordsFiltered' => 0,
                'data' => [],
                'error' => 'Unable to load employee data'
            ]);
        }
    }
    
    /**
     * Display individual employee details
     * 
     * Shows comprehensive employee information including personal details,
     * university unit association, and software role assignments. Includes
     * counts of software products managed in different roles.
     * 
     * @param int $id Employee ID to display
     * @return void Renders employee detail template or error page
     */
    public function show($id)
    {
        try {
            $employee = $this->employeeModel->getEmployeeById($id);
            
            if (!$employee) {
                http_response_code(404);
                echo $this->twig->render('error.twig', [
                    'title' => 'Employee Not Found',
                    'error_message' => 'Employee not found.'
                ]);
                return;
            }
            
            $softwareRoles = $this->employeeModel->getEmployeeSoftwareRoles($id);
            
            echo $this->twig->render('employees/show.twig', [
                'title' => $employee['first_name'] . ' ' . $employee['last_name'],
                'employee' => $employee,
                'software_roles' => $softwareRoles,
                'page' => 'employees'
            ]);
            
        } catch (\Exception $e) {
            error_log("Employee show error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load employee details.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Display employee creation form or process form submission
     * 
     * Handles both GET requests (show form) and POST requests (process form).
     * Requires administrator privileges for access. Loads university units
     * for dropdown selection and includes comprehensive validation.
     * 
     * @return void Renders creation form, processes submission, or shows error
     */
    public function create()
    {
        // Check if user is admin
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Administrator access required to create employees.',
                'error_details' => 'Only administrators can create new employees.'
            ]);
            return;
        }
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->store();
            return;
        }
        
        try {
            // Get university units for dropdown
            $units = $this->unitModel->getAllUnitsForDropdown();
            
            echo $this->twig->render('employees/create.twig', [
                'title' => 'Add New Employee',
                'page' => 'employees',
                'university_units' => $units
            ]);
            
        } catch (\Exception $e) {
            error_log("Employee create error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load employee creation form.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Process employee creation form submission
     * 
     * Validates form data, creates new employee record, and handles success/error
     * responses. Requires administrator privileges and includes comprehensive
     * data validation including email format and required fields.
     * 
     * @return void Redirects on success or renders form with errors
     */
    public function store()
    {
        // Check if user is admin
        if (!$this->auth->requireAdmin()) {
            header('Content-Type: application/json');
            echo json_encode(['success' => false, 'message' => 'Administrator access required']);
            return;
        }
        
        try {
            $data = [
                'first_name' => trim($_POST['first_name'] ?? ''),
                'last_name' => trim($_POST['last_name'] ?? ''),
                'email' => trim($_POST['email'] ?? ''),
                'phone' => trim($_POST['phone'] ?? ''),
                'university_unit_id' => !empty($_POST['university_unit_id']) ? intval($_POST['university_unit_id']) : null,
                'job_title' => trim($_POST['job_title'] ?? '')
            ];
            
            // Basic validation
            $errors = [];
            if (empty($data['first_name'])) $errors[] = 'First name is required';
            if (empty($data['last_name'])) $errors[] = 'Last name is required';
            if (empty($data['email'])) $errors[] = 'Email is required';
            if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) $errors[] = 'Valid email is required';
            if (empty($data['university_unit_id'])) $errors[] = 'University unit is required';
            
            if (!empty($errors)) {
                // Get university units for dropdown
                $units = $this->unitModel->getAllUnitsForDropdown();
                
                echo $this->twig->render('employees/create.twig', [
                    'title' => 'Add New Employee',
                    'page' => 'employees',
                    'errors' => $errors,
                    'form_data' => $data,
                    'university_units' => $units
                ]);
                return;
            }
            
            $employeeId = $this->employeeModel->createEmployee($data);
            
            if ($employeeId) {
                header('Location: /employees/' . $employeeId . '?success=Employee created successfully');
                exit;
            } else {
                // Get university units for dropdown
                $units = $this->unitModel->getAllUnitsForDropdown();
                
                echo $this->twig->render('employees/create.twig', [
                    'title' => 'Add New Employee',
                    'page' => 'employees',
                    'errors' => ['Failed to create employee'],
                    'form_data' => $data,
                    'university_units' => $units
                ]);
            }
            
        } catch (\Exception $e) {
            error_log("Employee store error: " . $e->getMessage());
            
            // Get university units for dropdown
            $units = $this->unitModel->getAllUnitsForDropdown();
            
            echo $this->twig->render('employees/create.twig', [
                'title' => 'Add New Employee',
                'page' => 'employees',
                'errors' => ['System error: Unable to create employee'],
                'form_data' => $_POST,
                'university_units' => $units
            ]);
        }
    }
    
    /**
     * Display employee edit form or process form submission
     * 
     * Handles both GET requests (show populated form) and POST requests (process form).
     * Requires administrator privileges and loads existing employee data for editing.
     * Includes university unit dropdown population.
     * 
     * @param int $id Employee ID to edit
     * @return void Renders edit form, processes submission, or shows error
     */
    public function edit($id)
    {
        // Check if user is admin
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Administrator access required to edit employees.',
                'error_details' => 'Only administrators can edit employees.'
            ]);
            return;
        }
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->update($id);
            return;
        }
        
        try {
            $employee = $this->employeeModel->getEmployeeById($id);
            
            if (!$employee) {
                http_response_code(404);
                echo $this->twig->render('error.twig', [
                    'title' => 'Employee Not Found',
                    'error_message' => 'Employee not found.'
                ]);
                return;
            }
            
            // Get university units for dropdown
            $units = $this->unitModel->getAllUnitsForDropdown();
            
            echo $this->twig->render('employees/edit.twig', [
                'title' => 'Edit Employee - ' . $employee['first_name'] . ' ' . $employee['last_name'],
                'employee' => $employee,
                'page' => 'employees',
                'university_units' => $units
            ]);
            
        } catch (\Exception $e) {
            error_log("Employee edit error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load employee edit form.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Process employee update form submission
     * 
     * Validates form data, updates existing employee record, and handles success/error
     * responses. Requires administrator privileges and includes comprehensive
     * data validation including email format and required fields.
     * 
     * @param int $id Employee ID to update
     * @return void Redirects on success or renders form with errors
     */
    public function update($id)
    {
        // Check if user is admin
        if (!$this->auth->requireAdmin()) {
            header('Content-Type: application/json');
            echo json_encode(['success' => false, 'message' => 'Administrator access required']);
            return;
        }
        
        try {
            $data = [
                'first_name' => trim($_POST['first_name'] ?? ''),
                'last_name' => trim($_POST['last_name'] ?? ''),
                'email' => trim($_POST['email'] ?? ''),
                'phone' => trim($_POST['phone'] ?? ''),
                'university_unit_id' => !empty($_POST['university_unit_id']) ? intval($_POST['university_unit_id']) : null,
                'job_title' => trim($_POST['job_title'] ?? '')
            ];
            
            // Basic validation
            $errors = [];
            if (empty($data['first_name'])) $errors[] = 'First name is required';
            if (empty($data['last_name'])) $errors[] = 'Last name is required';
            if (empty($data['email'])) $errors[] = 'Email is required';
            if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) $errors[] = 'Valid email is required';
            if (empty($data['university_unit_id'])) $errors[] = 'University unit is required';
            
            if (!empty($errors)) {
                $employee = array_merge(['id' => $id], $data);
                // Get university units for dropdown
                $units = $this->unitModel->getAllUnitsForDropdown();
                
                echo $this->twig->render('employees/edit.twig', [
                    'title' => 'Edit Employee',
                    'page' => 'employees',
                    'employee' => $employee,
                    'errors' => $errors,
                    'university_units' => $units
                ]);
                return;
            }
            
            $success = $this->employeeModel->updateEmployee($id, $data);
            
            if ($success) {
                header('Location: /employees/' . $id . '?success=Employee updated successfully');
                exit;
            } else {
                $employee = array_merge(['id' => $id], $data);
                // Get university units for dropdown
                $units = $this->unitModel->getAllUnitsForDropdown();
                
                echo $this->twig->render('employees/edit.twig', [
                    'title' => 'Edit Employee',
                    'page' => 'employees',
                    'employee' => $employee,
                    'errors' => ['Failed to update employee'],
                    'university_units' => $units
                ]);
            }
            
        } catch (\Exception $e) {
            error_log("Employee update error: " . $e->getMessage());
            
            $employee = array_merge(['id' => $id], $_POST);
            // Get university units for dropdown
            $units = $this->unitModel->getAllUnitsForDropdown();
            
            echo $this->twig->render('employees/edit.twig', [
                'title' => 'Edit Employee',
                'page' => 'employees',
                'employee' => $employee,
                'errors' => ['System error: Unable to update employee'],
                'university_units' => $units
            ]);
        }
    }
    
    /**
     * Delete employee record via AJAX request
     * 
     * Processes DELETE requests to remove employee records from the database.
     * Requires administrator privileges and POST request method. Returns JSON
     * response indicating success or failure status.
     * 
     * @return void Outputs JSON response with deletion status
     */
    public function delete()
    {
        // Check if user is admin
        if (!$this->auth->requireAdmin()) {
            header('Content-Type: application/json');
            echo json_encode(['success' => false, 'message' => 'Administrator access required']);
            return;
        }
        
        header('Content-Type: application/json');
        
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            echo json_encode(['success' => false, 'message' => 'Invalid request method']);
            return;
        }
        
        try {
            $id = intval($_POST['id'] ?? 0);
            
            if ($id <= 0) {
                echo json_encode(['success' => false, 'message' => 'Invalid employee ID']);
                return;
            }
            
            $success = $this->employeeModel->deleteEmployee($id);
            
            if ($success) {
                echo json_encode(['success' => true, 'message' => 'Employee deleted successfully']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to delete employee']);
            }
            
        } catch (\Exception $e) {
            error_log("Employee delete error: " . $e->getMessage());
            echo json_encode(['success' => false, 'message' => 'System error: Unable to delete employee']);
        }
    }
}
