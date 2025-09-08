<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Models\Employee;
use App\Models\SoftwareProduct;
use App\Models\UniversityUnit;

/**
 * Home controller for dashboard and landing page functionality
 * 
 * This controller handles the main dashboard view that provides an overview
 * of the application's data including summary statistics and recent activity.
 * It serves as the primary entry point for users accessing the application.
 * 
 * Features:
 * - Dashboard with summary statistics
 * - Recent activity display across all main entities
 * - Error handling with user-friendly error pages
 * - Integration with all main data models
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class HomeController
{
    /**
     * Twig Environment instance for template rendering
     * @var \Twig\Environment
     */
    private $twig;
    
    /**
     * Employee model instance for employee data operations
     * @var Employee
     */
    private $employeeModel;
    
    /**
     * Software product model instance for software data operations
     * @var SoftwareProduct
     */
    private $softwareModel;
    
    /**
     * University unit model instance for unit data operations
     * @var UniversityUnit
     */
    private $unitModel;
    
    /**
     * Initialize home controller with required services and models
     * 
     * Sets up the Twig templating engine and instantiates all necessary
     * data models for dashboard functionality. This provides access to
     * all main data entities in the application.
     */
    public function __construct()
    {
        $this->twig = TwigConfig::getInstance()->getTwig();
        $this->employeeModel = new Employee();
        $this->softwareModel = new SoftwareProduct();
        $this->unitModel = new UniversityUnit();
    }
    
    /**
     * Display the main dashboard page
     * 
     * Renders the dashboard view with summary statistics and recent activity
     * from all main data entities (employees, software, university units).
     * Provides error handling to display user-friendly error pages when
     * database connectivity or data retrieval issues occur.
     * 
     * @return void Outputs rendered HTML directly to the browser
     */
    public function index()
    {
        try {
            // Gather summary statistics for dashboard overview
            $stats = [
                'total_employees' => $this->employeeModel->getTotalCount(),
                'total_software' => $this->softwareModel->getTotalCount(),
                'total_units' => $this->unitModel->getTotalCount()
            ];
            
            // Get recent activity data for dashboard preview (limit to 5 items each)
            $recentEmployees = $this->employeeModel->getAllEmployees(5);
            $recentSoftware = $this->softwareModel->getAllSoftware(5);
            $recentUnits = $this->unitModel->getAllUnits(5);
            
            // Render dashboard template with collected data
            echo $this->twig->render('dashboard.twig', [
                'title' => 'Dashboard',
                'page' => 'dashboard',
                'stats' => $stats,
                'recent_employees' => $recentEmployees,
                'recent_software' => $recentSoftware,
                'recent_units' => $recentUnits
            ]);
            
        } catch (\Exception $e) {
            // Log error for debugging while providing user-friendly error page
            error_log("Dashboard error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Error',
                'page' => 'dashboard',
                'error_message' => 'Unable to load dashboard. Please check your database connection.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
}
