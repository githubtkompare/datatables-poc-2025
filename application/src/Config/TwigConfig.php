<?php

namespace App\Config;

use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use Twig\TwigFunction;

class TwigConfig
{
    private static $instance = null;
    private $twig;
    
    private function __construct()
    {
        $templateDir = __DIR__ . '/../Views/templates';
        $loader = new FilesystemLoader($templateDir);
        
        $options = [
            'cache' => false, // Disable cache for development
            'debug' => $_ENV['APP_DEBUG'] ?? true,
            'strict_variables' => false // Allow undefined variables to be null
        ];
        
        $this->twig = new Environment($loader, $options);
        
        // Set timezone for Twig date filters
        $timezone = $_ENV['APP_TIMEZONE'] ?? 'America/Chicago';
        $this->twig->getExtension('Twig\Extension\CoreExtension')->setTimezone($timezone);
        
        // Add global variables
        $this->twig->addGlobal('app_name', $_ENV['APP_NAME'] ?? 'Software Product Tracking System');
        $this->twig->addGlobal('app_version', $_ENV['APP_VERSION'] ?? '1.0.0');
        $this->twig->addGlobal('base_url', $_ENV['APP_URL'] ?? 'http://localhost:8080');
        
        // Add auth function that gets current auth state dynamically
        $authFunction = new TwigFunction('auth', function() {
            $auth = Auth::getInstance();
            return [
                'is_admin' => $auth->isAdmin(),
                'user_role' => $auth->getUserRole(),
                'user_name' => $auth->getUserName()
            ];
        });
        
        $this->twig->addFunction($authFunction);
    }
    
    public static function getInstance(): TwigConfig
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        
        return self::$instance;
    }
    
    public function getTwig(): Environment
    {
        return $this->twig;
    }
}
