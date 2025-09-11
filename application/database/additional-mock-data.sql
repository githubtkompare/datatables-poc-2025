-- Additional Mock Data for Software Product Tracking System
-- Adding 100 employees, 20 university units, and 200 software products
-- with proper relationships according to schema

USE datatables_db;

-- Additional University Units (20 new units)
INSERT INTO university_units (unit_name, unit_code, description, unit_type) VALUES
('Physics Department', 'PHYS', 'Department of Physics and Astronomy', 'department'),
('Psychology Department', 'PSYC', 'Department of Psychology and Behavioral Sciences', 'department'),
('Engineering Department', 'ENGR', 'Department of Engineering and Technology', 'department'),
('Business School', 'BUS', 'School of Business Administration', 'college'),
('Education Department', 'EDUC', 'Department of Education and Teaching', 'department'),
('Art Department', 'ART', 'Department of Fine Arts and Design', 'department'),
('Music Department', 'MUS', 'Department of Music and Performing Arts', 'department'),
('History Department', 'HIST', 'Department of History and Social Sciences', 'department'),
('English Department', 'ENG', 'Department of English and Literature', 'department'),
('Nursing Department', 'NURS', 'Department of Nursing and Health Sciences', 'department'),
('Facilities Management', 'FAC', 'Campus Facilities and Maintenance', 'support'),
('Security Services', 'SEC', 'Campus Security and Emergency Services', 'support'),
('Admissions Office', 'ADM', 'Student Admissions and Enrollment', 'administrative'),
('Registrar Office', 'REG', 'Academic Records and Registration', 'administrative'),
('Marketing Department', 'MARK', 'University Marketing and Communications', 'administrative'),
('Legal Affairs', 'LEG', 'Legal Counsel and Compliance', 'administrative'),
('Alumni Relations', 'ALU', 'Alumni Services and Development', 'support'),
('International Office', 'INT', 'International Student Services', 'support'),
('Research Office', 'RES', 'Office of Research and Innovation', 'research'),
('Health Services', 'HLTH', 'Campus Health and Wellness Center', 'support');

-- Additional Employees (100 new employees)
INSERT INTO employees (first_name, last_name, email, phone, university_unit_id, job_title) VALUES
-- Physics Department (unit_id 11)
('Albert', 'Einstein', 'albert.einstein@university.edu', '555-1001', 11, 'Professor of Physics'),
('Marie', 'Curie', 'marie.curie@university.edu', '555-1002', 11, 'Research Professor'),
('Neil', 'Tyson', 'neil.tyson@university.edu', '555-1003', 11, 'Department Chair'),
('Stephen', 'Hawking', 'stephen.hawking@university.edu', '555-1004', 11, 'Distinguished Professor'),
('Lisa', 'Randall', 'lisa.randall@university.edu', '555-1005', 11, 'Associate Professor'),

-- Psychology Department (unit_id 12)
('Sigmund', 'Freud', 'sigmund.freud@university.edu', '555-1006', 12, 'Professor Emeritus'),
('Carl', 'Jung', 'carl.jung@university.edu', '555-1007', 12, 'Professor'),
('B.F.', 'Skinner', 'bf.skinner@university.edu', '555-1008', 12, 'Research Director'),
('Jean', 'Piaget', 'jean.piaget@university.edu', '555-1009', 12, 'Child Development Specialist'),
('Elizabeth', 'Loftus', 'elizabeth.loftus@university.edu', '555-1010', 12, 'Memory Research Professor'),

-- Engineering Department (unit_id 13)
('Nikola', 'Tesla', 'nikola.tesla@university.edu', '555-1011', 13, 'Professor of Electrical Engineering'),
('Ada', 'Lovelace', 'ada.lovelace@university.edu', '555-1012', 13, 'Computer Engineering Professor'),
('Grace', 'Hopper', 'grace.hopper@university.edu', '555-1013', 13, 'Software Engineering Professor'),
('Hedy', 'Lamarr', 'hedy.lamarr@university.edu', '555-1014', 13, 'Communications Engineering Professor'),
('Katherine', 'Johnson', 'katherine.johnson@university.edu', '555-1015', 13, 'Aerospace Engineering Professor'),

-- Business School (unit_id 14)
('Warren', 'Buffett', 'warren.buffett@university.edu', '555-1016', 14, 'Dean of Business'),
('Peter', 'Drucker', 'peter.drucker@university.edu', '555-1017', 14, 'Management Professor'),
('Michael', 'Porter', 'michael.porter@university.edu', '555-1018', 14, 'Strategy Professor'),
('Clayton', 'Christensen', 'clayton.christensen@university.edu', '555-1019', 14, 'Innovation Professor'),
('Jim', 'Collins', 'jim.collins@university.edu', '555-1020', 14, 'Leadership Professor'),

-- Education Department (unit_id 15)
('John', 'Dewey', 'john.dewey@university.edu', '555-1021', 15, 'Educational Philosophy Professor'),
('Maria', 'Montessori', 'maria.montessori@university.edu', '555-1022', 15, 'Early Childhood Education Professor'),
('Paulo', 'Freire', 'paulo.freire@university.edu', '555-1023', 15, 'Critical Pedagogy Professor'),
('Howard', 'Gardner', 'howard.gardner@university.edu', '555-1024', 15, 'Multiple Intelligence Theory Professor'),
('Carol', 'Dweck', 'carol.dweck@university.edu', '555-1025', 15, 'Educational Psychology Professor'),

-- Art Department (unit_id 16)
('Leonardo', 'DaVinci', 'leonardo.davinci@university.edu', '555-1026', 16, 'Fine Arts Professor'),
('Pablo', 'Picasso', 'pablo.picasso@university.edu', '555-1027', 16, 'Modern Art Professor'),
('Georgia', 'OKeeffe', 'georgia.okeefe@university.edu', '555-1028', 16, 'Painting Professor'),
('Andy', 'Warhol', 'andy.warhol@university.edu', '555-1029', 16, 'Pop Art Professor'),
('Frida', 'Kahlo', 'frida.kahlo@university.edu', '555-1030', 16, 'Contemporary Art Professor'),

-- Music Department (unit_id 17)
('Ludwig', 'Beethoven', 'ludwig.beethoven@university.edu', '555-1031', 17, 'Composition Professor'),
('Wolfgang', 'Mozart', 'wolfgang.mozart@university.edu', '555-1032', 17, 'Classical Music Professor'),
('Miles', 'Davis', 'miles.davis@university.edu', '555-1033', 17, 'Jazz Studies Professor'),
('Ella', 'Fitzgerald', 'ella.fitzgerald@university.edu', '555-1034', 17, 'Vocal Performance Professor'),
('John', 'Williams', 'john.williams@university.edu', '555-1035', 17, 'Film Music Professor'),

-- History Department (unit_id 18)
('Winston', 'Churchill', 'winston.churchill@university.edu', '555-1036', 18, 'Modern History Professor'),
('Frederick', 'Douglass', 'frederick.douglass@university.edu', '555-1037', 18, 'American History Professor'),
('Cleopatra', 'VII', 'cleopatra.vii@university.edu', '555-1038', 18, 'Ancient History Professor'),
('Nelson', 'Mandela', 'nelson.mandela@university.edu', '555-1039', 18, 'African Studies Professor'),
('Joan', 'Arc', 'joan.arc@university.edu', '555-1040', 18, 'Medieval History Professor'),

-- English Department (unit_id 19)
('William', 'Shakespeare', 'william.shakespeare@university.edu', '555-1041', 19, 'Literature Professor'),
('Maya', 'Angelou', 'maya.angelou@university.edu', '555-1042', 19, 'Poetry Professor'),
('Mark', 'Twain', 'mark.twain@university.edu', '555-1043', 19, 'American Literature Professor'),
('Virginia', 'Woolf', 'virginia.woolf@university.edu', '555-1044', 19, 'Modern Literature Professor'),
('Toni', 'Morrison', 'toni.morrison@university.edu', '555-1045', 19, 'Contemporary Literature Professor'),

-- Nursing Department (unit_id 20)
('Florence', 'Nightingale', 'florence.nightingale@university.edu', '555-1046', 20, 'Nursing Department Chair'),
('Clara', 'Barton', 'clara.barton@university.edu', '555-1047', 20, 'Emergency Nursing Professor'),
('Mary', 'Breckinridge', 'mary.breckinridge@university.edu', '555-1048', 20, 'Midwifery Professor'),
('Lillian', 'Wald', 'lillian.wald@university.edu', '555-1049', 20, 'Public Health Nursing Professor'),
('Dorothea', 'Dix', 'dorothea.dix@university.edu', '555-1050', 20, 'Psychiatric Nursing Professor'),

-- Administrative and Support Staff
-- Facilities Management (unit_id 21)
('Frank', 'Lloyd', 'frank.lloyd@university.edu', '555-1051', 21, 'Facilities Director'),
('Jane', 'Jacobs', 'jane.jacobs@university.edu', '555-1052', 21, 'Campus Planning Manager'),
('Christopher', 'Alexander', 'christopher.alexander@university.edu', '555-1053', 21, 'Building Operations Manager'),
('Zaha', 'Hadid', 'zaha.hadid@university.edu', '555-1054', 21, 'Architectural Services Manager'),
('I.M.', 'Pei', 'im.pei@university.edu', '555-1055', 21, 'Infrastructure Manager'),

-- Security Services (unit_id 22)
('Jack', 'Ryan', 'jack.ryan@university.edu', '555-1056', 22, 'Security Director'),
('Ellen', 'Ripley', 'ellen.ripley@university.edu', '555-1057', 22, 'Emergency Response Coordinator'),
('James', 'Bond', 'james.bond@university.edu', '555-1058', 22, 'Campus Security Chief'),
('Sarah', 'Connor', 'sarah.connor@university.edu', '555-1059', 22, 'Security Training Manager'),
('John', 'McClane', 'john.mcclane@university.edu', '555-1060', 22, 'Night Shift Supervisor'),

-- Admissions Office (unit_id 23)
('Michelle', 'Obama', 'michelle.obama@university.edu', '555-1061', 23, 'Admissions Director'),
('Oprah', 'Winfrey', 'oprah.winfrey@university.edu', '555-1062', 23, 'Student Outreach Coordinator'),
('Ruth', 'Ginsburg', 'ruth.ginsburg@university.edu', '555-1063', 23, 'Graduate Admissions Manager'),
('Condoleezza', 'Rice', 'condoleezza.rice@university.edu', '555-1064', 23, 'International Admissions Manager'),
('Hillary', 'Clinton', 'hillary.clinton@university.edu', '555-1065', 23, 'Enrollment Services Manager'),

-- Registrar Office (unit_id 24)
('Benjamin', 'Franklin', 'benjamin.franklin@university.edu', '555-1066', 24, 'University Registrar'),
('Thomas', 'Jefferson', 'thomas.jefferson@university.edu', '555-1067', 24, 'Academic Records Manager'),
('John', 'Adams', 'john.adams@university.edu', '555-1068', 24, 'Degree Audit Specialist'),
('Alexander', 'Hamilton', 'alexander.hamilton@university.edu', '555-1069', 24, 'Transcript Services Manager'),
('George', 'Washington', 'george.washington@university.edu', '555-1070', 24, 'Registration Systems Manager'),

-- Marketing Department (unit_id 25)
('Don', 'Draper', 'don.draper@university.edu', '555-1071', 25, 'Marketing Director'),
('Peggy', 'Olson', 'peggy.olson@university.edu', '555-1072', 25, 'Creative Director'),
('Joan', 'Holloway', 'joan.holloway@university.edu', '555-1073', 25, 'Communications Manager'),
('Roger', 'Sterling', 'roger.sterling@university.edu', '555-1074', 25, 'Brand Manager'),
('Betty', 'Francis', 'betty.francis@university.edu', '555-1075', 25, 'Social Media Manager'),

-- Legal Affairs (unit_id 26)
('Johnnie', 'Cochran', 'johnnie.cochran@university.edu', '555-1076', 26, 'General Counsel'),
('Sandra', 'Day', 'sandra.day@university.edu', '555-1077', 26, 'Deputy General Counsel'),
('Thurgood', 'Marshall', 'thurgood.marshall@university.edu', '555-1078', 26, 'Compliance Officer'),
('Elena', 'Kagan', 'elena.kagan@university.edu', '555-1079', 26, 'Contract Specialist'),
('Sonia', 'Sotomayor', 'sonia.sotomayor@university.edu', '555-1080', 26, 'Legal Research Coordinator'),

-- Alumni Relations (unit_id 27)
('Bill', 'Gates', 'bill.gates@university.edu', '555-1081', 27, 'Alumni Relations Director'),
('Melinda', 'Gates', 'melinda.gates@university.edu', '555-1082', 27, 'Development Officer'),
('Steve', 'Jobs', 'steve.jobs@university.edu', '555-1083', 27, 'Corporate Relations Manager'),
('Mark', 'Zuckerberg', 'mark.zuckerberg@university.edu', '555-1084', 27, 'Alumni Engagement Coordinator'),
('Sheryl', 'Sandberg', 'sheryl.sandberg@university.edu', '555-1085', 27, 'Fundraising Manager'),

-- International Office (unit_id 28)
('Kofi', 'Annan', 'kofi.annan@university.edu', '555-1086', 28, 'International Programs Director'),
('Ban', 'Ki-moon', 'ban.ki-moon@university.edu', '555-1087', 28, 'Study Abroad Coordinator'),
('Malala', 'Yousafzai', 'malala.yousafzai@university.edu', '555-1088', 28, 'International Student Advisor'),
('Wangari', 'Maathai', 'wangari.maathai@university.edu', '555-1089', 28, 'Cultural Exchange Coordinator'),
('Desmond', 'Tutu', 'desmond.tutu@university.edu', '555-1090', 28, 'Global Partnerships Manager'),

-- Research Office (unit_id 29)
('Jane', 'Goodall', 'jane.goodall@university.edu', '555-1091', 29, 'Research Director'),
('Rachel', 'Carson', 'rachel.carson@university.edu', '555-1092', 29, 'Environmental Research Coordinator'),
('Barbara', 'McClintock', 'barbara.mcclintock@university.edu', '555-1093', 29, 'Genetics Research Manager'),
('Rosalind', 'Franklin', 'rosalind.franklin@university.edu', '555-1094', 29, 'Structural Biology Research Lead'),
('Dorothy', 'Hodgkin', 'dorothy.hodgkin@university.edu', '555-1095', 29, 'Chemistry Research Coordinator'),

-- Health Services (unit_id 30)
('Jonas', 'Salk', 'jonas.salk@university.edu', '555-1096', 30, 'Health Services Director'),
('Paul', 'Farmer', 'paul.farmer@university.edu', '555-1097', 30, 'Public Health Coordinator'),
('Susan', 'Love', 'susan.love@university.edu', '555-1098', 30, 'Women\'s Health Specialist'),
('Anthony', 'Fauci', 'anthony.fauci@university.edu', '555-1099', 30, 'Infectious Disease Specialist'),
('Atul', 'Gawande', 'atul.gawande@university.edu', '555-1100', 30, 'Preventive Medicine Coordinator'),

-- Additional staff across various departments
('Emma', 'Watson', 'emma.watson@university.edu', '555-1101', 19, 'Assistant Professor'),
('Malala', 'Smith', 'malala.smith@university.edu', '555-1102', 15, 'Curriculum Specialist'),
('Rosa', 'Parks', 'rosa.parks@university.edu', '555-1103', 18, 'Civil Rights History Professor'),
('Katherine', 'Hepburn', 'katherine.hepburn@university.edu', '555-1104', 16, 'Theatre Arts Professor'),
('Amelia', 'Earhart', 'amelia.earhart@university.edu', '555-1105', 13, 'Aviation Engineering Professor'),
('Margaret', 'Thatcher', 'margaret.thatcher@university.edu', '555-1106', 14, 'Political Science Professor'),
('Mother', 'Teresa', 'mother.teresa@university.edu', '555-1107', 20, 'Ethics in Healthcare Professor'),
('Diana', 'Ross', 'diana.ross@university.edu', '555-1108', 17, 'Popular Music Professor'),
('Billie', 'Holiday', 'billie.holiday@university.edu', '555-1109', 17, 'Blues and Jazz Professor'),
('Aretha', 'Franklin', 'aretha.franklin@university.edu', '555-1110', 17, 'Soul Music Professor'),
('Janis', 'Joplin', 'janis.joplin@university.edu', '555-1111', 17, 'Rock Music Professor'),
('Joni', 'Mitchell', 'joni.mitchell@university.edu', '555-1112', 17, 'Folk Music Professor'),
('Tina', 'Turner', 'tina.turner@university.edu', '555-1113', 17, 'Performance Studies Professor'),
('Stevie', 'Nicks', 'stevie.nicks@university.edu', '555-1114', 17, 'Songwriting Professor'),
('Dolly', 'Parton', 'dolly.parton@university.edu', '555-1115', 17, 'Country Music Professor');

-- Additional Software Products (200 new software products)
INSERT INTO software_products (software_name, version, description, vendor_managed, vendor_name, license_type, university_unit_id) VALUES
-- Academic Software
('Mathematica', '13.3', 'Computational mathematics software for advanced calculations', TRUE, 'Wolfram Research', 'Academic License', 3),
('Maple', '2023', 'Mathematical software for algebra, calculus, and more', TRUE, 'Maplesoft', 'Educational License', 3),
('Origin', '2023', 'Data analysis and graphing software for scientists', TRUE, 'OriginLab', 'Academic License', 11),
('GraphPad Prism', '10.0', 'Biostatistics and scientific graphing software', TRUE, 'GraphPad Software', 'Institutional License', 2),
('ImageJ', '1.54', 'Open source image processing software', FALSE, NULL, 'Open Source', 2),
('ChemSketch', '2023', 'Chemical drawing and molecular modeling software', TRUE, 'ACD/Labs', 'Educational License', 4),
('Gaussian', '16', 'Computational chemistry software package', TRUE, 'Gaussian Inc.', 'Academic License', 4),
('ANSYS', '2023', 'Engineering simulation software', TRUE, 'ANSYS Inc.', 'Academic License', 13),
('SolidWorks', '2024', '3D CAD design software', TRUE, 'Dassault Systemes', 'Educational License', 13),
('LabVIEW', '2023', 'System design platform and development environment', TRUE, 'National Instruments', 'Academic License', 13),

-- Statistical and Research Software
('SAS', '9.4', 'Statistical analysis system for data analytics', TRUE, 'SAS Institute', 'Academic License', 12),
('Stata', '18', 'Statistical software package for data analysis', TRUE, 'StataCorp', 'Educational License', 12),
('JMP', '17', 'Statistical discovery software from SAS', TRUE, 'SAS Institute', 'Academic License', 11),
('NVivo', '14', 'Qualitative data analysis software', TRUE, 'Lumivero', 'Academic License', 12),
('Atlas.ti', '23', 'Qualitative data analysis and research software', TRUE, 'ATLAS.ti GmbH', 'Educational License', 15),
('MaxQDA', '2024', 'Software for qualitative and mixed methods research', TRUE, 'VERBI Software', 'Academic License', 15),
('Qualtrics', '2024', 'Online survey and research platform', TRUE, 'Qualtrics', 'Institutional License', 23),
('REDCap', '14.0', 'Research electronic data capture platform', TRUE, 'Vanderbilt University', 'Consortium License', 29),
('Mendeley', '2024', 'Reference manager and academic social network', TRUE, 'Elsevier', 'Institutional License', 8),
('EndNote', 'X21', 'Reference management software', TRUE, 'Clarivate Analytics', 'Site License', 8),

-- Programming and Development Tools
('IntelliJ IDEA', '2024.1', 'Integrated development environment for Java', TRUE, 'JetBrains', 'Educational License', 1),
('PyCharm', '2024.1', 'Python IDE for professional developers', TRUE, 'JetBrains', 'Educational License', 1),
('Visual Studio', '2022', 'Integrated development environment from Microsoft', TRUE, 'Microsoft', 'Educational License', 1),
('Eclipse', '2024-03', 'Open source integrated development environment', FALSE, NULL, 'Open Source', 1),
('NetBeans', '20', 'Open source IDE for multiple programming languages', FALSE, NULL, 'Open Source', 1),
('RStudio', '2024.04', 'Integrated development environment for R', FALSE, NULL, 'Open Source', 10),
('Jupyter Notebook', '7.0', 'Web-based interactive computing platform', FALSE, NULL, 'Open Source', 1),
('Docker', '24.0', 'Containerization platform for applications', FALSE, NULL, 'Open Source', 5),
('Git', '2.45', 'Distributed version control system', FALSE, NULL, 'Open Source', 1),
('GitHub Desktop', '3.4', 'GUI for Git version control', FALSE, NULL, 'Open Source', 1),

-- Design and Media Software
('Photoshop', '2024', 'Professional image editing software', TRUE, 'Adobe', 'Educational License', 16),
('Illustrator', '2024', 'Vector graphics editor', TRUE, 'Adobe', 'Educational License', 16),
('InDesign', '2024', 'Desktop publishing software', TRUE, 'Adobe', 'Educational License', 16),
('Premiere Pro', '2024', 'Video editing software', TRUE, 'Adobe', 'Educational License', 16),
('After Effects', '2024', 'Digital visual effects software', TRUE, 'Adobe', 'Educational License', 16),
('Final Cut Pro', '10.8', 'Video editing software for macOS', TRUE, 'Apple', 'Educational License', 16),
('Blender', '4.1', 'Open source 3D creation suite', FALSE, NULL, 'Open Source', 16),
('SketchUp', '2024', '3D modeling software', TRUE, 'Trimble', 'Educational License', 16),
('Maya', '2024', '3D computer animation software', TRUE, 'Autodesk', 'Educational License', 16),
('3ds Max', '2024', '3D modeling and rendering software', TRUE, 'Autodesk', 'Educational License', 16),

-- Business and Administrative Software
('QuickBooks', '2024', 'Accounting software for small to medium business', TRUE, 'Intuit', 'Commercial License', 7),
('SAP ERP', '6.0', 'Enterprise resource planning software', TRUE, 'SAP', 'Enterprise License', 7),
('Oracle Financials', '12.2', 'Financial management system', TRUE, 'Oracle', 'Enterprise License', 7),
('PeopleSoft', '9.2', 'Human resources management system', TRUE, 'Oracle', 'Enterprise License', 6),
('Workday', '2024', 'Cloud-based HR and finance software', TRUE, 'Workday', 'SaaS License', 6),
('Salesforce', '2024', 'Customer relationship management platform', TRUE, 'Salesforce', 'Educational License', 25),
('HubSpot', '2024', 'Inbound marketing and sales platform', TRUE, 'HubSpot', 'Educational License', 25),
('Mailchimp', '2024', 'Email marketing platform', TRUE, 'Intuit', 'Premium License', 25),
('Hootsuite', '2024', 'Social media management platform', TRUE, 'Hootsuite', 'Professional License', 25),
('Canva', '2024', 'Graphic design platform', TRUE, 'Canva', 'Education License', 25),

-- Specialized Academic Software
('ArcGIS', '10.9', 'Geographic information system software', TRUE, 'Esri', 'Educational License', 18),
('QGIS', '3.36', 'Open source geographic information system', FALSE, NULL, 'Open Source', 18),
('Sibelius', '2024', 'Music notation software', TRUE, 'Avid', 'Educational License', 17),
('Finale', '27', 'Music notation and composition software', TRUE, 'MakeMusic', 'Educational License', 17),
('Pro Tools', '2024.6', 'Digital audio workstation', TRUE, 'Avid', 'Educational License', 17),
('Logic Pro', '10.8', 'Digital audio workstation for macOS', TRUE, 'Apple', 'Educational License', 17),
('Ableton Live', '12', 'Music production software', TRUE, 'Ableton', 'Educational License', 17),
('PsychoPy', '2024.1', 'Psychology experiment software', FALSE, NULL, 'Open Source', 12),
('E-Prime', '3.0', 'Psychology experiment design software', TRUE, 'Psychology Software Tools', 'Academic License', 12),
('OpenSesame', '4.0', 'Graphical experiment builder for psychology', FALSE, NULL, 'Open Source', 12),

-- Medical and Health Software
('Epic', '2024', 'Electronic health records system', TRUE, 'Epic Systems', 'Enterprise License', 30),
('Cerner', '2024', 'Healthcare information technology', TRUE, 'Oracle', 'Enterprise License', 30),
('MEDITECH', '2024', 'Healthcare information system', TRUE, 'Medical Information Technology', 'Enterprise License', 30),
('athenahealth', '2024', 'Cloud-based healthcare software', TRUE, 'athenahealth', 'SaaS License', 30),
('NextGen', '2024', 'Healthcare practice management', TRUE, 'NextGen Healthcare', 'Professional License', 30),
('DrChrono', '2024', 'Electronic health records for mobile', TRUE, 'DrChrono', 'Cloud License', 30),
('Practice Fusion', '2024', 'Web-based electronic health records', TRUE, 'Veracyte', 'Cloud License', 30),
('eClinicalWorks', '2024', 'Electronic medical records system', TRUE, 'eClinicalWorks', 'Enterprise License', 30),
('AllScripts', '2024', 'Healthcare information solutions', TRUE, 'Allscripts', 'Enterprise License', 20),
('CPRS', '2024', 'Computerized patient record system', FALSE, 'US Department of Veterans Affairs', 'Government License', 20),

-- Library and Information Science Software
('Alma', '2024', 'Library services platform', TRUE, 'Ex Libris', 'Subscription License', 8),
('Sierra', '6.1', 'Integrated library system', TRUE, 'Innovative Interfaces', 'Annual License', 8),
('WorldCat', '2024', 'Global library catalog', TRUE, 'OCLC', 'Membership License', 8),
('LibGuides', '2024', 'Library website content management', TRUE, 'Springshare', 'Annual License', 8),
('DSpace', '7.6', 'Open source digital repository software', FALSE, NULL, 'Open Source', 8),
('Fedora', '6.5', 'Digital object repository architecture', FALSE, NULL, 'Open Source', 8),
('Samvera', '2024', 'Repository software framework', FALSE, NULL, 'Open Source', 8),
('LOCKSS', '2024', 'Digital preservation system', FALSE, NULL, 'Open Source', 8),
('Zotero', '7.0', 'Free reference management tool', FALSE, NULL, 'Open Source', 8),
('RefWorks', '2024', 'Web-based reference management', TRUE, 'ProQuest', 'Institutional License', 8),

-- Engineering and Technical Software
('CATIA', 'V5', '3D product design and experience solution', TRUE, 'Dassault Systemes', 'Academic License', 13),
('NX', '2312', 'Product development solution', TRUE, 'Siemens', 'Academic License', 13),
('Creo', '10.0', 'Product design software', TRUE, 'PTC', 'Academic License', 13),
('Inventor', '2024', '3D mechanical design software', TRUE, 'Autodesk', 'Educational License', 13),
('Fusion 360', '2024', 'Cloud-based 3D CAD/CAM/CAE software', TRUE, 'Autodesk', 'Educational License', 13),
('Revit', '2024', 'Building information modeling software', TRUE, 'Autodesk', 'Educational License', 13),
('ArchiCAD', '27', 'BIM software for architects', TRUE, 'Graphisoft', 'Educational License', 16),
('Rhino', '8', '3D computer graphics software', TRUE, 'Robert McNeel & Associates', 'Educational License', 16),
('KeyShot', '12', '3D rendering and animation software', TRUE, 'Luxion', 'Educational License', 16),
('Substance Painter', '2024', '3D painting software', TRUE, 'Adobe', 'Educational License', 16),

-- Scientific Research Software
('ChemDraw Professional', '22.0', 'Chemical drawing and analysis software', TRUE, 'PerkinElmer', 'Academic License', 4),
('SciFinder', '2024', 'Chemical research database', TRUE, 'Chemical Abstracts Service', 'Academic License', 4),
('Reaxys', '2024', 'Chemical database and search engine', TRUE, 'Elsevier', 'Academic License', 4),
('Materials Studio', '2024', 'Modeling and simulation for materials science', TRUE, 'BIOVIA', 'Academic License', 4),
('VASP', '6.4', 'Ab initio quantum mechanical molecular dynamics', TRUE, 'University of Vienna', 'Academic License', 11),
('NAMD', '3.0', 'Molecular dynamics simulation software', FALSE, NULL, 'Open Source', 4),
('VMD', '1.9.4', 'Molecular visualization program', FALSE, NULL, 'Open Source', 4),
('PyMOL', '2.5', 'Molecular visualization system', TRUE, 'Schrodinger', 'Educational License', 2),
('GROMACS', '2024', 'Molecular dynamics package', FALSE, NULL, 'Open Source', 4),
('AMBER', '22', 'Suite of biomolecular simulation programs', TRUE, 'University of California', 'Academic License', 2),

-- Data Science and Analytics Software
('Tableau', '2024.1', 'Data visualization software', TRUE, 'Salesforce', 'Academic License', 29),
('Power BI', '2024', 'Business analytics solution', TRUE, 'Microsoft', 'Educational License', 14),
('Qlik Sense', '2024', 'Data analytics platform', TRUE, 'Qlik', 'Academic License', 14),
('Spotfire', '2024', 'Analytics and data visualization software', TRUE, 'TIBCO', 'Academic License', 29),
('Alteryx', '2024.1', 'Data science and analytics platform', TRUE, 'Alteryx', 'Academic License', 29),
('DataRobot', '2024', 'Automated machine learning platform', TRUE, 'DataRobot', 'Academic License', 1),
('H2O.ai', '3.46', 'Open source machine learning platform', FALSE, NULL, 'Open Source', 1),
('Weka', '3.8', 'Machine learning software', FALSE, NULL, 'Open Source', 1),
('Orange', '3.36', 'Data visualization and analysis tool', FALSE, NULL, 'Open Source', 1),
('KNIME', '5.2', 'Analytics platform for data science', FALSE, NULL, 'Open Source', 29),

-- Productivity and Collaboration Software
('Slack', '2024', 'Team collaboration platform', TRUE, 'Salesforce', 'Enterprise License', 5),
('Microsoft Teams', '2024', 'Collaboration and communication platform', TRUE, 'Microsoft', 'Educational License', 5),
('Zoom', '2024', 'Video conferencing software', TRUE, 'Zoom', 'Educational License', 5),
('WebEx', '2024', 'Video conferencing and collaboration', TRUE, 'Cisco', 'Educational License', 5),
('Google Workspace', '2024', 'Productivity and collaboration suite', TRUE, 'Google', 'Educational License', 5),
('Dropbox', '2024', 'Cloud storage and file sharing', TRUE, 'Dropbox', 'Education License', 5),
('Box', '2024', 'Cloud content management platform', TRUE, 'Box', 'Educational License', 5),
('OneDrive', '2024', 'Cloud storage service', TRUE, 'Microsoft', 'Educational License', 5),
('SharePoint', '2024', 'Web-based collaboration platform', TRUE, 'Microsoft', 'Educational License', 5),
('Confluence', '2024', 'Team collaboration software', TRUE, 'Atlassian', 'Academic License', 5),

-- Security and System Administration
('CrowdStrike', '2024', 'Endpoint protection platform', TRUE, 'CrowdStrike', 'Enterprise License', 22),
('Symantec Endpoint Protection', '14.3', 'Antivirus and security software', TRUE, 'Broadcom', 'Enterprise License', 22),
('McAfee ePO', '5.10', 'Security management platform', TRUE, 'McAfee', 'Enterprise License', 22),
('Splunk', '9.2', 'Data analytics and security platform', TRUE, 'Splunk', 'Educational License', 5),
('Wireshark', '4.2', 'Network protocol analyzer', FALSE, NULL, 'Open Source', 5),
('Nessus', '10.7', 'Vulnerability assessment scanner', TRUE, 'Tenable', 'Educational License', 22),
('Nmap', '7.94', 'Network discovery and security auditing', FALSE, NULL, 'Open Source', 5),
('Metasploit', '6.4', 'Penetration testing framework', TRUE, 'Rapid7', 'Educational License', 5),
('Burp Suite', '2024', 'Web application security testing', TRUE, 'PortSwigger', 'Educational License', 5),
('OWASP ZAP', '2.15', 'Web application security scanner', FALSE, NULL, 'Open Source', 5),

-- Database and Data Management
('Oracle Database', '23c', 'Relational database management system', TRUE, 'Oracle', 'Academic License', 5),
('SQL Server', '2022', 'Relational database management system', TRUE, 'Microsoft', 'Academic License', 5),
('PostgreSQL', '16', 'Open source relational database', FALSE, NULL, 'Open Source', 5),
('MongoDB', '7.0', 'NoSQL document database', TRUE, 'MongoDB Inc.', 'Educational License', 5),
('Redis', '7.2', 'In-memory data structure store', FALSE, NULL, 'Open Source', 5),
('Elasticsearch', '8.13', 'Search and analytics engine', FALSE, NULL, 'Open Source', 5),
('Neo4j', '5.19', 'Graph database management system', TRUE, 'Neo4j', 'Educational License', 5),
('Cassandra', '5.0', 'Distributed NoSQL database', FALSE, NULL, 'Open Source', 5),
('InfluxDB', '2.7', 'Time series database', FALSE, NULL, 'Open Source', 5),
('Tableau Server', '2024.1', 'Enterprise analytics platform', TRUE, 'Salesforce', 'Academic License', 29),

-- Web Development and CMS
('WordPress', '6.5', 'Content management system', FALSE, NULL, 'Open Source', 25),
('Drupal', '10', 'Content management framework', FALSE, NULL, 'Open Source', 25),
('Joomla', '5.1', 'Content management system', FALSE, NULL, 'Open Source', 25),
('Magento', '2.4', 'E-commerce platform', FALSE, NULL, 'Open Source', 25),
('Shopify', '2024', 'E-commerce platform', TRUE, 'Shopify', 'Commercial License', 25),
('WooCommerce', '8.8', 'E-commerce plugin for WordPress', FALSE, NULL, 'Open Source', 25),
('Squarespace', '2024', 'Website building and hosting', TRUE, 'Squarespace', 'Commercial License', 25),
('Wix', '2024', 'Cloud-based web development platform', TRUE, 'Wix', 'Commercial License', 25),
('WebFlow', '2024', 'Visual web design platform', TRUE, 'Webflow', 'Professional License', 25),
('Ghost', '5.82', 'Publishing platform', FALSE, NULL, 'Open Source', 25),

-- Network and Infrastructure
('VMware vSphere', '8.0', 'Virtualization platform', TRUE, 'VMware', 'Academic License', 5),
('Hyper-V', '2022', 'Hypervisor-based virtualization', TRUE, 'Microsoft', 'Academic License', 5),
('Citrix XenApp', '2402', 'Application virtualization', TRUE, 'Citrix', 'Academic License', 5),
('Kubernetes', '1.30', 'Container orchestration platform', FALSE, NULL, 'Open Source', 5),
('OpenShift', '4.15', 'Enterprise Kubernetes platform', TRUE, 'Red Hat', 'Academic License', 5),
('Ansible', '9.4', 'Automation and configuration management', FALSE, NULL, 'Open Source', 5),
('Puppet', '8.6', 'Configuration management tool', TRUE, 'Puppet', 'Educational License', 5),
('Chef', '18.4', 'Infrastructure automation platform', TRUE, 'Progress', 'Educational License', 5),
('Terraform', '1.8', 'Infrastructure as code software', FALSE, NULL, 'Open Source', 5),
('Nagios', '4.5', 'Network and infrastructure monitoring', FALSE, NULL, 'Open Source', 5),

-- Specialized Software
('LabArchives', '2024', 'Electronic lab notebook', TRUE, 'LabArchives LLC', 'Institutional License', 29),
('Benchling', '2024', 'Life sciences R&D cloud platform', TRUE, 'Benchling', 'Academic License', 2),
('Geneious', '2024.0', 'Molecular biology and sequence analysis', TRUE, 'Dotmatics', 'Academic License', 2),
('FlowJo', '10.10', 'Flow cytometry analysis software', TRUE, 'BD Life Sciences', 'Academic License', 2),
('GraphPad InStat', '3.1', 'Statistical analysis software', TRUE, 'GraphPad Software', 'Academic License', 12),
('Minitab', '21', 'Statistical software for quality improvement', TRUE, 'Minitab LLC', 'Academic License', 14),
('EViews', '13', 'Econometric analysis software', TRUE, 'HIS Global Inc.', 'Academic License', 14),
('Stata/MP', '18', 'Multiprocessor statistical software', TRUE, 'StataCorp', 'Academic License', 12),
('MPlus', '8.10', 'Statistical modeling software', TRUE, 'Muthen & Muthen', 'Academic License', 12),
('Lisrel', '10.3', 'Structural equation modeling software', TRUE, 'Scientific Software International', 'Academic License', 12);