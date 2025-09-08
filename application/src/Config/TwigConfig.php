<?php

namespace App\Config;

use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use Twig\TwigFunction;

/**
 * Twig templating engine configuration and setup
 * 
 * This class configures and initializes the Twig templating engine for the application.
 * It implements the singleton pattern to ensure consistent template configuration
 * across the entire application and provides centralized template management.
 * 
 * The configuration includes environment-based settings, global variables injection,
 * custom function registration (particularly for authentication context), and
 * timezone synchronization with the application's timezone settings.
 * 
 * Features:
 * - Singleton pattern for consistent configuration
 * - Environment-based configuration management
 * - Global variables injection for templates
 * - Custom function registration (auth functions)
 * - Timezone synchronization with application settings
 * - Development-friendly caching and debugging options
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class TwigConfig
{
    /**
     * Singleton instance of the TwigConfig class
     * @var TwigConfig|null
     */
    private static $instance = null;
    
    /**
     * Configured Twig Environment instance
     * @var Environment
     */
    private $twig;
    
    /**
     * Private constructor to initialize Twig environment
     * 
     * Configures the Twig templating engine with appropriate settings for the application,
     * including template directory setup, environment configuration, global variables,
     * and custom function registration.
     */
    private function __construct()
    {
        // Set up template directory location
        $templateDir = __DIR__ . '/../Views/templates';
        $loader = new FilesystemLoader($templateDir);
        
        // Configure Twig environment options based on application settings
        $options = [
            'cache' => false, // Disable cache for development - should be enabled in production
            'debug' => $_ENV['APP_DEBUG'] ?? true,
            'strict_variables' => false // Allow undefined variables to be null for flexibility
        ];
        
        $this->twig = new Environment($loader, $options);
        
        // Set timezone for Twig date filters to match application timezone
        $timezone = $_ENV['APP_TIMEZONE'] ?? 'America/Chicago';
        $this->twig->getExtension('Twig\Extension\CoreExtension')->setTimezone($timezone);
        
        // Add global variables accessible in all templates
        $this->twig->addGlobal('app_name', $_ENV['APP_NAME'] ?? 'Software Product Tracking System');
        $this->twig->addGlobal('app_version', $_ENV['APP_VERSION'] ?? '1.0.0');
        $this->twig->addGlobal('base_url', $_ENV['APP_URL'] ?? 'http://localhost:8080');
        
        // Add authentication function that dynamically provides current auth state
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
    
    /**
     * Get singleton instance of TwigConfig class
     * 
     * Implements the singleton pattern to ensure consistent Twig configuration
     * across the application and prevent multiple initialization of the
     * templating environment.
     * 
     * @return TwigConfig The singleton TwigConfig instance
     */
    public static function getInstance(): TwigConfig
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        
        return self::$instance;
    }
    
    /**
     * Get the configured Twig Environment instance
     * 
     * Returns the fully configured Twig Environment instance for use by
     * controllers and other components that need to render templates.
     * 
     * @return Environment The configured Twig Environment instance
     */
    public function getTwig(): Environment
    {
        return $this->twig;
    }
}
