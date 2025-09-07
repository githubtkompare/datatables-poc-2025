<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Models\Employee;
use App\Models\SoftwareProduct;
use App\Models\UniversityUnit;

class HomeController
{
    private $twig;
    private $employeeModel;
    private $softwareModel;
    private $unitModel;
    
    public function __construct()
    {
        $this->twig = TwigConfig::getInstance()->getTwig();
        $this->employeeModel = new Employee();
        $this->softwareModel = new SoftwareProduct();
        $this->unitModel = new UniversityUnit();
    }
    
    public function index()
    {
        try {
            // Get summary statistics
            $stats = [
                'total_employees' => $this->employeeModel->getTotalCount(),
                'total_software' => $this->softwareModel->getTotalCount(),
                'total_units' => $this->unitModel->getTotalCount()
            ];
            
            // Get recent data for dashboard
            $recentEmployees = $this->employeeModel->getAllEmployees(5);
            $recentSoftware = $this->softwareModel->getAllSoftware(5);
            $recentUnits = $this->unitModel->getAllUnits(5);
            
            echo $this->twig->render('dashboard.twig', [
                'title' => 'Dashboard',
                'page' => 'dashboard',
                'stats' => $stats,
                'recent_employees' => $recentEmployees,
                'recent_software' => $recentSoftware,
                'recent_units' => $recentUnits
            ]);
            
        } catch (\Exception $e) {
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
