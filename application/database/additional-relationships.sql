-- Additional Software Roles and Operating System Relationships
-- Creating relationships between employees, software, and units according to schema

USE datatables_db;

-- Software Roles for the additional 200 software products
-- Each software product needs exactly one business owner, technical owner, and technical manager
-- Business owner determines the university_unit_id for the software

INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) VALUES
-- Academic Software (software_id 15-24)
(15, 13, 4, 1),  -- Mathematica: John Smith (Math) -> unit 3, David Thompson, Sarah Johnson
(16, 5, 6, 1),   -- Maple: Jessica Williams (Math) -> unit 3, Robert Davis, Sarah Johnson  
(17, 16, 4, 1),  -- Origin: Albert Einstein (Physics) -> unit 11, David Thompson, Sarah Johnson
(18, 11, 6, 1),  -- GraphPad Prism: James Peterson (Bio) -> unit 2, Robert Davis, Sarah Johnson
(19, 3, 4, 1),   -- ImageJ: Emily Rodriguez (Bio) -> unit 2, David Thompson, Sarah Johnson
(20, 14, 6, 1),  -- ChemSketch: Anna Brown (Chem) -> unit 4, Robert Davis, Sarah Johnson
(21, 10, 4, 1),  -- Gaussian: Kevin Taylor (Chem) -> unit 4, David Thompson, Sarah Johnson
(22, 20, 6, 1),  -- ANSYS: Katherine Johnson (Engineering) -> unit 13, Robert Davis, Sarah Johnson
(23, 19, 4, 1),  -- SolidWorks: Clayton Christensen (Business) -> unit 14, David Thompson, Sarah Johnson
(24, 18, 6, 1),  -- LabVIEW: Michael Porter (Business) -> unit 14, Robert Davis, Sarah Johnson

-- Statistical and Research Software (software_id 25-34)
(25, 27, 4, 1),  -- SAS: Carl Jung (Psychology) -> unit 12, David Thompson, Sarah Johnson
(26, 28, 6, 1),  -- Stata: B.F. Skinner (Psychology) -> unit 12, Robert Davis, Sarah Johnson
(27, 16, 4, 1),  -- JMP: Albert Einstein (Physics) -> unit 11, David Thompson, Sarah Johnson
(28, 29, 6, 1),  -- NVivo: Jean Piaget (Psychology) -> unit 12, Robert Davis, Sarah Johnson
(29, 21, 4, 1),  -- Atlas.ti: John Dewey (Education) -> unit 15, David Thompson, Sarah Johnson
(30, 22, 6, 1),  -- MaxQDA: Maria Montessori (Education) -> unit 15, Robert Davis, Sarah Johnson
(31, 61, 4, 1),  -- Qualtrics: Michelle Obama (Admissions) -> unit 23, David Thompson, Sarah Johnson
(32, 91, 6, 1),  -- REDCap: Jane Goodall (Research) -> unit 29, Robert Davis, Sarah Johnson
(33, 15, 4, 1),  -- Mendeley: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson
(34, 15, 6, 1),  -- EndNote: Tom Lee (Library) -> unit 8, Robert Davis, Sarah Johnson

-- Programming and Development Tools (software_id 35-44)
(35, 2, 12, 1),  -- IntelliJ IDEA: Michael Chen (CS) -> unit 1, Maria Garcia, Sarah Johnson
(36, 12, 2, 1),  -- PyCharm: Maria Garcia (CS) -> unit 1, Michael Chen, Sarah Johnson
(37, 2, 12, 1),  -- Visual Studio: Michael Chen (CS) -> unit 1, Maria Garcia, Sarah Johnson
(38, 12, 2, 1),  -- Eclipse: Maria Garcia (CS) -> unit 1, Michael Chen, Sarah Johnson
(39, 2, 12, 1),  -- NetBeans: Michael Chen (CS) -> unit 1, Maria Garcia, Sarah Johnson
(40, 9, 4, 1),   -- RStudio: Lisa Anderson (Research Computing) -> unit 10, David Thompson, Sarah Johnson
(41, 12, 2, 1),  -- Jupyter Notebook: Maria Garcia (CS) -> unit 1, Michael Chen, Sarah Johnson
(42, 4, 6, 1),   -- Docker: David Thompson (IT) -> unit 5, Robert Davis, Sarah Johnson
(43, 2, 12, 1),  -- Git: Michael Chen (CS) -> unit 1, Maria Garcia, Sarah Johnson
(44, 12, 2, 1),  -- GitHub Desktop: Maria Garcia (CS) -> unit 1, Michael Chen, Sarah Johnson

-- Design and Media Software (software_id 45-54)
(45, 26, 4, 1),  -- Photoshop: Leonardo DaVinci (Art) -> unit 16, David Thompson, Sarah Johnson
(46, 27, 6, 1),  -- Illustrator: Pablo Picasso (Art) -> unit 16, Robert Davis, Sarah Johnson
(47, 28, 4, 1),  -- InDesign: Georgia OKeeffe (Art) -> unit 16, David Thompson, Sarah Johnson
(48, 29, 6, 1),  -- Premiere Pro: Andy Warhol (Art) -> unit 16, Robert Davis, Sarah Johnson
(49, 30, 4, 1),  -- After Effects: Frida Kahlo (Art) -> unit 16, David Thompson, Sarah Johnson
(50, 35, 6, 1),  -- Final Cut Pro: John Williams (Music) -> unit 17, Robert Davis, Sarah Johnson
(51, 26, 4, 1),  -- Blender: Leonardo DaVinci (Art) -> unit 16, David Thompson, Sarah Johnson
(52, 27, 6, 1),  -- SketchUp: Pablo Picasso (Art) -> unit 16, Robert Davis, Sarah Johnson
(53, 28, 4, 1),  -- Maya: Georgia OKeeffe (Art) -> unit 16, David Thompson, Sarah Johnson
(54, 29, 6, 1),  -- 3ds Max: Andy Warhol (Art) -> unit 16, Robert Davis, Sarah Johnson

-- Business and Administrative Software (software_id 55-64)
(55, 8, 4, 1),   -- QuickBooks: Christopher Wilson (Finance) -> unit 7, David Thompson, Sarah Johnson
(56, 8, 6, 1),   -- SAP ERP: Christopher Wilson (Finance) -> unit 7, Robert Davis, Sarah Johnson
(57, 8, 4, 1),   -- Oracle Financials: Christopher Wilson (Finance) -> unit 7, David Thompson, Sarah Johnson
(58, 7, 6, 1),   -- PeopleSoft: Amanda Miller (HR) -> unit 6, Robert Davis, Sarah Johnson
(59, 7, 4, 1),   -- Workday: Amanda Miller (HR) -> unit 6, David Thompson, Sarah Johnson
(60, 71, 6, 1),  -- Salesforce: Don Draper (Marketing) -> unit 25, Robert Davis, Sarah Johnson
(61, 72, 4, 1),  -- HubSpot: Peggy Olson (Marketing) -> unit 25, David Thompson, Sarah Johnson
(62, 73, 6, 1),  -- Mailchimp: Joan Holloway (Marketing) -> unit 25, Robert Davis, Sarah Johnson
(63, 74, 4, 1),  -- Hootsuite: Roger Sterling (Marketing) -> unit 25, David Thompson, Sarah Johnson
(64, 75, 6, 1),  -- Canva: Betty Francis (Marketing) -> unit 25, Robert Davis, Sarah Johnson

-- Specialized Academic Software (software_id 65-74)
(65, 36, 4, 1),  -- ArcGIS: Winston Churchill (History) -> unit 18, David Thompson, Sarah Johnson
(66, 37, 6, 1),  -- QGIS: Frederick Douglass (History) -> unit 18, Robert Davis, Sarah Johnson
(67, 31, 4, 1),  -- Sibelius: Ludwig Beethoven (Music) -> unit 17, David Thompson, Sarah Johnson
(68, 32, 6, 1),  -- Finale: Wolfgang Mozart (Music) -> unit 17, Robert Davis, Sarah Johnson
(69, 33, 4, 1),  -- Pro Tools: Miles Davis (Music) -> unit 17, David Thompson, Sarah Johnson
(70, 34, 6, 1),  -- Logic Pro: Ella Fitzgerald (Music) -> unit 17, Robert Davis, Sarah Johnson
(71, 35, 4, 1),  -- Ableton Live: John Williams (Music) -> unit 17, David Thompson, Sarah Johnson
(72, 26, 6, 1),  -- PsychoPy: Sigmund Freud (Psychology) -> unit 12, Robert Davis, Sarah Johnson
(73, 27, 4, 1),  -- E-Prime: Carl Jung (Psychology) -> unit 12, David Thompson, Sarah Johnson
(74, 28, 6, 1),  -- OpenSesame: B.F. Skinner (Psychology) -> unit 12, Robert Davis, Sarah Johnson

-- Medical and Health Software (software_id 75-84)
(75, 96, 4, 1),  -- Epic: Jonas Salk (Health Services) -> unit 30, David Thompson, Sarah Johnson
(76, 97, 6, 1),  -- Cerner: Paul Farmer (Health Services) -> unit 30, Robert Davis, Sarah Johnson
(77, 98, 4, 1),  -- MEDITECH: Susan Love (Health Services) -> unit 30, David Thompson, Sarah Johnson
(78, 99, 6, 1),  -- athenahealth: Anthony Fauci (Health Services) -> unit 30, Robert Davis, Sarah Johnson
(79, 100, 4, 1), -- NextGen: Atul Gawande (Health Services) -> unit 30, David Thompson, Sarah Johnson
(80, 96, 6, 1),  -- DrChrono: Jonas Salk (Health Services) -> unit 30, Robert Davis, Sarah Johnson
(81, 97, 4, 1),  -- Practice Fusion: Paul Farmer (Health Services) -> unit 30, David Thompson, Sarah Johnson
(82, 98, 6, 1),  -- eClinicalWorks: Susan Love (Health Services) -> unit 30, Robert Davis, Sarah Johnson
(83, 46, 4, 1),  -- AllScripts: Florence Nightingale (Nursing) -> unit 20, David Thompson, Sarah Johnson
(84, 47, 6, 1),  -- CPRS: Clara Barton (Nursing) -> unit 20, Robert Davis, Sarah Johnson

-- Library and Information Science Software (software_id 85-94)
(85, 15, 4, 1),  -- Alma: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson
(86, 15, 6, 1),  -- Sierra: Tom Lee (Library) -> unit 8, Robert Davis, Sarah Johnson
(87, 15, 4, 1),  -- WorldCat: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson
(88, 15, 6, 1),  -- LibGuides: Tom Lee (Library) -> unit 8, Robert Davis, Sarah Johnson
(89, 15, 4, 1),  -- DSpace: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson
(90, 15, 6, 1),  -- Fedora: Tom Lee (Library) -> unit 8, Robert Davis, Sarah Johnson
(91, 15, 4, 1),  -- Samvera: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson
(92, 15, 6, 1),  -- LOCKSS: Tom Lee (Library) -> unit 8, Robert Davis, Sarah Johnson
(93, 15, 4, 1),  -- Zotero: Tom Lee (Library) -> unit 8, David Thompson, Sarah Johnson
(94, 15, 6, 1),  -- RefWorks: Tom Lee (Library) -> unit 8, Robert Davis, Sarah Johnson

-- Engineering and Technical Software (software_id 95-104)
(95, 20, 4, 1),  -- CATIA: Katherine Johnson (Engineering) -> unit 13, David Thompson, Sarah Johnson
(96, 18, 6, 1),  -- NX: Michael Porter (Engineering) -> unit 13, Robert Davis, Sarah Johnson
(97, 19, 4, 1),  -- Creo: Clayton Christensen (Engineering) -> unit 13, David Thompson, Sarah Johnson
(98, 20, 6, 1),  -- Inventor: Katherine Johnson (Engineering) -> unit 13, Robert Davis, Sarah Johnson
(99, 18, 4, 1),  -- Fusion 360: Michael Porter (Engineering) -> unit 13, David Thompson, Sarah Johnson
(100, 19, 6, 1), -- Revit: Clayton Christensen (Engineering) -> unit 13, Robert Davis, Sarah Johnson
(101, 26, 4, 1), -- ArchiCAD: Leonardo DaVinci (Art) -> unit 16, David Thompson, Sarah Johnson
(102, 27, 6, 1), -- Rhino: Pablo Picasso (Art) -> unit 16, Robert Davis, Sarah Johnson
(103, 28, 4, 1), -- KeyShot: Georgia OKeeffe (Art) -> unit 16, David Thompson, Sarah Johnson
(104, 29, 6, 1), -- Substance Painter: Andy Warhol (Art) -> unit 16, Robert Davis, Sarah Johnson

-- Scientific Research Software (software_id 105-114)
(105, 10, 4, 1), -- ChemDraw Professional: Kevin Taylor (Chemistry) -> unit 4, David Thompson, Sarah Johnson
(106, 14, 6, 1), -- SciFinder: Anna Brown (Chemistry) -> unit 4, Robert Davis, Sarah Johnson
(107, 10, 4, 1), -- Reaxys: Kevin Taylor (Chemistry) -> unit 4, David Thompson, Sarah Johnson
(108, 14, 6, 1), -- Materials Studio: Anna Brown (Chemistry) -> unit 4, Robert Davis, Sarah Johnson
(109, 16, 4, 1), -- VASP: Albert Einstein (Physics) -> unit 11, David Thompson, Sarah Johnson
(110, 10, 6, 1), -- NAMD: Kevin Taylor (Chemistry) -> unit 4, Robert Davis, Sarah Johnson
(111, 14, 4, 1), -- VMD: Anna Brown (Chemistry) -> unit 4, David Thompson, Sarah Johnson
(112, 3, 6, 1),  -- PyMOL: Emily Rodriguez (Biology) -> unit 2, Robert Davis, Sarah Johnson
(113, 10, 4, 1), -- GROMACS: Kevin Taylor (Chemistry) -> unit 4, David Thompson, Sarah Johnson
(114, 11, 6, 1), -- AMBER: James Peterson (Biology) -> unit 2, Robert Davis, Sarah Johnson

-- Data Science and Analytics Software (software_id 115-124)
(115, 91, 4, 1), -- Tableau: Jane Goodall (Research) -> unit 29, David Thompson, Sarah Johnson
(116, 16, 6, 1), -- Power BI: Warren Buffett (Business) -> unit 14, Robert Davis, Sarah Johnson
(117, 17, 4, 1), -- Qlik Sense: Peter Drucker (Business) -> unit 14, David Thompson, Sarah Johnson
(118, 92, 6, 1), -- Spotfire: Rachel Carson (Research) -> unit 29, Robert Davis, Sarah Johnson
(119, 93, 4, 1), -- Alteryx: Barbara McClintock (Research) -> unit 29, David Thompson, Sarah Johnson
(120, 2, 6, 1),  -- DataRobot: Michael Chen (CS) -> unit 1, Robert Davis, Sarah Johnson
(121, 12, 4, 1), -- H2O.ai: Maria Garcia (CS) -> unit 1, David Thompson, Sarah Johnson
(122, 2, 6, 1),  -- Weka: Michael Chen (CS) -> unit 1, Robert Davis, Sarah Johnson
(123, 12, 4, 1), -- Orange: Maria Garcia (CS) -> unit 1, David Thompson, Sarah Johnson
(124, 94, 6, 1), -- KNIME: Rosalind Franklin (Research) -> unit 29, Robert Davis, Sarah Johnson

-- Productivity and Collaboration Software (software_id 125-134)
(125, 1, 4, 1),  -- Slack: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(126, 4, 6, 1),  -- Microsoft Teams: David Thompson (IT) -> unit 5, Robert Davis, Sarah Johnson
(127, 1, 4, 1),  -- Zoom: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(128, 6, 6, 1),  -- WebEx: Robert Davis (IT) -> unit 5, Robert Davis, Sarah Johnson
(129, 4, 4, 1),  -- Google Workspace: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(130, 1, 6, 1),  -- Dropbox: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
(131, 4, 4, 1),  -- Box: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(132, 6, 6, 1),  -- OneDrive: Robert Davis (IT) -> unit 5, Robert Davis, Sarah Johnson
(133, 1, 4, 1),  -- SharePoint: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(134, 4, 6, 1),  -- Confluence: David Thompson (IT) -> unit 5, Robert Davis, Sarah Johnson

-- Security and System Administration (software_id 135-144)
(135, 56, 4, 1), -- CrowdStrike: Jack Ryan (Security) -> unit 22, David Thompson, Sarah Johnson
(136, 57, 6, 1), -- Symantec Endpoint Protection: Ellen Ripley (Security) -> unit 22, Robert Davis, Sarah Johnson
(137, 58, 4, 1), -- McAfee ePO: James Bond (Security) -> unit 22, David Thompson, Sarah Johnson
(138, 1, 6, 1),  -- Splunk: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
(139, 4, 4, 1),  -- Wireshark: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(140, 59, 6, 1), -- Nessus: Sarah Connor (Security) -> unit 22, Robert Davis, Sarah Johnson
(141, 6, 4, 1),  -- Nmap: Robert Davis (IT) -> unit 5, David Thompson, Sarah Johnson
(142, 1, 6, 1),  -- Metasploit: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
(143, 4, 4, 1),  -- Burp Suite: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(144, 6, 6, 1),  -- OWASP ZAP: Robert Davis (IT) -> unit 5, Robert Davis, Sarah Johnson

-- Database and Data Management (software_id 145-154)
(145, 6, 4, 1),  -- Oracle Database: Robert Davis (IT) -> unit 5, David Thompson, Sarah Johnson
(146, 1, 6, 1),  -- SQL Server: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
(147, 4, 4, 1),  -- PostgreSQL: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(148, 6, 6, 1),  -- MongoDB: Robert Davis (IT) -> unit 5, Robert Davis, Sarah Johnson
(149, 1, 4, 1),  -- Redis: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(150, 4, 6, 1),  -- Elasticsearch: David Thompson (IT) -> unit 5, Robert Davis, Sarah Johnson
(151, 6, 4, 1),  -- Neo4j: Robert Davis (IT) -> unit 5, David Thompson, Sarah Johnson
(152, 1, 6, 1),  -- Cassandra: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
(153, 4, 4, 1),  -- InfluxDB: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(154, 95, 6, 1), -- Tableau Server: Dorothy Hodgkin (Research) -> unit 29, Robert Davis, Sarah Johnson

-- Web Development and CMS (software_id 155-164)
(155, 71, 4, 1), -- WordPress: Don Draper (Marketing) -> unit 25, David Thompson, Sarah Johnson
(156, 72, 6, 1), -- Drupal: Peggy Olson (Marketing) -> unit 25, Robert Davis, Sarah Johnson
(157, 73, 4, 1), -- Joomla: Joan Holloway (Marketing) -> unit 25, David Thompson, Sarah Johnson
(158, 74, 6, 1), -- Magento: Roger Sterling (Marketing) -> unit 25, Robert Davis, Sarah Johnson
(159, 75, 4, 1), -- Shopify: Betty Francis (Marketing) -> unit 25, David Thompson, Sarah Johnson
(160, 71, 6, 1), -- WooCommerce: Don Draper (Marketing) -> unit 25, Robert Davis, Sarah Johnson
(161, 72, 4, 1), -- Squarespace: Peggy Olson (Marketing) -> unit 25, David Thompson, Sarah Johnson
(162, 73, 6, 1), -- Wix: Joan Holloway (Marketing) -> unit 25, Robert Davis, Sarah Johnson
(163, 74, 4, 1), -- WebFlow: Roger Sterling (Marketing) -> unit 25, David Thompson, Sarah Johnson
(164, 75, 6, 1), -- Ghost: Betty Francis (Marketing) -> unit 25, Robert Davis, Sarah Johnson

-- Network and Infrastructure (software_id 165-174)
(165, 1, 4, 1),  -- VMware vSphere: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(166, 4, 6, 1),  -- Hyper-V: David Thompson (IT) -> unit 5, Robert Davis, Sarah Johnson
(167, 6, 4, 1),  -- Citrix XenApp: Robert Davis (IT) -> unit 5, David Thompson, Sarah Johnson
(168, 1, 6, 1),  -- Kubernetes: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson
(169, 4, 4, 1),  -- OpenShift: David Thompson (IT) -> unit 5, David Thompson, Sarah Johnson
(170, 6, 6, 1),  -- Ansible: Robert Davis (IT) -> unit 5, Robert Davis, Sarah Johnson
(171, 1, 4, 1),  -- Puppet: Sarah Johnson (IT) -> unit 5, David Thompson, Sarah Johnson
(172, 4, 6, 1),  -- Chef: David Thompson (IT) -> unit 5, Robert Davis, Sarah Johnson
(173, 6, 4, 1),  -- Terraform: Robert Davis (IT) -> unit 5, David Thompson, Sarah Johnson
(174, 1, 6, 1),  -- Nagios: Sarah Johnson (IT) -> unit 5, Robert Davis, Sarah Johnson

-- Specialized Software (software_id 175-214)
(175, 91, 4, 1), -- LabArchives: Jane Goodall (Research) -> unit 29, David Thompson, Sarah Johnson
(176, 3, 6, 1),  -- Benchling: Emily Rodriguez (Biology) -> unit 2, Robert Davis, Sarah Johnson
(177, 11, 4, 1), -- Geneious: James Peterson (Biology) -> unit 2, David Thompson, Sarah Johnson
(178, 3, 6, 1),  -- FlowJo: Emily Rodriguez (Biology) -> unit 2, Robert Davis, Sarah Johnson
(179, 26, 4, 1), -- GraphPad InStat: Sigmund Freud (Psychology) -> unit 12, David Thompson, Sarah Johnson
(180, 16, 6, 1), -- Minitab: Warren Buffett (Business) -> unit 14, Robert Davis, Sarah Johnson
(181, 17, 4, 1), -- EViews: Peter Drucker (Business) -> unit 14, David Thompson, Sarah Johnson
(182, 28, 6, 1), -- Stata/MP: B.F. Skinner (Psychology) -> unit 12, Robert Davis, Sarah Johnson
(183, 29, 4, 1), -- MPlus: Jean Piaget (Psychology) -> unit 12, David Thompson, Sarah Johnson
(184, 30, 6, 1); -- Lisrel: Elizabeth Loftus (Psychology) -> unit 12, Robert Davis, Sarah Johnson

-- Operating System Compatibility for new software products
INSERT INTO software_operating_systems (software_id, os_id, minimum_version, notes) VALUES
-- Mathematica (software_id 15)
(15, 1, NULL, 'Windows 11 compatible'), (15, 2, NULL, 'Windows 10 supported'), 
(15, 3, NULL, 'macOS Sonoma'), (15, 5, NULL, 'Ubuntu Linux'),

-- Maple (software_id 16)
(16, 1, NULL, 'Windows 11'), (16, 3, NULL, 'macOS Sonoma'), (16, 5, NULL, 'Linux supported'),

-- Origin (software_id 17)
(17, 1, NULL, 'Windows 11'), (17, 2, NULL, 'Windows 10'),

-- GraphPad Prism (software_id 18)
(18, 1, NULL, 'Windows 11'), (18, 2, NULL, 'Windows 10'), (18, 3, NULL, 'macOS Sonoma'),

-- ImageJ (software_id 19)
(19, 8, NULL, 'Cross-platform Java application'),

-- ChemSketch (software_id 20)
(20, 1, NULL, 'Windows 11'), (20, 2, NULL, 'Windows 10'),

-- Gaussian (software_id 21)
(21, 5, NULL, 'Linux clusters'), (21, 2, NULL, 'Windows HPC'),

-- ANSYS (software_id 22)
(22, 1, NULL, 'Windows 11'), (22, 5, NULL, 'Linux workstations'),

-- SolidWorks (software_id 23)
(23, 1, NULL, 'Windows 11'), (23, 2, NULL, 'Windows 10'),

-- LabVIEW (software_id 24)
(24, 1, NULL, 'Windows 11'), (24, 3, NULL, 'macOS'), (24, 5, NULL, 'Linux RT'),

-- SAS (software_id 25)
(25, 1, NULL, 'Windows 11'), (25, 5, NULL, 'Linux'), (25, 4, NULL, 'Unix systems'),

-- Stata (software_id 26)
(26, 1, NULL, 'Windows 11'), (26, 3, NULL, 'macOS'), (26, 5, NULL, 'Linux'),

-- JMP (software_id 27)
(27, 1, NULL, 'Windows 11'), (27, 3, NULL, 'macOS'),

-- NVivo (software_id 28)
(28, 1, NULL, 'Windows 11'), (28, 3, NULL, 'macOS Sonoma'),

-- Atlas.ti (software_id 29)
(29, 1, NULL, 'Windows 11'), (29, 3, NULL, 'macOS'),

-- MaxQDA (software_id 30)
(30, 1, NULL, 'Windows 11'), (30, 3, NULL, 'macOS'),

-- Qualtrics (software_id 31)
(31, 8, NULL, 'Web-based platform'),

-- REDCap (software_id 32)
(32, 8, NULL, 'Web-based research platform'),

-- Mendeley (software_id 33)
(33, 8, NULL, 'Cross-platform with web sync'),

-- EndNote (software_id 34)
(34, 1, NULL, 'Windows 11'), (34, 3, NULL, 'macOS'),

-- IntelliJ IDEA (software_id 35)
(35, 8, NULL, 'Cross-platform Java IDE'),

-- PyCharm (software_id 36)
(36, 8, NULL, 'Cross-platform Python IDE'),

-- Visual Studio (software_id 37)
(37, 1, NULL, 'Windows 11'), (37, 3, NULL, 'macOS version available'),

-- Eclipse (software_id 38)
(38, 8, NULL, 'Cross-platform Java-based IDE'),

-- NetBeans (software_id 39)
(39, 8, NULL, 'Cross-platform IDE'),

-- RStudio (software_id 40)
(40, 1, NULL, 'Windows 11'), (40, 3, NULL, 'macOS'), (40, 5, NULL, 'Linux'),

-- Jupyter Notebook (software_id 41)
(41, 8, NULL, 'Web-based cross-platform'),

-- Docker (software_id 42)
(42, 1, NULL, 'Windows 11 with WSL2'), (42, 3, NULL, 'macOS'), (42, 5, NULL, 'Linux native'),

-- Git (software_id 43)
(43, 8, NULL, 'Cross-platform version control'),

-- GitHub Desktop (software_id 44)
(44, 1, NULL, 'Windows 11'), (44, 3, NULL, 'macOS'),

-- Design Software - most require Windows or macOS
-- Photoshop through 3ds Max (software_id 45-54)
(45, 1, NULL, 'Windows 11'), (45, 3, NULL, 'macOS Sonoma'),
(46, 1, NULL, 'Windows 11'), (46, 3, NULL, 'macOS Sonoma'),
(47, 1, NULL, 'Windows 11'), (47, 3, NULL, 'macOS Sonoma'),
(48, 1, NULL, 'Windows 11'), (48, 3, NULL, 'macOS Sonoma'),
(49, 1, NULL, 'Windows 11'), (49, 3, NULL, 'macOS Sonoma'),
(50, 3, NULL, 'macOS exclusive'),
(51, 8, NULL, 'Cross-platform 3D suite'),
(52, 1, NULL, 'Windows 11'), (52, 3, NULL, 'macOS'),
(53, 1, NULL, 'Windows 11'), (53, 5, NULL, 'Linux'),
(54, 1, NULL, 'Windows 11'),

-- Business Software - mostly cross-platform or cloud-based
-- QuickBooks through Canva (software_id 55-64)
(55, 1, NULL, 'Windows 11'), (55, 3, NULL, 'macOS'),
(56, 8, NULL, 'Enterprise web-based'),
(57, 8, NULL, 'Enterprise database system'),
(58, 8, NULL, 'Enterprise web application'),
(59, 8, NULL, 'Cloud-based SaaS'),
(60, 8, NULL, 'Cloud CRM platform'),
(61, 8, NULL, 'Web-based marketing platform'),
(62, 8, NULL, 'Cloud email marketing'),
(63, 8, NULL, 'Cloud social media management'),
(64, 8, NULL, 'Web-based design platform'),

-- Specialized Academic Software (software_id 65-74)
(65, 1, NULL, 'Windows 11'), (65, 3, NULL, 'macOS'), (65, 5, NULL, 'Linux'),
(66, 8, NULL, 'Cross-platform open source'),
(67, 1, NULL, 'Windows 11'), (67, 3, NULL, 'macOS'),
(68, 1, NULL, 'Windows 11'), (68, 3, NULL, 'macOS'),
(69, 1, NULL, 'Windows 11'), (69, 3, NULL, 'macOS'),
(70, 3, NULL, 'macOS exclusive'),
(71, 1, NULL, 'Windows 11'), (71, 3, NULL, 'macOS'),
(72, 8, NULL, 'Cross-platform Python-based'),
(73, 1, NULL, 'Windows experimental software'),
(74, 8, NULL, 'Cross-platform experiment builder'),

-- Medical and Health Software (software_id 75-84) - mostly web-based enterprise
(75, 8, NULL, 'Web-based EHR system'),
(76, 8, NULL, 'Healthcare IT platform'),
(77, 8, NULL, 'Web-based healthcare system'),
(78, 8, NULL, 'Cloud-based healthcare'),
(79, 8, NULL, 'Healthcare practice management'),
(80, 8, NULL, 'Mobile-first EHR'),
(81, 8, NULL, 'Web-based EHR'),
(82, 8, NULL, 'Cloud healthcare platform'),
(83, 8, NULL, 'Healthcare information system'),
(84, 8, NULL, 'Government healthcare system'),

-- Library Software (software_id 85-94) - web-based
(85, 8, NULL, 'Cloud library platform'),
(86, 8, NULL, 'Integrated library system'),
(87, 8, NULL, 'Web-based global catalog'),
(88, 8, NULL, 'Web-based CMS for libraries'),
(89, 8, NULL, 'Cross-platform repository'),
(90, 8, NULL, 'Java-based repository'),
(91, 8, NULL, 'Ruby-based repository framework'),
(92, 8, NULL, 'Distributed preservation system'),
(93, 8, NULL, 'Cross-platform reference tool'),
(94, 8, NULL, 'Web-based reference management'),

-- Engineering Software (software_id 95-104)
(95, 1, NULL, 'Windows 11'), (95, 5, NULL, 'Linux workstations'),
(96, 1, NULL, 'Windows 11'), (96, 5, NULL, 'Linux'),
(97, 1, NULL, 'Windows 11'),
(98, 1, NULL, 'Windows 11'),
(99, 1, NULL, 'Windows 11'), (99, 3, NULL, 'macOS'),
(100, 1, NULL, 'Windows 11'),
(101, 1, NULL, 'Windows 11'), (101, 3, NULL, 'macOS'),
(102, 1, NULL, 'Windows 11'), (102, 3, NULL, 'macOS'),
(103, 1, NULL, 'Windows 11'), (103, 3, NULL, 'macOS'), (103, 5, NULL, 'Linux'),
(104, 1, NULL, 'Windows 11'), (104, 3, NULL, 'macOS'),

-- Scientific Software (software_id 105-114)
(105, 1, NULL, 'Windows 11'), (105, 3, NULL, 'macOS'),
(106, 8, NULL, 'Web-based chemical database'),
(107, 8, NULL, 'Web-based chemical search'),
(108, 1, NULL, 'Windows HPC'), (108, 5, NULL, 'Linux clusters'),
(109, 5, NULL, 'Linux supercomputing'),
(110, 5, NULL, 'Linux molecular dynamics'),
(111, 8, NULL, 'Cross-platform visualization'),
(112, 1, NULL, 'Windows 11'), (112, 3, NULL, 'macOS'), (112, 5, NULL, 'Linux'),
(113, 5, NULL, 'Linux molecular dynamics'),
(114, 5, NULL, 'Linux biomolecular simulation'),

-- Data Science Software (software_id 115-124)
(115, 1, NULL, 'Windows 11'), (115, 3, NULL, 'macOS'), (115, 5, NULL, 'Linux'),
(116, 1, NULL, 'Windows 11'), (116, 3, NULL, 'macOS'),
(117, 1, NULL, 'Windows 11'), (117, 3, NULL, 'macOS'),
(118, 1, NULL, 'Windows 11'), (118, 3, NULL, 'macOS'), (118, 5, NULL, 'Linux'),
(119, 1, NULL, 'Windows 11'), (119, 3, NULL, 'macOS'),
(120, 8, NULL, 'Cloud-based ML platform'),
(121, 8, NULL, 'Cross-platform ML'),
(122, 8, NULL, 'Java-based cross-platform'),
(123, 8, NULL, 'Cross-platform data mining'),
(124, 8, NULL, 'Cross-platform analytics'),

-- Productivity Software (software_id 125-134) - mostly cloud-based
(125, 8, NULL, 'Cloud collaboration platform'),
(126, 8, NULL, 'Cross-platform collaboration'),
(127, 8, NULL, 'Cross-platform video conferencing'),
(128, 8, NULL, 'Cross-platform web conferencing'),
(129, 8, NULL, 'Cloud productivity suite'),
(130, 8, NULL, 'Cloud file storage'),
(131, 8, NULL, 'Cloud content management'),
(132, 8, NULL, 'Cloud storage service'),
(133, 8, NULL, 'Web-based collaboration'),
(134, 8, NULL, 'Web-based team collaboration'),

-- Security Software (software_id 135-144)
(135, 1, NULL, 'Windows endpoint protection'), (135, 3, NULL, 'macOS support'), (135, 5, NULL, 'Linux support'),
(136, 1, NULL, 'Windows enterprise security'), (136, 3, NULL, 'macOS support'),
(137, 1, NULL, 'Windows security management'),
(138, 1, NULL, 'Windows data analytics'), (138, 5, NULL, 'Linux enterprise'),
(139, 8, NULL, 'Cross-platform network analyzer'),
(140, 1, NULL, 'Windows vulnerability scanner'), (140, 5, NULL, 'Linux scanning'),
(141, 8, NULL, 'Cross-platform network discovery'),
(142, 1, NULL, 'Windows penetration testing'), (142, 5, NULL, 'Linux pen testing'),
(143, 1, NULL, 'Windows web security testing'), (143, 3, NULL, 'macOS support'), (143, 5, NULL, 'Linux support'),
(144, 8, NULL, 'Cross-platform web security scanner'),

-- Database Software (software_id 145-154)
(145, 1, NULL, 'Windows enterprise'), (145, 5, NULL, 'Linux enterprise'), (145, 4, NULL, 'Unix systems'),
(146, 1, NULL, 'Windows SQL Server'),
(147, 8, NULL, 'Cross-platform open source database'),
(148, 8, NULL, 'Cross-platform NoSQL database'),
(149, 8, NULL, 'Cross-platform in-memory store'),
(150, 8, NULL, 'Cross-platform search engine'),
(151, 8, NULL, 'Cross-platform graph database'),
(152, 8, NULL, 'Cross-platform distributed database'),
(153, 8, NULL, 'Cross-platform time series database'),
(154, 1, NULL, 'Windows enterprise analytics'), (154, 5, NULL, 'Linux server'),

-- Web Development Software (software_id 155-164) - web-based or cross-platform
(155, 8, NULL, 'Cross-platform CMS'),
(156, 8, NULL, 'Cross-platform CMS framework'),
(157, 8, NULL, 'Cross-platform CMS'),
(158, 8, NULL, 'Cross-platform e-commerce'),
(159, 8, NULL, 'Cloud e-commerce platform'),
(160, 8, NULL, 'Cross-platform e-commerce plugin'),
(161, 8, NULL, 'Cloud website builder'),
(162, 8, NULL, 'Cloud web development platform'),
(163, 8, NULL, 'Cloud visual web design'),
(164, 8, NULL, 'Cross-platform publishing platform'),

-- Network and Infrastructure (software_id 165-174)
(165, 1, NULL, 'Windows virtualization'), (165, 5, NULL, 'Linux vCenter'),
(166, 1, NULL, 'Windows Hyper-V'),
(167, 1, NULL, 'Windows app virtualization'),
(168, 8, NULL, 'Cross-platform container orchestration'),
(169, 5, NULL, 'Enterprise Kubernetes on Linux'),
(170, 8, NULL, 'Cross-platform automation'),
(171, 8, NULL, 'Cross-platform configuration management'),
(172, 8, NULL, 'Cross-platform infrastructure automation'),
(173, 8, NULL, 'Cross-platform infrastructure as code'),
(174, 8, NULL, 'Cross-platform network monitoring'),

-- Specialized Software (software_id 175-184)
(175, 8, NULL, 'Cloud-based electronic lab notebook'),
(176, 8, NULL, 'Cloud life sciences platform'),
(177, 1, NULL, 'Windows molecular biology'), (177, 3, NULL, 'macOS support'), (177, 5, NULL, 'Linux support'),
(178, 1, NULL, 'Windows flow cytometry'), (178, 3, NULL, 'macOS support'),
(179, 1, NULL, 'Windows statistical analysis'),
(180, 1, NULL, 'Windows statistical software'),
(181, 1, NULL, 'Windows econometric software'),
(182, 1, NULL, 'Windows multiprocessor statistics'), (182, 3, NULL, 'macOS support'), (182, 5, NULL, 'Linux support'),
(183, 1, NULL, 'Windows statistical modeling'),
(184, 1, NULL, 'Windows structural equation modeling');