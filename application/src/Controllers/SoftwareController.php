<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Models\SoftwareProduct;
use App\Models\Employee;

/**
 * Software product management controller for comprehensive CRUD operations
 * 
 * Handles all software product functionality including listing, viewing,
 * creating, editing, and deleting software records. Integrates with DataTables
 * for dynamic data display and provides autocomplete functionality for
 * enhanced user experience in forms.
 * 
 * Features:
 * - DataTables integration with server-side processing
 * - Software product CRUD operations with role assignments
 * - Employee role management (business owner, technical owner, technical manager)
 * - Autocomplete functionality for software names, versions, vendors, and employees
 * - University unit association through business owner
 * - Operating system compatibility tracking
 * - Comprehensive error handling and logging
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class SoftwareController
{
    /**
     * Twig template engine instance
     * @var \Twig\Environment
     */
    private $twig;
    
    /**
     * Software product model instance for database operations
     * @var SoftwareProduct
     */
    private $softwareModel;
    
    /**
     * Employee model instance for role assignments and autocomplete
     * @var Employee
     */
    private $employeeModel;
    
    /**
     * Initialize SoftwareController with required dependencies
     * 
     * Sets up the controller with Twig templating, SoftwareProduct model
     * for database operations, and Employee model for role assignments
     * and autocomplete functionality.
     */
    public function __construct()
    {
        $this->twig = TwigConfig::getInstance()->getTwig();
        $this->softwareModel = new SoftwareProduct();
        $this->employeeModel = new Employee();
    }
    
    /**
     * Display the software products listing page
     * 
     * Renders the main software products index page with DataTables integration.
     * The actual data loading is handled by getSoftwareData() method for
     * server-side processing and performance optimization.
     * 
     * @return void Renders software index template or error page
     */
    public function index()
    {
        try {
            echo $this->twig->render('software/index.twig', [
                'title' => 'Software Products',
                'page' => 'software'
            ]);
            
        } catch (\Exception $e) {
            error_log("Software index error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load software page.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * API endpoint for DataTables software product data
     * 
     * Provides server-side data processing for the software DataTable including
     * pagination, sorting, searching, and filtering. Returns JSON formatted data
     * with software information, role assignments, and university unit details.
     * Optimized for handling large datasets efficiently.
     * 
     * @return void Outputs JSON response with DataTables formatted data
     */
    public function getSoftwareData()
    {
        header('Content-Type: application/json');
        
        try {
            // DataTables parameters
            $draw = intval($_GET['draw'] ?? 1);
            $start = intval($_GET['start'] ?? 0);
            $length = intval($_GET['length'] ?? 10);
            $search = $_GET['search']['value'] ?? '';
            
            // Handle sorting parameters
            $orderBy = 'sp.updated_at';
            $orderDir = 'DESC';
            
            if (isset($_GET['order']) && is_array($_GET['order']) && count($_GET['order']) > 0) {
                $orderColumnIndex = intval($_GET['order'][0]['column'] ?? 0);
                $orderDir = strtoupper($_GET['order'][0]['dir'] ?? 'ASC');
                
                // Map column indices to database columns
                $columns = [
                    0 => 'sp.software_name',
                    1 => 'sp.version', 
                    2 => 'sp.vendor_managed',  // Vendor column - sort by vendor_managed status
                    3 => 'operating_systems',
                    4 => 'university_unit',
                    5 => 'sp.created_at',
                    6 => 'sp.id' // Actions column - not sortable but included for completeness
                ];
                
                if (isset($columns[$orderColumnIndex])) {
                    $orderBy = $columns[$orderColumnIndex];
                }
                
                // Ensure orderDir is valid
                if (!in_array($orderDir, ['ASC', 'DESC'])) {
                    $orderDir = 'ASC';
                }
            }
            
            // Get data
            $software = $this->softwareModel->getAllSoftware($length, $start, $search, $orderBy, $orderDir);
            $totalRecords = $this->softwareModel->getTotalCount();
            $filteredRecords = $this->softwareModel->getTotalCount($search);
            
            // Format data for DataTables
            $data = [];
            foreach ($software as $item) {
                // Determine missing roles
                $missingRoles = [];
                if ($item['missing_roles_record'] || $item['missing_business_owner']) {
                    $missingRoles[] = 'Business Owner';
                }
                if ($item['missing_roles_record'] || $item['missing_technical_owner']) {
                    $missingRoles[] = 'Technical Owner';
                }
                if ($item['missing_roles_record'] || $item['missing_technical_manager']) {
                    $missingRoles[] = 'Technical Manager';
                }
                
                $data[] = [
                    'id' => $item['id'],
                    'software_name' => $item['software_name'],
                    'version' => $item['version'] ?? '',
                    'vendor_managed' => $item['vendor_managed'] ? 'Yes' : 'No',
                    'vendor_name' => $item['vendor_name'] ?? 'N/A',
                    'license_type' => $item['license_type'] ?? '',
                    'operating_systems' => $item['operating_systems'] ?? '',
                    'university_unit' => $item['university_unit'] ?? 'Not Assigned',
                    'business_owner' => $item['business_owner'] ?? 'Not Assigned',
                    'business_owner_department' => $item['business_owner_department'] ?? '',
                    'technical_owner' => $item['technical_owner'] ?? 'Not Assigned',
                    'technical_manager' => $item['technical_manager'] ?? 'Not Assigned',
                    'created_at' => date('Y-m-d', strtotime($item['created_at'])),
                    'missing_roles' => $missingRoles,
                    'has_role_warnings' => !empty($missingRoles)
                ];
            }
            
            echo json_encode([
                'draw' => $draw,
                'recordsTotal' => $totalRecords,
                'recordsFiltered' => $filteredRecords,
                'data' => $data
            ]);
            
        } catch (\Exception $e) {
            error_log("Software data error: " . $e->getMessage());
            
            echo json_encode([
                'draw' => intval($_GET['draw'] ?? 1),
                'recordsTotal' => 0,
                'recordsFiltered' => 0,
                'data' => [],
                'error' => 'Unable to load software data'
            ]);
        }
    }
    
    public function getAutocompleteSuggestions()
    {
        header('Content-Type: application/json');
        
        try {
            $search = $_GET['q'] ?? '';
            
            // Get unique software names that match the search term
            $suggestions = $this->softwareModel->getUniqueSoftwareNames($search);
            
            echo json_encode([
                'suggestions' => $suggestions
            ]);
            
        } catch (\Exception $e) {
            error_log("Software autocomplete error: " . $e->getMessage());
            
            echo json_encode([
                'suggestions' => [],
                'error' => 'Unable to load suggestions'
            ]);
        }
    }
    
    /**
     * API endpoint for software version autocomplete suggestions
     * 
     * Returns JSON response containing unique software versions that match
     * the search query parameter. Used by frontend autocomplete functionality
     * for the version input field.
     */
    public function getVersionSuggestions()
    {
        header('Content-Type: application/json');
        
        try {
            $search = $_GET['q'] ?? '';
            $suggestions = $this->softwareModel->getUniqueVersions($search);
            
            echo json_encode([
                'suggestions' => $suggestions
            ]);
            
        } catch (\Exception $e) {
            error_log("Software version autocomplete error: " . $e->getMessage());
            
            echo json_encode([
                'suggestions' => [],
                'error' => 'Unable to load version suggestions'
            ]);
        }
    }
    
    /**
     * API endpoint for software vendor autocomplete suggestions
     * 
     * Returns JSON response containing unique vendor names that match
     * the search query parameter. Used by frontend autocomplete functionality
     * for the vendor name input field.
     */
    public function getVendorSuggestions()
    {
        header('Content-Type: application/json');
        
        try {
            $search = $_GET['q'] ?? '';
            $suggestions = $this->softwareModel->getUniqueVendorNames($search);
            
            echo json_encode([
                'suggestions' => $suggestions
            ]);
            
        } catch (\Exception $e) {
            error_log("Software vendor autocomplete error: " . $e->getMessage());
            
            echo json_encode([
                'suggestions' => [],
                'error' => 'Unable to load vendor suggestions'
            ]);
        }
    }
    
    /**
     * API endpoint for employee autocomplete suggestions
     * 
     * Returns JSON response containing employee data that matches the search
     * query parameter. Used by frontend autocomplete functionality for role
     * assignment fields (business owner, technical owner, technical manager).
     * Searches across first name, last name, and full name combinations.
     */
    public function getEmployeeSuggestions()
    {
        header('Content-Type: application/json');
        
        try {
            $search = $_GET['q'] ?? '';
            $employees = $this->employeeModel->searchEmployees($search);
            
            echo json_encode([
                'suggestions' => $employees
            ]);
            
        } catch (\Exception $e) {
            error_log("Employee autocomplete error: " . $e->getMessage());
            
            echo json_encode([
                'suggestions' => [],
                'error' => 'Unable to load employee suggestions'
            ]);
        }
    }
    
    /**
     * Display individual software product details
     * 
     * Shows comprehensive software product information including basic details,
     * role assignments, operating system compatibility, and university unit
     * association. Provides complete overview for software management.
     * 
     * @param int $id Software product ID to display
     * @return void Renders software detail template or error page
     */
    public function show($id)
    {
        try {
            $software = $this->softwareModel->getSoftwareById($id);
            
            if (!$software) {
                http_response_code(404);
                echo $this->twig->render('error.twig', [
                    'title' => 'Software Not Found',
                    'error_message' => 'Software product not found.'
                ]);
                return;
            }
            
            $operatingSystems = $this->softwareModel->getSoftwareOperatingSystems($id);
            $unit = $this->softwareModel->getSoftwareUnit($id);
            
            echo $this->twig->render('software/show.twig', [
                'title' => $software['software_name'],
                'software' => $software,
                'operating_systems' => $operatingSystems,
                'unit' => $unit,
                'page' => 'software'
            ]);
            
        } catch (\Exception $e) {
            error_log("Software show error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load software details.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Display software creation form or process form submission
     * 
     * Handles both GET requests (show form) and POST requests (process form).
     * Loads employee data for role assignment dropdowns and includes
     * autocomplete functionality for enhanced user experience.
     * 
     * @return void Renders creation form, processes submission, or shows error
     */
    public function create()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->store();
            return;
        }
        
        try {
            $employees = $this->employeeModel->getAllEmployees();
            
            echo $this->twig->render('software/create.twig', [
                'title' => 'Add New Software Product',
                'employees' => $employees,
                'page' => 'software'
            ]);
            
        } catch (\Exception $e) {
            error_log("Software create error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load software creation form.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Process software creation form submission
     * 
     * Validates form data, creates new software product record with role
     * assignments, and handles success/error responses. Includes comprehensive
     * validation for required fields and role assignments.
     * 
     * @return void Redirects on success or renders form with errors
     */
    public function store()
    {
        try {
            $data = [
                'software_name' => trim($_POST['software_name'] ?? ''),
                'version' => trim($_POST['version'] ?? ''),
                'description' => trim($_POST['description'] ?? ''),
                'vendor_managed' => intval($_POST['vendor_managed'] ?? 0),
                'vendor_name' => trim($_POST['vendor_name'] ?? ''),
                'license_type' => trim($_POST['license_type'] ?? ''),
                'installation_notes' => trim($_POST['installation_notes'] ?? ''),
                'business_owner_id' => !empty($_POST['business_owner_id']) ? intval($_POST['business_owner_id']) : null,
                'technical_owner_id' => !empty($_POST['technical_owner_id']) ? intval($_POST['technical_owner_id']) : null,
                'technical_manager_id' => !empty($_POST['technical_manager_id']) ? intval($_POST['technical_manager_id']) : null
            ];
            
            // Clear vendor name if self managed is selected
            if ($data['vendor_managed'] == 0) {
                $data['vendor_name'] = '';
            }
            
            // Basic validation
            $errors = [];
            if (empty($data['software_name'])) $errors[] = 'Software name is required';
            if ($data['vendor_managed'] && empty($data['vendor_name'])) $errors[] = 'Vendor name is required when software is vendor managed';
            
            // New requirement: All three roles are required
            if (empty($data['business_owner_id'])) $errors[] = 'Business owner is required';
            if (empty($data['technical_owner_id'])) $errors[] = 'Technical owner is required';
            if (empty($data['technical_manager_id'])) $errors[] = 'Technical manager is required';
            
            if (!empty($errors)) {
                $employees = $this->employeeModel->getAllEmployees();
                echo $this->twig->render('software/create.twig', [
                    'title' => 'Add New Software Product',
                    'employees' => $employees,
                    'page' => 'software',
                    'errors' => $errors,
                    'form_data' => $data
                ]);
                return;
            }
            
            $softwareId = $this->softwareModel->createSoftware($data);
            
            if ($softwareId) {
                header('Location: /software/' . $softwareId . '?success=Software created successfully');
                exit;
            } else {
                $employees = $this->employeeModel->getAllEmployees();
                echo $this->twig->render('software/create.twig', [
                    'title' => 'Add New Software Product',
                    'employees' => $employees,
                    'page' => 'software',
                    'errors' => ['Failed to create software'],
                    'form_data' => $data
                ]);
            }
            
        } catch (\Exception $e) {
            error_log("Software store error: " . $e->getMessage());
            
            $employees = $this->employeeModel->getAllEmployees();
            echo $this->twig->render('software/create.twig', [
                'title' => 'Add New Software Product',
                'employees' => $employees,
                'page' => 'software',
                'errors' => ['System error: Unable to create software'],
                'form_data' => $_POST
            ]);
        }
    }
    
    /**
     * Display software edit form or process form submission
     * 
     * Handles both GET requests (show populated form) and POST requests (process form).
     * Loads existing software data and employee information for role assignments.
     * Resolves employee IDs to names for autocomplete text inputs.
     * 
     * @param int $id Software product ID to edit
     * @return void Renders edit form, processes submission, or shows error
     */
    public function edit($id)
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->update($id);
            return;
        }
        
        try {
            $software = $this->softwareModel->getSoftwareById($id);
            
            if (!$software) {
                http_response_code(404);
                echo $this->twig->render('error.twig', [
                    'title' => 'Software Not Found',
                    'error_message' => 'Software product not found.'
                ]);
                return;
            }
            
            $employees = $this->employeeModel->getAllEmployees();
            
            // Get current employee names for the text inputs
            $businessOwnerName = '';
            $technicalOwnerName = '';
            $technicalManagerName = '';
            
            if ($software['business_owner_id']) {
                $businessOwner = $this->employeeModel->getEmployeeById($software['business_owner_id']);
                if ($businessOwner) {
                    $businessOwnerName = $businessOwner['first_name'] . ' ' . $businessOwner['last_name'];
                }
            }
            
            if ($software['technical_owner_id']) {
                $technicalOwner = $this->employeeModel->getEmployeeById($software['technical_owner_id']);
                if ($technicalOwner) {
                    $technicalOwnerName = $technicalOwner['first_name'] . ' ' . $technicalOwner['last_name'];
                }
            }
            
            if ($software['technical_manager_id']) {
                $technicalManager = $this->employeeModel->getEmployeeById($software['technical_manager_id']);
                if ($technicalManager) {
                    $technicalManagerName = $technicalManager['first_name'] . ' ' . $technicalManager['last_name'];
                }
            }
            
            echo $this->twig->render('software/edit.twig', [
                'title' => 'Edit Software - ' . $software['software_name'],
                'software' => $software,
                'employees' => $employees,
                'business_owner_name' => $businessOwnerName,
                'technical_owner_name' => $technicalOwnerName,
                'technical_manager_name' => $technicalManagerName,
                'page' => 'software'
            ]);
            
        } catch (\Exception $e) {
            error_log("Software edit error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load software edit form.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Process software update form submission
     * 
     * Validates form data, updates existing software product record and role
     * assignments, and handles success/error responses. Includes comprehensive
     * validation for required fields and role assignments.
     * 
     * @param int $id Software product ID to update
     * @return void Redirects on success or renders form with errors
     */
    public function update($id)
    {
        try {
            $data = [
                'software_name' => trim($_POST['software_name'] ?? ''),
                'version' => trim($_POST['version'] ?? ''),
                'description' => trim($_POST['description'] ?? ''),
                'vendor_managed' => intval($_POST['vendor_managed'] ?? 0),
                'vendor_name' => trim($_POST['vendor_name'] ?? ''),
                'license_type' => trim($_POST['license_type'] ?? ''),
                'installation_notes' => trim($_POST['installation_notes'] ?? ''),
                'business_owner_id' => !empty($_POST['business_owner_id']) ? intval($_POST['business_owner_id']) : null,
                'technical_owner_id' => !empty($_POST['technical_owner_id']) ? intval($_POST['technical_owner_id']) : null,
                'technical_manager_id' => !empty($_POST['technical_manager_id']) ? intval($_POST['technical_manager_id']) : null
            ];
            
            // Clear vendor name if self managed is selected
            if ($data['vendor_managed'] == 0) {
                $data['vendor_name'] = '';
            }
            
            // Basic validation
            $errors = [];
            if (empty($data['software_name'])) $errors[] = 'Software name is required';
            if ($data['vendor_managed'] && empty($data['vendor_name'])) $errors[] = 'Vendor name is required when software is vendor managed';
            
            // New requirement: All three roles are required
            if (empty($data['business_owner_id'])) $errors[] = 'Business owner is required';
            if (empty($data['technical_owner_id'])) $errors[] = 'Technical owner is required';
            if (empty($data['technical_manager_id'])) $errors[] = 'Technical manager is required';
            
            if (!empty($errors)) {
                $software = array_merge(['id' => $id], $data);
                $employees = $this->employeeModel->getAllEmployees();
                
                // Get current employee names for the text inputs from form data
                $businessOwnerName = $_POST['business_owner_name'] ?? '';
                $technicalOwnerName = $_POST['technical_owner_name'] ?? '';
                $technicalManagerName = $_POST['technical_manager_name'] ?? '';
                
                echo $this->twig->render('software/edit.twig', [
                    'title' => 'Edit Software',
                    'software' => $software,
                    'employees' => $employees,
                    'business_owner_name' => $businessOwnerName,
                    'technical_owner_name' => $technicalOwnerName,
                    'technical_manager_name' => $technicalManagerName,
                    'page' => 'software',
                    'errors' => $errors,
                    'form_data' => $_POST
                ]);
                return;
            }
            
            $success = $this->softwareModel->updateSoftware($id, $data);
            
            if ($success) {
                header('Location: /software/' . $id . '?success=Software updated successfully');
                exit;
            } else {
                $software = array_merge(['id' => $id], $data);
                $employees = $this->employeeModel->getAllEmployees();
                echo $this->twig->render('software/edit.twig', [
                    'title' => 'Edit Software',
                    'software' => $software,
                    'employees' => $employees,
                    'page' => 'software',
                    'errors' => ['Failed to update software']
                ]);
            }
            
        } catch (\Exception $e) {
            error_log("Software update error: " . $e->getMessage());
            
            $software = array_merge(['id' => $id], $_POST);
            $employees = $this->employeeModel->getAllEmployees();
            echo $this->twig->render('software/edit.twig', [
                'title' => 'Edit Software',
                'software' => $software,
                'employees' => $employees,
                'page' => 'software',
                'errors' => ['System error: Unable to update software']
            ]);
        }
    }
    
    /**
     * Delete software product record via AJAX request
     * 
     * Processes DELETE requests to remove software product records from the
     * database. Returns JSON response indicating success or failure status.
     * Handles referential integrity and related record cleanup.
     * 
     * @return void Outputs JSON response with deletion status
     */
    public function delete()
    {
        header('Content-Type: application/json');
        
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            echo json_encode(['success' => false, 'message' => 'Invalid request method']);
            return;
        }
        
        try {
            $id = intval($_POST['id'] ?? 0);
            
            if ($id <= 0) {
                echo json_encode(['success' => false, 'message' => 'Invalid software ID']);
                return;
            }
            
            $success = $this->softwareModel->deleteSoftware($id);
            
            if ($success) {
                echo json_encode(['success' => true, 'message' => 'Software deleted successfully']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to delete software']);
            }
            
        } catch (\Exception $e) {
            error_log("Software delete error: " . $e->getMessage());
            echo json_encode(['success' => false, 'message' => 'System error: Unable to delete software']);
        }
    }
}
