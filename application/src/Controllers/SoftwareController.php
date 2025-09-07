<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Models\SoftwareProduct;
use App\Models\Employee;

class SoftwareController
{
    private $twig;
    private $softwareModel;
    private $employeeModel;
    
    public function __construct()
    {
        $this->twig = TwigConfig::getInstance()->getTwig();
        $this->softwareModel = new SoftwareProduct();
        $this->employeeModel = new Employee();
    }
    
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
            
            echo $this->twig->render('software/edit.twig', [
                'title' => 'Edit Software - ' . $software['software_name'],
                'software' => $software,
                'employees' => $employees,
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
                echo $this->twig->render('software/edit.twig', [
                    'title' => 'Edit Software',
                    'software' => $software,
                    'employees' => $employees,
                    'page' => 'software',
                    'errors' => $errors
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
