-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: quantum
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agents` (
  `id` varchar(36) NOT NULL,
  `agent_type` varchar(255) NOT NULL,
  `binary` varchar(255) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `started_at` datetime NOT NULL,
  `heartbeat_timestamp` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `configurations` varchar(4095) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
INSERT INTO `agents` VALUES ('440c1a39-7925-4126-bd7f-1afe5d186d61','L3 agent','quantum-l3-agent','l3_agent','tst-goss6.tst-goss6',1,'2013-05-06 18:10:47','2013-05-08 01:45:23','2013-05-08 04:54:57',NULL,'{\"router_id\": \"\", \"gateway_external_network_id\": \"\", \"handle_internal_only_routers\": true, \"use_namespaces\": true, \"routers\": 0, \"interfaces\": 0, \"floating_ips\": 0, \"interface_driver\": \"quantum.agent.linux.interface.OVSInterfaceDriver\", \"ex_gw_ports\": 0}'),('66ff3ffa-74ec-4fff-adf1-0ce2d3c371fe','Open vSwitch agent','quantum-openvswitch-agent','N/A','tst-goss7',1,'2013-05-07 01:18:07','2013-05-07 07:49:49','2013-05-08 04:55:00',NULL,'{\"devices\": 0}'),('ec88990c-a5dc-4768-a89e-51b03f09afb1','DHCP agent','quantum-dhcp-agent','dhcp_agent','tst-goss6.tst-goss6',1,'2013-05-06 18:10:46','2013-05-08 01:45:23','2013-05-08 04:55:01',NULL,'{\"subnets\": 0, \"use_namespaces\": false, \"dhcp_driver\": \"quantum.agent.linux.dhcp.Dnsmasq\", \"networks\": 0, \"dhcp_lease_time\": 120, \"ports\": 0}'),('f1c79e59-f68d-465c-9030-6fa366e02639','Open vSwitch agent','quantum-openvswitch-agent','N/A','tst-goss6.tst-goss6',1,'2013-05-06 18:15:29','2013-05-08 01:45:25','2013-05-08 04:55:00',NULL,'{\"devices\": 3}');
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dnsnameservers`
--

DROP TABLE IF EXISTS `dnsnameservers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dnsnameservers` (
  `address` varchar(128) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  PRIMARY KEY (`address`,`subnet_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `dnsnameservers_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dnsnameservers`
--

LOCK TABLES `dnsnameservers` WRITE;
/*!40000 ALTER TABLE `dnsnameservers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dnsnameservers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externalnetworks`
--

DROP TABLE IF EXISTS `externalnetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externalnetworks` (
  `network_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `externalnetworks_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `externalnetworks`
--

LOCK TABLES `externalnetworks` WRITE;
/*!40000 ALTER TABLE `externalnetworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `externalnetworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floatingips`
--

DROP TABLE IF EXISTS `floatingips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floatingips` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `floating_ip_address` varchar(64) NOT NULL,
  `floating_network_id` varchar(36) NOT NULL,
  `floating_port_id` varchar(36) NOT NULL,
  `fixed_port_id` varchar(36) DEFAULT NULL,
  `fixed_ip_address` varchar(64) DEFAULT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `floating_port_id` (`floating_port_id`),
  KEY `fixed_port_id` (`fixed_port_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `floatingips_ibfk_1` FOREIGN KEY (`floating_port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `floatingips_ibfk_2` FOREIGN KEY (`fixed_port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `floatingips_ibfk_3` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floatingips`
--

LOCK TABLES `floatingips` WRITE;
/*!40000 ALTER TABLE `floatingips` DISABLE KEYS */;
/*!40000 ALTER TABLE `floatingips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipallocationpools`
--

DROP TABLE IF EXISTS `ipallocationpools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipallocationpools` (
  `id` varchar(36) NOT NULL,
  `subnet_id` varchar(36) DEFAULT NULL,
  `first_ip` varchar(64) NOT NULL,
  `last_ip` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `ipallocationpools_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipallocationpools`
--

LOCK TABLES `ipallocationpools` WRITE;
/*!40000 ALTER TABLE `ipallocationpools` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipallocationpools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipallocations`
--

DROP TABLE IF EXISTS `ipallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipallocations` (
  `port_id` varchar(36) DEFAULT NULL,
  `ip_address` varchar(64) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`ip_address`,`subnet_id`,`network_id`),
  KEY `port_id` (`port_id`),
  KEY `subnet_id` (`subnet_id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `ipallocations_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipallocations_ibfk_2` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipallocations_ibfk_3` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipallocations`
--

LOCK TABLES `ipallocations` WRITE;
/*!40000 ALTER TABLE `ipallocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipallocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipavailabilityranges`
--

DROP TABLE IF EXISTS `ipavailabilityranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipavailabilityranges` (
  `allocation_pool_id` varchar(36) NOT NULL,
  `first_ip` varchar(64) NOT NULL,
  `last_ip` varchar(64) NOT NULL,
  PRIMARY KEY (`allocation_pool_id`,`first_ip`,`last_ip`),
  CONSTRAINT `ipavailabilityranges_ibfk_1` FOREIGN KEY (`allocation_pool_id`) REFERENCES `ipallocationpools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipavailabilityranges`
--

LOCK TABLES `ipavailabilityranges` WRITE;
/*!40000 ALTER TABLE `ipavailabilityranges` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipavailabilityranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkdhcpagentbindings`
--

DROP TABLE IF EXISTS `networkdhcpagentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkdhcpagentbindings` (
  `network_id` varchar(36) NOT NULL,
  `dhcp_agent_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`,`dhcp_agent_id`),
  KEY `dhcp_agent_id` (`dhcp_agent_id`),
  CONSTRAINT `networkdhcpagentbindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networkdhcpagentbindings_ibfk_2` FOREIGN KEY (`dhcp_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkdhcpagentbindings`
--

LOCK TABLES `networkdhcpagentbindings` WRITE;
/*!40000 ALTER TABLE `networkdhcpagentbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkdhcpagentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_network_bindings`
--

DROP TABLE IF EXISTS `ovs_network_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_network_bindings` (
  `network_id` varchar(36) NOT NULL,
  `network_type` varchar(32) NOT NULL,
  `physical_network` varchar(64) DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `ovs_network_bindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_network_bindings`
--

LOCK TABLES `ovs_network_bindings` WRITE;
/*!40000 ALTER TABLE `ovs_network_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ovs_network_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_tunnel_allocations`
--

DROP TABLE IF EXISTS `ovs_tunnel_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_tunnel_allocations` (
  `tunnel_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  PRIMARY KEY (`tunnel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_tunnel_allocations`
--

LOCK TABLES `ovs_tunnel_allocations` WRITE;
/*!40000 ALTER TABLE `ovs_tunnel_allocations` DISABLE KEYS */;
INSERT INTO `ovs_tunnel_allocations` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0),(31,0),(32,0),(33,0),(34,0),(35,0),(36,0),(37,0),(38,0),(39,0),(40,0),(41,0),(42,0),(43,0),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0),(50,0),(51,0),(52,0),(53,0),(54,0),(55,0),(56,0),(57,0),(58,0),(59,0),(60,0),(61,0),(62,0),(63,0),(64,0),(65,0),(66,0),(67,0),(68,0),(69,0),(70,0),(71,0),(72,0),(73,0),(74,0),(75,0),(76,0),(77,0),(78,0),(79,0),(80,0),(81,0),(82,0),(83,0),(84,0),(85,0),(86,0),(87,0),(88,0),(89,0),(90,0),(91,0),(92,0),(93,0),(94,0),(95,0),(96,0),(97,0),(98,0),(99,0),(100,0),(101,0),(102,0),(103,0),(104,0),(105,0),(106,0),(107,0),(108,0),(109,0),(110,0),(111,0),(112,0),(113,0),(114,0),(115,0),(116,0),(117,0),(118,0),(119,0),(120,0),(121,0),(122,0),(123,0),(124,0),(125,0),(126,0),(127,0),(128,0),(129,0),(130,0),(131,0),(132,0),(133,0),(134,0),(135,0),(136,0),(137,0),(138,0),(139,0),(140,0),(141,0),(142,0),(143,0),(144,0),(145,0),(146,0),(147,0),(148,0),(149,0),(150,0),(151,0),(152,0),(153,0),(154,0),(155,0),(156,0),(157,0),(158,0),(159,0),(160,0),(161,0),(162,0),(163,0),(164,0),(165,0),(166,0),(167,0),(168,0),(169,0),(170,0),(171,0),(172,0),(173,0),(174,0),(175,0),(176,0),(177,0),(178,0),(179,0),(180,0),(181,0),(182,0),(183,0),(184,0),(185,0),(186,0),(187,0),(188,0),(189,0),(190,0),(191,0),(192,0),(193,0),(194,0),(195,0),(196,0),(197,0),(198,0),(199,0),(200,0),(201,0),(202,0),(203,0),(204,0),(205,0),(206,0),(207,0),(208,0),(209,0),(210,0),(211,0),(212,0),(213,0),(214,0),(215,0),(216,0),(217,0),(218,0),(219,0),(220,0),(221,0),(222,0),(223,0),(224,0),(225,0),(226,0),(227,0),(228,0),(229,0),(230,0),(231,0),(232,0),(233,0),(234,0),(235,0),(236,0),(237,0),(238,0),(239,0),(240,0),(241,0),(242,0),(243,0),(244,0),(245,0),(246,0),(247,0),(248,0),(249,0),(250,0),(251,0),(252,0),(253,0),(254,0),(255,0),(256,0),(257,0),(258,0),(259,0),(260,0),(261,0),(262,0),(263,0),(264,0),(265,0),(266,0),(267,0),(268,0),(269,0),(270,0),(271,0),(272,0),(273,0),(274,0),(275,0),(276,0),(277,0),(278,0),(279,0),(280,0),(281,0),(282,0),(283,0),(284,0),(285,0),(286,0),(287,0),(288,0),(289,0),(290,0),(291,0),(292,0),(293,0),(294,0),(295,0),(296,0),(297,0),(298,0),(299,0),(300,0),(301,0),(302,0),(303,0),(304,0),(305,0),(306,0),(307,0),(308,0),(309,0),(310,0),(311,0),(312,0),(313,0),(314,0),(315,0),(316,0),(317,0),(318,0),(319,0),(320,0),(321,0),(322,0),(323,0),(324,0),(325,0),(326,0),(327,0),(328,0),(329,0),(330,0),(331,0),(332,0),(333,0),(334,0),(335,0),(336,0),(337,0),(338,0),(339,0),(340,0),(341,0),(342,0),(343,0),(344,0),(345,0),(346,0),(347,0),(348,0),(349,0),(350,0),(351,0),(352,0),(353,0),(354,0),(355,0),(356,0),(357,0),(358,0),(359,0),(360,0),(361,0),(362,0),(363,0),(364,0),(365,0),(366,0),(367,0),(368,0),(369,0),(370,0),(371,0),(372,0),(373,0),(374,0),(375,0),(376,0),(377,0),(378,0),(379,0),(380,0),(381,0),(382,0),(383,0),(384,0),(385,0),(386,0),(387,0),(388,0),(389,0),(390,0),(391,0),(392,0),(393,0),(394,0),(395,0),(396,0),(397,0),(398,0),(399,0),(400,0),(401,0),(402,0),(403,0),(404,0),(405,0),(406,0),(407,0),(408,0),(409,0),(410,0),(411,0),(412,0),(413,0),(414,0),(415,0),(416,0),(417,0),(418,0),(419,0),(420,0),(421,0),(422,0),(423,0),(424,0),(425,0),(426,0),(427,0),(428,0),(429,0),(430,0),(431,0),(432,0),(433,0),(434,0),(435,0),(436,0),(437,0),(438,0),(439,0),(440,0),(441,0),(442,0),(443,0),(444,0),(445,0),(446,0),(447,0),(448,0),(449,0),(450,0),(451,0),(452,0),(453,0),(454,0),(455,0),(456,0),(457,0),(458,0),(459,0),(460,0),(461,0),(462,0),(463,0),(464,0),(465,0),(466,0),(467,0),(468,0),(469,0),(470,0),(471,0),(472,0),(473,0),(474,0),(475,0),(476,0),(477,0),(478,0),(479,0),(480,0),(481,0),(482,0),(483,0),(484,0),(485,0),(486,0),(487,0),(488,0),(489,0),(490,0),(491,0),(492,0),(493,0),(494,0),(495,0),(496,0),(497,0),(498,0),(499,0),(500,0),(501,0),(502,0),(503,0),(504,0),(505,0),(506,0),(507,0),(508,0),(509,0),(510,0),(511,0),(512,0),(513,0),(514,0),(515,0),(516,0),(517,0),(518,0),(519,0),(520,0),(521,0),(522,0),(523,0),(524,0),(525,0),(526,0),(527,0),(528,0),(529,0),(530,0),(531,0),(532,0),(533,0),(534,0),(535,0),(536,0),(537,0),(538,0),(539,0),(540,0),(541,0),(542,0),(543,0),(544,0),(545,0),(546,0),(547,0),(548,0),(549,0),(550,0),(551,0),(552,0),(553,0),(554,0),(555,0),(556,0),(557,0),(558,0),(559,0),(560,0),(561,0),(562,0),(563,0),(564,0),(565,0),(566,0),(567,0),(568,0),(569,0),(570,0),(571,0),(572,0),(573,0),(574,0),(575,0),(576,0),(577,0),(578,0),(579,0),(580,0),(581,0),(582,0),(583,0),(584,0),(585,0),(586,0),(587,0),(588,0),(589,0),(590,0),(591,0),(592,0),(593,0),(594,0),(595,0),(596,0),(597,0),(598,0),(599,0),(600,0),(601,0),(602,0),(603,0),(604,0),(605,0),(606,0),(607,0),(608,0),(609,0),(610,0),(611,0),(612,0),(613,0),(614,0),(615,0),(616,0),(617,0),(618,0),(619,0),(620,0),(621,0),(622,0),(623,0),(624,0),(625,0),(626,0),(627,0),(628,0),(629,0),(630,0),(631,0),(632,0),(633,0),(634,0),(635,0),(636,0),(637,0),(638,0),(639,0),(640,0),(641,0),(642,0),(643,0),(644,0),(645,0),(646,0),(647,0),(648,0),(649,0),(650,0),(651,0),(652,0),(653,0),(654,0),(655,0),(656,0),(657,0),(658,0),(659,0),(660,0),(661,0),(662,0),(663,0),(664,0),(665,0),(666,0),(667,0),(668,0),(669,0),(670,0),(671,0),(672,0),(673,0),(674,0),(675,0),(676,0),(677,0),(678,0),(679,0),(680,0),(681,0),(682,0),(683,0),(684,0),(685,0),(686,0),(687,0),(688,0),(689,0),(690,0),(691,0),(692,0),(693,0),(694,0),(695,0),(696,0),(697,0),(698,0),(699,0),(700,0),(701,0),(702,0),(703,0),(704,0),(705,0),(706,0),(707,0),(708,0),(709,0),(710,0),(711,0),(712,0),(713,0),(714,0),(715,0),(716,0),(717,0),(718,0),(719,0),(720,0),(721,0),(722,0),(723,0),(724,0),(725,0),(726,0),(727,0),(728,0),(729,0),(730,0),(731,0),(732,0),(733,0),(734,0),(735,0),(736,0),(737,0),(738,0),(739,0),(740,0),(741,0),(742,0),(743,0),(744,0),(745,0),(746,0),(747,0),(748,0),(749,0),(750,0),(751,0),(752,0),(753,0),(754,0),(755,0),(756,0),(757,0),(758,0),(759,0),(760,0),(761,0),(762,0),(763,0),(764,0),(765,0),(766,0),(767,0),(768,0),(769,0),(770,0),(771,0),(772,0),(773,0),(774,0),(775,0),(776,0),(777,0),(778,0),(779,0),(780,0),(781,0),(782,0),(783,0),(784,0),(785,0),(786,0),(787,0),(788,0),(789,0),(790,0),(791,0),(792,0),(793,0),(794,0),(795,0),(796,0),(797,0),(798,0),(799,0),(800,0),(801,0),(802,0),(803,0),(804,0),(805,0),(806,0),(807,0),(808,0),(809,0),(810,0),(811,0),(812,0),(813,0),(814,0),(815,0),(816,0),(817,0),(818,0),(819,0),(820,0),(821,0),(822,0),(823,0),(824,0),(825,0),(826,0),(827,0),(828,0),(829,0),(830,0),(831,0),(832,0),(833,0),(834,0),(835,0),(836,0),(837,0),(838,0),(839,0),(840,0),(841,0),(842,0),(843,0),(844,0),(845,0),(846,0),(847,0),(848,0),(849,0),(850,0),(851,0),(852,0),(853,0),(854,0),(855,0),(856,0),(857,0),(858,0),(859,0),(860,0),(861,0),(862,0),(863,0),(864,0),(865,0),(866,0),(867,0),(868,0),(869,0),(870,0),(871,0),(872,0),(873,0),(874,0),(875,0),(876,0),(877,0),(878,0),(879,0),(880,0),(881,0),(882,0),(883,0),(884,0),(885,0),(886,0),(887,0),(888,0),(889,0),(890,0),(891,0),(892,0),(893,0),(894,0),(895,0),(896,0),(897,0),(898,0),(899,0),(900,0),(901,0),(902,0),(903,0),(904,0),(905,0),(906,0),(907,0),(908,0),(909,0),(910,0),(911,0),(912,0),(913,0),(914,0),(915,0),(916,0),(917,0),(918,0),(919,0),(920,0),(921,0),(922,0),(923,0),(924,0),(925,0),(926,0),(927,0),(928,0),(929,0),(930,0),(931,0),(932,0),(933,0),(934,0),(935,0),(936,0),(937,0),(938,0),(939,0),(940,0),(941,0),(942,0),(943,0),(944,0),(945,0),(946,0),(947,0),(948,0),(949,0),(950,0),(951,0),(952,0),(953,0),(954,0),(955,0),(956,0),(957,0),(958,0),(959,0),(960,0),(961,0),(962,0),(963,0),(964,0),(965,0),(966,0),(967,0),(968,0),(969,0),(970,0),(971,0),(972,0),(973,0),(974,0),(975,0),(976,0),(977,0),(978,0),(979,0),(980,0),(981,0),(982,0),(983,0),(984,0),(985,0),(986,0),(987,0),(988,0),(989,0),(990,0),(991,0),(992,0),(993,0),(994,0),(995,0),(996,0),(997,0),(998,0),(999,0),(1000,0);
/*!40000 ALTER TABLE `ovs_tunnel_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_tunnel_endpoints`
--

DROP TABLE IF EXISTS `ovs_tunnel_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_tunnel_endpoints` (
  `ip_address` varchar(64) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_tunnel_endpoints`
--

LOCK TABLES `ovs_tunnel_endpoints` WRITE;
/*!40000 ALTER TABLE `ovs_tunnel_endpoints` DISABLE KEYS */;
INSERT INTO `ovs_tunnel_endpoints` VALUES ('10.20.20.51',2),('10.20.20.52',1);
/*!40000 ALTER TABLE `ovs_tunnel_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_tunnel_ips`
--

DROP TABLE IF EXISTS `ovs_tunnel_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_tunnel_ips` (
  `ip_address` varchar(255) NOT NULL,
  PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_tunnel_ips`
--

LOCK TABLES `ovs_tunnel_ips` WRITE;
/*!40000 ALTER TABLE `ovs_tunnel_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `ovs_tunnel_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovs_vlan_allocations`
--

DROP TABLE IF EXISTS `ovs_vlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ovs_vlan_allocations` (
  `physical_network` varchar(64) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  PRIMARY KEY (`physical_network`,`vlan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovs_vlan_allocations`
--

LOCK TABLES `ovs_vlan_allocations` WRITE;
/*!40000 ALTER TABLE `ovs_vlan_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ovs_vlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ports`
--

DROP TABLE IF EXISTS `ports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ports` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `network_id` varchar(36) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `status` varchar(16) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `device_owner` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `ports_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ports`
--

LOCK TABLES `ports` WRITE;
/*!40000 ALTER TABLE `ports` DISABLE KEYS */;
/*!40000 ALTER TABLE `ports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotas`
--

DROP TABLE IF EXISTS `quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotas` (
  `id` varchar(36) NOT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quotas_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotas`
--

LOCK TABLES `quotas` WRITE;
/*!40000 ALTER TABLE `quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerl3agentbindings`
--

DROP TABLE IF EXISTS `routerl3agentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerl3agentbindings` (
  `id` varchar(36) NOT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  `l3_agent_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `router_id` (`router_id`),
  KEY `l3_agent_id` (`l3_agent_id`),
  CONSTRAINT `routerl3agentbindings_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `routerl3agentbindings_ibfk_2` FOREIGN KEY (`l3_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerl3agentbindings`
--

LOCK TABLES `routerl3agentbindings` WRITE;
/*!40000 ALTER TABLE `routerl3agentbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `routerl3agentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerroutes`
--

DROP TABLE IF EXISTS `routerroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerroutes` (
  `destination` varchar(64) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  PRIMARY KEY (`destination`,`nexthop`,`router_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `routerroutes_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerroutes`
--

LOCK TABLES `routerroutes` WRITE;
/*!40000 ALTER TABLE `routerroutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `routerroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routers`
--

DROP TABLE IF EXISTS `routers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routers` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `gw_port_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gw_port_id` (`gw_port_id`),
  CONSTRAINT `routers_ibfk_1` FOREIGN KEY (`gw_port_id`) REFERENCES `ports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routers`
--

LOCK TABLES `routers` WRITE;
/*!40000 ALTER TABLE `routers` DISABLE KEYS */;
/*!40000 ALTER TABLE `routers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroupportbindings`
--

DROP TABLE IF EXISTS `securitygroupportbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroupportbindings` (
  `port_id` varchar(36) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  PRIMARY KEY (`port_id`,`security_group_id`),
  KEY `security_group_id` (`security_group_id`),
  CONSTRAINT `securitygroupportbindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygroupportbindings_ibfk_2` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroupportbindings`
--

LOCK TABLES `securitygroupportbindings` WRITE;
/*!40000 ALTER TABLE `securitygroupportbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroupportbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygrouprules`
--

DROP TABLE IF EXISTS `securitygrouprules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygrouprules` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  `remote_group_id` varchar(36) DEFAULT NULL,
  `direction` enum('ingress','egress') DEFAULT NULL,
  `ethertype` varchar(40) DEFAULT NULL,
  `protocol` varchar(40) DEFAULT NULL,
  `port_range_min` int(11) DEFAULT NULL,
  `port_range_max` int(11) DEFAULT NULL,
  `remote_ip_prefix` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `security_group_id` (`security_group_id`),
  KEY `remote_group_id` (`remote_group_id`),
  CONSTRAINT `securitygrouprules_ibfk_1` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygrouprules_ibfk_2` FOREIGN KEY (`remote_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygrouprules`
--

LOCK TABLES `securitygrouprules` WRITE;
/*!40000 ALTER TABLE `securitygrouprules` DISABLE KEYS */;
INSERT INTO `securitygrouprules` VALUES ('702869ee0f86421583c663008ac5f9c5','28109a0d-faf8-4166-b4eb-e8e2103f5bb9','8096927e-a97e-49eb-8b92-f114e28eca8b',NULL,'egress','IPv4',NULL,NULL,NULL,NULL),('ba8c14da70cb4204ba8ac3bca6f7e8b9','291b6e09-1e64-44b1-87ac-c9cdb62fa73c','0385e4a8-7300-4525-b4d6-b6d393b8951e','0385e4a8-7300-4525-b4d6-b6d393b8951e','ingress','IPv6',NULL,NULL,NULL,NULL),('user_one@domain.com','298ee289-a53d-49e9-af9f-72bf3fb95df1','cafc15d9-acfd-49cc-9e97-7a849bb6e826','cafc15d9-acfd-49cc-9e97-7a849bb6e826','ingress','IPv6',NULL,NULL,NULL,NULL),('id','2c2f54d8-5229-4df4-8ae3-ea52bf748c15','29cbf529-06c6-423c-9a15-9a129aa62131','29cbf529-06c6-423c-9a15-9a129aa62131','ingress','IPv6',NULL,NULL,NULL,NULL),('ba8c14da70cb4204ba8ac3bca6f7e8b9','2f017922-e0ca-46e5-a471-ae7df91274b2','0385e4a8-7300-4525-b4d6-b6d393b8951e','0385e4a8-7300-4525-b4d6-b6d393b8951e','ingress','IPv4',NULL,NULL,NULL,NULL),('id','30a13748-5b48-487a-a465-f343784989ff','29cbf529-06c6-423c-9a15-9a129aa62131','29cbf529-06c6-423c-9a15-9a129aa62131','ingress','IPv4',NULL,NULL,NULL,NULL),('user_one@domain.com','325ae378-a4aa-49e1-9b99-51e327874e4c','cafc15d9-acfd-49cc-9e97-7a849bb6e826','cafc15d9-acfd-49cc-9e97-7a849bb6e826','ingress','IPv4',NULL,NULL,NULL,NULL),('id','53209f28-2cf0-461b-9d5b-17578135d43e','29cbf529-06c6-423c-9a15-9a129aa62131',NULL,'egress','IPv6',NULL,NULL,NULL,NULL),('702869ee0f86421583c663008ac5f9c5','7027a2c9-a62b-4369-ae2a-0a6375985d83','8096927e-a97e-49eb-8b92-f114e28eca8b',NULL,'egress','IPv6',NULL,NULL,NULL,NULL),('702869ee0f86421583c663008ac5f9c5','9c69be07-d959-4ff5-955b-ef408294267b','8096927e-a97e-49eb-8b92-f114e28eca8b','8096927e-a97e-49eb-8b92-f114e28eca8b','ingress','IPv4',NULL,NULL,NULL,NULL),('user_one@domain.com','d52c8bb0-322f-4394-b596-1fdca3c1ea31','cafc15d9-acfd-49cc-9e97-7a849bb6e826',NULL,'egress','IPv6',NULL,NULL,NULL,NULL),('user_one@domain.com','dbb834a3-d763-433a-a962-65b9940baf1d','cafc15d9-acfd-49cc-9e97-7a849bb6e826',NULL,'egress','IPv4',NULL,NULL,NULL,NULL),('702869ee0f86421583c663008ac5f9c5','dda45e79-3ec3-406c-9eeb-c4c5635dfb93','8096927e-a97e-49eb-8b92-f114e28eca8b','8096927e-a97e-49eb-8b92-f114e28eca8b','ingress','IPv6',NULL,NULL,NULL,NULL),('id','dee7da70-104f-4e03-9e3e-81bcb6ff2ac7','29cbf529-06c6-423c-9a15-9a129aa62131',NULL,'egress','IPv4',NULL,NULL,NULL,NULL),('ba8c14da70cb4204ba8ac3bca6f7e8b9','edd5089d-fe85-4e16-9f55-596fb0d34e26','0385e4a8-7300-4525-b4d6-b6d393b8951e',NULL,'egress','IPv4',NULL,NULL,NULL,NULL),('ba8c14da70cb4204ba8ac3bca6f7e8b9','fe61c99b-0fca-4450-a39f-092b915fee07','0385e4a8-7300-4525-b4d6-b6d393b8951e',NULL,'egress','IPv6',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `securitygrouprules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups`
--

DROP TABLE IF EXISTS `securitygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroups` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups`
--

LOCK TABLES `securitygroups` WRITE;
/*!40000 ALTER TABLE `securitygroups` DISABLE KEYS */;
INSERT INTO `securitygroups` VALUES ('ba8c14da70cb4204ba8ac3bca6f7e8b9','0385e4a8-7300-4525-b4d6-b6d393b8951e','default','default'),('id','29cbf529-06c6-423c-9a15-9a129aa62131','default','default'),('702869ee0f86421583c663008ac5f9c5','8096927e-a97e-49eb-8b92-f114e28eca8b','default','default'),('user_one@domain.com','cafc15d9-acfd-49cc-9e97-7a849bb6e826','default','default');
/*!40000 ALTER TABLE `securitygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnetroutes`
--

DROP TABLE IF EXISTS `subnetroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnetroutes` (
  `destination` varchar(64) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  PRIMARY KEY (`destination`,`nexthop`,`subnet_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `subnetroutes_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnetroutes`
--

LOCK TABLES `subnetroutes` WRITE;
/*!40000 ALTER TABLE `subnetroutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnetroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnets`
--

DROP TABLE IF EXISTS `subnets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnets` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  `ip_version` int(11) NOT NULL,
  `cidr` varchar(64) NOT NULL,
  `gateway_ip` varchar(64) DEFAULT NULL,
  `enable_dhcp` tinyint(1) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `subnets_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnets`
--

LOCK TABLES `subnets` WRITE;
/*!40000 ALTER TABLE `subnets` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-08 13:55:01
