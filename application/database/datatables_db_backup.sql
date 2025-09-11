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
  `university_unit_id` int DEFAULT NULL,
  `job_title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_name` (`last_name`,`first_name`),
  KEY `idx_university_unit_id` (`university_unit_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`university_unit_id`) REFERENCES `university_units` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Sarah','Johnson','sarah.johnson@university.edu','555-0101',5,'IT Director','2025-09-06 19:41:49','2025-09-06 21:02:49'),(2,'Michael','Chen','michael.chen@university.edu','555-0102',1,'Professor','2025-09-06 19:41:49','2025-09-06 21:02:49'),(3,'Emily','Rodriguez','emily.rodriguez@university.edu','555-0103',2,'Associate Professor','2025-09-06 19:41:49','2025-09-06 21:02:49'),(4,'David','Thompson','david.thompson@university.edu','555-0104',5,'Systems Administrator','2025-09-06 19:41:49','2025-09-06 21:02:49'),(5,'Jessica','Williams','jessica.williams@university.edu','555-0105',3,'Department Chair','2025-09-06 19:41:49','2025-09-06 21:02:49'),(6,'Robert','Davis','robert.davis@university.edu','555-0106',5,'Database Administrator','2025-09-06 19:41:49','2025-09-06 21:02:49'),(7,'Amanda','Miller','amanda.miller@university.edu','555-0107',6,'HR Manager','2025-09-06 19:41:49','2025-09-07 00:08:50'),(8,'Christopher','Wilson','christopher.wilson@university.edu','555-0108',7,'Finance Director','2025-09-06 19:41:49','2025-09-11 22:44:05'),(9,'Lisa','Anderson','lisa.anderson@university.edu','555-0109',10,'Research Computing Manager','2025-09-06 19:41:49','2025-09-06 21:02:10'),(10,'Kevin','Taylor','kevin.taylor@university.edu','555-0110',4,'Lab Manager','2025-09-06 19:41:49','2025-09-07 00:08:50'),(11,'Dr. James','Peterson','james.peterson@university.edu','555-0111',2,'Professor','2025-09-06 19:41:49','2025-09-06 21:02:49'),(12,'Maria','Garcia','maria.garcia@university.edu','555-0112',1,'Associate Professor','2025-09-06 19:41:49','2025-09-06 21:02:49'),(13,'John','Smith','john.smith@university.edu','555-0113',3,'Professor','2025-09-06 19:41:49','2025-09-06 21:02:49'),(14,'Anna','Brown','anna.brown@university.edu','555-0114',2,'Research Coordinator','2025-09-06 19:41:49','2025-09-06 21:41:43'),(15,'Tom','Lee','tom.lee@university.edu','555-0115',8,'Systems Librarian','2025-09-06 19:41:49','2025-09-07 00:08:50'),(16,'Albert','Einstein','albert.einstein@university.edu','555-1001',11,'Professor of Physics','2025-09-11 22:35:59','2025-09-11 22:35:59'),(17,'Marie','Curie','marie.curie@university.edu','555-1002',11,'Research Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(18,'Neil','Tyson','neil.tyson@university.edu','555-1003',11,'Department Chair','2025-09-11 22:35:59','2025-09-11 22:35:59'),(19,'Stephen','Hawking','stephen.hawking@university.edu','555-1004',11,'Distinguished Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(20,'Lisa','Randall','lisa.randall@university.edu','555-1005',11,'Associate Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(21,'Sigmund','Freud','sigmund.freud@university.edu','555-1006',12,'Professor Emeritus','2025-09-11 22:35:59','2025-09-11 22:35:59'),(22,'Carl','Jung','carl.jung@university.edu','555-1007',12,'Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(23,'B.F.','Skinner','bf.skinner@university.edu','555-1008',12,'Research Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(24,'Jean','Piaget','jean.piaget@university.edu','555-1009',12,'Child Development Specialist','2025-09-11 22:35:59','2025-09-11 22:35:59'),(25,'Elizabeth','Loftus','elizabeth.loftus@university.edu','555-1010',12,'Memory Research Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(26,'Nikola','Tesla','nikola.tesla@university.edu','555-1011',13,'Professor of Electrical Engineering','2025-09-11 22:35:59','2025-09-11 22:35:59'),(27,'Ada','Lovelace','ada.lovelace@university.edu','555-1012',13,'Computer Engineering Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(28,'Grace','Hopper','grace.hopper@university.edu','555-1013',13,'Software Engineering Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(29,'Hedy','Lamarr','hedy.lamarr@university.edu','555-1014',13,'Communications Engineering Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(30,'Katherine','Johnson','katherine.johnson@university.edu','555-1015',13,'Aerospace Engineering Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(31,'Warren','Buffett','warren.buffett@university.edu','555-1016',14,'Dean of Business','2025-09-11 22:35:59','2025-09-11 22:35:59'),(32,'Peter','Drucker','peter.drucker@university.edu','555-1017',14,'Management Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(33,'Michael','Porter','michael.porter@university.edu','555-1018',14,'Strategy Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(34,'Clayton','Christensen','clayton.christensen@university.edu','555-1019',14,'Innovation Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(35,'Jim','Collins','jim.collins@university.edu','555-1020',14,'Leadership Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(36,'John','Dewey','john.dewey@university.edu','555-1021',15,'Educational Philosophy Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(37,'Maria','Montessori','maria.montessori@university.edu','555-1022',15,'Early Childhood Education Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(38,'Paulo','Freire','paulo.freire@university.edu','555-1023',15,'Critical Pedagogy Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(39,'Howard','Gardner','howard.gardner@university.edu','555-1024',15,'Multiple Intelligence Theory Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(40,'Carol','Dweck','carol.dweck@university.edu','555-1025',15,'Educational Psychology Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(41,'Leonardo','DaVinci','leonardo.davinci@university.edu','555-1026',16,'Fine Arts Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(42,'Pablo','Picasso','pablo.picasso@university.edu','555-1027',16,'Modern Art Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(43,'Georgia','OKeeffe','georgia.okeefe@university.edu','555-1028',16,'Painting Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(44,'Andy','Warhol','andy.warhol@university.edu','555-1029',16,'Pop Art Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(45,'Frida','Kahlo','frida.kahlo@university.edu','555-1030',16,'Contemporary Art Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(46,'Ludwig','Beethoven','ludwig.beethoven@university.edu','555-1031',17,'Composition Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(47,'Wolfgang','Mozart','wolfgang.mozart@university.edu','555-1032',17,'Classical Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(48,'Miles','Davis','miles.davis@university.edu','555-1033',17,'Jazz Studies Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(49,'Ella','Fitzgerald','ella.fitzgerald@university.edu','555-1034',17,'Vocal Performance Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(50,'John','Williams','john.williams@university.edu','555-1035',17,'Film Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(51,'Winston','Churchill','winston.churchill@university.edu','555-1036',18,'Modern History Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(52,'Frederick','Douglass','frederick.douglass@university.edu','555-1037',18,'American History Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(53,'Cleopatra','VII','cleopatra.vii@university.edu','555-1038',18,'Ancient History Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(54,'Nelson','Mandela','nelson.mandela@university.edu','555-1039',18,'African Studies Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(55,'Joan','Arc','joan.arc@university.edu','555-1040',18,'Medieval History Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(56,'William','Shakespeare','william.shakespeare@university.edu','555-1041',19,'Literature Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(57,'Maya','Angelou','maya.angelou@university.edu','555-1042',19,'Poetry Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(58,'Mark','Twain','mark.twain@university.edu','555-1043',19,'American Literature Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(59,'Virginia','Woolf','virginia.woolf@university.edu','555-1044',19,'Modern Literature Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(60,'Toni','Morrison','toni.morrison@university.edu','555-1045',19,'Contemporary Literature Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(61,'Florence','Nightingale','florence.nightingale@university.edu','555-1046',20,'Nursing Department Chair','2025-09-11 22:35:59','2025-09-11 22:35:59'),(62,'Clara','Barton','clara.barton@university.edu','555-1047',20,'Emergency Nursing Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(63,'Mary','Breckinridge','mary.breckinridge@university.edu','555-1048',20,'Midwifery Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(64,'Lillian','Wald','lillian.wald@university.edu','555-1049',20,'Public Health Nursing Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(65,'Dorothea','Dix','dorothea.dix@university.edu','555-1050',20,'Psychiatric Nursing Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(66,'Frank','Lloyd','frank.lloyd@university.edu','555-1051',21,'Facilities Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(67,'Jane','Jacobs','jane.jacobs@university.edu','555-1052',21,'Campus Planning Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(68,'Christopher','Alexander','christopher.alexander@university.edu','555-1053',21,'Building Operations Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(69,'Zaha','Hadid','zaha.hadid@university.edu','555-1054',21,'Architectural Services Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(70,'I.M.','Pei','im.pei@university.edu','555-1055',21,'Infrastructure Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(71,'Jack','Ryan','jack.ryan@university.edu','555-1056',22,'Security Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(72,'Ellen','Ripley','ellen.ripley@university.edu','555-1057',22,'Emergency Response Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(73,'James','Bond','james.bond@university.edu','555-1058',22,'Campus Security Chief','2025-09-11 22:35:59','2025-09-11 22:35:59'),(74,'Sarah','Connor','sarah.connor@university.edu','555-1059',22,'Security Training Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(75,'John','McClane','john.mcclane@university.edu','555-1060',22,'Night Shift Supervisor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(76,'Michelle','Obama','michelle.obama@university.edu','555-1061',23,'Admissions Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(77,'Oprah','Winfrey','oprah.winfrey@university.edu','555-1062',23,'Student Outreach Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(78,'Ruth','Ginsburg','ruth.ginsburg@university.edu','555-1063',23,'Graduate Admissions Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(79,'Condoleezza','Rice','condoleezza.rice@university.edu','555-1064',23,'International Admissions Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(80,'Hillary','Clinton','hillary.clinton@university.edu','555-1065',23,'Enrollment Services Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(81,'Benjamin','Franklin','benjamin.franklin@university.edu','555-1066',24,'University Registrar','2025-09-11 22:35:59','2025-09-11 22:35:59'),(82,'Thomas','Jefferson','thomas.jefferson@university.edu','555-1067',24,'Academic Records Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(83,'John','Adams','john.adams@university.edu','555-1068',24,'Degree Audit Specialist','2025-09-11 22:35:59','2025-09-11 22:35:59'),(84,'Alexander','Hamilton','alexander.hamilton@university.edu','555-1069',24,'Transcript Services Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(85,'George','Washington','george.washington@university.edu','555-1070',24,'Registration Systems Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(86,'Don','Draper','don.draper@university.edu','555-1071',25,'Marketing Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(87,'Peggy','Olson','peggy.olson@university.edu','555-1072',25,'Creative Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(88,'Joan','Holloway','joan.holloway@university.edu','555-1073',25,'Communications Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(89,'Roger','Sterling','roger.sterling@university.edu','555-1074',25,'Brand Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(90,'Betty','Francis','betty.francis@university.edu','555-1075',25,'Social Media Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(91,'Johnnie','Cochran','johnnie.cochran@university.edu','555-1076',26,'General Counsel','2025-09-11 22:35:59','2025-09-11 22:35:59'),(92,'Sandra','Day','sandra.day@university.edu','555-1077',26,'Deputy General Counsel','2025-09-11 22:35:59','2025-09-11 22:35:59'),(93,'Thurgood','Marshall','thurgood.marshall@university.edu','555-1078',26,'Compliance Officer','2025-09-11 22:35:59','2025-09-11 22:35:59'),(94,'Elena','Kagan','elena.kagan@university.edu','555-1079',26,'Contract Specialist','2025-09-11 22:35:59','2025-09-11 22:35:59'),(95,'Sonia','Sotomayor','sonia.sotomayor@university.edu','555-1080',26,'Legal Research Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(96,'Bill','Gates','bill.gates@university.edu','555-1081',27,'Alumni Relations Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(97,'Melinda','Gates','melinda.gates@university.edu','555-1082',27,'Development Officer','2025-09-11 22:35:59','2025-09-11 22:35:59'),(98,'Steve','Jobs','steve.jobs@university.edu','555-1083',27,'Corporate Relations Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(99,'Mark','Zuckerberg','mark.zuckerberg@university.edu','555-1084',27,'Alumni Engagement Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(100,'Sheryl','Sandberg','sheryl.sandberg@university.edu','555-1085',27,'Fundraising Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(101,'Kofi','Annan','kofi.annan@university.edu','555-1086',28,'International Programs Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(102,'Ban','Ki-moon','ban.ki-moon@university.edu','555-1087',28,'Study Abroad Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(103,'Malala','Yousafzai','malala.yousafzai@university.edu','555-1088',28,'International Student Advisor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(104,'Wangari','Maathai','wangari.maathai@university.edu','555-1089',28,'Cultural Exchange Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(105,'Desmond','Tutu','desmond.tutu@university.edu','555-1090',28,'Global Partnerships Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(106,'Jane','Goodall','jane.goodall@university.edu','555-1091',29,'Research Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(107,'Rachel','Carson','rachel.carson@university.edu','555-1092',29,'Environmental Research Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(108,'Barbara','McClintock','barbara.mcclintock@university.edu','555-1093',29,'Genetics Research Manager','2025-09-11 22:35:59','2025-09-11 22:35:59'),(109,'Rosalind','Franklin','rosalind.franklin@university.edu','555-1094',29,'Structural Biology Research Lead','2025-09-11 22:35:59','2025-09-11 22:35:59'),(110,'Dorothy','Hodgkin','dorothy.hodgkin@university.edu','555-1095',29,'Chemistry Research Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(111,'Jonas','Salk','jonas.salk@university.edu','555-1096',30,'Health Services Director','2025-09-11 22:35:59','2025-09-11 22:35:59'),(112,'Paul','Farmer','paul.farmer@university.edu','555-1097',30,'Public Health Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(113,'Susan','Love','susan.love@university.edu','555-1098',30,'Women\'s Health Specialist','2025-09-11 22:35:59','2025-09-11 22:35:59'),(114,'Anthony','Fauci','anthony.fauci@university.edu','555-1099',30,'Infectious Disease Specialist','2025-09-11 22:35:59','2025-09-11 22:35:59'),(115,'Atul','Gawande','atul.gawande@university.edu','555-1100',30,'Preventive Medicine Coordinator','2025-09-11 22:35:59','2025-09-11 22:35:59'),(116,'Emma','Watson','emma.watson@university.edu','555-1101',19,'Assistant Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(117,'Malala','Smith','malala.smith@university.edu','555-1102',15,'Curriculum Specialist','2025-09-11 22:35:59','2025-09-11 22:35:59'),(118,'Rosa','Parks','rosa.parks@university.edu','555-1103',18,'Civil Rights History Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(119,'Katherine','Hepburn','katherine.hepburn@university.edu','555-1104',16,'Theatre Arts Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(120,'Amelia','Earhart','amelia.earhart@university.edu','555-1105',13,'Aviation Engineering Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(121,'Margaret','Thatcher','margaret.thatcher@university.edu','555-1106',14,'Political Science Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(122,'Mother','Teresa','mother.teresa@university.edu','555-1107',20,'Ethics in Healthcare Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(123,'Diana','Ross','diana.ross@university.edu','555-1108',17,'Popular Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(124,'Billie','Holiday','billie.holiday@university.edu','555-1109',17,'Blues and Jazz Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(125,'Aretha','Franklin','aretha.franklin@university.edu','555-1110',17,'Soul Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(126,'Janis','Joplin','janis.joplin@university.edu','555-1111',17,'Rock Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(127,'Joni','Mitchell','joni.mitchell@university.edu','555-1112',17,'Folk Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(128,'Tina','Turner','tina.turner@university.edu','555-1113',17,'Performance Studies Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(129,'Stevie','Nicks','stevie.nicks@university.edu','555-1114',17,'Songwriting Professor','2025-09-11 22:35:59','2025-09-11 22:35:59'),(130,'Dolly','Parton','dolly.parton@university.edu','555-1115',17,'Country Music Professor','2025-09-11 22:35:59','2025-09-11 22:35:59');
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
INSERT INTO `operating_systems` VALUES (1,'Windows 11','11','Windows','2025-09-06 19:41:49'),(2,'Windows 10','10','Windows','2025-09-06 19:41:49'),(3,'macOS Sonoma','14.0','macOS','2025-09-06 19:41:49'),(4,'macOS Ventura','13.0','macOS','2025-09-06 19:41:49'),(5,'Ubuntu Linux','22.04 LTS','Linux','2025-09-06 19:41:49'),(6,'CentOS Linux','8','Linux','2025-09-06 19:41:49'),(7,'Red Hat Enterprise Linux','9','Linux','2025-09-06 19:41:49'),(8,'Cross-Platform','N/A','Other','2025-09-06 19:41:49');
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
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_operating_systems`
--

LOCK TABLES `software_operating_systems` WRITE;
/*!40000 ALTER TABLE `software_operating_systems` DISABLE KEYS */;
INSERT INTO `software_operating_systems` VALUES (1,1,1,NULL,'Windows 11 compatible','2025-09-06 19:41:49'),(2,1,2,NULL,'Windows 10 supported','2025-09-06 19:41:49'),(3,1,3,NULL,'macOS Sonoma','2025-09-06 19:41:49'),(4,2,1,NULL,'Windows 11 compatible','2025-09-06 19:41:49'),(5,2,2,NULL,'Windows 10 supported','2025-09-06 19:41:49'),(6,2,3,NULL,'macOS Sonoma','2025-09-06 19:41:49'),(7,3,1,NULL,'Windows 11 compatible','2025-09-06 19:41:49'),(8,3,2,NULL,'Windows 10 supported','2025-09-06 19:41:49'),(9,3,4,NULL,'macOS Ventura','2025-09-06 19:41:49'),(10,4,1,NULL,'Windows 11','2025-09-06 19:41:49'),(11,4,3,NULL,'macOS Sonoma','2025-09-06 19:41:49'),(12,4,5,NULL,'Ubuntu Linux','2025-09-06 19:41:49'),(13,5,1,NULL,'Windows 11','2025-09-06 19:41:49'),(14,5,3,NULL,'macOS Sonoma','2025-09-06 19:41:49'),(15,6,1,NULL,'Windows 11','2025-09-06 19:41:49'),(16,6,5,NULL,'Ubuntu Linux','2025-09-06 19:41:49'),(17,7,8,NULL,'Cross-platform','2025-09-06 19:41:49'),(18,8,8,NULL,'Cross-platform','2025-09-06 19:41:49'),(19,9,8,NULL,'Cross-platform','2025-09-06 19:41:49'),(20,10,1,NULL,'Windows 11','2025-09-06 19:41:49'),(21,10,3,NULL,'macOS Sonoma','2025-09-06 19:41:49'),(22,11,1,NULL,'Windows 11','2025-09-06 19:41:49'),(23,11,3,NULL,'macOS Sonoma','2025-09-06 19:41:49'),(24,12,1,NULL,'Windows 11','2025-09-06 19:41:49'),(25,12,2,NULL,'Windows 10','2025-09-06 19:41:49'),(26,13,1,NULL,'Windows 11','2025-09-06 19:41:49'),(27,13,2,NULL,'Windows 10','2025-09-06 19:41:49'),(28,14,8,NULL,'Web-based access','2025-09-06 19:41:49'),(29,15,1,NULL,'Windows 11 compatible','2025-09-11 22:36:09'),(30,15,2,NULL,'Windows 10 supported','2025-09-11 22:36:09'),(31,15,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(32,15,5,NULL,'Ubuntu Linux','2025-09-11 22:36:09'),(33,16,1,NULL,'Windows 11','2025-09-11 22:36:09'),(34,16,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(35,16,5,NULL,'Linux supported','2025-09-11 22:36:09'),(36,17,1,NULL,'Windows 11','2025-09-11 22:36:09'),(37,17,2,NULL,'Windows 10','2025-09-11 22:36:09'),(38,18,1,NULL,'Windows 11','2025-09-11 22:36:09'),(39,18,2,NULL,'Windows 10','2025-09-11 22:36:09'),(40,18,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(41,19,8,NULL,'Cross-platform Java application','2025-09-11 22:36:09'),(42,20,1,NULL,'Windows 11','2025-09-11 22:36:09'),(43,20,2,NULL,'Windows 10','2025-09-11 22:36:09'),(44,21,5,NULL,'Linux clusters','2025-09-11 22:36:09'),(45,21,2,NULL,'Windows HPC','2025-09-11 22:36:09'),(46,22,1,NULL,'Windows 11','2025-09-11 22:36:09'),(47,22,5,NULL,'Linux workstations','2025-09-11 22:36:09'),(48,23,1,NULL,'Windows 11','2025-09-11 22:36:09'),(49,23,2,NULL,'Windows 10','2025-09-11 22:36:09'),(50,24,1,NULL,'Windows 11','2025-09-11 22:36:09'),(51,24,3,NULL,'macOS','2025-09-11 22:36:09'),(52,24,5,NULL,'Linux RT','2025-09-11 22:36:09'),(53,25,1,NULL,'Windows 11','2025-09-11 22:36:09'),(54,25,5,NULL,'Linux','2025-09-11 22:36:09'),(55,25,4,NULL,'Unix systems','2025-09-11 22:36:09'),(56,26,1,NULL,'Windows 11','2025-09-11 22:36:09'),(57,26,3,NULL,'macOS','2025-09-11 22:36:09'),(58,26,5,NULL,'Linux','2025-09-11 22:36:09'),(59,27,1,NULL,'Windows 11','2025-09-11 22:36:09'),(60,27,3,NULL,'macOS','2025-09-11 22:36:09'),(61,28,1,NULL,'Windows 11','2025-09-11 22:36:09'),(62,28,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(63,29,1,NULL,'Windows 11','2025-09-11 22:36:09'),(64,29,3,NULL,'macOS','2025-09-11 22:36:09'),(65,30,1,NULL,'Windows 11','2025-09-11 22:36:09'),(66,30,3,NULL,'macOS','2025-09-11 22:36:09'),(67,31,8,NULL,'Web-based platform','2025-09-11 22:36:09'),(68,32,8,NULL,'Web-based research platform','2025-09-11 22:36:09'),(69,33,8,NULL,'Cross-platform with web sync','2025-09-11 22:36:09'),(70,34,1,NULL,'Windows 11','2025-09-11 22:36:09'),(71,34,3,NULL,'macOS','2025-09-11 22:36:09'),(72,35,8,NULL,'Cross-platform Java IDE','2025-09-11 22:36:09'),(73,36,8,NULL,'Cross-platform Python IDE','2025-09-11 22:36:09'),(74,37,1,NULL,'Windows 11','2025-09-11 22:36:09'),(75,37,3,NULL,'macOS version available','2025-09-11 22:36:09'),(76,38,8,NULL,'Cross-platform Java-based IDE','2025-09-11 22:36:09'),(77,39,8,NULL,'Cross-platform IDE','2025-09-11 22:36:09'),(78,40,1,NULL,'Windows 11','2025-09-11 22:36:09'),(79,40,3,NULL,'macOS','2025-09-11 22:36:09'),(80,40,5,NULL,'Linux','2025-09-11 22:36:09'),(81,41,8,NULL,'Web-based cross-platform','2025-09-11 22:36:09'),(82,42,1,NULL,'Windows 11 with WSL2','2025-09-11 22:36:09'),(83,42,3,NULL,'macOS','2025-09-11 22:36:09'),(84,42,5,NULL,'Linux native','2025-09-11 22:36:09'),(85,43,8,NULL,'Cross-platform version control','2025-09-11 22:36:09'),(86,44,1,NULL,'Windows 11','2025-09-11 22:36:09'),(87,44,3,NULL,'macOS','2025-09-11 22:36:09'),(88,45,1,NULL,'Windows 11','2025-09-11 22:36:09'),(89,45,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(90,46,1,NULL,'Windows 11','2025-09-11 22:36:09'),(91,46,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(92,47,1,NULL,'Windows 11','2025-09-11 22:36:09'),(93,47,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(94,48,1,NULL,'Windows 11','2025-09-11 22:36:09'),(95,48,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(96,49,1,NULL,'Windows 11','2025-09-11 22:36:09'),(97,49,3,NULL,'macOS Sonoma','2025-09-11 22:36:09'),(98,50,3,NULL,'macOS exclusive','2025-09-11 22:36:09'),(99,51,8,NULL,'Cross-platform 3D suite','2025-09-11 22:36:09'),(100,52,1,NULL,'Windows 11','2025-09-11 22:36:09'),(101,52,3,NULL,'macOS','2025-09-11 22:36:09'),(102,53,1,NULL,'Windows 11','2025-09-11 22:36:09'),(103,53,5,NULL,'Linux','2025-09-11 22:36:09'),(104,54,1,NULL,'Windows 11','2025-09-11 22:36:09'),(105,55,1,NULL,'Windows 11','2025-09-11 22:36:09'),(106,55,3,NULL,'macOS','2025-09-11 22:36:09'),(107,56,8,NULL,'Enterprise web-based','2025-09-11 22:36:09'),(108,57,8,NULL,'Enterprise database system','2025-09-11 22:36:09'),(109,58,8,NULL,'Enterprise web application','2025-09-11 22:36:09'),(110,59,8,NULL,'Cloud-based SaaS','2025-09-11 22:36:09'),(111,60,8,NULL,'Cloud CRM platform','2025-09-11 22:36:09'),(112,61,8,NULL,'Web-based marketing platform','2025-09-11 22:36:09'),(113,62,8,NULL,'Cloud email marketing','2025-09-11 22:36:09'),(114,63,8,NULL,'Cloud social media management','2025-09-11 22:36:09'),(115,64,8,NULL,'Web-based design platform','2025-09-11 22:36:09'),(116,65,1,NULL,'Windows 11','2025-09-11 22:36:09'),(117,65,3,NULL,'macOS','2025-09-11 22:36:09'),(118,65,5,NULL,'Linux','2025-09-11 22:36:09'),(119,66,8,NULL,'Cross-platform open source','2025-09-11 22:36:09'),(120,67,1,NULL,'Windows 11','2025-09-11 22:36:09'),(121,67,3,NULL,'macOS','2025-09-11 22:36:09'),(122,68,1,NULL,'Windows 11','2025-09-11 22:36:09'),(123,68,3,NULL,'macOS','2025-09-11 22:36:09'),(124,69,1,NULL,'Windows 11','2025-09-11 22:36:09'),(125,69,3,NULL,'macOS','2025-09-11 22:36:09'),(126,70,3,NULL,'macOS exclusive','2025-09-11 22:36:09'),(127,71,1,NULL,'Windows 11','2025-09-11 22:36:09'),(128,71,3,NULL,'macOS','2025-09-11 22:36:09'),(129,72,8,NULL,'Cross-platform Python-based','2025-09-11 22:36:09'),(130,73,1,NULL,'Windows experimental software','2025-09-11 22:36:09'),(131,74,8,NULL,'Cross-platform experiment builder','2025-09-11 22:36:09'),(132,75,8,NULL,'Web-based EHR system','2025-09-11 22:36:09'),(133,76,8,NULL,'Healthcare IT platform','2025-09-11 22:36:09'),(134,77,8,NULL,'Web-based healthcare system','2025-09-11 22:36:09'),(135,78,8,NULL,'Cloud-based healthcare','2025-09-11 22:36:09'),(136,79,8,NULL,'Healthcare practice management','2025-09-11 22:36:09'),(137,80,8,NULL,'Mobile-first EHR','2025-09-11 22:36:09'),(138,81,8,NULL,'Web-based EHR','2025-09-11 22:36:09'),(139,82,8,NULL,'Cloud healthcare platform','2025-09-11 22:36:09'),(140,83,8,NULL,'Healthcare information system','2025-09-11 22:36:09'),(141,84,8,NULL,'Government healthcare system','2025-09-11 22:36:09'),(142,85,8,NULL,'Cloud library platform','2025-09-11 22:36:09'),(143,86,8,NULL,'Integrated library system','2025-09-11 22:36:09'),(144,87,8,NULL,'Web-based global catalog','2025-09-11 22:36:09'),(145,88,8,NULL,'Web-based CMS for libraries','2025-09-11 22:36:09'),(146,89,8,NULL,'Cross-platform repository','2025-09-11 22:36:09'),(147,90,8,NULL,'Java-based repository','2025-09-11 22:36:09'),(148,91,8,NULL,'Ruby-based repository framework','2025-09-11 22:36:09'),(149,92,8,NULL,'Distributed preservation system','2025-09-11 22:36:09'),(150,93,8,NULL,'Cross-platform reference tool','2025-09-11 22:36:09'),(151,94,8,NULL,'Web-based reference management','2025-09-11 22:36:09'),(152,95,1,NULL,'Windows 11','2025-09-11 22:36:09'),(153,95,5,NULL,'Linux workstations','2025-09-11 22:36:09'),(154,96,1,NULL,'Windows 11','2025-09-11 22:36:09'),(155,96,5,NULL,'Linux','2025-09-11 22:36:09'),(156,97,1,NULL,'Windows 11','2025-09-11 22:36:09'),(157,98,1,NULL,'Windows 11','2025-09-11 22:36:09'),(158,99,1,NULL,'Windows 11','2025-09-11 22:36:09'),(159,99,3,NULL,'macOS','2025-09-11 22:36:09'),(160,100,1,NULL,'Windows 11','2025-09-11 22:36:09'),(161,101,1,NULL,'Windows 11','2025-09-11 22:36:09'),(162,101,3,NULL,'macOS','2025-09-11 22:36:09'),(163,102,1,NULL,'Windows 11','2025-09-11 22:36:09'),(164,102,3,NULL,'macOS','2025-09-11 22:36:09'),(165,103,1,NULL,'Windows 11','2025-09-11 22:36:09'),(166,103,3,NULL,'macOS','2025-09-11 22:36:09'),(167,103,5,NULL,'Linux','2025-09-11 22:36:09'),(168,104,1,NULL,'Windows 11','2025-09-11 22:36:09'),(169,104,3,NULL,'macOS','2025-09-11 22:36:09'),(170,105,1,NULL,'Windows 11','2025-09-11 22:36:09'),(171,105,3,NULL,'macOS','2025-09-11 22:36:09'),(172,106,8,NULL,'Web-based chemical database','2025-09-11 22:36:09'),(173,107,8,NULL,'Web-based chemical search','2025-09-11 22:36:09'),(174,108,1,NULL,'Windows HPC','2025-09-11 22:36:09'),(175,108,5,NULL,'Linux clusters','2025-09-11 22:36:09'),(176,109,5,NULL,'Linux supercomputing','2025-09-11 22:36:09'),(177,110,5,NULL,'Linux molecular dynamics','2025-09-11 22:36:09'),(178,111,8,NULL,'Cross-platform visualization','2025-09-11 22:36:09'),(179,112,1,NULL,'Windows 11','2025-09-11 22:36:09'),(180,112,3,NULL,'macOS','2025-09-11 22:36:09'),(181,112,5,NULL,'Linux','2025-09-11 22:36:09'),(182,113,5,NULL,'Linux molecular dynamics','2025-09-11 22:36:09'),(183,114,5,NULL,'Linux biomolecular simulation','2025-09-11 22:36:09'),(184,115,1,NULL,'Windows 11','2025-09-11 22:36:09'),(185,115,3,NULL,'macOS','2025-09-11 22:36:09'),(186,115,5,NULL,'Linux','2025-09-11 22:36:09'),(187,116,1,NULL,'Windows 11','2025-09-11 22:36:09'),(188,116,3,NULL,'macOS','2025-09-11 22:36:09'),(189,117,1,NULL,'Windows 11','2025-09-11 22:36:09'),(190,117,3,NULL,'macOS','2025-09-11 22:36:09'),(191,118,1,NULL,'Windows 11','2025-09-11 22:36:09'),(192,118,3,NULL,'macOS','2025-09-11 22:36:09'),(193,118,5,NULL,'Linux','2025-09-11 22:36:09'),(194,119,1,NULL,'Windows 11','2025-09-11 22:36:09'),(195,119,3,NULL,'macOS','2025-09-11 22:36:09'),(196,120,8,NULL,'Cloud-based ML platform','2025-09-11 22:36:09'),(197,121,8,NULL,'Cross-platform ML','2025-09-11 22:36:09'),(198,122,8,NULL,'Java-based cross-platform','2025-09-11 22:36:09'),(199,123,8,NULL,'Cross-platform data mining','2025-09-11 22:36:09'),(200,124,8,NULL,'Cross-platform analytics','2025-09-11 22:36:09'),(201,125,8,NULL,'Cloud collaboration platform','2025-09-11 22:36:09'),(202,126,8,NULL,'Cross-platform collaboration','2025-09-11 22:36:09'),(203,127,8,NULL,'Cross-platform video conferencing','2025-09-11 22:36:09'),(204,128,8,NULL,'Cross-platform web conferencing','2025-09-11 22:36:09'),(205,129,8,NULL,'Cloud productivity suite','2025-09-11 22:36:09'),(206,130,8,NULL,'Cloud file storage','2025-09-11 22:36:09'),(207,131,8,NULL,'Cloud content management','2025-09-11 22:36:09'),(208,132,8,NULL,'Cloud storage service','2025-09-11 22:36:09'),(209,133,8,NULL,'Web-based collaboration','2025-09-11 22:36:09'),(210,134,8,NULL,'Web-based team collaboration','2025-09-11 22:36:09'),(211,135,1,NULL,'Windows endpoint protection','2025-09-11 22:36:09'),(212,135,3,NULL,'macOS support','2025-09-11 22:36:09'),(213,135,5,NULL,'Linux support','2025-09-11 22:36:09'),(214,136,1,NULL,'Windows enterprise security','2025-09-11 22:36:09'),(215,136,3,NULL,'macOS support','2025-09-11 22:36:09'),(216,137,1,NULL,'Windows security management','2025-09-11 22:36:09'),(217,138,1,NULL,'Windows data analytics','2025-09-11 22:36:09'),(218,138,5,NULL,'Linux enterprise','2025-09-11 22:36:09'),(219,139,8,NULL,'Cross-platform network analyzer','2025-09-11 22:36:09'),(220,140,1,NULL,'Windows vulnerability scanner','2025-09-11 22:36:09'),(221,140,5,NULL,'Linux scanning','2025-09-11 22:36:09'),(222,141,8,NULL,'Cross-platform network discovery','2025-09-11 22:36:09'),(223,142,1,NULL,'Windows penetration testing','2025-09-11 22:36:09'),(224,142,5,NULL,'Linux pen testing','2025-09-11 22:36:09'),(225,143,1,NULL,'Windows web security testing','2025-09-11 22:36:09'),(226,143,3,NULL,'macOS support','2025-09-11 22:36:09'),(227,143,5,NULL,'Linux support','2025-09-11 22:36:09'),(228,144,8,NULL,'Cross-platform web security scanner','2025-09-11 22:36:09'),(229,145,1,NULL,'Windows enterprise','2025-09-11 22:36:09'),(230,145,5,NULL,'Linux enterprise','2025-09-11 22:36:09'),(231,145,4,NULL,'Unix systems','2025-09-11 22:36:09'),(232,146,1,NULL,'Windows SQL Server','2025-09-11 22:36:09'),(233,147,8,NULL,'Cross-platform open source database','2025-09-11 22:36:09'),(234,148,8,NULL,'Cross-platform NoSQL database','2025-09-11 22:36:09'),(235,149,8,NULL,'Cross-platform in-memory store','2025-09-11 22:36:09'),(236,150,8,NULL,'Cross-platform search engine','2025-09-11 22:36:09'),(237,151,8,NULL,'Cross-platform graph database','2025-09-11 22:36:09'),(238,152,8,NULL,'Cross-platform distributed database','2025-09-11 22:36:09'),(239,153,8,NULL,'Cross-platform time series database','2025-09-11 22:36:09'),(240,154,1,NULL,'Windows enterprise analytics','2025-09-11 22:36:09'),(241,154,5,NULL,'Linux server','2025-09-11 22:36:09'),(242,155,8,NULL,'Cross-platform CMS','2025-09-11 22:36:09'),(243,156,8,NULL,'Cross-platform CMS framework','2025-09-11 22:36:09'),(244,157,8,NULL,'Cross-platform CMS','2025-09-11 22:36:09'),(245,158,8,NULL,'Cross-platform e-commerce','2025-09-11 22:36:09'),(246,159,8,NULL,'Cloud e-commerce platform','2025-09-11 22:36:09'),(247,160,8,NULL,'Cross-platform e-commerce plugin','2025-09-11 22:36:09'),(248,161,8,NULL,'Cloud website builder','2025-09-11 22:36:09'),(249,162,8,NULL,'Cloud web development platform','2025-09-11 22:36:09'),(250,163,8,NULL,'Cloud visual web design','2025-09-11 22:36:09'),(251,164,8,NULL,'Cross-platform publishing platform','2025-09-11 22:36:09'),(252,165,1,NULL,'Windows virtualization','2025-09-11 22:36:09'),(253,165,5,NULL,'Linux vCenter','2025-09-11 22:36:09'),(254,166,1,NULL,'Windows Hyper-V','2025-09-11 22:36:09'),(255,167,1,NULL,'Windows app virtualization','2025-09-11 22:36:09'),(256,168,8,NULL,'Cross-platform container orchestration','2025-09-11 22:36:09'),(257,169,5,NULL,'Enterprise Kubernetes on Linux','2025-09-11 22:36:09'),(258,170,8,NULL,'Cross-platform automation','2025-09-11 22:36:09'),(259,171,8,NULL,'Cross-platform configuration management','2025-09-11 22:36:09'),(260,172,8,NULL,'Cross-platform infrastructure automation','2025-09-11 22:36:09'),(261,173,8,NULL,'Cross-platform infrastructure as code','2025-09-11 22:36:09'),(262,174,8,NULL,'Cross-platform network monitoring','2025-09-11 22:36:09'),(263,175,8,NULL,'Cloud-based electronic lab notebook','2025-09-11 22:36:09'),(264,176,8,NULL,'Cloud life sciences platform','2025-09-11 22:36:09'),(265,177,1,NULL,'Windows molecular biology','2025-09-11 22:36:09'),(266,177,3,NULL,'macOS support','2025-09-11 22:36:09'),(267,177,5,NULL,'Linux support','2025-09-11 22:36:09'),(268,178,1,NULL,'Windows flow cytometry','2025-09-11 22:36:09'),(269,178,3,NULL,'macOS support','2025-09-11 22:36:09'),(270,179,1,NULL,'Windows statistical analysis','2025-09-11 22:36:09'),(271,180,1,NULL,'Windows statistical software','2025-09-11 22:36:09'),(272,181,1,NULL,'Windows econometric software','2025-09-11 22:36:09'),(273,182,1,NULL,'Windows multiprocessor statistics','2025-09-11 22:36:09'),(274,182,3,NULL,'macOS support','2025-09-11 22:36:09'),(275,182,5,NULL,'Linux support','2025-09-11 22:36:09'),(276,183,1,NULL,'Windows statistical modeling','2025-09-11 22:36:09'),(277,184,1,NULL,'Windows structural equation modeling','2025-09-11 22:36:09');
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
  `university_unit_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_software_name` (`software_name`),
  KEY `idx_vendor_managed` (`vendor_managed`),
  KEY `idx_vendor_name` (`vendor_name`),
  KEY `fk_software_university_unit` (`university_unit_id`),
  CONSTRAINT `fk_software_university_unit` FOREIGN KEY (`university_unit_id`) REFERENCES `university_units` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_products`
--

LOCK TABLES `software_products` WRITE;
/*!40000 ALTER TABLE `software_products` DISABLE KEYS */;
INSERT INTO `software_products` VALUES (1,'SPSS Statistical Software','29.0','Statistical analysis software for psychology research',0,'','Site License','','2025-09-06 19:41:49','2025-09-07 01:17:54',2),(2,'SPSS Statistical Software','29.0','Statistical analysis software for biology research',1,'IBM','Site License','','2025-09-06 19:41:49','2025-09-06 23:56:07',1),(3,'SPSS Statistical Software','28.0','Statistical analysis software for mathematics research',1,'IBM','Site License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',3),(4,'MATLAB','R2023b','Technical computing for engineering applications',1,'MathWorks','Campus License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',1),(5,'MATLAB','R2023a','Mathematical modeling for biology research',1,'MathWorks','Campus License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',2),(6,'MATLAB','R2023b','Statistical computing platform for mathematics',1,'MathWorks','Campus License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',3),(7,'Microsoft Office 365','2023','Productivity suite for IT administrative tasks',1,'Microsoft','Enterprise Agreement',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',5),(8,'Microsoft Office 365','2023','Office suite for HR operations',1,'Microsoft','Enterprise Agreement',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',6),(9,'Microsoft Office 365','2023','Document management for library services',1,'Microsoft','Enterprise Agreement',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',8),(10,'Adobe Creative Suite','2023','Design software for CS course materials',1,'Adobe','Education License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',1),(11,'Adobe Creative Suite','2023','Scientific illustration software for biology',1,'Adobe','Education License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',2),(12,'AutoCAD','2024','CAD software for computer graphics courses',1,'Autodesk','Educational License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',1),(13,'AutoCAD','2024','Technical drawing for chemistry lab design',1,'Autodesk','Educational License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',4),(14,'Banner ERP','9.4','Student information system',1,'Ellucian','Perpetual License',NULL,'2025-09-06 19:41:49','2025-09-06 19:41:49',5),(15,'Mathematica','13.3','Computational mathematics software for advanced calculations',1,'Wolfram Research','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',3),(16,'Maple','2023','Mathematical software for algebra, calculus, and more',1,'Maplesoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',3),(17,'Origin','2023','Data analysis and graphing software for scientists',1,'OriginLab','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',11),(18,'GraphPad Prism','10.0','Biostatistics and scientific graphing software',1,'GraphPad Software','Institutional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(19,'ImageJ','1.54','Open source image processing software',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(20,'ChemSketch','2023','Chemical drawing and molecular modeling software',1,'ACD/Labs','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',2),(21,'Gaussian','16','Computational chemistry software package',1,'Gaussian Inc.','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',4),(22,'ANSYS','2023','Engineering simulation software',1,'ANSYS Inc.','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(23,'SolidWorks','2024','3D CAD design software',1,'Dassault Systemes','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(24,'LabVIEW','2023','System design platform and development environment',1,'National Instruments','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(25,'SAS','9.4','Statistical analysis system for data analytics',1,'SAS Institute','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(26,'Stata','18','Statistical software package for data analysis',1,'StataCorp','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(27,'JMP','17','Statistical discovery software from SAS',1,'SAS Institute','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',11),(28,'NVivo','14','Qualitative data analysis software',1,'Lumivero','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(29,'Atlas.ti','23','Qualitative data analysis and research software',1,'ATLAS.ti GmbH','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',12),(30,'MaxQDA','2024','Software for qualitative and mixed methods research',1,'VERBI Software','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',12),(31,'Qualtrics','2024','Online survey and research platform',1,'Qualtrics','Institutional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',20),(32,'REDCap','14.0','Research electronic data capture platform',1,'Vanderbilt University','Consortium License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(33,'Mendeley','2024','Reference manager and academic social network',1,'Elsevier','Institutional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(34,'EndNote','X21','Reference management software',1,'Clarivate Analytics','Site License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(35,'IntelliJ IDEA','2024.1','Integrated development environment for Java',1,'JetBrains','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(36,'PyCharm','2024.1','Python IDE for professional developers',1,'JetBrains','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(37,'Visual Studio','2022','Integrated development environment from Microsoft',1,'Microsoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(38,'Eclipse','2024-03','Open source integrated development environment',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(39,'NetBeans','20','Open source IDE for multiple programming languages',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(40,'RStudio','2024.04','Integrated development environment for R',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',10),(41,'Jupyter Notebook','7.0','Web-based interactive computing platform',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(42,'Docker','24.0','Containerization platform for applications',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(43,'Git','2.45','Distributed version control system',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(44,'GitHub Desktop','3.4','GUI for Git version control',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(45,'Photoshop','2024','Professional image editing software',1,'Adobe','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(46,'Illustrator','2024','Vector graphics editor',1,'Adobe','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(47,'InDesign','2024','Desktop publishing software',1,'Adobe','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(48,'Premiere Pro','2024','Video editing software',1,'Adobe','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(49,'After Effects','2024','Digital visual effects software',1,'Adobe','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(50,'Final Cut Pro','10.8','Video editing software for macOS',1,'Apple','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',14),(51,'Blender','4.1','Open source 3D creation suite',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(52,'SketchUp','2024','3D modeling software',1,'Trimble','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(53,'Maya','2024','3D computer animation software',1,'Autodesk','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(54,'3ds Max','2024','3D modeling and rendering software',1,'Autodesk','Commercial','','2025-09-11 22:35:59','2025-09-11 23:26:20',24),(55,'QuickBooks','2024','Accounting software for small to medium business',1,'Intuit','Commercial License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',7),(56,'SAP ERP','6.0','Enterprise resource planning software',1,'SAP','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',7),(57,'Oracle Financials','12.2','Financial management system',1,'Oracle','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',7),(58,'PeopleSoft','9.2','Human resources management system',1,'Oracle','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',6),(59,'Workday','2024','Cloud-based HR and finance software',1,'Workday','SaaS License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',6),(60,'Salesforce','2024','Customer relationship management platform',1,'Salesforce','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(61,'HubSpot','2024','Inbound marketing and sales platform',1,'HubSpot','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(62,'Mailchimp','2024','Email marketing platform',1,'Intuit','Premium License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(63,'Hootsuite','2024','Social media management platform',1,'Hootsuite','Professional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(64,'Canva','2024','Graphic design platform',1,'Canva','Education License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(65,'ArcGIS','10.9','Geographic information system software',1,'Esri','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',15),(66,'QGIS','3.36','Open source geographic information system',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',15),(67,'Sibelius','2024','Music notation software',1,'Avid','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',14),(68,'Finale','27','Music notation and composition software',1,'MakeMusic','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',14),(69,'Pro Tools','2024.6','Digital audio workstation',1,'Avid','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',14),(70,'Logic Pro','10.8','Digital audio workstation for macOS',1,'Apple','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',14),(71,'Ableton Live','12','Music production software',1,'Ableton','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',14),(72,'PsychoPy','2024.1','Psychology experiment software',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(73,'E-Prime','3.0','Psychology experiment design software',1,'Psychology Software Tools','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(74,'OpenSesame','4.0','Graphical experiment builder for psychology',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(75,'Epic','2024','Electronic health records system',1,'Epic Systems','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(76,'Cerner','2024','Healthcare information technology',1,'Oracle','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(77,'MEDITECH','2024','Healthcare information system',1,'Medical Information Technology','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(78,'athenahealth','2024','Cloud-based healthcare software',1,'athenahealth','SaaS License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(79,'NextGen','2024','Healthcare practice management',1,'NextGen Healthcare','Professional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(80,'DrChrono','2024','Electronic health records for mobile',1,'DrChrono','Cloud License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(81,'Practice Fusion','2024','Web-based electronic health records',1,'Veracyte','Cloud License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(82,'eClinicalWorks','2024','Electronic medical records system',1,'eClinicalWorks','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',27),(83,'AllScripts','2024','Healthcare information solutions',1,'Allscripts','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',17),(84,'CPRS','2024','Computerized patient record system',0,'US Department of Veterans Affairs','Government License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',17),(85,'Alma','2024','Library services platform',1,'Ex Libris','Subscription License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(86,'Sierra','6.1','Integrated library system',1,'Innovative Interfaces','Annual License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(87,'WorldCat','2024','Global library catalog',1,'OCLC','Membership License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(88,'LibGuides','2024','Library website content management',1,'Springshare','Annual License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(89,'DSpace','7.6','Open source digital repository software',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(90,'Fedora','6.5','Digital object repository architecture',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(91,'Samvera','2024','Repository software framework',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(92,'LOCKSS','2024','Digital preservation system',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(93,'Zotero','7.0','Free reference management tool',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(94,'RefWorks','2024','Web-based reference management',1,'ProQuest','Institutional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',8),(95,'CATIA','V5','3D product design and experience solution',1,'Dassault Systemes','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(96,'NX','2312','Product development solution',1,'Siemens','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(97,'Creo','10.0','Product design software',1,'PTC','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(98,'Inventor','2024','3D mechanical design software',1,'Autodesk','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(99,'Fusion 360','2024','Cloud-based 3D CAD/CAM/CAE software',1,'Autodesk','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(100,'Revit','2024','Building information modeling software',1,'Autodesk','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(101,'ArchiCAD','27','BIM software for architects',1,'Graphisoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(102,'Rhino','8','3D computer graphics software',1,'Robert McNeel & Associates','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(103,'KeyShot','12','3D rendering and animation software',1,'Luxion','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(104,'Substance Painter','2024','3D painting software',1,'Adobe','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(105,'ChemDraw Professional','22.0','Chemical drawing and analysis software',1,'PerkinElmer','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',4),(106,'SciFinder','2024','Chemical research database',1,'Chemical Abstracts Service','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',2),(107,'Reaxys','2024','Chemical database and search engine',1,'Elsevier','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',4),(108,'Materials Studio','2024','Modeling and simulation for materials science',1,'BIOVIA','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',2),(109,'VASP','6.4','Ab initio quantum mechanical molecular dynamics',1,'University of Vienna','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',11),(110,'NAMD','3.0','Molecular dynamics simulation software',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',4),(111,'VMD','1.9.4','Molecular visualization program',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',2),(112,'PyMOL','2.5','Molecular visualization system',1,'Schrodinger','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(113,'GROMACS','2024','Molecular dynamics package',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',4),(114,'AMBER','22','Suite of biomolecular simulation programs',1,'University of California','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(115,'Tableau','2024.1','Data visualization software',1,'Salesforce','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(116,'Power BI','2024','Business analytics solution',1,'Microsoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(117,'Qlik Sense','2024','Data analytics platform',1,'Qlik','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(118,'Spotfire','2024','Analytics and data visualization software',1,'TIBCO','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(119,'Alteryx','2024.1','Data science and analytics platform',1,'Alteryx','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(120,'DataRobot','2024','Automated machine learning platform',1,'DataRobot','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(121,'H2O.ai','3.46','Open source machine learning platform',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(122,'Weka','3.8','Machine learning software',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(123,'Orange','3.36','Data visualization and analysis tool',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',1),(124,'KNIME','5.2','Analytics platform for data science',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(125,'Slack','2024','Team collaboration platform',1,'Salesforce','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(126,'Microsoft Teams','2024','Collaboration and communication platform',1,'Microsoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(127,'Zoom','2024','Video conferencing software',1,'Zoom','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(128,'WebEx','2024','Video conferencing and collaboration',1,'Cisco','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(129,'Google Workspace','2024','Productivity and collaboration suite',1,'Google','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(130,'Dropbox','2024','Cloud storage and file sharing',1,'Dropbox','Education License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(131,'Box','2024','Cloud content management platform',1,'Box','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(132,'OneDrive','2024','Cloud storage service',1,'Microsoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(133,'SharePoint','2024','Web-based collaboration platform',1,'Microsoft','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(134,'Confluence','2024','Team collaboration software',1,'Atlassian','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(135,'CrowdStrike','2024','Endpoint protection platform',1,'CrowdStrike','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',19),(136,'Symantec Endpoint Protection','14.3','Antivirus and security software',1,'Broadcom','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',19),(137,'McAfee ePO','5.10','Security management platform',1,'McAfee','Enterprise License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',19),(138,'Splunk','9.2','Data analytics and security platform',1,'Splunk','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(139,'Wireshark','4.2','Network protocol analyzer',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(140,'Nessus','10.7','Vulnerability assessment scanner',1,'Tenable','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',19),(141,'Nmap','7.94','Network discovery and security auditing',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(142,'Metasploit','6.4','Penetration testing framework',1,'Rapid7','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(143,'Burp Suite','2024','Web application security testing',1,'PortSwigger','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(144,'OWASP ZAP','2.15','Web application security scanner',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(145,'Oracle Database','23c','Relational database management system',1,'Oracle','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(146,'SQL Server','2022','Relational database management system',1,'Microsoft','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(147,'PostgreSQL','16','Open source relational database',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(148,'MongoDB','7.0','NoSQL document database',1,'MongoDB Inc.','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(149,'Redis','7.2','In-memory data structure store',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(150,'Elasticsearch','8.13','Search and analytics engine',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(151,'Neo4j','5.19','Graph database management system',1,'Neo4j','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(152,'Cassandra','5.0','Distributed NoSQL database',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(153,'InfluxDB','2.7','Time series database',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(154,'Tableau Server','2024.1','Enterprise analytics platform',1,'Salesforce','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(155,'WordPress','6.5','Content management system',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(156,'Drupal','10','Content management framework',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(157,'Joomla','5.1','Content management system',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(158,'Magento','2.4','E-commerce platform',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(159,'Shopify','2024','E-commerce platform',1,'Shopify','Commercial License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(160,'WooCommerce','8.8','E-commerce plugin for WordPress',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(161,'Squarespace','2024','Website building and hosting',1,'Squarespace','Commercial License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(162,'Wix','2024','Cloud-based web development platform',1,'Wix','Commercial License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(163,'WebFlow','2024','Visual web design platform',1,'Webflow','Professional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(164,'Ghost','5.82','Publishing platform',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',22),(165,'VMware vSphere','8.0','Virtualization platform',1,'VMware','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(166,'Hyper-V','2022','Hypervisor-based virtualization',1,'Microsoft','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(167,'Citrix XenApp','2402','Application virtualization',1,'Citrix','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(168,'Kubernetes','1.30','Container orchestration platform',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(169,'OpenShift','4.15','Enterprise Kubernetes platform',1,'Red Hat','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(170,'Ansible','9.4','Automation and configuration management',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(171,'Puppet','8.6','Configuration management tool',1,'Puppet','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(172,'Chef','18.4','Infrastructure automation platform',1,'Progress','Educational License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(173,'Terraform','1.8','Infrastructure as code software',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(174,'Nagios','4.5','Network and infrastructure monitoring',0,NULL,'Open Source',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',5),(175,'LabArchives','2024','Electronic lab notebook',1,'LabArchives LLC','Institutional License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',26),(176,'Benchling','2024','Life sciences R&D cloud platform',1,'Benchling','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(177,'Geneious','2024.0','Molecular biology and sequence analysis',1,'Dotmatics','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(178,'FlowJo','10.10','Flow cytometry analysis software',1,'BD Life Sciences','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:35:59',2),(179,'GraphPad InStat','3.1','Statistical analysis software',1,'GraphPad Software','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(180,'Minitab','21','Statistical software for quality improvement',1,'Minitab LLC','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(181,'EViews','13','Econometric analysis software',1,'HIS Global Inc.','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',11),(182,'Stata/MP','18','Multiprocessor statistical software',1,'StataCorp','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(183,'MPlus','8.10','Statistical modeling software',1,'Muthen & Muthen','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13),(184,'Lisrel','10.3','Structural equation modeling software',1,'Scientific Software International','Academic License',NULL,'2025-09-11 22:35:59','2025-09-11 22:41:39',13);
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
  `business_owner_id` int NOT NULL,
  `technical_owner_id` int NOT NULL,
  `technical_manager_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `software_id` (`software_id`),
  KEY `business_owner_id` (`business_owner_id`),
  KEY `technical_owner_id` (`technical_owner_id`),
  KEY `technical_manager_id` (`technical_manager_id`),
  CONSTRAINT `software_roles_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software_products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `software_roles_ibfk_2` FOREIGN KEY (`business_owner_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `software_roles_ibfk_3` FOREIGN KEY (`technical_owner_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `software_roles_ibfk_4` FOREIGN KEY (`technical_manager_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_roles`
--

LOCK TABLES `software_roles` WRITE;
/*!40000 ALTER TABLE `software_roles` DISABLE KEYS */;
INSERT INTO `software_roles` VALUES (3,3,5,6,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(4,4,2,12,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(5,5,3,11,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(6,6,13,6,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(7,7,1,4,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(8,8,7,4,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(9,9,15,4,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(10,10,2,12,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(11,11,3,11,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(12,12,12,2,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(13,13,10,14,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(14,14,1,6,1,'2025-09-06 19:41:49','2025-09-06 19:41:49'),(17,2,12,4,1,'2025-09-06 23:56:07','2025-09-06 23:56:07'),(25,1,3,4,1,'2025-09-07 01:17:54','2025-09-07 01:17:54'),(26,15,13,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(27,16,5,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(28,17,16,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(29,18,11,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(30,19,3,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(31,20,14,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(32,21,10,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(33,22,20,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(34,23,19,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(35,24,18,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(36,25,27,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(37,26,28,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(38,27,16,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(39,28,29,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(40,29,21,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(41,30,22,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(42,31,61,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(43,32,91,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(44,33,15,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(45,34,15,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(46,35,2,12,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(47,36,12,2,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(48,37,2,12,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(49,38,12,2,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(50,39,2,12,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(51,40,9,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(52,41,12,2,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(53,42,4,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(54,43,2,12,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(55,44,12,2,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(56,45,26,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(57,46,27,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(58,47,28,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(59,48,29,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(60,49,30,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(61,50,35,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(62,51,26,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(63,52,27,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(64,53,28,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(66,55,8,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(67,56,8,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(68,57,8,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(69,58,7,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(70,59,7,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(71,60,71,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(72,61,72,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(73,62,73,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(74,63,74,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(75,64,75,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(76,65,36,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(77,66,37,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(78,67,31,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(79,68,32,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(80,69,33,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(81,70,34,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(82,71,35,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(83,72,26,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(84,73,27,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(85,74,28,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(86,75,96,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(87,76,97,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(88,77,98,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(89,78,99,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(90,79,100,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(91,80,96,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(92,81,97,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(93,82,98,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(94,83,46,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(95,84,47,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(96,85,15,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(97,86,15,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(98,87,15,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(99,88,15,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(100,89,15,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(101,90,15,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(102,91,15,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(103,92,15,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(104,93,15,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(105,94,15,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(106,95,20,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(107,96,18,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(108,97,19,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(109,98,20,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(110,99,18,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(111,100,19,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(112,101,26,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(113,102,27,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(114,103,28,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(115,104,29,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(116,105,10,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(117,106,14,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(118,107,10,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(119,108,14,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(120,109,16,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(121,110,10,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(122,111,14,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(123,112,3,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(124,113,10,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(125,114,11,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(126,115,91,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(127,116,16,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(128,117,17,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(129,118,92,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(130,119,93,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(131,120,2,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(132,121,12,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(133,122,2,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(134,123,12,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(135,124,94,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(136,125,1,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(137,126,4,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(138,127,1,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(139,128,6,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(140,129,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(141,130,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(142,131,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(143,132,6,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(144,133,1,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(145,134,4,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(146,135,56,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(147,136,57,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(148,137,58,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(149,138,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(150,139,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(151,140,59,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(152,141,6,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(153,142,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(154,143,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(155,144,6,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(156,145,6,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(157,146,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(158,147,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(159,148,6,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(160,149,1,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(161,150,4,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(162,151,6,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(163,152,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(164,153,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(165,154,95,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(166,155,71,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(167,156,72,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(168,157,73,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(169,158,74,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(170,159,75,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(171,160,71,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(172,161,72,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(173,162,73,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(174,163,74,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(175,164,75,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(176,165,1,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(177,166,4,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(178,167,6,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(179,168,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(180,169,4,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(181,170,6,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(182,171,1,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(183,172,4,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(184,173,6,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(185,174,1,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(186,175,91,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(187,176,3,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(188,177,11,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(189,178,3,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(190,179,26,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(191,180,16,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(192,181,17,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(193,182,28,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(194,183,29,4,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(195,184,30,6,1,'2025-09-11 22:36:09','2025-09-11 22:36:09'),(197,54,83,6,1,'2025-09-11 23:26:20','2025-09-11 23:26:20');
/*!40000 ALTER TABLE `software_roles` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university_units`
--

LOCK TABLES `university_units` WRITE;
/*!40000 ALTER TABLE `university_units` DISABLE KEYS */;
INSERT INTO `university_units` VALUES (1,'Computer Science Department','CS','Department of Computer Science and Software Engineering',NULL,'department','2025-09-06 19:41:49','2025-09-06 19:41:49'),(2,'Biology Department','BIOL','Department of Biological Sciences',NULL,'department','2025-09-06 19:41:49','2025-09-06 21:25:39'),(3,'Mathematics Department','MATH','Department of Mathematics and Statistics',NULL,'department','2025-09-06 19:41:49','2025-09-06 19:41:49'),(4,'Chemistry Department','CHEM','Department of Chemistry and Biochemistry',NULL,'department','2025-09-06 19:41:49','2025-09-06 19:41:49'),(5,'IT Services','ITS','Information Technology Services Division',NULL,'administrative','2025-09-06 19:41:49','2025-09-06 19:41:49'),(6,'Human Resources','HR','Human Resources Department',NULL,'administrative','2025-09-06 19:41:49','2025-09-06 19:41:49'),(7,'Finance Department','FIN','Financial Services and Administration',NULL,'administrative','2025-09-06 19:41:49','2025-09-06 19:41:49'),(8,'University Library','LIB','Main University Library System',NULL,'support','2025-09-06 19:41:49','2025-09-06 19:41:49'),(9,'Student Services','SS','Student Affairs and Support Services',NULL,'support','2025-09-06 19:41:49','2025-09-06 19:41:49'),(10,'Research Computing','RC','High Performance Computing and Research Support',NULL,'research','2025-09-06 19:41:49','2025-09-06 19:41:49'),(11,'Physics Department','PHYS','Department of Physics and Astronomy',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(12,'Psychology Department','PSYC','Department of Psychology and Behavioral Sciences',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(13,'Engineering Department','ENGR','Department of Engineering and Technology',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(14,'Business School','BUS','School of Business Administration',NULL,'college','2025-09-11 22:35:59','2025-09-11 22:35:59'),(15,'Education Department','EDUC','Department of Education and Teaching',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(16,'Art Department','ART','Department of Fine Arts and Design',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(17,'Music Department','MUS','Department of Music and Performing Arts',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(18,'History Department','HIST','Department of History and Social Sciences',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(19,'English Department','ENG','Department of English and Literature',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(20,'Nursing Department','NURS','Department of Nursing and Health Sciences',NULL,'department','2025-09-11 22:35:59','2025-09-11 22:35:59'),(21,'Facilities Management','FAC','Campus Facilities and Maintenance',NULL,'support','2025-09-11 22:35:59','2025-09-11 22:35:59'),(22,'Security Services','SEC','Campus Security and Emergency Services',NULL,'support','2025-09-11 22:35:59','2025-09-11 22:35:59'),(23,'Admissions Office','ADM','Student Admissions and Enrollment',NULL,'administrative','2025-09-11 22:35:59','2025-09-11 22:35:59'),(24,'Registrar Office','REG','Academic Records and Registration',NULL,'administrative','2025-09-11 22:35:59','2025-09-11 22:35:59'),(25,'Marketing Department','MARK','University Marketing and Communications',NULL,'administrative','2025-09-11 22:35:59','2025-09-11 22:35:59'),(26,'Legal Affairs','LEG','Legal Counsel and Compliance',NULL,'administrative','2025-09-11 22:35:59','2025-09-11 22:35:59'),(27,'Alumni Relations','ALU','Alumni Services and Development',NULL,'support','2025-09-11 22:35:59','2025-09-11 22:35:59'),(28,'International Office','INT','International Student Services',NULL,'support','2025-09-11 22:35:59','2025-09-11 22:35:59'),(29,'Research Office','RES','Office of Research and Innovation',NULL,'research','2025-09-11 22:35:59','2025-09-11 22:35:59'),(30,'Health Services','HLTH','Campus Health and Wellness Center',NULL,'support','2025-09-11 22:35:59','2025-09-11 22:35:59');
/*!40000 ALTER TABLE `university_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'datatables_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_employee`(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_university_unit_id INT,
    IN p_job_title VARCHAR(150),
    OUT p_employee_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_employee_id = NULL;
    END;
    
    START TRANSACTION;
    
    INSERT INTO employees (first_name, last_name, email, phone, university_unit_id, job_title) 
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_university_unit_id, p_job_title);
    
    SET p_employee_id = LAST_INSERT_ID();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_software` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_software`(
    IN p_software_name VARCHAR(200),
    IN p_version VARCHAR(50),
    IN p_description TEXT,
    IN p_vendor_managed BOOLEAN,
    IN p_vendor_name VARCHAR(200),
    IN p_license_type VARCHAR(100),
    IN p_installation_notes TEXT,
    IN p_business_owner_id INT,
    IN p_technical_owner_id INT,
    IN p_technical_manager_id INT,
    OUT p_software_id INT
)
BEGIN
    DECLARE v_university_unit_id INT DEFAULT NULL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_software_id = NULL;
    END;
    
    START TRANSACTION;
    
    
    SELECT university_unit_id INTO v_university_unit_id
    FROM employees 
    WHERE id = p_business_owner_id;
    
    
    INSERT INTO software_products (software_name, version, description, vendor_managed, vendor_name, license_type, installation_notes, university_unit_id) 
    VALUES (p_software_name, p_version, p_description, p_vendor_managed, p_vendor_name, p_license_type, p_installation_notes, v_university_unit_id);
    
    SET p_software_id = LAST_INSERT_ID();
    
    
    INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) 
    VALUES (p_software_id, p_business_owner_id, p_technical_owner_id, p_technical_manager_id);
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_unit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_unit`(
    IN p_unit_name VARCHAR(200),
    IN p_unit_code VARCHAR(50),
    IN p_description TEXT,
    IN p_parent_unit_id INT,
    IN p_unit_type VARCHAR(20),
    OUT p_unit_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_unit_id = NULL;
    END;
    
    START TRANSACTION;
    
    INSERT INTO university_units (unit_name, unit_code, description, parent_unit_id, unit_type) 
    VALUES (p_unit_name, p_unit_code, p_description, p_parent_unit_id, p_unit_type);
    
    SET p_unit_id = LAST_INSERT_ID();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_employee`(
    IN p_employee_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    
    UPDATE software_roles SET business_owner_id = NULL WHERE business_owner_id = p_employee_id;
    UPDATE software_roles SET technical_owner_id = NULL WHERE technical_owner_id = p_employee_id;
    UPDATE software_roles SET technical_manager_id = NULL WHERE technical_manager_id = p_employee_id;
    
    
    DELETE FROM employees WHERE id = p_employee_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_software` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_software`(
    IN p_software_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    DELETE FROM software_products WHERE id = p_software_id;
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_delete_unit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_unit`(
    IN p_unit_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    DELETE FROM university_units WHERE id = p_unit_id;
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_all_employees` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_employees`(
    IN p_limit INT,
    IN p_offset INT, 
    IN p_search VARCHAR(255),
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE where_clause TEXT DEFAULT '';
    DECLARE order_clause TEXT DEFAULT ' ORDER BY e.updated_at DESC';
    DECLARE limit_clause TEXT DEFAULT '';
    
    
    SET sql_query = 'SELECT 
                        e.id,
                        e.first_name,
                        e.last_name,
                        e.email,
                        e.phone,
                        e.university_unit_id,
                        e.job_title,
                        e.created_at,
                        e.updated_at,
                        u.unit_name as university_unit_name,
                        COUNT(DISTINCT CASE WHEN sr.business_owner_id = e.id THEN sr.software_id END) as business_owner_count,
                        COUNT(DISTINCT CASE WHEN sr.technical_owner_id = e.id THEN sr.software_id END) as technical_owner_count,
                        COUNT(DISTINCT CASE WHEN sr.technical_manager_id = e.id THEN sr.software_id END) as technical_manager_count
                    FROM employees e
                    LEFT JOIN university_units u ON e.university_unit_id = u.id
                    LEFT JOIN software_roles sr ON (e.id = sr.business_owner_id OR e.id = sr.technical_owner_id OR e.id = sr.technical_manager_id)';
    
    
    IF p_search IS NOT NULL AND p_search != '' THEN
        SET where_clause = CONCAT(' WHERE (e.first_name LIKE ''%', p_search, '%'' OR e.last_name LIKE ''%', p_search, '%'' OR e.email LIKE ''%', p_search, '%'' OR u.unit_name LIKE ''%', p_search, '%'')');
    END IF;
    
    
    SET sql_query = CONCAT(sql_query, where_clause, ' GROUP BY e.id, e.first_name, e.last_name, e.email, e.phone, e.university_unit_id, e.job_title, e.created_at, e.updated_at, u.unit_name');
    
    
    IF p_order_by IS NOT NULL THEN
        CASE p_order_by
            WHEN 'name' THEN SET order_clause = CONCAT(' ORDER BY CONCAT(e.first_name, '' '', e.last_name) ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'first_name' THEN SET order_clause = CONCAT(' ORDER BY e.first_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'last_name' THEN SET order_clause = CONCAT(' ORDER BY e.last_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'email' THEN SET order_clause = CONCAT(' ORDER BY e.email ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'phone' THEN SET order_clause = CONCAT(' ORDER BY e.phone ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'university_unit_name' THEN SET order_clause = CONCAT(' ORDER BY u.unit_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'job_title' THEN SET order_clause = CONCAT(' ORDER BY e.job_title ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'created_at' THEN SET order_clause = CONCAT(' ORDER BY e.created_at ', IFNULL(p_order_dir, 'ASC'));
            ELSE SET order_clause = ' ORDER BY e.updated_at DESC';
        END CASE;
    END IF;
    
    
    IF p_limit IS NOT NULL AND p_limit > 0 THEN
        SET limit_clause = CONCAT(' LIMIT ', p_limit);
        IF p_offset IS NOT NULL AND p_offset > 0 THEN
            SET limit_clause = CONCAT(limit_clause, ' OFFSET ', p_offset);
        END IF;
    END IF;
    
    
    SET @sql = CONCAT(sql_query, order_clause, limit_clause);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_all_software` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_software`(
    IN p_limit INT,
    IN p_offset INT,
    IN p_search VARCHAR(255),
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE where_clause TEXT DEFAULT '';
    DECLARE order_clause TEXT DEFAULT ' ORDER BY sp.updated_at DESC';
    DECLARE limit_clause TEXT DEFAULT '';
    
    SET sql_query = 'SELECT 
                        sp.id,
                        sp.software_name,
                        sp.version,
                        sp.description,
                        sp.vendor_managed,
                        sp.vendor_name,
                        sp.license_type,
                        sp.created_at,
                        sp.updated_at,
                        bo_unit.unit_name as university_unit,
                        bo_unit.unit_code as university_unit_code,
                        CASE WHEN bo_unit.id IS NOT NULL THEN 1 ELSE 0 END as unit_count,
                        CONCAT(bo.first_name, '' '', bo.last_name) as business_owner,
                        bo.email as business_owner_email,
                        bo_unit.unit_name as business_owner_department,
                        CONCAT(to_emp.first_name, '' '', to_emp.last_name) as technical_owner,
                        to_emp.email as technical_owner_email,
                        CONCAT(tm.first_name, '' '', tm.last_name) as technical_manager,
                        tm.email as technical_manager_email,
                        GROUP_CONCAT(DISTINCT os.os_name ORDER BY os.os_name SEPARATOR '', '') as operating_systems,
                        CASE WHEN sr.business_owner_id IS NULL THEN 1 ELSE 0 END as missing_business_owner,
                        CASE WHEN sr.technical_owner_id IS NULL THEN 1 ELSE 0 END as missing_technical_owner,
                        CASE WHEN sr.technical_manager_id IS NULL THEN 1 ELSE 0 END as missing_technical_manager,
                        CASE WHEN sr.id IS NULL THEN 1 ELSE 0 END as missing_roles_record
                    FROM software_products sp
                    LEFT JOIN software_roles sr ON sp.id = sr.software_id
                    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
                    LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
                    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
                    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
                    LEFT JOIN software_operating_systems sos ON sp.id = sos.software_id
                    LEFT JOIN operating_systems os ON sos.os_id = os.id';
    
    
    IF p_search IS NOT NULL AND p_search != '' THEN
        SET where_clause = CONCAT(' WHERE (sp.software_name LIKE ''%', p_search, '%'' OR sp.vendor_name LIKE ''%', p_search, '%'' OR sp.description LIKE ''%', p_search, '%'' OR bo_unit.unit_name LIKE ''%', p_search, '%'' OR CONCAT(bo.first_name, '' '', bo.last_name) LIKE ''%', p_search, '%'')');
    END IF;
    
    
    SET sql_query = CONCAT(sql_query, where_clause, ' GROUP BY sp.id, sp.software_name, sp.version, sp.description, sp.vendor_managed, sp.vendor_name, sp.license_type, sp.created_at, sp.updated_at, bo_unit.unit_name, bo_unit.unit_code, bo.first_name, bo.last_name, bo.email, bo_unit.unit_name, to_emp.first_name, to_emp.last_name, to_emp.email, tm.first_name, tm.last_name, tm.email, sr.id, sr.business_owner_id, sr.technical_owner_id, sr.technical_manager_id');
    
    
    IF p_order_by IS NOT NULL AND p_order_dir IS NOT NULL THEN
        SET order_clause = CONCAT(' ORDER BY ', p_order_by, ' ', p_order_dir);
    END IF;
    
    
    IF p_limit IS NOT NULL AND p_limit > 0 THEN
        SET limit_clause = CONCAT(' LIMIT ', p_limit);
        IF p_offset IS NOT NULL AND p_offset > 0 THEN
            SET limit_clause = CONCAT(limit_clause, ' OFFSET ', p_offset);
        END IF;
    END IF;
    
    
    SET @sql = CONCAT(sql_query, order_clause, limit_clause);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_all_units` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_units`(
    IN p_limit INT,
    IN p_offset INT,
    IN p_search VARCHAR(255),
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE sql_query TEXT;
    DECLARE where_clause TEXT DEFAULT '';
    DECLARE order_clause TEXT DEFAULT ' ORDER BY u.updated_at DESC';
    DECLARE limit_clause TEXT DEFAULT '';
    
    SET sql_query = 'SELECT 
                        u.id,
                        u.unit_name,
                        u.unit_code,
                        u.description,
                        u.unit_type,
                        u.created_at,
                        u.updated_at,
                        parent.unit_name as parent_unit_name,
                        COUNT(DISTINCT sp.id) as software_count,
                        COUNT(DISTINCT sp.id) as active_software_count
                    FROM university_units u
                    LEFT JOIN university_units parent ON u.parent_unit_id = parent.id
                    LEFT JOIN employees e ON u.id = e.university_unit_id
                    LEFT JOIN software_roles sr ON e.id = sr.business_owner_id
                    LEFT JOIN software_products sp ON sr.software_id = sp.id';
    
    
    IF p_search IS NOT NULL AND p_search != '' THEN
        SET where_clause = CONCAT(' WHERE (u.unit_name LIKE ''%', p_search, '%'' OR u.unit_code LIKE ''%', p_search, '%'' OR u.description LIKE ''%', p_search, '%'')');
    END IF;
    
    
    SET sql_query = CONCAT(sql_query, where_clause, ' GROUP BY u.id, u.unit_name, u.unit_code, u.description, u.unit_type, u.created_at, u.updated_at, parent.unit_name');
    
    
    IF p_order_by IS NOT NULL THEN
        CASE p_order_by
            WHEN 'unit_name' THEN SET order_clause = CONCAT(' ORDER BY u.unit_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'unit_code' THEN SET order_clause = CONCAT(' ORDER BY u.unit_code ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'unit_type' THEN SET order_clause = CONCAT(' ORDER BY u.unit_type ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'parent_unit_name' THEN SET order_clause = CONCAT(' ORDER BY parent.unit_name ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'software_count' THEN SET order_clause = CONCAT(' ORDER BY software_count ', IFNULL(p_order_dir, 'ASC'));
            WHEN 'updated_at' THEN SET order_clause = CONCAT(' ORDER BY u.updated_at ', IFNULL(p_order_dir, 'ASC'));
            ELSE SET order_clause = ' ORDER BY u.updated_at DESC';
        END CASE;
    END IF;
    
    
    IF p_limit IS NOT NULL AND p_limit > 0 THEN
        SET limit_clause = CONCAT(' LIMIT ', p_limit);
        IF p_offset IS NOT NULL AND p_offset > 0 THEN
            SET limit_clause = CONCAT(limit_clause, ' OFFSET ', p_offset);
        END IF;
    END IF;
    
    
    SET @sql = CONCAT(sql_query, order_clause, limit_clause);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_all_units_for_dropdown` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_units_for_dropdown`()
BEGIN
    SELECT 
        id,
        unit_name,
        unit_code,
        unit_type
    FROM university_units 
    ORDER BY unit_name ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_employee_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_employee_by_id`(
    IN p_employee_id INT
)
BEGIN
    SELECT e.*, u.unit_name as university_unit_name 
    FROM employees e 
    LEFT JOIN university_units u ON e.university_unit_id = u.id 
    WHERE e.id = p_employee_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_employee_software_roles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_employee_software_roles`(
    IN p_employee_id INT
)
BEGIN
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        'Business Owner' as role_type
    FROM software_products sp
    JOIN software_roles sr ON sp.id = sr.software_id
    WHERE sr.business_owner_id = p_employee_id
    
    UNION ALL
    
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        'Technical Owner' as role_type
    FROM software_products sp
    JOIN software_roles sr ON sp.id = sr.software_id
    WHERE sr.technical_owner_id = p_employee_id
    
    UNION ALL
    
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        'Technical Manager' as role_type
    FROM software_products sp
    JOIN software_roles sr ON sp.id = sr.software_id
    WHERE sr.technical_manager_id = p_employee_id
    
    ORDER BY software_name, role_type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_employee_total_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_employee_total_count`(
    IN p_search VARCHAR(255),
    OUT p_total_count INT
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT COUNT(DISTINCT e.id) INTO p_total_count
        FROM employees e
        LEFT JOIN university_units u ON e.university_unit_id = u.id
        WHERE (e.first_name LIKE CONCAT('%', p_search, '%') 
               OR e.last_name LIKE CONCAT('%', p_search, '%') 
               OR e.email LIKE CONCAT('%', p_search, '%') 
               OR u.unit_name LIKE CONCAT('%', p_search, '%'));
    ELSE
        SELECT COUNT(*) INTO p_total_count FROM employees;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_software_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_software_by_id`(
    IN p_software_id INT
)
BEGIN
    SELECT sp.*, 
           u.unit_name as university_unit,
           u.unit_code as university_unit_code,
           u.unit_type as university_unit_type,
           CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
           CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
           CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager,
           sr.business_owner_id,
           sr.technical_owner_id,
           sr.technical_manager_id,
           bo.first_name as business_owner_first_name,
           bo.last_name as business_owner_last_name,
           bo.email as business_owner_email,
           bo_unit.unit_name as business_owner_department,
           to_emp.first_name as technical_owner_first_name,
           to_emp.last_name as technical_owner_last_name,
           to_emp.email as technical_owner_email,
           tm.first_name as technical_manager_first_name,
           tm.last_name as technical_manager_last_name,
           tm.email as technical_manager_email
    FROM software_products sp
    LEFT JOIN university_units u ON sp.university_unit_id = u.id
    LEFT JOIN software_roles sr ON sp.id = sr.software_id
    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
    LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
    WHERE sp.id = p_software_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_software_operating_systems` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_software_operating_systems`(
    IN p_software_id INT
)
BEGIN
    SELECT os.id, os.os_name, os.os_version, os.os_family
    FROM operating_systems os
    JOIN software_operating_systems sos ON os.id = sos.os_id
    WHERE sos.software_id = p_software_id
    ORDER BY os.os_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_software_total_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_software_total_count`(
    IN p_search VARCHAR(255),
    OUT p_total_count INT
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT COUNT(DISTINCT sp.id) INTO p_total_count
        FROM software_products sp
        LEFT JOIN university_units u ON sp.university_unit_id = u.id
        LEFT JOIN software_roles sr ON sp.id = sr.software_id
        LEFT JOIN employees bo ON sr.business_owner_id = bo.id
        LEFT JOIN university_units bo_unit ON bo.university_unit_id = bo_unit.id
        WHERE (sp.software_name LIKE CONCAT('%', p_search, '%') 
               OR sp.vendor_name LIKE CONCAT('%', p_search, '%') 
               OR sp.description LIKE CONCAT('%', p_search, '%') 
               OR u.unit_name LIKE CONCAT('%', p_search, '%') 
               OR CONCAT(bo.first_name, ' ', bo.last_name) LIKE CONCAT('%', p_search, '%'));
    ELSE
        SELECT COUNT(*) INTO p_total_count FROM software_products;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_software_unit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_software_unit`(
    IN p_software_id INT
)
BEGIN
    SELECT u.id, u.unit_name, u.unit_code, u.unit_type
    FROM software_products sp
    LEFT JOIN university_units u ON sp.university_unit_id = u.id
    WHERE sp.id = p_software_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_unique_software_names` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_unique_software_names`(
    IN p_search VARCHAR(255)
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT DISTINCT software_name 
        FROM software_products 
        WHERE software_name LIKE CONCAT('%', p_search, '%')
        ORDER BY software_name ASC 
        LIMIT 5;
    ELSE
        SELECT DISTINCT software_name 
        FROM software_products 
        ORDER BY software_name ASC 
        LIMIT 5;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_unit_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_unit_by_id`(
    IN p_unit_id INT
)
BEGIN
    SELECT u.*, parent.unit_name as parent_unit_name
    FROM university_units u
    LEFT JOIN university_units parent ON u.parent_unit_id = parent.id
    WHERE u.id = p_unit_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_unit_software` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_unit_software`(
    IN p_unit_id INT
)
BEGIN
    SELECT 
        sp.id as software_id,
        sp.software_name,
        sp.version,
        sp.vendor_managed,
        sp.vendor_name,
        sp.created_at,
        CONCAT(bo.first_name, ' ', bo.last_name) as business_owner,
        CONCAT(to_emp.first_name, ' ', to_emp.last_name) as technical_owner,
        CONCAT(tm.first_name, ' ', tm.last_name) as technical_manager
    FROM software_products sp
    LEFT JOIN software_roles sr ON sp.id = sr.software_id
    LEFT JOIN employees bo ON sr.business_owner_id = bo.id
    LEFT JOIN employees to_emp ON sr.technical_owner_id = to_emp.id
    LEFT JOIN employees tm ON sr.technical_manager_id = tm.id
    WHERE sp.university_unit_id = p_unit_id
    ORDER BY sp.software_name, sp.version;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_unit_total_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_unit_total_count`(
    IN p_search VARCHAR(255),
    OUT p_total_count INT
)
BEGIN
    IF p_search IS NOT NULL AND p_search != '' THEN
        SELECT COUNT(*) INTO p_total_count 
        FROM university_units 
        WHERE (unit_name LIKE CONCAT('%', p_search, '%') 
               OR unit_code LIKE CONCAT('%', p_search, '%') 
               OR description LIKE CONCAT('%', p_search, '%'));
    ELSE
        SELECT COUNT(*) INTO p_total_count FROM university_units;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_employee`(
    IN p_employee_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_university_unit_id INT,
    IN p_job_title VARCHAR(150),
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    UPDATE employees 
    SET first_name = p_first_name, 
        last_name = p_last_name, 
        email = p_email, 
        phone = p_phone, 
        university_unit_id = p_university_unit_id,
        job_title = p_job_title,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_employee_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_software` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_software`(
    IN p_software_id INT,
    IN p_software_name VARCHAR(200),
    IN p_version VARCHAR(50),
    IN p_description TEXT,
    IN p_vendor_managed BOOLEAN,
    IN p_vendor_name VARCHAR(200),
    IN p_license_type VARCHAR(100),
    IN p_installation_notes TEXT,
    IN p_business_owner_id INT,
    IN p_technical_owner_id INT,
    IN p_technical_manager_id INT,
    OUT p_rows_affected INT
)
BEGIN
    DECLARE v_university_unit_id INT DEFAULT NULL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    
    SELECT university_unit_id INTO v_university_unit_id
    FROM employees 
    WHERE id = p_business_owner_id;
    
    
    UPDATE software_products 
    SET software_name = p_software_name, 
        version = p_version, 
        description = p_description, 
        vendor_managed = p_vendor_managed, 
        vendor_name = p_vendor_name, 
        license_type = p_license_type,
        installation_notes = p_installation_notes,
        university_unit_id = v_university_unit_id,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_software_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    
    DELETE FROM software_roles WHERE software_id = p_software_id;
    
    INSERT INTO software_roles (software_id, business_owner_id, technical_owner_id, technical_manager_id) 
    VALUES (p_software_id, p_business_owner_id, p_technical_owner_id, p_technical_manager_id);
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_unit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_unit`(
    IN p_unit_id INT,
    IN p_unit_name VARCHAR(200),
    IN p_unit_code VARCHAR(50),
    IN p_description TEXT,
    IN p_parent_unit_id INT,
    IN p_unit_type VARCHAR(20),
    OUT p_rows_affected INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_rows_affected = 0;
    END;
    
    START TRANSACTION;
    
    UPDATE university_units 
    SET unit_name = p_unit_name, 
        unit_code = p_unit_code, 
        description = p_description, 
        parent_unit_id = p_parent_unit_id, 
        unit_type = p_unit_type,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_unit_id;
    
    SET p_rows_affected = ROW_COUNT();
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-11 23:44:34
