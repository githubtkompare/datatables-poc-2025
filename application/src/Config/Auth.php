<?php

namespace App\Config;

/**
 * Authentication and authorization handler using session-based security
 * 
 * This class implements a singleton pattern to manage user authentication
 * and authorization throughout the application. It provides a simple role-based
 * access control system suitable for demonstration and proof-of-concept purposes.
 * 
 * The implementation uses PHP sessions to maintain authentication state and
 * supports two primary roles: 'admin' and 'user'. This approach is simplified
 * for POC purposes and would require enhancement for production use.
 * 
 * Features:
 * - Singleton pattern for consistent authentication state
 * - Session-based authentication storage
 * - Simple role-based access control (admin/user)
 * - Authentication state management methods
 * - Access control enforcement for protected resources
 * 
 * @author DataTables POC Team
 * @version 1.0.0
 */
class Auth
{
    /**
     * Singleton instance of the Auth class
     * @var Auth|null
     */
    private static $instance = null;
    
    /**
     * Private constructor to prevent direct instantiation
     * Ensures session is properly initialized for authentication tracking
     */
    private function __construct() 
    {
        // Ensure session is started for authentication state management
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
    }
    
    /**
     * Get singleton instance of Auth class
     * 
     * Implements the singleton pattern to ensure only one Auth instance
     * exists throughout the application lifecycle.
     * 
     * @return self The singleton Auth instance
     */
    public static function getInstance(): self
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    /**
     * Check if user is authenticated as admin
     * 
     * For this POC, we'll use a simple session-based approach to determine
     * if the current user has administrative privileges.
     * 
     * @return bool True if user has admin role, false otherwise
     */
    public function isAdmin(): bool
    {
        return isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'admin';
    }
    
    /**
     * Set user as admin (for demo purposes)
     * 
     * Elevates the current session to administrative privileges.
     * This is a simplified approach for demonstration purposes.
     * 
     * @return void
     */
    public function setAdmin(): void
    {
        $_SESSION['user_role'] = 'admin';
        $_SESSION['user_name'] = 'Administrator';
    }
    
    /**
     * Set user as regular user
     * 
     * Sets the current session to regular user privileges,
     * removing any administrative access.
     * 
     * @return void
     */
    public function setUser(): void
    {
        $_SESSION['user_role'] = 'user';
        $_SESSION['user_name'] = 'User';
    }
    
    /**
     * Get current user role
     * 
     * Retrieves the role of the currently authenticated user from the session.
     * 
     * @return string|null The user's role ('admin' or 'user') or null if not set
     */
    public function getUserRole(): ?string
    {
        return $_SESSION['user_role'] ?? null;
    }
    
    /**
     * Get current user name
     * 
     * Retrieves the display name of the currently authenticated user.
     * 
     * @return string|null The user's display name or null if not set
     */
    public function getUserName(): ?string
    {
        return $_SESSION['user_name'] ?? null;
    }
    
    /**
     * Logout user
     * 
     * Clears authentication data from the session, effectively logging out
     * the current user while preserving the session for future use.
     * 
     * @return void
     */
    public function logout(): void
    {
        unset($_SESSION['user_role']);
        unset($_SESSION['user_name']);
    }
    
    /**
     * Require admin access or redirect/show error
     * 
     * Enforces administrative access requirements for protected resources.
     * Sets appropriate HTTP status code if access is denied.
     * 
     * @return bool True if user has admin access, false otherwise
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
