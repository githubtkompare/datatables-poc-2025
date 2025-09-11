<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Config\Auth;
use App\Config\Database;

/**
 * Administrator panel controller for system management and monitoring
 * 
 * Provides administrative functionality including system dashboard, database
 * inspection, table viewing, and authentication management. All methods require
 * administrator privileges for access.
 * 
 * Features:
 * - System dashboard with database statistics
 * - Table structure and data inspection
 * - Authentication mode toggling (demo purposes)
 * - Comprehensive error handling and logging
 * - Security validation for database access
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class AdminController extends BaseController
{
    /**
     * Database connection instance for administrative operations
     * @var Database
     */
    private $db;
    
    /**
     * Initialize AdminController with database connection
     * 
     * Sets up the controller with database access for administrative
     * operations and inherits base controller functionality.
     */
    public function __construct()
    {
        parent::__construct();
        $this->db = Database::getInstance();
    }
    
    /**
     * Display the administrator dashboard
     * 
     * Renders the main admin dashboard with system statistics and database
     * information. Requires administrator authentication and provides overview
     * of all database tables with record counts.
     * 
     * @return void Renders admin dashboard template or error page
     */
    public function index()
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Administrator access required.',
                'error_details' => 'You need admin privileges to access the administration panel.'
            ]);
            return;
        }

        try {
            // Get basic system information
            $tableStats = $this->db->getTableStats();
            
            echo $this->twig->render('admin/dashboard.twig', [
                'title' => 'Admin Dashboard',
                'page' => 'admin',
                'table_stats' => $tableStats
            ]);
            
        } catch (\Exception $e) {
            error_log("Admin dashboard error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Admin Dashboard Error',
                'error_message' => 'Unable to load admin dashboard.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    /**
     * Toggle administrator privileges for demonstration purposes
     * 
     * API endpoint that switches between regular user and administrator modes.
     * Returns JSON response indicating the new authentication state. Used for
     * demo functionality to showcase different permission levels.
     * 
     * @return void Outputs JSON response with authentication status
     */
    public function toggleAdmin()
    {
        header('Content-Type: application/json');
        
        try {
            $auth = Auth::getInstance();
            
            if ($auth->isAdmin()) {
                $auth->setUser();
                $message = 'Admin mode disabled. You are now a regular user.';
                $isAdmin = false;
            } else {
                $auth->setAdmin();
                $message = 'Admin mode enabled. You now have administrator privileges.';
                $isAdmin = true;
            }
            
            echo json_encode([
                'success' => true,
                'message' => $message,
                'isAdmin' => $isAdmin,
                'userName' => $auth->getUserName(),
                'userRole' => $auth->getUserRole()
            ]);
            
        } catch (\Exception $e) {
            error_log("Admin toggle error: " . $e->getMessage());
            echo json_encode([
                'success' => false,
                'message' => 'Failed to toggle admin mode'
            ]);
        }
    }
    
    /**
     * Display database table structure and contents
     * 
     * Provides administrative view of database table including column structure,
     * data types, and table contents. Includes security validation to prevent
     * unauthorized table access and SQL injection attacks.
     * 
     * @param string $tableName Name of the database table to view
     * @return void Renders table view template or error page
     * @throws Exception When table name is not in allowed list
     */
    public function viewTable($tableName)
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Administrator access required.',
                'error_details' => 'You need admin privileges to access table information.'
            ]);
            return;
        }

        try {
            // Validate table name to prevent SQL injection
            $allowedTables = [
                'employees',
                'university_units', 
                'software_products',
                'operating_systems',
                'software_operating_systems',
                'software_roles'
            ];
            
            if (!in_array($tableName, $allowedTables)) {
                throw new \Exception("Table '{$tableName}' is not accessible.");
            }
            
            // Get table structure
            $tableStructure = $this->db->getTableStructure($tableName);
            
            // Get table data
            $tableData = $this->db->getTableData($tableName);
            
            // Get record count
            $recordCount = $this->db->getTableRecordCount($tableName);
            
            echo $this->twig->render('admin/table_view.twig', [
                'title' => 'Table View: ' . ucwords(str_replace('_', ' ', $tableName)),
                'page' => 'admin',
                'table_name' => $tableName,
                'table_display_name' => ucwords(str_replace('_', ' ', $tableName)),
                'table_structure' => $tableStructure,
                'table_data' => $tableData,
                'record_count' => $recordCount
            ]);
            
        } catch (\Exception $e) {
            error_log("Table view error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Table View Error',
                'error_message' => 'Unable to load table information.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
}
