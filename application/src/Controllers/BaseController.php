<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Config\Auth;

/**
 * Base controller providing common functionality for all application controllers
 * 
 * This abstract base class provides shared functionality and services that all
 * controllers in the application can utilize. It handles template rendering,
 * authentication integration, and common utility methods.
 * 
 * Features:
 * - Twig template engine integration
 * - Authentication service access
 * - Standardized template rendering with auth context
 * - Common utility methods for controllers
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
abstract class BaseController
{
    /**
     * Twig Environment instance for template rendering
     * @var \Twig\Environment
     */
    protected $twig;
    
    /**
     * Authentication service instance
     * @var Auth
     */
    protected $auth;
    
    /**
     * Initialize base controller with essential services
     * 
     * Sets up Twig templating and authentication services that are
     * commonly needed by all controllers in the application.
     */
    public function __construct()
    {
        $this->twig = TwigConfig::getInstance()->getTwig();
        $this->auth = Auth::getInstance();
    }
    
    /**
     * Render a template with authentication data automatically included
     * 
     * Provides a standardized way to render templates with authentication
     * context automatically injected. This ensures all templates have
     * access to current user information without manual injection.
     * 
     * @param string $template Path to the template file relative to templates directory
     * @param array $data Associative array of data to pass to the template
     * @return void
     */
    protected function render(string $template, array $data = []): void
    {
        // Add authentication data to all templates for consistent access
        $data['auth'] = [
            'is_admin' => $this->auth->isAdmin(),
            'user_role' => $this->auth->getUserRole(),
            'user_name' => $this->auth->getUserName()
        ];
        
        echo $this->twig->render($template, $data);
    }
    
    /**
     * Get authentication data as associative array
     * 
     * Utility method to retrieve current authentication state in a
     * standardized format. Useful for controllers that need to inspect
     * or manipulate authentication data before rendering.
     * 
     * @return array Authentication data with keys: is_admin, user_role, user_name
     */
    protected function getAuthData(): array
    {
        return [
            'is_admin' => $this->auth->isAdmin(),
            'user_role' => $this->auth->getUserRole(),
            'user_name' => $this->auth->getUserName()
        ];
    }
}
