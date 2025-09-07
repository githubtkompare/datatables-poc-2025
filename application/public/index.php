<?php

// Load environment variables
if (file_exists(__DIR__ . '/../.env')) {
    $lines = file(__DIR__ . '/../.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0) {
            continue;
        }
        list($name, $value) = explode('=', $line, 2);
        $_ENV[trim($name)] = trim($value);
        putenv(trim($name) . '=' . trim($value));
    }
}

// Set timezone
$timezone = $_ENV['APP_TIMEZONE'] ?? 'America/Chicago';
if (!date_default_timezone_set($timezone)) {
    // Fallback to Chicago if the timezone is invalid
    date_default_timezone_set('America/Chicago');
}

// Include Composer autoloader when available
if (file_exists(__DIR__ . '/../vendor/autoload.php')) {
    require_once __DIR__ . '/../vendor/autoload.php';
}

// Set error reporting based on environment
if (($_ENV['APP_DEBUG'] ?? 'false') === 'true') {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
}

// Start session
session_start();

// Simple router
$request_uri = $_SERVER['REQUEST_URI'];
$path = parse_url($request_uri, PHP_URL_PATH);
$path = rtrim($path, '/') ?: '/';

// Import controllers (temporary until Composer autoload is working)
function loadClass($className) {
    $className = ltrim($className, '\\');
    $fileName = '';
    if ($lastNsPos = strrpos($className, '\\')) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';
    $fullPath = __DIR__ . '/../src/' . $fileName;
    
    if (file_exists($fullPath)) {
        require_once $fullPath;
    }
}

spl_autoload_register('loadClass');

use App\Controllers\HomeController;
use App\Controllers\EmployeeController;
use App\Controllers\SoftwareController;
use App\Controllers\UniversityUnitController;
use App\Controllers\AdminController;
use App\Config\Auth;

try {
    // Route handling
    if ($path === '/' || $path === '/home') {
        $controller = new HomeController();
        $controller->index();
        
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
        
    } elseif ($path === '/admin/db-test') {
        $controller = new AdminController();
        $controller->databaseTest();
        
    } elseif ($path === '/admin/db-test/run') {
        $controller = new AdminController();
        $controller->performDatabaseTest();
        
    } elseif ($path === '/admin/performance-test') {
        $controller = new AdminController();
        $controller->performanceTest();
        
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
