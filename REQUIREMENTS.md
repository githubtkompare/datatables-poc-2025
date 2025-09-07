# Web Application Framework Requirements

## Project Overview

This document outlines the technical framework requirements for a self-contained web application built with modern web technologies and deployed using Docker containerization.

## Business Requirements

### Software Product Tracking System

This application tracks various software products used by different units within a university environment. The system manages the following key entities and relationships:

#### Software Products

- [x] **Software Product Management**
  - Track multiple software products used across university units
  - Each product has associated metadata and properties
  - Products are associated with specific university units/departments
  - Product lifecycle tracking and management

- [x] **Required Software Properties**
  - **Software Name**: Unique identifier and display name for the software
  - **Operating System(s)**: Track which operating systems the software runs on
    - Support for multiple OS selections (Windows, macOS, Linux, etc.)
    - Version-specific OS requirements if applicable
  - **Vendor Management Status**: Indicate if the software is vendor-managed
    - Boolean flag for vendor-managed vs. internally managed
    - **Vendor Name**: If vendor-managed, capture the vendor/company name
  - **Additional Metadata**: Version, description, license information, installation notes, etc.

#### Employee Roles and Responsibilities

- [x] **Three Primary Roles per Software Product**
  - **Business Owner**: Responsible for business decisions and requirements
  - **Technical Owner**: Responsible for technical implementation and maintenance
  - **Technical Manager**: Responsible for technical oversight and management

- [x] **Role Assignment Flexibility**
  - Each software product must have all three roles assigned
  - The same employee can fill multiple roles for the same product
  - The same employee can fill the same role across multiple products
  - All three roles can be assigned to different employees
  - All three roles can be assigned to the same employee
  - Any combination of role assignments is permitted

#### Employee Management

- [x] **Employee Database**
  - Maintain database of university employees
  - Employee identification and contact information (first name, last name, email, phone, department, job title)
  - Track employee assignments across multiple products and roles
  - Support for role history and changes over time
  - Role count tracking (business owner, technical owner, technical manager counts)

#### Data Relationships

- [x] **Many-to-Many Relationships**
  - Products ↔ University Units (products can be used by multiple units)
  - Employees ↔ Products ↔ Roles (employees can have multiple roles across multiple products)
  - Software ↔ Operating Systems (software can support multiple operating systems)
  - Flexible assignment system supporting all role combinations

#### University Units Management

- [x] **University Units Database**
  - Track university departments, colleges, administrative units, support services, and research units
  - Unit hierarchy support with parent-child relationships
  - Unit codes, descriptions, and type classification
  - Association with software products and usage tracking

#### Audit and Tracking

- [x] **Audit Log System**
  - Track all data changes (INSERT, UPDATE, DELETE operations)
  - Store old and new values in JSON format
  - Track who made changes and when
  - Support for compliance and change tracking requirements

#### Reporting and Analytics

- [x] **Role Assignment Reports**
  - View all products and their assigned roles
  - View all employees and their assigned products/roles
  - Identify products with incomplete role assignments
  - Generate reports on role distribution and workload
  - Database views for common queries and reporting

## Technical Architecture

### Backend Framework

- **Language**: PHP 8.3 ✅
- **Template Engine**: Twig 3.x ✅
- **Database**: MySQL 8.0+ ✅
- **Database Access**: PDO (PHP Data Objects) ✅
- **Web Server**: Apache (containerized) ✅
- **Environment Management**: PHP DotEnv for configuration ✅

### Frontend Framework

- **CSS Framework**: Bootstrap 5.x ✅
- **JavaScript Library**: DataTables (v2.3.3) ✅
- **Browser Compatibility**: Modern browsers (Chrome, Firefox, Safari, Edge) ✅
- **Responsive Design**: Fully responsive interface ✅

### Containerization

- **Platform**: Docker ✅
- **Architecture**: Multi-container setup with Docker Compose ✅
- **Containers**:
  - Web server (Apache + PHP 8.3) ✅
  - MySQL database ✅
  - phpMyAdmin for database management ✅

## Technical Requirements

**🏗️ BUILD LOCATION: All application code, configuration files, and assets must be built within the `application/` folder in the project root directory.**

### 1. Docker Configuration

**Note: All Docker configuration files should be placed within the `application/` folder.**

#### Docker Compose Services

- [x] **Web Service**
  - Base image: `php:8.3-apache` ✅
  - PHP extensions: PDO, PDO_MySQL, Twig ✅
  - Volume mounts for application code ✅
  - Port mapping for web access (8080:80) ✅

- [x] **Database Service**
  - Base image: `mysql:8.0` ✅
  - Persistent volume for data storage ✅
  - Environment variables for database configuration ✅
  - Health checks ✅

- [x] **Database Management**
  - phpMyAdmin container for database administration ✅
  - Access via port 8081 ✅

#### Environment Configuration

- [x] `.env` support for environment-specific variables ✅
- [x] Separate configurations for development/production ✅
- [x] Database connection parameters ✅
- [x] Application settings ✅

### 2. PHP Backend Requirements

#### Core Components

- [x] **Application Structure**
  - MVC architectural pattern ✅
  - Routing system (index.php with path-based routing) ✅
  - Controller classes (HomeController, EmployeeController, SoftwareController, etc.) ✅
  - Model classes for database interaction (Employee, SoftwareProduct, UniversityUnit) ✅
  - View templates using Twig ✅

- [x] **Database Layer**
  - PDO connection manager ✅
  - Database migration system (schema.sql) ✅
  - Prepared statements for security ✅
  - Transaction support ✅
  - Database views for complex queries ✅

- [x] **Database Testing and Monitoring Scripts**
  - Connection testing script with detailed diagnostics ✅
  - Database performance testing scripts ✅
  - Query execution time measurement tools ✅
  - Connection pool status monitoring ✅
  - Database health check utilities ✅

- [x] **Security Features**
  - Input validation and sanitization ✅
  - CSRF protection ✅
  - SQL injection prevention (prepared statements) ✅
  - XSS protection ✅

- [x] **Administrative Interface**
  - Admin dashboard for system monitoring ✅
  - Database connectivity testing interface ✅
  - Performance monitoring tools ✅
  - System diagnostics and health checks ✅
  - Table statistics and monitoring ✅

#### PHP Dependencies (Composer)

- [x] Twig template engine (v3.x) ✅
- [x] PHP DotEnv for environment management ✅
- [x] Development dependencies (PHPUnit, PHP CodeSniffer) ✅
- [x] PSR-4 autoloading configuration ✅

### 3. Database Requirements

#### MySQL Configuration

- [x] Database schema design ✅
- [x] Table creation scripts (schema.sql) ✅
- [x] Sample data for development (sample-data.sql) ✅
- [x] Indexing strategy ✅
- [x] Foreign key constraints ✅

#### Database Features

- [x] UTF-8 character set support (utf8mb4) ✅
- [x] Foreign key constraints ✅
- [x] Database views for complex queries ✅
- [x] Audit logging system ✅
- [x] Performance monitoring capabilities ✅

#### Initial Mock Data Requirements

- [x] **Employee Mock Data (10+ records)**
  - Realistic employee names and contact information ✅
  - Mix of different university departments/roles ✅
  - Variety of employees to demonstrate role assignment flexibility ✅
  - Include employees who fill multiple software roles ✅

- [x] **Software Product Mock Data (10+ records)**
  - Diverse software types commonly used in university environments ✅
  - Mix of operating systems (Windows, macOS, Linux, cross-platform) ✅
  - Combination of vendor-managed and internally managed software ✅
  - Include popular software categories:
    - Academic software (research tools, statistical packages) ✅
    - Administrative software (HR, finance, student information systems) ✅
    - Development/technical tools ✅
    - Office productivity software ✅
  - Realistic vendor names for vendor-managed products ✅

- [x] **University Unit Mock Data (10+ records)**
  - Representative university departments and units:
    - Academic departments (Computer Science, Biology, Mathematics, etc.) ✅
    - Administrative units (IT Services, Human Resources, Finance, etc.) ✅
    - Support services (Library, Student Services, Facilities, etc.) ✅
  - Realistic unit names and organizational structure ✅
  - Unit types and hierarchical relationships ✅

- [x] **Operating System Mock Data**
  - Support for major operating systems (Windows, macOS, Linux variants) ✅
  - OS family classification and version tracking ✅

- [x] **Mock Data Associations**
  - Each software product assigned all three required roles ✅
  - Demonstrate role assignment flexibility:
    - Some products with all roles assigned to different employees ✅
    - Some products with same employee in multiple roles ✅
    - Some products with all three roles assigned to same employee ✅
  - Multiple software products associated with each university unit ✅
  - Multiple university units using the same software products ✅
  - Realistic cross-departmental software usage patterns ✅
  - Software-to-operating system associations ✅

### 4. Frontend Requirements

#### Bootstrap Integration

- [x] Bootstrap 5.x CSS and JS files ✅
- [x] Responsive grid system implementation ✅
- [x] Form styling and validation ✅
- [x] Navigation components ✅
- [x] Modal dialogs ✅
- [x] Alert/notification system ✅

#### DataTables Integration

- [x] DataTables library and dependencies ✅
- [x] Server-side processing capability ✅
- [x] Sorting, filtering, and pagination ✅
- [x] Column customization ✅
- [x] Export functionality (CSV, PDF, Excel) ✅
- [x] Responsive table design ✅

#### JavaScript Features

- [x] AJAX functionality for dynamic content ✅
- [x] Form validation ✅
- [x] Interactive UI components ✅
- [x] Error handling and user feedback ✅

#### User Interface Views

- [x] **Employee View**
  - Search functionality for finding specific employees ✅
  - Tabular display of search results with DataTables ✅
  - Show all software products associated with each person ✅
  - Display person's roles for each software product ✅
  - CRUD operations (Create, Read, Update, Delete) ✅
  - Role count summaries ✅

- [x] **Software View**
  - Filter and search capabilities for software properties:
    - Software name ✅
    - Operating system(s) ✅
    - Vendor status and vendor name ✅
    - University units using the software ✅
  - Tabular display of filtered software results ✅
  - Show assigned roles (Business Owner, Technical Owner, Technical Manager) ✅
  - Show associated campus units for each software ✅
  - CRUD operations with modal forms ✅

- [x] **University Unit View**
  - Search functionality for university units/departments ✅
  - Tabular display of campus units ✅
  - Show all software products associated with each unit ✅
  - Unit type classification and hierarchy support ✅
  - CRUD operations ✅

- [x] **Dashboard View**
  - Summary statistics (total employees, software, units) ✅
  - Recent data overview ✅
  - Quick navigation to main sections ✅

- [x] **Admin Dashboard**
  - Database connectivity testing interface ✅
  - Performance monitoring tools ✅
  - System diagnostics and health checks ✅
  - Table statistics and row counts ✅

- [x] **Common Table Features**
  - Responsive table design for all views ✅
  - DataTables integration with advanced features ✅
  - Export functionality (CSV, Excel, PDF, Print) ✅
  - Real-time search and filtering ✅
  - Pagination for large datasets ✅
  - Column sorting and customization ✅

### 5. Development Environment

**Important: All application files must be created and maintained within the `application/` folder in the project root.**

#### Local Development Setup

- [x] Docker Compose for local development (located in `application/docker-compose.yml`) ✅
- [x] Hot reloading for code changes (volume mounts) ✅
- [x] Debug configuration ✅
- [x] Development tools integration ✅

#### Code Organization

- [x] Clear directory structure within the `application/` folder ✅
- [x] Separation of concerns (MVC pattern) ✅
- [x] Configuration management (Database, TwigConfig classes) ✅
- [x] Asset management (CSS, JS, images in public folder) ✅

### 6. Performance Requirements

#### Optimization

- [ ] Database query optimization
- [ ] Caching strategy (if needed)
- [ ] Asset minification and compression
- [ ] Image optimization

#### Scalability Considerations

- [ ] Efficient database queries
- [ ] Pagination for large datasets
- [ ] Resource usage monitoring

### 7. Security Requirements

#### Application Security

- [ ] Input validation on both client and server side
- [ ] Secure authentication system (if needed)
- [ ] Session management
- [ ] Error handling without information disclosure

#### Infrastructure Security

- [ ] Container security best practices
- [ ] Database access restrictions
- [ ] Environment variable protection
- [ ] HTTPS configuration (production)

### 8. Testing Requirements

#### Testing Strategy

- [ ] Unit tests for PHP classes
- [ ] Integration tests for database operations
- [ ] Frontend testing for JavaScript functionality
- [ ] End-to-end testing scenarios

#### Administrative Testing Tools

- [x] **Database Connectivity Tests**
  - Real-time connection status checker ✅
  - Connection timeout and retry testing ✅
  - Multiple database connection testing ✅
  - Connection pool utilization monitoring ✅

- [x] **Database Performance Tests**
  - Query execution time benchmarking ✅
  - Table optimization analysis ✅
  - Performance metrics collection ✅
  - Database load testing utilities ✅
  - Memory usage monitoring during operations ✅

- [x] **Web-based Admin Testing Interface**
  - Admin panel for running diagnostic tests ✅
  - Test result logging and history ✅
  - Performance metrics visualization ✅
  - Real-time system status dashboard ✅
  - Table statistics and health monitoring ✅

- [x] **Automated Health Checks**
  - Scheduled connectivity tests ✅
  - Performance threshold monitoring ✅
  - System resource monitoring ✅
  - Database integrity checks ✅

#### Quality Assurance

- [x] Code linting and formatting standards (PHP CodeSniffer) ✅
- [x] Automated testing framework setup (PHPUnit) ✅
- [ ] Performance testing
- [ ] Security testing

### 9. Documentation Requirements

#### Technical Documentation

- [x] Installation and setup instructions ✅
- [x] Database schema documentation ✅
- [x] Configuration guide ✅
- [x] Administrative testing tools documentation ✅
- [x] Database connectivity testing procedures ✅
- [ ] API documentation (if applicable)
- [ ] Performance testing guidelines and benchmarks

#### User Documentation

- [x] User manual for application features ✅
- [x] Administrator guide ✅
- [x] Troubleshooting guide ✅

### 10. Deployment Requirements

**Note: All deployment configurations should be contained within the `application/` folder structure.**

#### Production Deployment

- [x] Production Docker configuration (in `application/` folder) ✅
- [x] Environment-specific settings ✅
- [x] Monitoring and logging setup ✅
- [ ] Backup and recovery procedures

#### CI/CD Pipeline

- [ ] Automated testing
- [ ] Build process
- [ ] Deployment automation
- [ ] Version control integration

## File Structure Template

**Note: All application code and files should be built within the `application/` folder.**

```text
datatables-poc-2025/
├── application/                          ✅ COMPLETED
│   ├── docker-compose.yml               ✅ COMPLETED
│   ├── Dockerfile                       ✅ COMPLETED
│   ├── .env.example                     ✅ COMPLETED
│   ├── .gitignore                       ✅ COMPLETED
│   ├── composer.json                    ✅ COMPLETED
│   ├── composer.lock                    ✅ COMPLETED
│   ├── README.md                        ✅ COMPLETED
│   ├── src/                            ✅ COMPLETED
│   │   ├── Controllers/                ✅ COMPLETED
│   │   │   ├── HomeController.php      ✅ COMPLETED
│   │   │   ├── EmployeeController.php  ✅ COMPLETED
│   │   │   ├── SoftwareController.php  ✅ COMPLETED
│   │   │   ├── UniversityUnitController.php ✅ COMPLETED
│   │   │   └── AdminController.php     ✅ COMPLETED
│   │   ├── Models/                     ✅ COMPLETED
│   │   │   ├── Employee.php            ✅ COMPLETED
│   │   │   ├── SoftwareProduct.php     ✅ COMPLETED
│   │   │   └── UniversityUnit.php      ✅ COMPLETED
│   │   ├── Views/                      ✅ COMPLETED
│   │   │   └── templates/              ✅ COMPLETED
│   │   │       ├── base.twig           ✅ COMPLETED
│   │   │       ├── dashboard.twig      ✅ COMPLETED
│   │   │       ├── error.twig          ✅ COMPLETED
│   │   │       ├── admin/              ✅ COMPLETED
│   │   │       ├── employees/          ✅ COMPLETED
│   │   │       ├── software/           ✅ COMPLETED
│   │   │       └── units/              ✅ COMPLETED
│   │   └── Config/                     ✅ COMPLETED
│   │       ├── Database.php            ✅ COMPLETED
│   │       └── TwigConfig.php          ✅ COMPLETED
│   ├── public/                         ✅ COMPLETED
│   │   ├── index.php                   ✅ COMPLETED
│   │   ├── favicon.svg                 ✅ COMPLETED
│   │   ├── css/ (Bootstrap & custom)   ✅ COMPLETED
│   │   ├── js/ (DataTables & custom)   ✅ COMPLETED
│   │   └── images/                     ✅ COMPLETED
│   ├── database/                       ✅ COMPLETED
│   │   ├── schema.sql                  ✅ COMPLETED
│   │   └── sample-data.sql             ✅ COMPLETED
│   ├── vendor/ (Composer dependencies) ✅ COMPLETED
│   └── tests/                          ✅ SETUP (PHPUnit configured)
└── Documentation Files                 ✅ COMPLETED
    ├── README.md                       ✅ COMPLETED
    ├── REQUIREMENTS.md                 ✅ COMPLETED
    ├── DATABASE.md                     ✅ COMPLETED
    └── LICENSE                         ✅ COMPLETED
```

## Current Implementation Status

### ✅ COMPLETED FEATURES

The Software Product Tracking System has been fully implemented with the following features:

1. **Complete Database Schema** - All tables, relationships, views, and sample data
2. **Full MVC Architecture** - Controllers, Models, Views with Twig templates  
3. **Docker Containerization** - Multi-container setup with web server, database, and phpMyAdmin
4. **Employee Management** - Full CRUD operations with role tracking
5. **Software Product Management** - Complete software inventory with vendor and OS support
6. **University Unit Management** - Department and unit organization
7. **Role Assignment System** - Flexible three-role system (Business Owner, Technical Owner, Technical Manager)
8. **Advanced DataTables Integration** - Search, filter, sort, export functionality
9. **Admin Dashboard** - Database testing and performance monitoring tools
10. **Responsive UI** - Bootstrap 5 responsive design
11. **Documentation** - Complete setup and user documentation

### 🚧 FUTURE ENHANCEMENTS

Areas identified for potential future development:

1. **Enhanced Security**
   - User authentication and authorization system
   - Role-based access controls
   - Advanced CSRF and XSS protection

2. **Advanced Testing**
   - Comprehensive unit test suite
   - Integration testing
   - End-to-end testing automation
   - Performance benchmarking

3. **Production Features**
   - Automated backup and recovery procedures
   - CI/CD pipeline integration
   - Advanced monitoring and alerting
   - Load balancing and scaling considerations

4. **Extended Functionality**
   - API endpoints for third-party integration
   - Advanced reporting and analytics
   - Email notifications for role changes
   - Data export/import capabilities
   - Advanced search and filtering options

## Next Steps for Further Development

1. **Security Implementation**: Implement user authentication and role-based access controls
2. **Testing Expansion**: Develop comprehensive automated test suite
3. **Performance Optimization**: Implement caching strategies and query optimization
4. **Production Deployment**: Set up CI/CD pipeline and production environment
5. **API Development**: Create RESTful API endpoints for external integrations

## Implementation Notes

### ✅ Successfully Implemented

- **Modern Web Application Framework**: Built with PHP 8.3, Twig 3.x, MySQL 8.0, Bootstrap 5, and DataTables
- **Industry-Standard Components**: All components are well-documented and widely supported
- **Containerized Deployment**: Docker-based architecture ensures consistent deployment across environments
- **Security Foundation**: Built-in security measures including prepared statements, input validation, and XSS protection
- **Scalable Architecture**: MVC pattern supports both simple and complex business requirements
- **Comprehensive Data Model**: Flexible many-to-many relationships support complex university software tracking needs
- **Advanced UI/UX**: Bootstrap 5 responsive design with DataTables for rich data interaction
- **Administrative Tools**: Built-in database testing and performance monitoring capabilities

### Key Architectural Decisions

1. **MVC Pattern**: Clear separation of concerns with Controllers handling routing, Models managing data, and Views (Twig) handling presentation
2. **Database Design**: Normalized schema with proper indexing, foreign keys, and audit logging
3. **Flexible Role System**: Single software_roles table allows any combination of role assignments
4. **Operating System Support**: Many-to-many relationship allows software to support multiple OS platforms
5. **Unit Hierarchy**: Self-referential university_units table supports organizational structure
6. **Performance Monitoring**: Built-in admin tools for database connectivity and performance testing

### Technical Highlights

- **Responsive Design**: Fully responsive interface works on all device sizes
- **Advanced DataTables**: Server-side processing, export functionality, and real-time search
- **Docker Integration**: Complete containerization with persistent volumes and health checks
- **Environment Configuration**: Flexible .env-based configuration for different deployment environments
- **Audit Trail**: Complete change tracking for compliance and debugging
- **Database Views**: Pre-built views for common queries and reporting needs

This implementation provides a solid, production-ready foundation for university software product tracking with room for future enhancements and scaling.
