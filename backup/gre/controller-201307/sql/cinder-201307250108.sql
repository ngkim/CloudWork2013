-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: cinder
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.13.04.1

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
-- Table structure for table `backups`
--

DROP TABLE IF EXISTS `backups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backups` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `volume_id` varchar(36) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `container` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `fail_reason` varchar(255) DEFAULT NULL,
  `service_metadata` varchar(255) DEFAULT NULL,
  `service` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `object_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backups`
--

LOCK TABLES `backups` WRITE;
/*!40000 ALTER TABLE `backups` DISABLE KEYS */;
/*!40000 ALTER TABLE `backups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscsi_targets`
--

DROP TABLE IF EXISTS `iscsi_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iscsi_targets` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_num` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `volume_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volume_id` (`volume_id`),
  CONSTRAINT `iscsi_targets_ibfk_1` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscsi_targets`
--

LOCK TABLES `iscsi_targets` WRITE;
/*!40000 ALTER TABLE `iscsi_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `iscsi_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_version`
--

DROP TABLE IF EXISTS `migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` mediumtext,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_version`
--

LOCK TABLES `migrate_version` WRITE;
/*!40000 ALTER TABLE `migrate_version` DISABLE KEYS */;
INSERT INTO `migrate_version` VALUES ('cinder','/usr/lib/python2.7/dist-packages/cinder/db/sqlalchemy/migrate_repo',9);
/*!40000 ALTER TABLE `migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_compute` varchar(255) DEFAULT NULL,
  `dest_compute` varchar(255) DEFAULT NULL,
  `dest_host` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(255) DEFAULT NULL,
  `old_instance_type_id` int(11) DEFAULT NULL,
  `new_instance_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quota_classes`
--

DROP TABLE IF EXISTS `quota_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_classes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quota_classes_class_name` (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quota_classes`
--

LOCK TABLES `quota_classes` WRITE;
/*!40000 ALTER TABLE `quota_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quota_usages`
--

DROP TABLE IF EXISTS `quota_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_usages` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `in_use` int(11) NOT NULL,
  `reserved` int(11) NOT NULL,
  `until_refresh` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quota_usages_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quota_usages`
--

LOCK TABLES `quota_usages` WRITE;
/*!40000 ALTER TABLE `quota_usages` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotas`
--

DROP TABLE IF EXISTS `quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) NOT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotas`
--

LOCK TABLES `quotas` WRITE;
/*!40000 ALTER TABLE `quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservations` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `usage_id` int(11) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `delta` int(11) NOT NULL,
  `expire` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usage_id` (`usage_id`),
  KEY `ix_reservations_project_id` (`project_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`usage_id`) REFERENCES `quota_usages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `binary` varchar(255) DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `report_count` int(11) NOT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES ('2013-07-05 01:45:45','2013-07-24 04:55:08',NULL,0,1,'openstack1','cinder-scheduler','cinder-scheduler',164414,0,'nova');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_backend_config`
--

DROP TABLE IF EXISTS `sm_backend_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_backend_config` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flavor_id` int(11) NOT NULL,
  `sr_uuid` varchar(255) DEFAULT NULL,
  `sr_type` varchar(255) DEFAULT NULL,
  `config_params` varchar(2047) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flavor_id` (`flavor_id`),
  CONSTRAINT `sm_backend_config_ibfk_1` FOREIGN KEY (`flavor_id`) REFERENCES `sm_flavors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_backend_config`
--

LOCK TABLES `sm_backend_config` WRITE;
/*!40000 ALTER TABLE `sm_backend_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_backend_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_flavors`
--

DROP TABLE IF EXISTS `sm_flavors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_flavors` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_flavors`
--

LOCK TABLES `sm_flavors` WRITE;
/*!40000 ALTER TABLE `sm_flavors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_flavors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_volume`
--

DROP TABLE IF EXISTS `sm_volume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_volume` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `backend_id` int(11) NOT NULL,
  `vdi_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_id` (`backend_id`),
  CONSTRAINT `sm_volume_ibfk_1` FOREIGN KEY (`id`) REFERENCES `volumes` (`id`),
  CONSTRAINT `sm_volume_ibfk_2` FOREIGN KEY (`backend_id`) REFERENCES `sm_backend_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_volume`
--

LOCK TABLES `sm_volume` WRITE;
/*!40000 ALTER TABLE `sm_volume` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_volume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot_metadata`
--

DROP TABLE IF EXISTS `snapshot_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `snapshot_id` varchar(36) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `snapshot_id` (`snapshot_id`),
  CONSTRAINT `snapshot_metadata_ibfk_1` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_metadata`
--

LOCK TABLES `snapshot_metadata` WRITE;
/*!40000 ALTER TABLE `snapshot_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshots`
--

DROP TABLE IF EXISTS `snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshots` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `volume_id` varchar(36) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `progress` varchar(255) DEFAULT NULL,
  `volume_size` int(11) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `provider_location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `snapshots_volume_id_fkey` (`volume_id`),
  CONSTRAINT `snapshots_volume_id_fkey` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshots`
--

LOCK TABLES `snapshots` WRITE;
/*!40000 ALTER TABLE `snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_glance_metadata`
--

DROP TABLE IF EXISTS `volume_glance_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_glance_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `volume_id` varchar(36) DEFAULT NULL,
  `snapshot_id` varchar(36) DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  KEY `volume_id` (`volume_id`),
  KEY `snapshot_id` (`snapshot_id`),
  CONSTRAINT `volume_glance_metadata_ibfk_1` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`),
  CONSTRAINT `volume_glance_metadata_ibfk_2` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_glance_metadata`
--

LOCK TABLES `volume_glance_metadata` WRITE;
/*!40000 ALTER TABLE `volume_glance_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_glance_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_metadata`
--

DROP TABLE IF EXISTS `volume_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `volume_id` varchar(36) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volume_id` (`volume_id`),
  CONSTRAINT `volume_metadata_ibfk_1` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_metadata`
--

LOCK TABLES `volume_metadata` WRITE;
/*!40000 ALTER TABLE `volume_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_type_extra_specs`
--

DROP TABLE IF EXISTS `volume_type_extra_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_type_extra_specs` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `volume_type_id` varchar(36) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volume_type_extra_specs_ibfk_1` (`volume_type_id`),
  CONSTRAINT `volume_type_extra_specs_ibfk_1` FOREIGN KEY (`volume_type_id`) REFERENCES `volume_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_type_extra_specs`
--

LOCK TABLES `volume_type_extra_specs` WRITE;
/*!40000 ALTER TABLE `volume_type_extra_specs` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_type_extra_specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_types`
--

DROP TABLE IF EXISTS `volume_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_types` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_types`
--

LOCK TABLES `volume_types` WRITE;
/*!40000 ALTER TABLE `volume_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `ec2_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `mountpoint` varchar(255) DEFAULT NULL,
  `attach_time` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `attach_status` varchar(255) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `launched_at` datetime DEFAULT NULL,
  `terminated_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `provider_location` varchar(256) DEFAULT NULL,
  `provider_auth` varchar(256) DEFAULT NULL,
  `snapshot_id` varchar(36) DEFAULT NULL,
  `volume_type_id` varchar(36) DEFAULT NULL,
  `source_volid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-07-25  1:08:05
