-- phpMyAdmin SQL Dump

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE DATABASE IF NOT EXISTS `osama_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_danish_ci;

DROP USER 'osama'@'localhost';
CREATE USER 'osama'@'localhost' IDENTIFIED BY '4t6ZsSqZp5tceqKU';
GRANT ALL PRIVILEGES ON osama_db.* TO osama WITH GRANT OPTION; 

USE `osama_db`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8_danish_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_danish_ci DEFAULT NULL,
  `firstname` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `lastname` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_danish_ci DEFAULT NULL,
  `mail` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `title` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `lastLoginDatetime` datetime DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_user_idx PRIMARY KEY (id),
  CONSTRAINT udx_user_username UNIQUE KEY (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `description` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_service_idx PRIMARY KEY (id),
  CONSTRAINT udx_service_servicename UNIQUE KEY (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskUID` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `title` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `prerequisites` mediumtext COLLATE utf8_danish_ci,-- html description of the prerequisites
  `description` mediumtext COLLATE utf8_danish_ci,-- html description of the complete task
  `expectedDurationMinutes` int(11) NOT NULL, -- duration in minutes 
  `expectedDurationHours` int(11) NOT NULL,  -- duration in hours
  `service_id` int(11) DEFAULT NULL,
  `parentTask_id` int(11) DEFAULT NULL,
  `usergroup_id` int(11) DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_task_taskName` (`taskUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `description` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_service_idx PRIMARY KEY (id),
  CONSTRAINT udx_service_servicename UNIQUE KEY (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `taskSchedule`;
CREATE TABLE IF NOT EXISTS `taskSchedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `beginTask` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL, -- 'On Schedule', 'At Startup', 'At Log In', 'On Idle'
  `schedule` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL, -- 'Ad Hoc Only', 'Daily', 'Weekly', 'Monthly' -- must add ,'Quarterly', 'Once every half year', 'Once a year'
  `startDateTime` datetime DEFAULT NULL, 
  `recurEvery` int(11) DEFAULT NULL, -- daily = day interval, weeks = week interval
  `recurWeekdays` varchar(250) DEFAULT NULL,-- multiple select weekdays: mon, tue, wed, thur, fri, sat, sun 
  `recurMonths` varchar(500) DEFAULT NULL, --  multiple select months: 1,2,3,1 .. 11,12
  `recurMonthDays` varchar(500) DEFAULT NULL, -- multiple select dates: 1,2,3,4 .. 30,31 
  `recurMonthOndays` varchar(500) DEFAULT NULL, -- First, Second, Third, Fourth, Last - in addition to weekdays
  -- advanced setting only used to automate task with delay and repetition
  `delayTask` tinyint(4) NOT NULL DEFAULT '0',
  `delayTaskFor` int(11) DEFAULT NULL, -- integer representation of number of duration that the task should be delayed after triggered
  `delayTaskDuration` int(11) DEFAULT NULL, -- minutes, hours, days
  `repeatTask` tinyint(4) NOT NULL DEFAULT '0',
  `repeatTaskFor` int(11) DEFAULT NULL, -- integer representation of number of duration that the task should be delayed after triggered
  `repeatTaskDuration` int(11) DEFAULT NULL, -- minutes, hours, days
  -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  CONSTRAINT pk_taskschedule_idx PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `scheduledTask`;
CREATE TABLE IF NOT EXISTS `scheduledTask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `startDateTime` datetime DEFAULT NULL, 
  `expireDateTime` datetime DEFAULT NULL, 
  -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  CONSTRAINT pk_scheduledtask_idx PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `usergroup`;
CREATE TABLE IF NOT EXISTS `usergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `description` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_usergroup_idx PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `membership`;
CREATE TABLE IF NOT EXISTS `membership` (
  `usergroup_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `exppireDatetime` datetime DEFAULT NULL, -- if the pooling depends on a certification that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_membership_idx PRIMARY KEY (`usergroup_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `serviceusergroup`;
CREATE TABLE IF NOT EXISTS `serviceusergroup` (
  `usergroup_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `exppireDatetime` datetime DEFAULT NULL, -- if the pooling depends on a certification that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_serviceusergroup_idx PRIMARY KEY (`usergroup_id`,`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;


DROP TABLE IF EXISTS `taskfeedback`;
CREATE TABLE IF NOT EXISTS `taskfeedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `status` varchar(40) COLLATE utf8_danish_ci DEFAULT NULL,  -- completed, cancelled, expired, rescheduled,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `durationMinutes` int(11) NOT NULL, -- duration in minutes 
  `durationHours` int(11) NOT NULL, -- duration in hours
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `expireDatetime` datetime DEFAULT NULL, -- if the pooling depends on a certification that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_taskfeedback_idx PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;


DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role` varchar(40) COLLATE utf8_danish_ci DEFAULT NULL,  -- completed, cancelled, expired, rescheduled,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_role_idx PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `userRole`;
CREATE TABLE IF NOT EXISTS `userRole` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
   -- standard revision fields
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `exppireDatetime` datetime DEFAULT NULL, -- if the role depends on a permit that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_humanRole_idx PRIMARY KEY (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;









--
-- Initail data for tables
--

INSERT INTO `user` (`id`, `username`, `password`, `firstname`, `lastname`, `phone`, `mail`, `title`, `lastLoginDatetime`, `createdBy`, `createdDatetime`, `updatedBy`, `updatedDatetime`, `retired`) VALUES
(1, 'kimort', '897c8fde25c5cc5270cda61425eed3c8', 'Kim', 'Ortvald', '30590366', 'kimort@govcert.dk', 'K-CNS901', NULL, NULL, NULL, 0, '2015-05-29 08:02:00', 0), --qwerty
(2, 'torjuu', '897c8fde25c5cc5270cda61425eed3c8', 'Torsten', 'Juul-Jensen', '21661518', 'torjuu@govcert.dk', 'CNS05', NULL, NULL, NULL, 0, '2015-05-29 08:04:00', 0), -- qwerty
(3, 'alewan', '897c8fde25c5cc5270cda61425eed3c8', 'Alexander', 'Wang', '30354199', 'alewan@govcert.dk', 'CNS06', NULL, NULL, NULL, 0, '2015-05-29 08:03:00', 0); -- qwerty


INSERT INTO `service` (`id`, `name`, `description`, `owner`, `createdBy`, `createdDatetime`, `updatedBy`, `updatedDatetime`, `retired`) VALUES
(1, 'LDAP', 'ldap på ubuntu 12.04', 2, NULL, NULL, 0, '2015-05-29 06:37:00', 0),
(2, 'Mail', 'DoveCUT og Possix på Ubuntu 12.04', 2, NULL, NULL, 0, '2015-06-24 12:19:00', 0),
(3, 'Print Services', 'CUps på Ubuntu 12.04', 2, NULL, NULL, 0, '2015-06-24 12:19:00', 0),
(4, 'intranet', 'Apache2, php5, Mysql 5.2 på Ubuntu 12.04', 2, NULL, NULL, 0, '2015-06-24 12:19:00', 0);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


