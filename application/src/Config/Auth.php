<?php

namespace App\Config;

class Auth
{
    private static $instance = null;
    
    private function __construct() 
    {
        // Ensure session is started
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }
    
    public static function getInstance(): self
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    /**
     * Check if user is authenticated as admin
     * For this POC, we'll use a simple session-based approach
     */
    public function isAdmin(): bool
    {
        return isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'admin';
    }
    
    /**
     * Set user as admin (for demo purposes)
     */
    public function setAdmin(): void
    {
        $_SESSION['user_role'] = 'admin';
        $_SESSION['user_name'] = 'Administrator';
    }
    
    /**
     * Set user as regular user
     */
    public function setUser(): void
    {
        $_SESSION['user_role'] = 'user';
        $_SESSION['user_name'] = 'User';
    }
    
    /**
     * Get current user role
     */
    public function getUserRole(): ?string
    {
        return $_SESSION['user_role'] ?? null;
    }
    
    /**
     * Get current user name
     */
    public function getUserName(): ?string
    {
        return $_SESSION['user_name'] ?? null;
    }
    
    /**
     * Logout user
     */
    public function logout(): void
    {
        unset($_SESSION['user_role']);
        unset($_SESSION['user_name']);
    }
    
    /**
     * Require admin access or redirect/show error
     */
    public function requireAdmin(): bool
    {
        if (!$this->isAdmin()) {
            http_response_code(403);
            return false;
        }
        return true;
    }
}
