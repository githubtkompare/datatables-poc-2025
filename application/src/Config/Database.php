<?php

namespace App\Config;

use PDO;
use PDOException;

class Database
{
    private static $instance = null;
    private $connection;
    
    private $host;
    private $database;
    private $username;
    private $password;
    
    private function __construct()
    {
        $this->host = $_ENV['DB_HOST'] ?? 'database';
        $this->database = $_ENV['DB_NAME'] ?? 'datatables_db';
        $this->username = $_ENV['DB_USER'] ?? 'datatables_user';
        $this->password = $_ENV['DB_PASSWORD'] ?? 'datatables_password';
        
        try {
            $dsn = "mysql:host={$this->host};dbname={$this->database};charset=utf8mb4";
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
                PDO::ATTR_PERSISTENT => false,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
            ];
            
            $this->connection = new PDO($dsn, $this->username, $this->password, $options);
            
            // Set MySQL timezone to match PHP timezone
            $timezone = $_ENV['APP_TIMEZONE'] ?? 'America/Chicago';
            // Convert PHP timezone to MySQL timezone format
            $mysqlTimezone = $this->getMySQLTimezoneOffset($timezone);
            $this->connection->exec("SET time_zone = '$mysqlTimezone'");
            
        } catch (PDOException $e) {
            error_log("Database connection failed: " . $e->getMessage());
            throw new PDOException("Database connection failed: " . $e->getMessage());
        }
    }
    
    public static function getInstance(): Database
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        
        return self::$instance;
    }
    
    public function getConnection(): PDO
    {
        return $this->connection;
    }
    
    public function testConnection(): array
    {
        $result = [
            'success' => false,
            'message' => '',
            'details' => []
        ];
        
        try {
            $start_time = microtime(true);
            $stmt = $this->connection->query("SELECT 1 as test, NOW() as `current_time`, VERSION() as mysql_version");
            $data = $stmt->fetch();
            $end_time = microtime(true);
            
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
    
    public function getTableStats(): array
    {
        $tables = [
            'employees',
            'university_units', 
            'software_products',
            'operating_systems',
            'software_operating_systems',
            'software_roles'
        ];
        
        $stats = [];
        
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
     * Get table structure information
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
     * Get record count for a table
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
     * Convert PHP timezone to MySQL timezone offset
     */
    private function getMySQLTimezoneOffset(string $timezone): string
    {
        try {
            $tz = new \DateTimeZone($timezone);
            $now = new \DateTime('now', $tz);
            $offset = $now->getOffset();
            
            // Convert offset to MySQL format (+/-HH:MM)
            $hours = intval($offset / 3600);
            $minutes = abs(($offset % 3600) / 60);
            
            return sprintf('%+03d:%02d', $hours, $minutes);
        } catch (\Exception $e) {
            // Fallback to Central Time (-06:00 standard, -05:00 daylight)
            return '-06:00';
        }
    }
    
    // Prevent cloning
    private function __clone() {}
    
    // Prevent unserialization
    public function __wakeup()
    {
        throw new \Exception("Cannot unserialize a singleton.");
    }
}
