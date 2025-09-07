<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Config\Auth;
use App\Config\Database;

class AdminController_cleaned extends BaseController
{
    private $db;
    
    public function __construct()
    {
        parent::__construct();
        $this->db = Database::getInstance();
    }
    
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
     * Toggle admin mode (for demo purposes)
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
}
