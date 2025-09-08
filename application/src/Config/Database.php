<?php

namespace App\Config;

use PDO;
use PDOException;

/**
 * Database connection manager using singleton pattern
 * 
 * This class handles all database connectivity and provides centralized
 * database configuration management. It implements the singleton pattern
 * to ensure only one database connection exists throughout the application.
 * 
 * The class manages MySQL-specific configuration including UTF-8 character
 * encoding, timezone synchronization between PHP and MySQL, and optimal
 * PDO settings for security and performance. It also provides diagnostic
 * and monitoring capabilities for database health checks.
 * 
 * Features:
 * - Singleton pattern for connection management
 * - MySQL-specific configuration with UTF-8 support
 * - Timezone synchronization between PHP and MySQL
 * - Connection testing and monitoring capabilities
 * - Table statistics and structure introspection
 * - Comprehensive error handling and logging
 * - Environment-based configuration management
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class Database
{
    /**
     * Singleton instance of the Database class
     * @var Database|null
     */
    private static $instance = null;
    
    /**
     * PDO database connection instance
     * @var PDO
     */
    private $connection;
    
    /**
     * Database host address
     * @var string
     */
    private $host;
    
    /**
     * Database name
     * @var string
     */
    private $database;
    
    /**
     * Database username
     * @var string
     */
    private $username;
    
    /**
     * Database password
     * @var string
     */
    private $password;
    
    /**
     * Private constructor to initialize database connection
     * 
     * Configures database connection parameters from environment variables
     * and establishes the PDO connection with optimal settings for the application.
     * Sets up timezone synchronization between PHP and MySQL.
     */
    private function __construct()
    {
        // Load database configuration from environment variables with defaults
        $this->host = $_ENV['DB_HOST'] ?? 'database';
        $this->database = $_ENV['DB_NAME'] ?? 'datatables_db';
        $this->username = $_ENV['DB_USER'] ?? 'datatables_user';
        $this->password = $_ENV['DB_PASSWORD'] ?? 'datatables_password';
        
        try {
            // Configure Data Source Name with UTF-8 support
            $dsn = "mysql:host={$this->host};dbname={$this->database};charset=utf8mb4";
            
            // PDO connection options for optimal security and performance
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,     // Enable exceptions for error handling
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Return associative arrays by default
                PDO::ATTR_EMULATE_PREPARES => false,              // Use native prepared statements
                PDO::ATTR_PERSISTENT => false,                    // Disable persistent connections for this POC
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4" // Ensure UTF-8 character encoding
            ];
            
            $this->connection = new PDO($dsn, $this->username, $this->password, $options);
            
            // Synchronize MySQL timezone with PHP application timezone
            $timezone = $_ENV['APP_TIMEZONE'] ?? 'America/Chicago';
            // Convert PHP timezone to MySQL timezone format
            $mysqlTimezone = $this->getMySQLTimezoneOffset($timezone);
            $this->connection->exec("SET time_zone = '$mysqlTimezone'");
            
        } catch (PDOException $e) {
            error_log("Database connection failed: " . $e->getMessage());
            throw new PDOException("Database connection failed: " . $e->getMessage());
        }
    }
    
    /**
     * Get singleton instance of Database class
     * 
     * Implements the singleton pattern to ensure only one database connection
     * exists throughout the application lifecycle, improving performance and
     * resource management.
     * 
     * @return Database The singleton Database instance
     */
    public static function getInstance(): Database
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        
        return self::$instance;
    }
    
    /**
     * Get the PDO database connection
     * 
     * Returns the active PDO connection instance for use by models
     * and other database-dependent components.
     * 
     * @return PDO The configured PDO connection instance
     */
    public function getConnection(): PDO
    {
        return $this->connection;
    }
    
    /**
     * Test database connection and gather diagnostic information
     * 
     * Performs a comprehensive connection test including response time measurement,
     * version detection, and connection status verification. Used for system
     * health monitoring and troubleshooting.
     * 
     * @return array Associative array containing test results and diagnostic data
     */
    public function testConnection(): array
    {
        $result = [
            'success' => false,
            'message' => '',
            'details' => []
        ];
        
        try {
            // Measure connection response time
            $start_time = microtime(true);
            $stmt = $this->connection->query("SELECT 1 as test, NOW() as `current_time`, VERSION() as mysql_version");
            $data = $stmt->fetch();
            $end_time = microtime(true);
            
            // Connection successful - gather diagnostic information
            $result['success'] = true;
            $result['message'] = 'Database connection successful';
            $result['details'] = [
                'host' => $this->host,
                'database' => $this->database,
                'username' => $this->username,
                'mysql_version' => $data['mysql_version'],
                'current_time' => $data['current_time'],
                'response_time' => round(($end_time - $start_time) * 1000, 2) . ' ms',
                'connection_status' => 'Active'
            ];
            
        } catch (PDOException $e) {
            // Connection failed - provide error details
            $result['message'] = 'Database connection failed: ' . $e->getMessage();
            $result['details'] = [
                'host' => $this->host,
                'database' => $this->database,
                'username' => $this->username,
                'error' => $e->getMessage(),
                'connection_status' => 'Failed'
            ];
        }
        
        return $result;
    }
    
    /**
     * Get record counts for all main application tables
     * 
     * Provides a quick overview of data volume across the main tables
     * used by the application. Useful for dashboard statistics and
     * database health monitoring.
     * 
     * @return array Associative array with table names as keys and record counts as values
     */
    public function getTableStats(): array
    {
        // Define the main tables used by the application
        $tables = [
            'employees',
            'university_units', 
            'software_products',
            'operating_systems',
            'software_operating_systems',
            'software_roles'
        ];
        
        $stats = [];
        
        // Get record count for each table
        foreach ($tables as $table) {
            try {
                $stmt = $this->connection->prepare("SELECT COUNT(*) as count FROM {$table}");
                $stmt->execute();
                $result = $stmt->fetch();
                $stats[$table] = $result['count'];
            } catch (PDOException $e) {
                $stats[$table] = 'Error: ' . $e->getMessage();
            }
        }
        
        return $stats;
    }
    
    /**
     * Get table structure information using DESCRIBE command
     * 
     * Retrieves detailed information about a table's columns, including
     * data types, null constraints, keys, and default values. Used for
     * administrative interfaces and debugging.
     * 
     * @param string $tableName Name of the table to describe
     * @return array Array of column definitions
     * @throws \Exception If table doesn't exist or cannot be accessed
     */
    public function getTableStructure(string $tableName): array
    {
        try {
            $stmt = $this->connection->prepare("DESCRIBE {$tableName}");
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error getting table structure for {$tableName}: " . $e->getMessage());
            throw new \Exception("Unable to retrieve table structure for {$tableName}");
        }
    }
    
    /**
     * Get table data with pagination support
     * 
     * Retrieves data from a specified table with LIMIT/OFFSET pagination.
     * Used by administrative interfaces to browse table contents safely
     * without loading excessive amounts of data.
     * 
     * @param string $tableName Name of the table to query
     * @param int $limit Maximum number of records to return
     * @param int $offset Number of records to skip from the beginning
     * @return array Array of table records
     * @throws \Exception If table doesn't exist or cannot be accessed
     */
    public function getTableData(string $tableName, int $limit = 100, int $offset = 0): array
    {
        try {
            $stmt = $this->connection->prepare("SELECT * FROM {$tableName} LIMIT :limit OFFSET :offset");
            $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
            $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log("Error getting table data for {$tableName}: " . $e->getMessage());
            throw new \Exception("Unable to retrieve table data for {$tableName}");
        }
    }
    
    /**
     * Get total record count for a specific table
     * 
     * Returns the total number of records in a table. Used for pagination
     * calculations and data volume monitoring.
     * 
     * @param string $tableName Name of the table to count
     * @return int Total number of records in the table
     * @throws \Exception If table doesn't exist or cannot be accessed
     */
    public function getTableRecordCount(string $tableName): int
    {
        try {
            $stmt = $this->connection->prepare("SELECT COUNT(*) as count FROM {$tableName}");
            $stmt->execute();
            $result = $stmt->fetch();
            return (int) $result['count'];
        } catch (PDOException $e) {
            error_log("Error getting record count for {$tableName}: " . $e->getMessage());
            throw new \Exception("Unable to retrieve record count for {$tableName}");
        }
    }
    
    /**
     * Convert PHP timezone to MySQL timezone offset format
     * 
     * Converts a PHP timezone identifier (e.g., 'America/Chicago') to MySQL's
     * timezone offset format (e.g., '-06:00'). This ensures consistent
     * timestamp handling between PHP and MySQL operations.
     * 
     * @param string $timezone PHP timezone identifier
     * @return string MySQL timezone offset in format '+/-HH:MM'
     */
    private function getMySQLTimezoneOffset(string $timezone): string
    {
        try {
            $tz = new \DateTimeZone($timezone);
            $now = new \DateTime('now', $tz);
            $offset = $now->getOffset();
            
            // Convert offset seconds to MySQL format (+/-HH:MM)
            $hours = intval($offset / 3600);
            $minutes = abs(($offset % 3600) / 60);
            
            return sprintf('%+03d:%02d', $hours, $minutes);
        } catch (\Exception $e) {
            // Fallback to Central Time (-06:00 standard, -05:00 daylight)
            return '-06:00';
        }
    }
    
    /**
     * Prevent cloning of singleton instance
     * 
     * @return void
     */
    private function __clone() {}
    
    /**
     * Prevent unserialization of singleton instance
     * 
     * @throws \Exception Always throws exception to prevent unserialization
     * @return void
     */
    public function __wakeup()
    {
        throw new \Exception("Cannot unserialize a singleton.");
    }
}
