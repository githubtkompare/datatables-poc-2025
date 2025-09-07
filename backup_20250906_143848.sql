-- MySQL dump 10.13  Distrib 8.0.43, for Linux (aarch64)
--
-- Host: localhost    Database: datatables_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_id` int NOT NULL,
  `action` enum('INSERT','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_values` json DEFAULT NULL,
  `new_values` json DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_table_record` (`table_name`,`record_id`),
  KEY `idx_action` (`action`),
  KEY `idx_changed_at` (`changed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_name` (`last_name`,`first_name`),
  KEY `idx_department` (`department`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Sarah','Johnson','sarah.johnson@university.edu','555-0101','IT Services','IT Director','2025-09-06 03:08:46','2025-09-06 03:08:46'),(2,'Michael','Chen','michael.chen@university.edu','555-0102','Computer Science','Professor','2025-09-06 03:08:46','2025-09-06 03:08:46'),(3,'Emily','Rodriguez','emily.rodriguez@university.edu','555-0103','Biology','Associate Professor','2025-09-06 03:08:46','2025-09-06 03:08:46'),(4,'David','Thompson','david.thompson@university.edu','555-0104','IT Services','Systems Administrator','2025-09-06 03:08:46','2025-09-06 03:08:46'),(5,'Jessica','Williams','jessica.williams@university.edu','555-0105','Mathematics','Department Chair','2025-09-06 03:08:46','2025-09-06 03:08:46'),(6,'Robert','Davis','robert.davis@university.edu','555-0106','IT Services','Database Administrator','2025-09-06 03:08:46','2025-09-06 03:08:46'),(7,'Amanda','Miller','amanda.miller@university.edu','555-0107','Human Resources','HR Manager','2025-09-06 03:08:46','2025-09-06 03:08:46'),(8,'Christopher','Wilson','christopher.wilson@university.edu','555-0108','Finance','Finance Director','2025-09-06 03:08:46','2025-09-06 03:08:46'),(9,'Liza','Anderson','lisa.anderson@university.edu','555-0109','Research Computing','Research Computing Manager','2025-09-06 03:08:46','2025-09-06 17:19:30'),(10,'Kevin','Taylor','kevin.taylor@university.edu','555-0110','Chemistry','Lab Manager','2025-09-06 03:08:46','2025-09-06 03:08:46');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operating_systems`
--

DROP TABLE IF EXISTS `operating_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operating_systems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `os_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `os_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os_family` enum('Windows','macOS','Linux','Unix','Other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `os_name` (`os_name`),
  KEY `idx_os_name` (`os_name`),
  KEY `idx_os_family` (`os_family`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operating_systems`
--

LOCK TABLES `operating_systems` WRITE;
/*!40000 ALTER TABLE `operating_systems` DISABLE KEYS */;
INSERT INTO `operating_systems` VALUES (1,'Windows 11','11','Windows','2025-09-06 03:08:46'),(2,'Windows 10','10','Windows','2025-09-06 03:08:46'),(3,'macOS Sonoma','14.0','macOS','2025-09-06 03:08:46'),(4,'macOS Ventura','13.0','macOS','2025-09-06 03:08:46'),(5,'Ubuntu Linux','22.04 LTS','Linux','2025-09-06 03:08:46'),(6,'CentOS Linux','8','Linux','2025-09-06 03:08:46'),(7,'Red Hat Enterprise Linux','9','Linux','2025-09-06 03:08:46'),(8,'Cross-Platform','N/A','Other','2025-09-06 03:08:46');
/*!40000 ALTER TABLE `operating_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_operating_systems`
--

DROP TABLE IF EXISTS `software_operating_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software_operating_systems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_id` int NOT NULL,
  `os_id` int NOT NULL,
  `minimum_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_software_os` (`software_id`,`os_id`),
  KEY `os_id` (`os_id`),
  CONSTRAINT `software_operating_systems_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `software_operating_systems_ibfk_2` FOREIGN KEY (`os_id`) REFERENCES `operating_systems` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_operating_systems`
--

LOCK TABLES `software_operating_systems` WRITE;
/*!40000 ALTER TABLE `software_operating_systems` DISABLE KEYS */;
INSERT INTO `software_operating_systems` VALUES (5,2,1,NULL,NULL,'2025-09-06 03:08:46'),(6,2,2,NULL,NULL,'2025-09-06 03:08:46'),(7,2,3,NULL,NULL,'2025-09-06 03:08:46'),(8,2,4,NULL,NULL,'2025-09-06 03:08:46'),(9,2,5,NULL,NULL,'2025-09-06 03:08:46'),(10,3,1,NULL,NULL,'2025-09-06 03:08:46'),(11,3,2,NULL,NULL,'2025-09-06 03:08:46'),(12,3,3,NULL,NULL,'2025-09-06 03:08:46'),(13,3,4,NULL,NULL,'2025-09-06 03:08:46'),(14,4,1,NULL,NULL,'2025-09-06 03:08:46'),(15,4,2,NULL,NULL,'2025-09-06 03:08:46'),(16,4,3,NULL,NULL,'2025-09-06 03:08:46'),(17,4,4,NULL,NULL,'2025-09-06 03:08:46'),(18,5,1,NULL,NULL,'2025-09-06 03:08:46'),(19,5,2,NULL,NULL,'2025-09-06 03:08:46'),(20,6,8,NULL,NULL,'2025-09-06 03:08:46'),(21,7,1,NULL,NULL,'2025-09-06 03:08:46'),(22,7,2,NULL,NULL,'2025-09-06 03:08:46'),(23,7,3,NULL,NULL,'2025-09-06 03:08:46'),(24,7,4,NULL,NULL,'2025-09-06 03:08:46'),(25,8,1,NULL,NULL,'2025-09-06 03:08:46'),(26,8,2,NULL,NULL,'2025-09-06 03:08:46'),(27,8,3,NULL,NULL,'2025-09-06 03:08:46'),(28,8,4,NULL,NULL,'2025-09-06 03:08:46'),(29,8,5,NULL,NULL,'2025-09-06 03:08:46'),(30,8,6,NULL,NULL,'2025-09-06 03:08:46'),(31,8,7,NULL,NULL,'2025-09-06 03:08:46'),(32,9,1,NULL,NULL,'2025-09-06 03:08:46'),(33,9,2,NULL,NULL,'2025-09-06 03:08:46'),(34,9,3,NULL,NULL,'2025-09-06 03:08:46'),(35,9,4,NULL,NULL,'2025-09-06 03:08:46'),(36,9,5,NULL,NULL,'2025-09-06 03:08:46'),(37,9,6,NULL,NULL,'2025-09-06 03:08:46'),(38,9,7,NULL,NULL,'2025-09-06 03:08:46'),(39,10,8,NULL,NULL,'2025-09-06 03:08:46');
/*!40000 ALTER TABLE `software_operating_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_products`
--

DROP TABLE IF EXISTS `software_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `vendor_managed` tinyint(1) DEFAULT '0',
  `vendor_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installation_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_software_name` (`software_name`),
  KEY `idx_vendor_managed` (`vendor_managed`),
  KEY `idx_vendor_name` (`vendor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_products`
--

LOCK TABLES `software_products` WRITE;
/*!40000 ALTER TABLE `software_products` DISABLE KEYS */;
INSERT INTO `software_products` VALUES (2,'MATLAB','R2023b','Technical computing platform for engineering and scientific applications',1,'MathWorks','Campus License',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(3,'Microsoft Office 365','2023','Productivity suite including Word, Excel, PowerPoint, and Teams',1,'Microsoft','Enterprise Agreement',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(4,'Adobe Creative Suite','2023','Creative design and multimedia software suite',1,'Adobe','Education License',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(5,'AutoCAD','2024','Computer-aided design software for engineering and architecture',1,'Autodesk','Educational License',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(6,'Banner ERP','9.4','Enterprise resource planning system for student information and finance',1,'Ellucian','Perpetual License',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(7,'ChemDraw','22.0','Chemical drawing and molecular modeling software',1,'PerkinElmer','Departmental License',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(8,'R Statistical Software','4.3.0','Open source statistical computing and graphics software',0,NULL,'Open Source',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(9,'Python','3.11','Programming language and development environment',0,NULL,'Open Source',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(10,'Blackboard Learn','9.1','Learning management system for online courses and content delivery',1,'Anthology','Institutional License',NULL,'2025-09-06 03:08:46','2025-09-06 03:08:46');
/*!40000 ALTER TABLE `software_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_roles`
--

DROP TABLE IF EXISTS `software_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_id` int NOT NULL,
  `business_owner_id` int DEFAULT NULL,
  `technical_owner_id` int DEFAULT NULL,
  `technical_manager_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_software_roles` (`software_id`),
  KEY `business_owner_id` (`business_owner_id`),
  KEY `technical_owner_id` (`technical_owner_id`),
  KEY `technical_manager_id` (`technical_manager_id`),
  CONSTRAINT `software_roles_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `software_roles_ibfk_2` FOREIGN KEY (`business_owner_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL,
  CONSTRAINT `software_roles_ibfk_3` FOREIGN KEY (`technical_owner_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL,
  CONSTRAINT `software_roles_ibfk_4` FOREIGN KEY (`technical_manager_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_roles`
--

LOCK TABLES `software_roles` WRITE;
/*!40000 ALTER TABLE `software_roles` DISABLE KEYS */;
INSERT INTO `software_roles` VALUES (2,2,2,9,9,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(3,3,7,1,4,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(4,4,2,2,2,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(5,5,2,4,1,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(6,6,8,6,1,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(7,7,10,4,1,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(8,8,5,2,9,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(9,9,2,2,4,'2025-09-06 03:08:46','2025-09-06 03:08:46'),(10,10,7,1,9,'2025-09-06 03:08:46','2025-09-06 03:08:46');
/*!40000 ALTER TABLE `software_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_unit_assignments`
--

DROP TABLE IF EXISTS `software_unit_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software_unit_assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `assignment_date` date DEFAULT (curdate()),
  `status` enum('active','inactive','pending','retired') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_software_unit` (`software_id`,`unit_id`),
  KEY `unit_id` (`unit_id`),
  KEY `idx_status` (`status`),
  KEY `idx_assignment_date` (`assignment_date`),
  CONSTRAINT `software_unit_assignments_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `software_unit_assignments_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `university_units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_unit_assignments`
--

LOCK TABLES `software_unit_assignments` WRITE;
/*!40000 ALTER TABLE `software_unit_assignments` DISABLE KEYS */;
INSERT INTO `software_unit_assignments` VALUES (5,2,1,'2025-09-06','active','Computational programming courses','2025-09-06 03:08:46','2025-09-06 03:08:46'),(6,2,3,'2025-09-06','active','Numerical analysis and modeling','2025-09-06 03:08:46','2025-09-06 03:08:46'),(7,2,4,'2025-09-06','active','Chemical engineering applications','2025-09-06 03:08:46','2025-09-06 03:08:46'),(8,2,10,'2025-09-06','active','High performance computing integration','2025-09-06 03:08:46','2025-09-06 03:08:46'),(9,3,1,'2025-09-06','active','Department communications and documentation','2025-09-06 03:08:46','2025-09-06 03:08:46'),(10,3,2,'2025-09-06','active','Research documentation and presentations','2025-09-06 03:08:46','2025-09-06 03:08:46'),(11,3,5,'2025-09-06','active','Administrative operations','2025-09-06 03:08:46','2025-09-06 03:08:46'),(12,3,6,'2025-09-06','active','HR documentation and communications','2025-09-06 03:08:46','2025-09-06 03:08:46'),(13,3,7,'2025-09-06','active','Financial reporting and analysis','2025-09-06 03:08:46','2025-09-06 03:08:46'),(14,3,8,'2025-09-06','active','Library operations and communications','2025-09-06 03:08:46','2025-09-06 03:08:46'),(15,3,9,'2025-09-06','active','Student services documentation','2025-09-06 03:08:46','2025-09-06 03:08:46'),(16,4,1,'2025-09-06','active','Web development and digital media courses','2025-09-06 03:08:46','2025-09-06 03:08:46'),(17,4,8,'2025-09-06','active','Library digital collections and marketing','2025-09-06 03:08:46','2025-09-06 03:08:46'),(18,4,9,'2025-09-06','active','Student services marketing materials','2025-09-06 03:08:46','2025-09-06 03:08:46'),(19,5,1,'2025-09-06','active','Engineering design courses','2025-09-06 03:08:46','2025-09-06 03:08:46'),(20,5,10,'2025-09-06','active','Research facility planning','2025-09-06 03:08:46','2025-09-06 03:08:46'),(21,6,5,'2025-09-06','active','IT system administration','2025-09-06 03:08:46','2025-09-06 03:08:46'),(22,6,6,'2025-09-06','active','Human resources management','2025-09-06 03:08:46','2025-09-06 03:08:46'),(23,6,7,'2025-09-06','active','Financial operations','2025-09-06 03:08:46','2025-09-06 03:08:46'),(24,6,9,'2025-09-06','active','Student information management','2025-09-06 03:08:46','2025-09-06 03:08:46'),(25,7,4,'2025-09-06','active','Chemical structure drawing and analysis','2025-09-06 03:08:46','2025-09-06 03:08:46'),(26,7,2,'2025-09-06','active','Biochemistry applications','2025-09-06 03:08:46','2025-09-06 03:08:46'),(27,8,2,'2025-09-06','active','Biological data analysis','2025-09-06 03:08:46','2025-09-06 03:08:46'),(28,8,3,'2025-09-06','active','Statistical modeling and analysis','2025-09-06 03:08:46','2025-09-06 03:08:46'),(29,8,4,'2025-09-06','active','Chemical data analysis','2025-09-06 03:08:46','2025-09-06 03:08:46'),(30,8,10,'2025-09-06','active','Research computing support','2025-09-06 03:08:46','2025-09-06 03:08:46'),(31,9,1,'2025-09-06','active','Programming courses and research','2025-09-06 03:08:46','2025-09-06 03:08:46'),(32,9,2,'2025-09-06','active','Bioinformatics applications','2025-09-06 03:08:46','2025-09-06 03:08:46'),(33,9,3,'2025-09-06','active','Mathematical modeling','2025-09-06 03:08:46','2025-09-06 03:08:46'),(34,9,5,'2025-09-06','active','IT automation and scripting','2025-09-06 03:08:46','2025-09-06 03:08:46'),(35,9,10,'2025-09-06','active','Research computing development','2025-09-06 03:08:46','2025-09-06 03:08:46'),(36,10,1,'2025-09-06','active','Computer science course delivery','2025-09-06 03:08:46','2025-09-06 03:08:46'),(37,10,2,'2025-09-06','active','Biology course management','2025-09-06 03:08:46','2025-09-06 03:08:46'),(38,10,3,'2025-09-06','active','Mathematics course delivery','2025-09-06 03:08:46','2025-09-06 03:08:46'),(39,10,4,'2025-09-06','active','Chemistry laboratory management','2025-09-06 03:08:46','2025-09-06 03:08:46'),(40,10,8,'2025-09-06','active','Library instruction and tutorials','2025-09-06 03:08:46','2025-09-06 03:08:46'),(41,10,9,'2025-09-06','active','Student orientation and resources','2025-09-06 03:08:46','2025-09-06 03:08:46');
/*!40000 ALTER TABLE `software_unit_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university_units`
--

DROP TABLE IF EXISTS `university_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `university_units` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `parent_unit_id` int DEFAULT NULL,
  `unit_type` enum('department','college','administrative','support','research') COLLATE utf8mb4_unicode_ci DEFAULT 'department',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unit_code` (`unit_code`),
  KEY `parent_unit_id` (`parent_unit_id`),
  KEY `idx_unit_name` (`unit_name`),
  KEY `idx_unit_code` (`unit_code`),
  KEY `idx_unit_type` (`unit_type`),
  CONSTRAINT `university_units_ibfk_1` FOREIGN KEY (`parent_unit_id`) REFERENCES `university_units` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university_units`
--

LOCK TABLES `university_units` WRITE;
/*!40000 ALTER TABLE `university_units` DISABLE KEYS */;
INSERT INTO `university_units` VALUES (1,'Computerz Science Department','CS','Department of Computer Science and Software Engineering',NULL,'department','2025-09-06 03:08:46','2025-09-06 17:33:47'),(2,'Biology Department','BIOL','Department of Biological Sciences',NULL,'department','2025-09-06 03:08:46','2025-09-06 03:08:46'),(3,'Mathematics Department','MATH','Department of Mathematics and Statistics',NULL,'department','2025-09-06 03:08:46','2025-09-06 03:08:46'),(4,'Chemistry Department','CHEM','Department of Chemistry and Biochemistry',NULL,'department','2025-09-06 03:08:46','2025-09-06 03:08:46'),(5,'IT Services','ITS','Information Technology Services Division',NULL,'administrative','2025-09-06 03:08:46','2025-09-06 03:08:46'),(6,'Human Resources','HR','Human Resources Department',NULL,'administrative','2025-09-06 03:08:46','2025-09-06 03:08:46'),(7,'Finance Department','FIN','Financial Services and Administration',NULL,'administrative','2025-09-06 03:08:46','2025-09-06 03:08:46'),(8,'University Library','LIB','Main University Library System',NULL,'support','2025-09-06 03:08:46','2025-09-06 03:08:46'),(9,'Student Services','SS','Student Affairs and Support Services',NULL,'support','2025-09-06 03:08:46','2025-09-06 03:08:46'),(10,'Research Computing','RC','High Performance Computing and Research Support',NULL,'research','2025-09-06 03:08:46','2025-09-06 03:08:46');
/*!40000 ALTER TABLE `university_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_employee_roles`
--

DROP TABLE IF EXISTS `v_employee_roles`;
/*!50001 DROP VIEW IF EXISTS `v_employee_roles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_employee_roles` AS SELECT 
 1 AS `id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `department`,
 1 AS `business_owner_count`,
 1 AS `technical_owner_count`,
 1 AS `technical_manager_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_software_with_roles`
--

DROP TABLE IF EXISTS `v_software_with_roles`;
/*!50001 DROP VIEW IF EXISTS `v_software_with_roles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_software_with_roles` AS SELECT 
 1 AS `id`,
 1 AS `software_name`,
 1 AS `version`,
 1 AS `vendor_managed`,
 1 AS `vendor_name`,
 1 AS `business_owner`,
 1 AS `business_owner_email`,
 1 AS `technical_owner`,
 1 AS `technical_owner_email`,
 1 AS `technical_manager`,
 1 AS `technical_manager_email`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_unit_software_summary`
--

DROP TABLE IF EXISTS `v_unit_software_summary`;
/*!50001 DROP VIEW IF EXISTS `v_unit_software_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_unit_software_summary` AS SELECT 
 1 AS `id`,
 1 AS `unit_name`,
 1 AS `unit_code`,
 1 AS `unit_type`,
 1 AS `software_count`,
 1 AS `active_software_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_employee_roles`
--

/*!50001 DROP VIEW IF EXISTS `v_employee_roles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_employee_roles` AS select `e`.`id` AS `id`,`e`.`first_name` AS `first_name`,`e`.`last_name` AS `last_name`,`e`.`email` AS `email`,`e`.`department` AS `department`,count(distinct (case when (`sr`.`business_owner_id` = `e`.`id`) then `sr`.`software_id` end)) AS `business_owner_count`,count(distinct (case when (`sr`.`technical_owner_id` = `e`.`id`) then `sr`.`software_id` end)) AS `technical_owner_count`,count(distinct (case when (`sr`.`technical_manager_id` = `e`.`id`) then `sr`.`software_id` end)) AS `technical_manager_count` from (`employees` `e` left join `software_roles` `sr` on(((`e`.`id` = `sr`.`business_owner_id`) or (`e`.`id` = `sr`.`technical_owner_id`) or (`e`.`id` = `sr`.`technical_manager_id`)))) group by `e`.`id`,`e`.`first_name`,`e`.`last_name`,`e`.`email`,`e`.`department` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_software_with_roles`
--

/*!50001 DROP VIEW IF EXISTS `v_software_with_roles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_software_with_roles` AS select `sp`.`id` AS `id`,`sp`.`software_name` AS `software_name`,`sp`.`version` AS `version`,`sp`.`vendor_managed` AS `vendor_managed`,`sp`.`vendor_name` AS `vendor_name`,concat(`bo`.`first_name`,' ',`bo`.`last_name`) AS `business_owner`,`bo`.`email` AS `business_owner_email`,concat(`to_emp`.`first_name`,' ',`to_emp`.`last_name`) AS `technical_owner`,`to_emp`.`email` AS `technical_owner_email`,concat(`tm`.`first_name`,' ',`tm`.`last_name`) AS `technical_manager`,`tm`.`email` AS `technical_manager_email` from ((((`software_products` `sp` left join `software_roles` `sr` on((`sp`.`id` = `sr`.`software_id`))) left join `employees` `bo` on((`sr`.`business_owner_id` = `bo`.`id`))) left join `employees` `to_emp` on((`sr`.`technical_owner_id` = `to_emp`.`id`))) left join `employees` `tm` on((`sr`.`technical_manager_id` = `tm`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_unit_software_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_unit_software_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_unit_software_summary` AS select `u`.`id` AS `id`,`u`.`unit_name` AS `unit_name`,`u`.`unit_code` AS `unit_code`,`u`.`unit_type` AS `unit_type`,count(`sua`.`software_id`) AS `software_count`,count((case when (`sua`.`status` = 'active') then 1 end)) AS `active_software_count` from (`university_units` `u` left join `software_unit_assignments` `sua` on((`u`.`id` = `sua`.`unit_id`))) group by `u`.`id`,`u`.`unit_name`,`u`.`unit_code`,`u`.`unit_type` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-06 19:38:48
