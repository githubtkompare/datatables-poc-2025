<?php

namespace App\Controllers;

use App\Config\TwigConfig;
use App\Config\Auth;

abstract class BaseController
{
    protected $twig;
    protected $auth;
    
    public function __construct()
    {
        $this->twig = TwigConfig::getInstance()->getTwig();
        $this->auth = Auth::getInstance();
    }
    
    /**
     * Render a template with authentication data included
     */
    protected function render(string $template, array $data = []): void
    {
        // Add authentication data to all templates
        $data['auth'] = [
            'is_admin' => $this->auth->isAdmin(),
            'user_role' => $this->auth->getUserRole(),
            'user_name' => $this->auth->getUserName()
        ];
        
        echo $this->twig->render($template, $data);
    }
    
    /**
     * Get authentication data as array
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
