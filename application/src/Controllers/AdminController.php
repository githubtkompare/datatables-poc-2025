<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Config\Auth;
use App\Config\Database;
use App\Config\TwigConfig;
use PDOException;

class AdminController extends BaseController
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
            $dbTest = $this->db->testConnection();
            $tableStats = $this->db->getTableStats();
            
            echo $this->twig->render('admin/dashboard.twig', [
                'title' => 'Admin Dashboard',
                'page' => 'admin',
                'db_test' => $dbTest,
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
    
    public function databaseTest()
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Administrator access required.',
                'error_details' => 'You need admin privileges to access database testing.'
            ]);
            return;
        }

        try {
            echo $this->twig->render('admin/db-test.twig', [
                'title' => 'Database Testing',
                'page' => 'db-test'
            ]);
            
        } catch (\Exception $e) {
            error_log("Database test page error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Database Test Error',
                'error_message' => 'Unable to load database test page.',
                'error_details' => $e->getMessage()
            ]);
        }
    }
    
    public function performDatabaseTest()
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            header('Content-Type: application/json');
            echo json_encode([
                'success' => false,
                'message' => 'Administrator access required',
                'error' => 'You need admin privileges to perform database tests.'
            ]);
            return;
        }

        header('Content-Type: application/json');
        
        try {
            $testType = $_GET['type'] ?? 'connection';
            $result = [];
            
            switch ($testType) {
                case 'connection':
                    $result = $this->testDatabaseConnection();
                    break;
                    
                case 'performance':
                    $result = $this->testDatabasePerformance();
                    break;
                    
                case 'tables':
                    $result = $this->testTableIntegrity();
                    break;
                    
                case 'queries':
                    $result = $this->testComplexQueries();
                    break;
                    
                case 'search':
                    $result = $this->testSearchPerformance();
                    break;
                    
                default:
                    $result = [
                        'success' => false,
                        'message' => 'Invalid test type',
                        'details' => []
                    ];
            }
            
            echo json_encode($result);
            
        } catch (\Exception $e) {
            error_log("Database test error: " . $e->getMessage());
            
            echo json_encode([
                'success' => false,
                'message' => 'Database test failed: ' . $e->getMessage(),
                'details' => []
            ]);
        }
    }
    
    private function testDatabaseConnection(): array
    {
        try {
            $startTime = microtime(true);
            $connectionTest = $this->db->testConnection();
            $endTime = microtime(true);
            
            $result = $connectionTest;
            $result['test_duration'] = round(($endTime - $startTime) * 1000, 2) . ' ms';
            $result['timestamp'] = date('Y-m-d H:i:s');
            
            // Additional connection tests
            $conn = $this->db->getConnection();
            
            // Test multiple connections
            $connectionTests = [];
            for ($i = 1; $i <= 5; $i++) {
                $testStart = microtime(true);
                $stmt = $conn->query("SELECT $i as test_number, NOW() as test_time");
                $testData = $stmt->fetch();
                $testEnd = microtime(true);
                
                $connectionTests[] = [
                    'test_number' => $i,
                    'response_time' => round(($testEnd - $testStart) * 1000, 2) . ' ms',
                    'test_time' => $testData['test_time']
                ];
            }
            
            $result['connection_tests'] = $connectionTests;
            
            return $result;
            
        } catch (PDOException $e) {
            return [
                'success' => false,
                'message' => 'Database connection test failed: ' . $e->getMessage(),
                'details' => ['error' => $e->getMessage()]
            ];
        }
    }
    
    private function testDatabasePerformance(): array
    {
        try {
            $conn = $this->db->getConnection();
            $performanceTests = [];
            
            // Test 1: Simple SELECT query
            $startTime = microtime(true);
            $stmt = $conn->query("SELECT COUNT(*) as count FROM employees");
            $result = $stmt->fetch();
            $endTime = microtime(true);
            
            $performanceTests['simple_count'] = [
                'query' => 'SELECT COUNT(*) FROM employees',
                'result_count' => $result['count'],
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
            ];
            
            // Test 2: Complex JOIN query
            $startTime = microtime(true);
            $stmt = $conn->query("
                SELECT e.id, e.first_name, e.last_name, COUNT(sr.software_id) as software_count
                FROM employees e
                LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)
                GROUP BY e.id, e.first_name, e.last_name
                LIMIT 10
            ");
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $performanceTests['complex_join'] = [
                'query' => 'Complex JOIN with GROUP BY',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
            ];
            
            // Test 3: Full-text search simulation
            $startTime = microtime(true);
            $stmt = $conn->prepare("
                SELECT sp.*, u.unit_name, COUNT(DISTINCT sr.id) as role_count
                FROM software_products sp
                LEFT JOIN university_units u ON sp.university_unit_id = u.id
                LEFT JOIN software_roles sr ON sp.id = sr.software_id
                WHERE sp.software_name LIKE ? OR sp.description LIKE ?
                GROUP BY sp.id
                LIMIT 20
            ");
            $searchTerm = '%software%';
            $stmt->execute([$searchTerm, $searchTerm]);
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $performanceTests['search_query'] = [
                'query' => 'Search with LIKE and aggregation',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
            ];
            
            // Test 4: Multiple table stats
            $tableStats = $this->db->getTableStats();
            
            return [
                'success' => true,
                'message' => 'Database performance tests completed successfully',
                'details' => [
                    'performance_tests' => $performanceTests,
                    'table_statistics' => $tableStats,
                    'timestamp' => date('Y-m-d H:i:s')
                ]
            ];
            
        } catch (PDOException $e) {
            return [
                'success' => false,
                'message' => 'Database performance test failed: ' . $e->getMessage(),
                'details' => ['error' => $e->getMessage()]
            ];
        }
    }
    
    private function testTableIntegrity(): array
    {
        try {
            $conn = $this->db->getConnection();
            $integrityTests = [];
            
            // Test foreign key constraints
            $foreignKeyTests = [
                [
                    'table' => 'software_roles',
                    'query' => 'SELECT COUNT(*) as count FROM software_roles sr LEFT JOIN software_products sp ON sr.software_id = sp.id WHERE sp.id IS NULL',
                    'description' => 'Orphaned software roles'
                ],
                [
                    'table' => 'software_operating_systems',
                    'query' => 'SELECT COUNT(*) as count FROM software_operating_systems sos LEFT JOIN software_products sp ON sos.software_id = sp.id WHERE sp.id IS NULL',
                    'description' => 'Orphaned software-OS assignments'
                ],
                [
                    'table' => 'software_products',
                    'query' => 'SELECT COUNT(*) as count FROM software_products sp LEFT JOIN university_units u ON sp.university_unit_id = u.id WHERE sp.university_unit_id IS NOT NULL AND u.id IS NULL',
                    'description' => 'Software with invalid university unit references'
                ]
            ];
            
            foreach ($foreignKeyTests as $test) {
                $startTime = microtime(true);
                $stmt = $conn->query($test['query']);
                $result = $stmt->fetch();
                $endTime = microtime(true);
                
                $integrityTests[] = [
                    'table' => $test['table'],
                    'description' => $test['description'],
                    'orphaned_records' => $result['count'],
                    'status' => $result['count'] == 0 ? 'PASS' : 'FAIL',
                    'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
                ];
            }
            
            // Test data consistency
            $consistencyTests = [
                [
                    'description' => 'Software products with roles',
                    'query' => 'SELECT COUNT(*) as count FROM software_products sp LEFT JOIN software_roles sr ON sp.id = sr.software_id WHERE sr.software_id IS NOT NULL'
                ],
                [
                    'description' => 'Employees with role assignments',
                    'query' => 'SELECT COUNT(DISTINCT e.id) as count FROM employees e JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)'
                ],
                [
                    'description' => 'Software assigned to university units',
                    'query' => 'SELECT COUNT(*) as count FROM software_products WHERE university_unit_id IS NOT NULL'
                ]
            ];
            
            $consistencyResults = [];
            foreach ($consistencyTests as $test) {
                $stmt = $conn->query($test['query']);
                $result = $stmt->fetch();
                
                $consistencyResults[] = [
                    'description' => $test['description'],
                    'count' => $result['count']
                ];
            }
            
            return [
                'success' => true,
                'message' => 'Database integrity tests completed',
                'details' => [
                    'foreign_key_tests' => $integrityTests,
                    'data_consistency' => $consistencyResults,
                    'timestamp' => date('Y-m-d H:i:s')
                ]
            ];
            
        } catch (PDOException $e) {
            return [
                'success' => false,
                'message' => 'Database integrity test failed: ' . $e->getMessage(),
                'details' => ['error' => $e->getMessage()]
            ];
        }
    }
    
    private function testComplexQueries(): array
    {
        try {
            $conn = $this->db->getConnection();
            $queryTests = [];
            
            // Test 1: Software with roles query (replaces v_software_with_roles view)
            $startTime = microtime(true);
            $stmt = $conn->query("
                SELECT 
                    sp.id, sp.software_name, sp.version,
                    CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
                    CONCAT(tech.first_name, ' ', tech.last_name) as technical_owner,
                    CONCAT(mgr.first_name, ' ', mgr.last_name) as technical_manager,
                    u.unit_name as university_unit
                FROM software_products sp
                LEFT JOIN software_roles sr ON sp.id = sr.software_id
                LEFT JOIN employees bo ON sr.business_owner_id = bo.id
                LEFT JOIN employees tech ON sr.technical_owner_id = tech.id
                LEFT JOIN employees mgr ON sr.technical_manager_id = mgr.id
                LEFT JOIN university_units u ON sp.university_unit_id = u.id
                LIMIT 10
            ");
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $queryTests['software_with_roles'] = [
                'description' => 'Software with roles and unit assignment',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
            ];
            
            // Test 2: Employee roles summary (replaces v_employee_roles view)
            $startTime = microtime(true);
            $stmt = $conn->query("
                SELECT 
                    e.id, e.first_name, e.last_name, u.unit_name as university_unit,
                    COUNT(DISTINCT CASE WHEN sr.business_owner_id = e.id THEN sr.software_id END) as business_owner_count,
                    COUNT(DISTINCT CASE WHEN sr.technical_owner_id = e.id THEN sr.software_id END) as technical_owner_count,
                    COUNT(DISTINCT CASE WHEN sr.technical_manager_id = e.id THEN sr.software_id END) as technical_manager_count
                FROM employees e
                LEFT JOIN university_units u ON e.university_unit_id = u.id
                LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)
                GROUP BY e.id, e.first_name, e.last_name, u.unit_name
                LIMIT 10
            ");
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $queryTests['employee_roles_summary'] = [
                'description' => 'Employee roles summary',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
            ];
            
            // Test 3: Unit software summary (replaces v_unit_software_summary view)
            $startTime = microtime(true);
            $stmt = $conn->query("
                SELECT 
                    u.id, u.unit_name, u.unit_code, u.unit_type,
                    COUNT(DISTINCT sp.id) as software_count
                FROM university_units u
                LEFT JOIN software_products sp ON u.id = sp.university_unit_id
                GROUP BY u.id, u.unit_name, u.unit_code, u.unit_type
                LIMIT 10
            ");
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $queryTests['unit_software_summary'] = [
                'description' => 'Unit software summary',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
            ];
            
            // Test 4: Complex aggregation query (updated for new structure)
            $startTime = microtime(true);
            $stmt = $conn->query("
                SELECT 
                    u.unit_type,
                    COUNT(DISTINCT u.id) as unit_count,
                    COUNT(DISTINCT sp.id) as total_software,
                    COUNT(DISTINCT CASE WHEN sr.software_id IS NOT NULL THEN sp.id END) as software_with_roles
                FROM university_units u
                LEFT JOIN software_products sp ON u.id = sp.university_unit_id
                LEFT JOIN software_roles sr ON sp.id = sr.software_id
                GROUP BY u.unit_type
            ");
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $queryTests['unit_type_analysis'] = [
                'description' => 'Unit type software analysis',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms',
                'sample_data' => $results
            ];
            
            return [
                'success' => true,
                'message' => 'Complex query tests completed successfully',
                'details' => [
                    'query_tests' => $queryTests,
                    'timestamp' => date('Y-m-d H:i:s')
                ]
            ];
            
        } catch (PDOException $e) {
            return [
                'success' => false,
                'message' => 'Complex query test failed: ' . $e->getMessage(),
                'details' => ['error' => $e->getMessage()]
            ];
        }
    }
    
    private function testSearchPerformance(): array
    {
        try {
            $conn = $this->db->getConnection();
            $searchTests = [];
            
            // Test 1: Employee name search
            $searchTerms = ['john', 'smith', 'admin', 'tech'];
            foreach ($searchTerms as $term) {
                $startTime = microtime(true);
                $stmt = $conn->prepare("
                    SELECT e.*, COUNT(sr.id) as role_count
                    FROM employees e
                    LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)
                    WHERE LOWER(e.first_name) LIKE LOWER(?) OR LOWER(e.last_name) LIKE LOWER(?) OR LOWER(e.email) LIKE LOWER(?)
                    GROUP BY e.id
                    LIMIT 20
                ");
                $searchPattern = '%' . $term . '%';
                $stmt->execute([$searchPattern, $searchPattern, $searchPattern]);
                $results = $stmt->fetchAll();
                $endTime = microtime(true);
                
                $searchTests['employee_search_' . $term] = [
                    'query' => 'Employee search: ' . $term,
                    'result_count' => count($results),
                    'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
                ];
            }
            
            // Test 2: Software product search
            $softwareTerms = ['office', 'adobe', 'microsoft', 'system'];
            foreach ($softwareTerms as $term) {
                $startTime = microtime(true);
                $stmt = $conn->prepare("
                    SELECT sp.*, u.unit_name, COUNT(DISTINCT sr.id) as role_count
                    FROM software_products sp
                    LEFT JOIN university_units u ON sp.university_unit_id = u.id
                    LEFT JOIN software_roles sr ON sp.id = sr.software_id
                    WHERE LOWER(sp.software_name) LIKE LOWER(?) OR LOWER(sp.description) LIKE LOWER(?) OR LOWER(sp.vendor_name) LIKE LOWER(?)
                    GROUP BY sp.id
                    LIMIT 20
                ");
                $searchPattern = '%' . $term . '%';
                $stmt->execute([$searchPattern, $searchPattern, $searchPattern]);
                $results = $stmt->fetchAll();
                $endTime = microtime(true);
                
                $searchTests['software_search_' . $term] = [
                    'query' => 'Software search: ' . $term,
                    'result_count' => count($results),
                    'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
                ];
            }
            
            // Test 3: University unit search
            $unitTerms = ['engineering', 'department', 'research', 'admin'];
            foreach ($unitTerms as $term) {
                $startTime = microtime(true);
                $stmt = $conn->prepare("
                    SELECT u.*, COUNT(sp.id) as software_count
                    FROM university_units u
                    LEFT JOIN software_products sp ON u.id = sp.university_unit_id
                    WHERE LOWER(u.unit_name) LIKE LOWER(?) OR LOWER(u.description) LIKE LOWER(?) OR LOWER(u.unit_type) LIKE LOWER(?)
                    GROUP BY u.id
                    LIMIT 20
                ");
                $searchPattern = '%' . $term . '%';
                $stmt->execute([$searchPattern, $searchPattern, $searchPattern]);
                $results = $stmt->fetchAll();
                $endTime = microtime(true);
                
                $searchTests['unit_search_' . $term] = [
                    'query' => 'Unit search: ' . $term,
                    'result_count' => count($results),
                    'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms'
                ];
            }
            
            // Test 4: Combined search across all entities
            $startTime = microtime(true);
            $stmt = $conn->prepare("
                SELECT 'employee' as entity_type, e.id, CONCAT(e.first_name, ' ', e.last_name) as name, e.email as description
                FROM employees e
                WHERE LOWER(e.first_name) LIKE LOWER(?) OR LOWER(e.last_name) LIKE LOWER(?) OR LOWER(e.email) LIKE LOWER(?)
                UNION ALL
                SELECT 'software' as entity_type, sp.id, sp.software_name as name, sp.description
                FROM software_products sp
                WHERE LOWER(sp.software_name) LIKE LOWER(?) OR LOWER(sp.description) LIKE LOWER(?)
                UNION ALL
                SELECT 'unit' as entity_type, u.id, u.unit_name as name, u.description
                FROM university_units u
                WHERE LOWER(u.unit_name) LIKE LOWER(?) OR LOWER(u.description) LIKE LOWER(?)
                LIMIT 50
            ");
            $globalSearchTerm = '%admin%';
            $stmt->execute([
                $globalSearchTerm, $globalSearchTerm, $globalSearchTerm,
                $globalSearchTerm, $globalSearchTerm,
                $globalSearchTerm, $globalSearchTerm
            ]);
            $results = $stmt->fetchAll();
            $endTime = microtime(true);
            
            $searchTests['global_search'] = [
                'query' => 'Global search across all entities',
                'result_count' => count($results),
                'execution_time' => round(($endTime - $startTime) * 1000, 2) . ' ms',
                'sample_results' => array_slice($results, 0, 10)
            ];
            
            return [
                'success' => true,
                'message' => 'Search performance tests completed successfully',
                'details' => [
                    'search_tests' => $searchTests,
                    'timestamp' => date('Y-m-d H:i:s')
                ]
            ];
            
        } catch (PDOException $e) {
            return [
                'success' => false,
                'message' => 'Search performance test failed: ' . $e->getMessage(),
                'details' => ['error' => $e->getMessage()]
            ];
        }
    }
    
    public function performanceTest()
    {
        // Require admin authentication
        if (!$this->auth->requireAdmin()) {
            echo $this->twig->render('error.twig', [
                'title' => 'Access Denied',
                'error_message' => 'Administrator access required.',
                'error_details' => 'You need admin privileges to access performance testing.'
            ]);
            return;
        }

        try {
            echo $this->twig->render('admin/performance-test.twig', [
                'title' => 'Performance Testing',
                'page' => 'performance-test'
            ]);
            
        } catch (\Exception $e) {
            error_log("Performance test page error: " . $e->getMessage());
            
            echo $this->twig->render('error.twig', [
                'title' => 'Performance Test Error',
                'error_message' => 'Unable to load performance test page.',
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
