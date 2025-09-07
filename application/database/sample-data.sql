-- Sample Data for Software Product Tracking System
-- Updated to reflect new requirements:
-- 1. Each software has exactly one business owner, technical owner, and technical manager
-- 2. Multiple instances of same software are allowed
-- 3. Software university unit determined by business owner's department

USE datatables_db;

-- Insert Operating Systems
INSERT INTO operating_systems (os_name, os_version, os_family) VALUES
('Windows 11', '11', 'Windows'),
('Windows 10', '10', 'Windows'),
('macOS Sonoma', '14.0', 'macOS'),
('macOS Ventura', '13.0', 'macOS'),
('Ubuntu Linux', '22.04 LTS', 'Linux'),
('CentOS Linux', '8', 'Linux'),
('Red Hat Enterprise Linux', '9', 'Linux'),
('Cross-Platform', 'N/A', 'Other');

-- Insert University Units
INSERT INTO university_units (unit_name, unit_code, description, unit_type) VALUES
('Computer Science Department', 'CS', 'Department of Computer Science and Software Engineering', 'department'),
('Biology Department', 'BIOL', 'Department of Biological Sciences', 'department'),
('Mathematics Department', 'MATH', 'Department of Mathematics and Statistics', 'department'),
('Chemistry Department', 'CHEM', 'Department of Chemistry and Biochemistry', 'department'),
('IT Services', 'ITS', 'Information Technology Services Division', 'administrative'),
('Human Resources', 'HR', 'Human Resources Department', 'administrative'),
('Finance Department', 'FIN', 'Financial Services and Administration', 'administrative'),
('University Library', 'LIB', 'Main University Library System', 'support'),
('Student Services', 'SS', 'Student Affairs and Support Services', 'support'),
('Research Computing', 'RC', 'High Performance Computing and Research Support', 'research');

-- Insert Employees with departments matching university units
INSERT INTO employees (first_name, last_name, email, phone, department, job_title) VALUES
('Sarah', 'Johnson', 'sarah.johnson@university.edu', '555-0101', 'IT Services', 'IT Director'),
('Michael', 'Chen', 'michael.chen@university.edu', '555-0102', 'Computer Science Department', 'Professor'),
('Emily', 'Rodriguez', 'emily.rodriguez@university.edu', '555-0103', 'Biology Department', 'Associate Professor'),
('David', 'Thompson', 'david.thompson@university.edu', '555-0104', 'IT Services', 'Systems Administrator'),
('Jessica', 'Williams', 'jessica.williams@university.edu', '555-0105', 'Mathematics Department', 'Department Chair'),
('Robert', 'Davis', 'robert.davis@university.edu', '555-0106', 'IT Services', 'Database Administrator'),
('Amanda', 'Miller', 'amanda.miller@university.edu', '555-0107', 'Human Resources', 'HR Manager'),
('Christopher', 'Wilson', 'christopher.wilson@university.edu', '555-0108', 'Finance Department', 'Finance Director'),
('Lisa', 'Anderson', 'lisa.anderson@university.edu', '555-0109', 'Research Computing', 'Research Computing Manager'),
('Kevin', 'Taylor', 'kevin.taylor@university.edu', '555-0110', 'Chemistry Department', 'Lab Manager'),
('Dr. James', 'Peterson', 'james.peterson@university.edu', '555-0111', 'Biology Department', 'Professor'),
('Maria', 'Garcia', 'maria.garcia@university.edu', '555-0112', 'Computer Science Department', 'Associate Professor'),
('John', 'Smith', 'john.smith@university.edu', '555-0113', 'Mathematics Department', 'Professor'),
('Anna', 'Brown', 'anna.brown@university.edu', '555-0114', 'Chemistry Department', 'Research Coordinator'),
('Tom', 'Lee', 'tom.lee@university.edu', '555-0115', 'University Library', 'Systems Librarian');

-- Insert Software Products with university_unit_id determined by business owner's department
INSERT INTO software_products (software_name, version, description, vendor_managed, vendor_name, license_type, university_unit_id) VALUES
-- Multiple SPSS instances (same software, different instances)
('SPSS Statistical Software', '29.0', 'Statistical analysis software for psychology research', TRUE, 'IBM', 'Site License', 2),
('SPSS Statistical Software', '29.0', 'Statistical analysis software for biology research', TRUE, 'IBM', 'Site License', 2),  
('SPSS Statistical Software', '28.0', 'Statistical analysis software for mathematics research', TRUE, 'IBM', 'Site License', 3),

-- Multiple MATLAB instances
('MATLAB', 'R2023b', 'Technical computing for engineering applications', TRUE, 'MathWorks', 'Campus License', 1),
('MATLAB', 'R2023a', 'Mathematical modeling for biology research', TRUE, 'MathWorks', 'Campus License', 2),
('MATLAB', 'R2023b', 'Statistical computing platform for mathematics', TRUE, 'MathWorks', 'Campus License', 3),

-- Multiple Office instances  
('Microsoft Office 365', '2023', 'Productivity suite for IT administrative tasks', TRUE, 'Microsoft', 'Enterprise Agreement', 5),
('Microsoft Office 365', '2023', 'Office suite for HR operations', TRUE, 'Microsoft', 'Enterprise Agreement', 6),
('Microsoft Office 365', '2023', 'Document management for library services', TRUE, 'Microsoft', 'Enterprise Agreement', 8),

-- Multiple Adobe instances
('Adobe Creative Suite', '2023', 'Design software for CS course materials', TRUE, 'Adobe', 'Education License', 1),
('Adobe Creative Suite', '2023', 'Scientific illustration software for biology', TRUE, 'Adobe', 'Education License', 2),

-- Multiple AutoCAD instances
('AutoCAD', '2024', 'CAD software for computer graphics courses', TRUE, 'Autodesk', 'Educational License', 1),
('AutoCAD', '2024', 'Technical drawing for chemistry lab design', TRUE, 'Autodesk', 'Educational License', 4),

-- Banner ERP (single instance for IT)
('Banner ERP', '9.4', 'Student information system', TRUE, 'Ellucian', 'Perpetual License', 5);

-- Insert Software Roles (each software instance gets exactly one of each role type)
INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) VALUES
-- SPSS instances - Business owners determine university unit
(1, 3, 4, 1),   -- Biology SPSS: Emily Rodriguez (bio) -> unit 2, David Thompson (tech owner), Sarah Johnson (tech mgr)  
(2, 11, 4, 1),  -- Biology SPSS 2: James Peterson (bio) -> unit 2, David Thompson, Sarah Johnson
(3, 5, 6, 1),   -- Math SPSS: Jessica Williams (math) -> unit 3, Robert Davis, Sarah Johnson

-- MATLAB instances  
(4, 2, 12, 1),  -- CS MATLAB: Michael Chen (CS) -> unit 1, Maria Garcia, Sarah Johnson
(5, 3, 11, 1),  -- Biology MATLAB: Emily Rodriguez (bio) -> unit 2, James Peterson, Sarah Johnson  
(6, 13, 6, 1),  -- Math MATLAB: John Smith (math) -> unit 3, Robert Davis, Sarah Johnson

-- Office instances - Business owner's department determines unit
(7, 1, 4, 1),   -- IT Office: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(8, 7, 4, 1),   -- HR Office: Amanda Miller (HR) -> unit 6, David Thompson, Sarah Johnson
(9, 15, 4, 1),  -- Library Office: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson

-- Adobe instances
(10, 2, 12, 1), -- CS Adobe: Michael Chen (CS) -> unit 1, Maria Garcia, Sarah Johnson  
(11, 3, 11, 1), -- Biology Adobe: Emily Rodriguez (bio) -> unit 2, James Peterson, Sarah Johnson

-- AutoCAD instances
(12, 12, 2, 1), -- CS AutoCAD: Maria Garcia (CS) -> unit 1, Michael Chen, Sarah Johnson
(13, 10, 14, 1), -- Chemistry AutoCAD: Kevin Taylor (chem) -> unit 4, Anna Brown, Sarah Johnson

-- Banner ERP
(14, 1, 6, 1);  -- Banner: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
('ChemDraw', '22.0', 'Chemical drawing and molecular modeling software', TRUE, 'PerkinElmer', 'Departmental License'),
('R Statistical Software', '4.3.0', 'Open source statistical computing and graphics software', FALSE, NULL, 'Open Source'),
('Python', '3.11', 'Programming language and development environment', FALSE, NULL, 'Open Source'),
('Blackboard Learn', '9.1', 'Learning management system for online courses and content delivery', TRUE, 'Anthology', 'Institutional License');

-- Insert Software Operating System relationships
INSERT INTO software_operating_systems (software_id, os_id) VALUES
-- SPSS - Windows and macOS
(1, 1), (1, 2), (1, 3), (1, 4),
-- MATLAB - All major platforms
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
-- Microsoft Office 365 - Windows and macOS
(3, 1), (3, 2), (3, 3), (3, 4),
-- Adobe Creative Suite - Windows and macOS
-- Insert Software Operating System compatibility
INSERT INTO software_operating_systems (software_id, os_id, minimum_version, notes) VALUES
-- SPSS compatibility for all instances
(1, 1, NULL, 'Windows 11 compatible'), (1, 2, NULL, 'Windows 10 supported'), (1, 3, NULL, 'macOS Sonoma'),
(2, 1, NULL, 'Windows 11 compatible'), (2, 2, NULL, 'Windows 10 supported'), (2, 3, NULL, 'macOS Sonoma'),
(3, 1, NULL, 'Windows 11 compatible'), (3, 2, NULL, 'Windows 10 supported'), (3, 4, NULL, 'macOS Ventura'),

-- MATLAB compatibility  
(4, 1, NULL, 'Windows 11'), (4, 3, NULL, 'macOS Sonoma'), (4, 5, NULL, 'Ubuntu Linux'),
(5, 1, NULL, 'Windows 11'), (5, 3, NULL, 'macOS Sonoma'),
(6, 1, NULL, 'Windows 11'), (6, 5, NULL, 'Ubuntu Linux'),

-- Office 365 compatibility (cross-platform)
(7, 8, NULL, 'Cross-platform'), (8, 8, NULL, 'Cross-platform'), (9, 8, NULL, 'Cross-platform'),

-- Adobe compatibility
(10, 1, NULL, 'Windows 11'), (10, 3, NULL, 'macOS Sonoma'),
(11, 1, NULL, 'Windows 11'), (11, 3, NULL, 'macOS Sonoma'),

-- AutoCAD compatibility  
(12, 1, NULL, 'Windows 11'), (12, 2, NULL, 'Windows 10'),
(13, 1, NULL, 'Windows 11'), (13, 2, NULL, 'Windows 10'),

-- Banner ERP (web-based)
(14, 8, NULL, 'Web-based access');

-- Note: software_unit_assignments table is no longer used since university unit 
-- assignment is now determined by the business owner's department

-- MATLAB used by engineering and science departments
(2, 1, 'active', 'Computational programming courses'),
(2, 3, 'active', 'Numerical analysis and modeling'),
(2, 4, 'active', 'Chemical engineering applications'),
(2, 10, 'active', 'High performance computing integration'),

-- Microsoft Office 365 - University-wide
(3, 1, 'active', 'Department communications and documentation'),
(3, 2, 'active', 'Research documentation and presentations'),
(3, 5, 'active', 'Administrative operations'),
(3, 6, 'active', 'HR documentation and communications'),
(3, 7, 'active', 'Financial reporting and analysis'),
(3, 8, 'active', 'Library operations and communications'),
(3, 9, 'active', 'Student services documentation'),

-- Adobe Creative Suite - Design and media departments
(4, 1, 'active', 'Web development and digital media courses'),
(4, 8, 'active', 'Library digital collections and marketing'),
(4, 9, 'active', 'Student services marketing materials'),

-- AutoCAD - Engineering and architecture
(5, 1, 'active', 'Engineering design courses'),
(5, 10, 'active', 'Research facility planning'),

-- Banner ERP - Administrative units
(6, 5, 'active', 'IT system administration'),
(6, 6, 'active', 'Human resources management'),
(6, 7, 'active', 'Financial operations'),
(6, 9, 'active', 'Student information management'),

-- ChemDraw - Chemistry focused
(7, 4, 'active', 'Chemical structure drawing and analysis'),
(7, 2, 'active', 'Biochemistry applications'),

-- R Statistical Software - Research departments
(8, 2, 'active', 'Biological data analysis'),
(8, 3, 'active', 'Statistical modeling and analysis'),
(8, 4, 'active', 'Chemical data analysis'),
(8, 10, 'active', 'Research computing support'),

-- Python - Technical departments
(9, 1, 'active', 'Programming courses and research'),
(9, 2, 'active', 'Bioinformatics applications'),
(9, 3, 'active', 'Mathematical modeling'),
(9, 5, 'active', 'IT automation and scripting'),
(9, 10, 'active', 'Research computing development'),

-- Blackboard - University-wide LMS
(10, 1, 'active', 'Computer science course delivery'),
(10, 2, 'active', 'Biology course management'),
(10, 3, 'active', 'Mathematics course delivery'),
(10, 4, 'active', 'Chemistry laboratory management'),
(10, 8, 'active', 'Library instruction and tutorials'),
(10, 9, 'active', 'Student orientation and resources');
