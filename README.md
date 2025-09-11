# DataTables POC 2025 - Software Product Tracking System

A comprehensive proof-of-concept web application demonstrating modern DataTables integration with a PHP-based software product tracking system for university environments.

## 🚀 Project Overview

This project showcases a complete software product tracking system built to manage software inventory, employee roles, and organizational units within a university setting. The application demonstrates advanced DataTables functionality, modern web development practices, and enterprise-grade database design patterns.

### Key Highlights

- **Interactive DataTables Integration**: Advanced table functionality with search, filtering, sorting, and responsive design
- **Role-Based Software Management**: Flexible assignment system for business and technical ownership
- **University Organization Structure**: Support for university unit hierarchies with employee and software assignments  
- **Comprehensive Admin Tools**: Database table inspection, statistics monitoring, and clickable table exploration
- **Modern Development Stack**: PHP 8.3, MySQL 8.0, Twig templating, Bootstrap 5
- **Containerized Architecture**: Full Docker-based deployment with Docker Compose

## 📁 Project Structure

```text
datatables-poc-2025/
├── README.md                   # This comprehensive project overview
├── DATABASE.md                 # Complete database schema documentation
├── REQUIREMENTS.md             # Detailed business and technical requirements
├── LICENSE                     # CC0 1.0 Universal License
└── application/               # Main application directory
    ├── docker-compose.yml     # Docker services configuration
    ├── Dockerfile             # Application container configuration
    ├── composer.json          # PHP dependency management
    ├── public/                # Web-accessible files
    │   ├── index.php          # Application entry point
    │   └── favicon.svg        # Application favicon
    ├── src/                   # Application source code
    │   ├── Config/            # Configuration management
    │   ├── Controllers/       # MVC Controllers
    │   ├── Models/            # Database models and business logic
    │   └── Views/templates/   # Twig template files
    ├── database/              # Database setup and sample data
    │   ├── schema.sql         # Complete database schema
    │   └── sample-data.sql    # Realistic sample data
    └── vendor/                # Composer dependencies
```

## 🛠 Technology Stack

### Backend Technologies

- **PHP 8.3**: Modern PHP with type declarations and performance improvements
- **MySQL 8.0**: Enterprise-grade database with full ACID compliance
- **Twig 3.x**: Powerful templating engine with security features
- **Composer**: Dependency management and autoloading

### Frontend Technologies

- **DataTables 2.3.3**: Advanced table functionality with extensive plugins
- **Bootstrap 5**: Modern responsive CSS framework
- **jQuery**: JavaScript library for DOM manipulation and AJAX

### Infrastructure

- **Docker**: Containerization for consistent deployment
- **Docker Compose**: Multi-container orchestration
- **Apache**: Web server with PHP module
- **phpMyAdmin**: Database administration interface

## 🚀 Quick Start

### Prerequisites

- **Docker Desktop**: [Install Docker](https://www.docker.com/products/docker-desktop/)
- **Docker Compose**: Included with Docker Desktop
- **Web Browser**: Modern browser with JavaScript support

### Installation Steps

1. **Clone or download the repository**

   ```bash
   git clone <repository-url>
   cd datatables-poc-2025
   ```

2. **Navigate to the application directory**

   ```bash
   cd application
   ```

3. **Set up environment configuration**

   ```bash
   cp .env.example .env
   # Edit .env with your preferred settings if needed
   ```

4. **Start the application stack**

   ```bash
   docker-compose up -d
   ```

5. **Install PHP dependencies** (if not cached)

   ```bash
   docker-compose exec web composer install
   ```

6. **Access the application**
   - **Main Application**: <http://localhost:8080>
   - **Admin Dashboard**: <http://localhost:8080/admin> (authentication required)
   - **Database Admin**: <http://localhost:8081>
     - Username: `datatables_user`
     - Password: `datatables_password`

### First Run Experience

The application automatically:

- Creates the MySQL database with proper character encoding
- Executes the complete database schema
- Populates realistic sample data
- Initializes all necessary indexes and foreign key relationships

## 📊 Features & Capabilities

### Core Application Features

#### 🏢 **Employee Management**

- University unit association (replaces the deprecated department field)

#### 💻 **Software Product Management**

- Comprehensive software inventory with university unit assignments
- Version and vendor tracking
- Operating system compatibility matrix
- License type management
- Installation notes and documentation

#### 🏛 **University Unit Management**

- Hierarchical organizational structure
- Self-referencing parent-child relationships
- Department, college, administrative, support, and research unit types
- Employee and software assignment tracking
- Flexible organizational reporting

#### 👥 **Role Assignment System**

- **Business Owner**: Requirements and business decisions
- **Technical Owner**: Implementation and maintenance  
- **Technical Manager**: Technical oversight and management
- Each software product has exactly one set of role assignments
- Cross-employee role tracking and reporting

### Advanced DataTables Features

#### 📋 **Interactive Tables**

- **Server-side processing**: Efficient handling of large datasets
- **Advanced search**: Global and column-specific filtering
- **Multi-column sorting**: Complex data ordering
- **Responsive design**: Mobile-friendly table layouts
- **Real-time updates**: Dynamic data loading and display

#### 🔍 **Search & Filter Capabilities**

- Real-time search across all columns
- Custom column rendering for different data types
- Status indicators and badges
- Responsive column display on mobile devices
- Pagination with configurable page sizes

#### 📈 **Data Visualization**

- Row highlighting and selection
- Custom column rendering
- Status indicators and badges
- Progress bars and metrics
- Interactive tooltips

### Administration & Monitoring

#### 🔧 **Database Table Inspection** (`/admin`)

- **Interactive Table Statistics**: Clickable table cards showing record counts
- **Live Table Structure View**: Complete column definitions, types, keys, and constraints
- **Real-time Data Viewing**: Browse actual table data with first 100 records
- **Admin Authentication**: Secure access to database inspection tools
- **Responsive Design**: Mobile-friendly admin interface

#### 📊 **Database Testing Suite** (`/admin/db-test`)

- **Connection Tests**: Multi-connection testing with performance metrics
- **Performance Tests**: Query execution time analysis
- **Table Integrity**: Foreign key constraint validation
- **Complex Query Tests**: View and aggregation performance testing

#### 🔍 **Performance Monitoring** (`/admin/performance-test`)

- Real-time query performance monitoring
- Database response time analysis
- Resource utilization tracking
- Export capabilities for test results and data

#### 🏠 **System Dashboard**

- Live database table statistics
- Quick navigation to table inspection views  
- System status indicators
- Administrative tool access

## 🗄 Database Architecture

### Schema Overview

- **6 Core Tables**: Normalized relational design with proper foreign key relationships
- **9 Foreign Key Relationships**: Data integrity enforcement across all tables
- **Comprehensive Indexing**: Strategic index placement for query optimization
- **ACID Compliance**: Full transactional support with InnoDB engine
- **UTF8MB4 Character Set**: Full Unicode support including emoji

### Key Tables

- **university_units**: Hierarchical organizational structure (self-referencing)
- **employees**: Staff information with university_unit_id foreign key reference
- **software_products**: Software inventory with university_unit_id association
- **software_roles**: Role assignments linking employees to software products
- **operating_systems**: Supported operating systems catalog
- **software_operating_systems**: Software-OS compatibility mapping (many-to-many)

For complete database documentation, see [DATABASE.md](DATABASE.md).

## 📋 Sample Data

The application includes realistic sample data representing:

 **15 Employees** across various university units with proper unit associations
 **14 Software Products** (mix of vendor-managed and internal) with university unit assignments
 **10 University Units** representing academic and administrative units in hierarchical structure
 **Complete Role Assignments** with business owners, technical owners, and technical managers
 **OS Compatibility Matrix** showing software-operating system relationships
 **Cross-unit Usage Patterns** demonstrating real-world organizational complexity

## 🔧 Configuration & Customization

### Environment Configuration

Create a `.env` file in the `application/` directory with the following settings (use `.env.example` as a template):

```bash
# Database Configuration
DB_HOST=database
DB_NAME=datatables_db
DB_USER=datatables_user
DB_PASSWORD=datatables_password

# Application Configuration
APP_ENV=development
APP_DEBUG=true
APP_URL=http://localhost:8080
APP_TIMEZONE=America/Chicago

# MySQL Root Password
MYSQL_ROOT_PASSWORD=root_password
```

**Note**: The `.env` file is excluded from version control for security. Copy from `.env.example` and customize for your environment.

### Docker Services

The application uses three main Docker services:

- **Web Container**: Apache + PHP 8.3 + Application code
- **Database Container**: MySQL 8.0 with persistent storage
- **phpMyAdmin Container**: Database administration interface

### Customization Options

- **Theme Customization**: Bootstrap 5 variables and custom CSS
- **DataTables Configuration**: Column definitions and display options
- **Business Logic**: Model classes and validation rules
- **Template Customization**: Twig templates with inheritance

## 🚀 Development & Extension

### Adding New Features

1. **Create Database Tables**

   ```sql
   -- Update database/schema.sql
   CREATE TABLE new_table (...);
   ```

2. **Develop Models**

   ```php
   // src/Models/NewModel.php
   class NewModel { ... }
   ```

3. **Create Controllers**

   ```php
   // src/Controllers/NewController.php
   class NewController { ... }
   ```

4. **Design Templates**

   ```twig
   {# src/Views/templates/new/index.twig #}
   {% extends "base.twig" %}
   ```

5. **Update Routing**

   ```php
   // Update routing in public/index.php
   ```

### Development Workflow

1. Make changes to source code
2. Restart containers if needed: `docker-compose restart web`
3. Test changes in browser
4. Check logs: `docker-compose logs web`

### Database Changes

For structural database changes:

1. Update `database/schema.sql` for structural changes
2. Modify `database/sample-data.sql` for new sample data
3. Rebuild containers: `docker-compose down && docker-compose up -d --build`

## 📈 Performance Considerations

### Optimization Features

- **Database Indexing**: Strategic index placement for query performance
- **Connection Pooling**: Efficient database connection management  
- **Query Optimization**: Optimized SQL queries with proper joins
- **Caching Strategy**: Template caching with Twig
- **Asset Optimization**: Minimized CSS and JavaScript loading

### Monitoring Tools

- Built-in performance testing suite
- Real-time database monitoring
- Query execution analysis
- Resource utilization tracking

## 🔐 Security Features

### Data Protection

- **SQL Injection Prevention**: Prepared statements throughout
- **Input Validation**: Server-side validation for all inputs
- **XSS Protection**: Template escaping with Twig
- **CSRF Protection**: Form token validation
- **Environment Variable Protection**: Sensitive data isolation

### Access Control

- Session management
- Role-based access patterns
- Admin-only functionality segregation
- Secure database connections

## 🚀 Production Deployment

For production deployment considerations:

1. **Environment Configuration**
   - Update environment variables for production
   - Set `APP_DEBUG=false` in `.env`
   - Configure proper database credentials

2. **Security Hardening**
   - Configure SSL/TLS certificates
   - Implement proper security measures
   - Set up secure backup procedures
   - Configure monitoring and logging

3. **Performance Optimization**
   - Enable production caching
   - Configure proper resource limits
   - Set up load balancing if needed
   - Implement CDN for static assets

4. **Maintenance**
   - Regular security updates
   - Database backup strategies
   - Log rotation and monitoring
   - Performance monitoring and alerting

### Security Considerations

- Input validation and sanitization throughout the application
- All database queries use prepared statements
- Environment variables protect sensitive configuration
- HTTPS configuration strongly recommended for production
- Regular security updates and dependency management
- Compliance with institutional security policies

## 🐛 Troubleshooting

### Common Issues & Solutions

#### Database Connection Issues

```bash
# Check container status
docker-compose ps

# View database logs
docker-compose logs database

# Ensure Docker services are running
docker-compose restart database

# Verify environment variables in .env
```

#### Performance Issues

```bash
# Monitor container resources
docker stats

# Check application logs
docker-compose logs web

# Restart all services
docker-compose restart
```

#### Development Issues

```bash
# Rebuild containers (missing dependencies)
docker-compose down && docker-compose up -d --build

# Clear all containers and start fresh
docker-compose down -v && docker-compose up -d

# Reset container permissions
docker-compose down && docker-compose up -d
```

#### Composer Dependencies Missing

```bash
# Rebuild the web container
docker-compose up -d --build web
```

### Useful Development Commands

```bash
# View logs
docker-compose logs web
docker-compose logs database

# Restart services
docker-compose restart

# Access web container
docker-compose exec web bash

# Access MySQL directly
docker-compose exec database mysql -u datatables_user -p datatables_db
```

### Debug Mode

Enable detailed error reporting by setting `APP_DEBUG=true` in the environment configuration.

## 📚 Documentation

- **[DATABASE.md](DATABASE.md)**: Complete database schema documentation
- **[REQUIREMENTS.md](REQUIREMENTS.md)**: Detailed business and technical requirements

## 📄 License

This project is released under the **CC0 1.0 Universal License**, placing it in the public domain. You are free to use, modify, and distribute this code without any restrictions.

See [LICENSE](LICENSE) for the complete license text.

## 🤝 Contributing

This is a proof-of-concept project designed for educational and demonstration purposes. While not actively maintained, the codebase serves as a reference implementation for:

- Modern PHP web application architecture
- DataTables integration patterns
- Docker-based development workflows
- Database design best practices
- Enterprise application structure

## 🆘 Support & Resources

### Getting Help

1. Check the troubleshooting section above
2. Review container logs for error details
3. Use the built-in admin testing tools
4. Verify all prerequisites are installed

### Learning Resources

- [DataTables Documentation](https://datatables.net/)
- [PHP 8.3 Features](https://www.php.net/releases/8.3/)
- [Twig Template Documentation](https://twig.symfony.com/)
- [Docker Compose Guide](https://docs.docker.com/compose/)
- [Bootstrap 5 Documentation](https://getbootstrap.com/)

### Project Goals

This proof-of-concept demonstrates:

- ✅ Modern web application architecture
- ✅ Advanced DataTables integration
- ✅ Enterprise database design patterns
- ✅ Containerized development workflow
- ✅ Administrative tooling and monitoring
- ✅ Responsive and accessible UI design

---

Built with ❤️ as a comprehensive DataTables proof-of-concept
