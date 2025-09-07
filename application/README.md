# Software Product Tracking System

A comprehensive web application for managing software products, employees, and university units with role assignments and tracking capabilities.

## Features

- **Employee Management**: Track university employees with role assignments
- **Software Product Management**: Manage software inventory with vendor information and operating system compatibility  
- **University Unit Management**: Organize departments and administrative units
- **Role-Based Assignments**: Flexible role assignment system (Business Owner, Technical Owner, Technical Manager)
- **Advanced DataTables**: Interactive tables with search, filtering, sorting, and export capabilities
- **Database Testing Suite**: Comprehensive database connectivity and performance testing tools
- **Admin Dashboard**: System monitoring and health checks
- **Responsive Design**: Bootstrap 5-based responsive UI

## Technical Stack

- **Backend**: PHP 8.3
- **Template Engine**: Twig 3.x
- **Database**: MySQL 8.0
- **Frontend**: Bootstrap 5, DataTables 2.3.3
- **Containerization**: Docker & Docker Compose

## Prerequisites

- Docker Desktop
- Docker Compose

## Quick Start

1. **Clone or navigate to the project directory**
   ```bash
   cd /Users/tkompare/Documents/VSCode/datatables-poc-2025/application
   ```

2. **Start the application**
   ```bash
   docker-compose up -d
   ```

3. **Wait for services to initialize** (first run may take a few minutes)
   - Web application: http://localhost:8080
   - phpMyAdmin: http://localhost:8081 (username: datatables_user, password: datatables_password)

4. **Access the application**
   - Open your browser to http://localhost:8080
   - The application will automatically set up the database with sample data

## Application Structure

```
application/
├── docker-compose.yml          # Docker services configuration
├── Dockerfile                  # Web container configuration
├── composer.json               # PHP dependencies
├── .env                       # Environment variables
├── public/
│   └── index.php              # Application entry point
├── src/
│   ├── Config/                # Configuration classes
│   ├── Controllers/           # MVC Controllers
│   ├── Models/                # Database models
│   └── Views/
│       └── templates/         # Twig templates
├── database/
│   ├── schema.sql            # Database schema
│   └── sample-data.sql       # Sample data
└── README.md
```

## Key Features

### Dashboard
- System overview with statistics
- Recent employees, software, and units
- Quick action buttons

### Employee Management
- Full CRUD operations for employees
- Role assignment tracking
- Search and filtering capabilities
- Export functionality

### Software Product Management
- Software inventory with version tracking
- Vendor management status
- Operating system compatibility
- Role assignments (Business Owner, Technical Owner, Technical Manager)
- University unit assignments

### University Unit Management
- Hierarchical unit structure
- Department and administrative unit types
- Software assignment tracking
- Parent-child relationships

### Administration Tools
- **Database Testing Suite**: Comprehensive connectivity, performance, and integrity testing
- **Performance Monitoring**: Query execution time analysis
- **System Health Checks**: Real-time database status monitoring
- **Export Capabilities**: Test results and data export functionality

## Database Schema

The application uses a normalized MySQL database with the following key tables:

- `employees`: Staff information and contact details
- `software_products`: Software inventory with metadata
- `university_units`: Organizational structure
- `software_roles`: Role assignments linking employees to software products
- `operating_systems`: Supported operating systems
- `software_operating_systems`: Software-OS compatibility mapping

## Sample Data

The application includes comprehensive sample data:
- 10 employees across various departments
- 10 software products (mix of vendor-managed and internal)
- 10 university units representing typical academic and administrative departments
- Complete role assignments demonstrating flexibility
- Realistic cross-departmental software usage patterns

## Admin Features

### Database Testing
Access via `/admin/db-test`:
- **Connection Tests**: Multi-connection testing with performance metrics
- **Performance Tests**: Query execution time analysis
- **Table Integrity**: Foreign key constraint validation
- **Complex Query Tests**: View and aggregation performance testing

### Performance Monitoring
Access via `/admin/performance-test`:
- Real-time query performance monitoring
- Database response time analysis
- Resource utilization tracking

## Configuration

### Environment Variables (.env)
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

# MySQL Root Password
MYSQL_ROOT_PASSWORD=root_password
```

### Docker Services
- **Web Server**: Apache with PHP 8.3
- **Database**: MySQL 8.0 with persistent storage
- **phpMyAdmin**: Database administration interface

## Development

### Adding New Features
1. Create models in `src/Models/`
2. Add controllers in `src/Controllers/`
3. Create Twig templates in `src/Views/templates/`
4. Update routing in `public/index.php`

### Database Changes
1. Update `database/schema.sql` for structural changes
2. Modify `database/sample-data.sql` for new sample data
3. Rebuild containers: `docker-compose down && docker-compose up -d --build`

## Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Ensure Docker services are running
   - Check database initialization logs: `docker-compose logs database`
   - Verify environment variables in `.env`

2. **Composer Dependencies Missing**
   - Rebuild the web container: `docker-compose up -d --build web`

3. **Permission Issues**
   - Reset container permissions: `docker-compose down && docker-compose up -d`

### Useful Commands

```bash
# View logs
docker-compose logs web
docker-compose logs database

# Restart services
docker-compose restart

# Rebuild containers
docker-compose down && docker-compose up -d --build

# Access web container
docker-compose exec web bash

# Access MySQL
docker-compose exec database mysql -u datatables_user -p datatables_db
```

## Production Deployment

For production deployment:

1. Update environment variables for production
2. Set `APP_DEBUG=false` in `.env`
3. Configure proper SSL/TLS certificates
4. Set up proper backup procedures
5. Configure monitoring and logging
6. Implement proper security measures

## Security Considerations

- Input validation and sanitization
- Prepared statements for SQL queries
- Environment variable protection
- HTTPS configuration recommended for production
- Regular security updates

## License

This project is built for educational and demonstration purposes. Please ensure compliance with all software licenses and institutional policies when deploying in production environments.

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Docker container logs
3. Verify database connectivity using the admin testing tools
4. Ensure all prerequisites are met
