<?php
// Debug script to test search functionality
require_once '/var/www/html/vendor/autoload.php';

use App\Models\SoftwareProduct;

$model = new SoftwareProduct();

echo "Testing search with 'Ado':\n";
try {
    $software = $model->getAllSoftware(10, 0, 'Ado');
    echo "Found " . count($software) . " software items\n";
    
    $count = $model->getTotalCount('Ado');
    echo "Total count: " . $count . "\n";
    
    foreach ($software as $item) {
        echo "- " . $item['software_name'] . "\n";
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
