<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Config\Auth;
use App\Models\UniversityUnit;

/**
 * University unit management controller for organizational structure
 * 
 * Handles all university unit functionality including listing, viewing,
 * creating, editing, and deleting organizational units. Manages hierarchical
 * relationships between units and tracks associated software products and employees.
 * 
 * Features:
 * - DataTables integration with server-side processing
 * - University unit CRUD operations with admin authorization
 * - Hierarchical unit relationship management
 * - Software product association tracking
 * - Employee count tracking per unit
 * - Comprehensive error handling and logging
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class UniversityUnitController extends BaseController
{
    /**
     * University unit model instance for database operations
     * @var UniversityUnit
     */
    private $unitModel;
    
    /**
     * Initialize UniversityUnitController with required model
     * 
     * Sets up the controller with UniversityUnit model for comprehensive
     * organizational unit management functionality.
     */
    public function __construct()
    {
        parent::__construct();
        $this->unitModel = new UniversityUnit();
    }
    
    /**
     * Display the university units listing page
     * 
     * Renders the main university units index page with DataTables integration.
     * The actual data loading is handled by getUnitsData() method for
     * server-side processing and performance optimization.
     * 
     * @return void Renders units index template or error page
     */
    public function index()
    {
        try {
            echo $this->twig->render('units/index.twig', [
                'title' => 'University Units',
                'page' => 'units'
            ]);
            
        } catch (\Exception $e) {
            error_log("Unit index error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load university units page.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * API endpoint for DataTables university unit data
     * 
     * Provides server-side data processing for the units DataTable including
     * pagination, sorting, searching, and filtering. Returns JSON formatted data
     * with unit information, hierarchical relationships, and associated counts.
     * 
     * @return void Outputs JSON response with DataTables formatted data
     */
    public function getUnitsData()
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
                    0 => 'unit_name',        // Unit Name
                    1 => 'unit_code',        // Code  
                    2 => 'unit_type',        // Type
                    3 => 'parent_unit_name', // Parent Unit
                    4 => 'software_count',   // Software Count
                    5 => 'updated_at'        // Last Updated
                    // Column 6 (Actions) is not sortable
                ];
                
                if (isset($columnMap[$columnIndex])) {
                    $orderBy = $columnMap[$columnIndex];
                }
            }
            
            // Get data with sorting
            $units = $this->unitModel->getAllUnits($length, $start, $search, $orderBy, $orderDir);
            $totalRecords = $this->unitModel->getTotalCount();
            $filteredRecords = $this->unitModel->getTotalCount($search);
            
            // Format data for DataTables
            $data = [];
            foreach ($units as $unit) {
                $data[] = [
                    'id' => $unit['id'],
                    'unit_name' => $unit['unit_name'],
                    'unit_code' => $unit['unit_code'] ?? '',
                    'description' => $unit['description'] ?? '',
                    'unit_type' => ucfirst($unit['unit_type']),
                    'parent_unit_name' => $unit['parent_unit_name'] ?? 'None',
                    'software_count' => intval($unit['software_count'] ?? 0),
                    'updated_at' => date('M j, Y', strtotime($unit['updated_at']))
                ];
            }
            
            echo json_encode([
                'draw' => $draw,
                'recordsTotal' => $totalRecords,
                'recordsFiltered' => $filteredRecords,
                'data' => $data
            ]);
            
        } catch (\Exception $e) {
            error_log("Unit data error: " . $e->getMessage());
            
            echo json_encode([
                'draw' => intval($_GET['draw'] ?? 1),
                'recordsTotal' => 0,
                'recordsFiltered' => 0,
                'data' => [],
                'error' => 'Unable to load unit data'
            ]);
        }
    }
    
    /**
     * Display individual university unit details
     * 
     * Shows comprehensive university unit information including basic details,
     * hierarchical relationships, assigned software products, and employee counts.
     * Provides complete overview for organizational unit management.
     * 
     * @param int $id University unit ID to display
     * @return void Renders unit detail template or error page
     */
    public function show($id)
    {
        try {
            $unit = $this->unitModel->getUnitById($id);
            
            if (!$unit) {
                http_response_code(404);
                echo $this->twig->render('error.twig', [
                    'title' => 'Unit Not Found',
                    'error_message' => 'University unit not found.'
                ]);
                return;
            }
            
            $unitSoftware = $this->unitModel->getUnitSoftware($id);
            
            $this->render('units/show.twig', [
                'title' => $unit['unit_name'],
                'unit' => $unit,
                'unit_software' => $unitSoftware,
                'page' => 'units'
            ]);
            
        } catch (\Exception $e) {
            error_log("Unit show error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load unit details.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Display university unit creation form or process form submission
     * 
     * Handles both GET requests (show form) and POST requests (process form).
     * Requires administrator privileges for access. Loads parent units for
     * hierarchical relationship dropdown selection.
     * 
     * @return void Renders creation form, processes submission, or shows error
     */
    public function create()
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Only administrators can create university units.',
                'error_details' => 'You need admin privileges to access this feature.'
            ]);
            return;
        }
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->store();
            return;
        }
        
        try {
            $allUnits = $this->unitModel->getAllUnits();
            $unitTypes = $this->unitModel->getUnitTypes();
            
            echo $this->twig->render('units/create.twig', [
                'title' => 'Add New University Unit',
                'all_units' => $allUnits,
                'unit_types' => $unitTypes,
                'page' => 'units'
            ]);
            
        } catch (\Exception $e) {
            error_log("Unit create error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load unit creation form.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Process university unit creation form submission
     * 
     * Validates form data, creates new university unit record, and handles
     * success/error responses. Requires administrator privileges and includes
     * comprehensive validation for required fields and hierarchical relationships.
     * 
     * @return void Redirects on success or renders form with errors
     */
    public function store()
    {
        try {
            $data = [
                'unit_name' => trim($_POST['unit_name'] ?? ''),
                'unit_code' => trim($_POST['unit_code'] ?? ''),
                'description' => trim($_POST['description'] ?? ''),
                'parent_unit_id' => !empty($_POST['parent_unit_id']) ? intval($_POST['parent_unit_id']) : null,
                'unit_type' => trim($_POST['unit_type'] ?? 'department')
            ];
            
            // Basic validation
            $errors = [];
            if (empty($data['unit_name'])) $errors[] = 'Unit name is required';
            if (empty($data['unit_code'])) $errors[] = 'Unit code is required';
            
            if (!empty($errors)) {
                $allUnits = $this->unitModel->getAllUnits();
                $unitTypes = $this->unitModel->getUnitTypes();
                echo $this->twig->render('units/create.twig', [
                    'title' => 'Add New University Unit',
                    'all_units' => $allUnits,
                    'unit_types' => $unitTypes,
                    'page' => 'units',
                    'errors' => $errors,
                    'form_data' => $data
                ]);
                return;
            }
            
            $unitId = $this->unitModel->createUnit($data);
            
            if ($unitId) {
                header('Location: /units/' . $unitId . '?success=Unit created successfully');
                exit;
            } else {
                $allUnits = $this->unitModel->getAllUnits();
                $unitTypes = $this->unitModel->getUnitTypes();
                echo $this->twig->render('units/create.twig', [
                    'title' => 'Add New University Unit',
                    'all_units' => $allUnits,
                    'unit_types' => $unitTypes,
                    'page' => 'units',
                    'errors' => ['Failed to create unit'],
                    'form_data' => $data
                ]);
            }
            
        } catch (\Exception $e) {
            error_log("Unit store error: " . $e->getMessage());
            
            $allUnits = $this->unitModel->getAllUnits();
            $unitTypes = $this->unitModel->getUnitTypes();
            echo $this->twig->render('units/create.twig', [
                'title' => 'Add New University Unit',
                'all_units' => $allUnits,
                'unit_types' => $unitTypes,
                'page' => 'units',
                'errors' => ['System error: Unable to create unit'],
                'form_data' => $_POST
            ]);
        }
    }
    
    /**
     * Display university unit edit form or process form submission
     * 
     * Handles both GET requests (show populated form) and POST requests (process form).
     * Requires administrator privileges and loads existing unit data for editing.
     * Includes parent unit dropdown population for hierarchical management.
     * 
     * @param int $id University unit ID to edit
     * @return void Renders edit form, processes submission, or shows error
     */
    public function edit($id)
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Only administrators can edit university units.',
                'error_details' => 'You need admin privileges to access this feature.'
            ]);
            return;
        }
        
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $this->update($id);
            return;
        }
        
        try {
            $unit = $this->unitModel->getUnitById($id);
            
            if (!$unit) {
                http_response_code(404);
                echo $this->twig->render('error.twig', [
                    'title' => 'Unit Not Found',
                    'error_message' => 'University unit not found.'
                ]);
                return;
            }
            
            // Get all units excluding the current one for parent selection
            $allUnits = array_filter(
                $this->unitModel->getAllUnits(), 
                function($u) use ($id) { 
                    return $u['id'] != $id; 
                }
            );
            $unitTypes = $this->unitModel->getUnitTypes();
            
            echo $this->twig->render('units/edit.twig', [
                'title' => 'Edit Unit - ' . $unit['unit_name'],
                'unit' => $unit,
                'all_units' => $allUnits,
                'unit_types' => $unitTypes,
                'page' => 'units'
            ]);
            
        } catch (\Exception $e) {
            error_log("Unit edit error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'error_message' => 'Unable to load unit edit form.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Process university unit update form submission
     * 
     * Validates form data, updates existing university unit record, and handles
     * success/error responses. Requires administrator privileges and includes
     * comprehensive validation for required fields and hierarchical relationships.
     * 
     * @param int $id University unit ID to update
     * @return void Redirects on success or renders form with errors
     */
    public function update($id)
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Only administrators can update university units.',
                'error_details' => 'You need admin privileges to access this feature.'
            ]);
            return;
        }
        
        try {
            $data = [
                'unit_name' => trim($_POST['unit_name'] ?? ''),
                'unit_code' => trim($_POST['unit_code'] ?? ''),
                'description' => trim($_POST['description'] ?? ''),
                'parent_unit_id' => !empty($_POST['parent_unit_id']) ? intval($_POST['parent_unit_id']) : null,
                'unit_type' => trim($_POST['unit_type'] ?? 'department')
            ];
            
            // Basic validation
            $errors = [];
            if (empty($data['unit_name'])) $errors[] = 'Unit name is required';
            if (empty($data['unit_code'])) $errors[] = 'Unit code is required';
            
            if (!empty($errors)) {
                $unit = array_merge(['id' => $id], $data);
                $allUnits = array_filter(
                    $this->unitModel->getAllUnits(), 
                    function($u) use ($id) { 
                        return $u['id'] != $id; 
                    }
                );
                $unitTypes = $this->unitModel->getUnitTypes();
                echo $this->twig->render('units/edit.twig', [
                    'title' => 'Edit Unit',
                    'unit' => $unit,
                    'all_units' => $allUnits,
                    'unit_types' => $unitTypes,
                    'page' => 'units',
                    'errors' => $errors
                ]);
                return;
            }
            
            $success = $this->unitModel->updateUnit($id, $data);
            
            if ($success) {
                header('Location: /units/' . $id . '?success=Unit updated successfully');
                exit;
            } else {
                $unit = array_merge(['id' => $id], $data);
                $allUnits = array_filter(
                    $this->unitModel->getAllUnits(), 
                    function($u) use ($id) { 
                        return $u['id'] != $id; 
                    }
                );
                $unitTypes = $this->unitModel->getUnitTypes();
                echo $this->twig->render('units/edit.twig', [
                    'title' => 'Edit Unit',
                    'unit' => $unit,
                    'all_units' => $allUnits,
                    'unit_types' => $unitTypes,
                    'page' => 'units',
                    'errors' => ['Failed to update unit']
                ]);
            }
            
        } catch (\Exception $e) {
            error_log("Unit update error: " . $e->getMessage());
            
            $unit = array_merge(['id' => $id], $_POST);
            $allUnits = array_filter(
                $this->unitModel->getAllUnits(), 
                function($u) use ($id) { 
                    return $u['id'] != $id; 
                }
            );
            $unitTypes = $this->unitModel->getUnitTypes();
            echo $this->twig->render('units/edit.twig', [
                'title' => 'Edit Unit',
                'unit' => $unit,
                'all_units' => $allUnits,
                'unit_types' => $unitTypes,
                'page' => 'units',
                'errors' => ['System error: Unable to update unit']
            ]);
        }
    }
    
    /**
     * Delete university unit record via AJAX request
     * 
     * Processes DELETE requests to remove university unit records from the
     * database. Returns JSON response indicating success or failure status.
     * Handles referential integrity with employees and software products.
     * 
     * @return void Outputs JSON response with deletion status
     */
    public function delete()
    {
        header('Content-Type: application/json');
        
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo json_encode([
                'success' => false,
                'message' => 'Only administrators can delete university units.'
            ]);
            return;
        }
        
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            echo json_encode(['success' => false, 'message' => 'Invalid request method']);
            return;
        }
        
        try {
            $id = intval($_POST['id'] ?? 0);
            
            if ($id <= 0) {
                echo json_encode(['success' => false, 'message' => 'Invalid unit ID']);
                return;
            }
            
            $success = $this->unitModel->deleteUnit($id);
            
            if ($success) {
                echo json_encode(['success' => true, 'message' => 'Unit deleted successfully']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to delete unit']);
            }
            
        } catch (\Exception $e) {
            error_log("Unit delete error: " . $e->getMessage());
            echo json_encode(['success' => false, 'message' => 'System error: Unable to delete unit']);
        }
    }
}
