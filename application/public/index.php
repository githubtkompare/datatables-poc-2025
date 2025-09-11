<?php

/**
 * Main application entry point and router
 * 
 * This file serves as the central entry point for all HTTP requests to the
 * DataTables POC application. It handles environment configuration, autoloading,
 * session management, and URL routing to appropriate controllers.
 * 
 * Features:
 * - Environment variable loading and configuration
 * - Timezone configuration with fallback
 * - Custom autoloader for application classes
 * - Simple but effective URL routing system
 * - Centralized error handling and logging
 * - Session management initialization
 * 
 * The router uses pattern matching to direct requests to appropriate controllers
 * and actions, supporting both simple paths and parameterized routes with
 * regular expressions.
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */

// Load environment variables from .env file if available
if (file_exists(__DIR__ . '/../.env')) {
    $lines = file(__DIR__ . '/../.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        // Skip comment lines
        if (strpos(trim($line), '#') === 0) {
            continue;
        }
        // Parse key=value pairs and set as environment variables
        list($name, $value) = explode('=', $line, 2);
        $_ENV[trim($name)] = trim($value);
        putenv(trim($name) . '=' . trim($value));
    }
}

// Set application timezone with fallback to Central Time
$timezone = $_ENV['APP_TIMEZONE'] ?? 'America/Chicago';
if (!date_default_timezone_set($timezone)) {
    // Fallback to Chicago if the specified timezone is invalid
    date_default_timezone_set('America/Chicago');
}

// Include Composer autoloader when available for vendor dependencies
if (file_exists(__DIR__ . '/../vendor/autoload.php')) {
    require_once __DIR__ . '/../vendor/autoload.php';
}

// Configure error reporting based on environment debug setting
if (($_ENV['APP_DEBUG'] ?? 'false') === 'true') {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
}

// Initialize session for authentication and state management
session_start();

// Parse the incoming request URI for routing
$request_uri = $_SERVER['REQUEST_URI'];
$path = parse_url($request_uri, PHP_URL_PATH);
$path = rtrim($path, '/') ?: '/';

/**
 * Custom autoloader function for application classes
 * 
 * Provides PSR-4 compatible autoloading for application classes when
 * Composer autoloader is not available. Maps namespace paths to file
 * system paths within the src directory.
 * 
 * @param string $className Fully qualified class name to load
 * @return void
 */
function loadClass($className) {
    $className = ltrim($className, '\\');
    $fileName = '';
    
    // Parse namespace and convert to directory structure
    if ($lastNsPos = strrpos($className, '\\')) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    
    // Add class name and .php extension (PSR-4 standard)
    $fileName .= $className . '.php';
    $fullPath = __DIR__ . '/../src/' . $fileName;
    
    // Include the file if it exists
    if (file_exists($fullPath)) {
        require_once $fullPath;
    }
}

// Register the custom autoloader
spl_autoload_register('loadClass');

// Import required controller classes and configuration
use App\Controllers\HomeController;
use App\Controllers\EmployeeController;
use App\Controllers\SoftwareController;
use App\Controllers\UniversityUnitController;
use App\Controllers\AdminController;
use App\Config\Auth;

try {
    // URL routing system - maps request paths to controller actions
    
    // Home and dashboard routes
    if ($path === '/' || $path === '/home') {
        $controller = new HomeController();
        $controller->index();
        
    // Employee management routes
    } elseif ($path === '/employees') {
        $controller = new EmployeeController();
        $controller->index();
        
    } elseif ($path === '/employees/data') {
        $controller = new EmployeeController();
        $controller->getEmployeesData();
        
    } elseif (preg_match('/^\/employees\/(\d+)$/', $path, $matches)) {
        $controller = new EmployeeController();
        $controller->show($matches[1]);
        
    } elseif ($path === '/employees/create') {
        $controller = new EmployeeController();
        $controller->create();
        
    } elseif (preg_match('/^\/employees\/(\d+)\/edit$/', $path, $matches)) {
        $controller = new EmployeeController();
        $controller->edit($matches[1]);
        
    } elseif ($path === '/employees/delete') {
        $controller = new EmployeeController();
        $controller->delete();
        
    } elseif ($path === '/software') {
        $controller = new SoftwareController();
        $controller->index();
        
    } elseif ($path === '/software/data') {
        $controller = new SoftwareController();
        $controller->getSoftwareData();
        
    } elseif ($path === '/software/autocomplete') {
        $controller = new SoftwareController();
        $controller->getAutocompleteSuggestions();
        
    } elseif ($path === '/software/autocomplete/version') {
        $controller = new SoftwareController();
        $controller->getVersionSuggestions();
        
    } elseif ($path === '/software/autocomplete/vendor') {
        $controller = new SoftwareController();
        $controller->getVendorSuggestions();
        
    } elseif ($path === '/software/autocomplete/employee') {
        $controller = new SoftwareController();
        $controller->getEmployeeSuggestions();
        
    } elseif (preg_match('/^\/software\/(\d+)$/', $path, $matches)) {
        $controller = new SoftwareController();
        $controller->show($matches[1]);
        
    } elseif ($path === '/software/create') {
        $controller = new SoftwareController();
        $controller->create();
        
    } elseif (preg_match('/^\/software\/(\d+)\/edit$/', $path, $matches)) {
        $controller = new SoftwareController();
        $controller->edit($matches[1]);
        
    } elseif ($path === '/software/delete') {
        $controller = new SoftwareController();
        $controller->delete();
        
    } elseif ($path === '/units') {
        $controller = new UniversityUnitController();
        $controller->index();
        
    } elseif ($path === '/units/data') {
        $controller = new UniversityUnitController();
        $controller->getUnitsData();
        
    } elseif (preg_match('/^\/units\/(\d+)$/', $path, $matches)) {
        $controller = new UniversityUnitController();
        $controller->show($matches[1]);
        
    } elseif ($path === '/units/create') {
        $controller = new UniversityUnitController();
        $controller->create();
        
    } elseif (preg_match('/^\/units\/(\d+)\/edit$/', $path, $matches)) {
        $controller = new UniversityUnitController();
        $controller->edit($matches[1]);
        
    } elseif ($path === '/units/delete') {
        $controller = new UniversityUnitController();
        $controller->delete();
        
    } elseif ($path === '/admin') {
        $controller = new AdminController();
        $controller->index();
        
    } elseif (preg_match('/^\/admin\/table\/(.+)$/', $path, $matches)) {
        $controller = new AdminController();
        $controller->viewTable($matches[1]);
        
    } elseif ($path === '/admin/toggle-admin') {
        $controller = new AdminController();
        $controller->toggleAdmin();
        
    } elseif ($path === '/auth/login-admin') {
        // Simple demo login as admin
        $auth = Auth::getInstance();
        $auth->setAdmin();
        header('Location: /admin?success=Logged in as administrator');
        exit;
        
    } elseif ($path === '/auth/login-user') {
        // Simple demo login as user
        $auth = Auth::getInstance();
        $auth->setUser();
        header('Location: /?success=Logged in as regular user');
        exit;
        
    } elseif ($path === '/auth/logout') {
        // Logout
        $auth = Auth::getInstance();
        $auth->logout();
        header('Location: /?success=Logged out successfully');
        exit;
        
    } else {
        http_response_code(404);
        echo "<h1>404 Not Found</h1><p>The page you requested was not found.</p>";
    }
    
} catch (Exception $e) {
    error_log("Application error: " . $e->getMessage());
    
    http_response_code(500);
    if (($_ENV['APP_DEBUG'] ?? 'false') === 'true') {
        echo "<h1>Application Error</h1>";
        echo "<p><strong>Error:</strong> " . htmlspecialchars($e->getMessage()) . "</p>";
        echo "<p><strong>File:</strong> " . htmlspecialchars($e->getFile()) . "</p>";
        echo "<p><strong>Line:</strong> " . $e->getLine() . "</p>";
        echo "<pre>" . htmlspecialchars($e->getTraceAsString()) . "</pre>";
    } else {
        echo "<h1>Internal Server Error</h1><p>An error occurred while processing your request.</p>";
    }
}
