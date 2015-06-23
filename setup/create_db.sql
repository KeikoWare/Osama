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

DROP TABLE IF EXISTS `humanRessource`;
CREATE TABLE IF NOT EXISTS `humanRessource` (
  `id` int(11) NOT NULL,
  `username` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `firstname` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `lastname` varchar(250) COLLATE utf8_danish_ci DEFAULT NULL,
  `userLastLoginDatetime` datetime DEFAULT NULL,
  `userCreatedDatetime` datetime DEFAULT NULL,
  `userUpdatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_humanRessource_idx PRIMARY KEY (id),
  CONSTRAINT udx_humanRessource_username UNIQUE KEY (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL,
  `serviceName` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `serviceDescription` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `serviceOwner` int(11) DEFAULT NULL,
  `serviceCreatedDatetime` datetime DEFAULT NULL,
  `serviceUpdatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_service_idx PRIMARY KEY (id),
  CONSTRAINT udx_service_servicename UNIQUE KEY (`serviceName`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL,
  `taskUID` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `taskName` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `taskDescription` varchar(40000) COLLATE utf8_danish_ci DEFAULT NULL, -- html description of the complete task
  `expectedDurationMinutes` int(11) NOT NULL, -- duration in minutes 
  `expectedDurationHours` int(11) NOT NULL, -- duration in hours
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `service_id` int(11) NULL,
  `parentTask_id` int(11) NULL,
  `ressourcepool_id` int(11) NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_task_idx PRIMARY KEY (id),
  CONSTRAINT udx_task_taskName UNIQUE KEY (`taskUID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) NOT NULL,
  `serviceName` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `serviceDescription` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `serviceOwner` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_service_idx PRIMARY KEY (id),
  CONSTRAINT udx_service_servicename UNIQUE KEY (`serviceName`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `taskSchedule`;
CREATE TABLE IF NOT EXISTS `taskSchedule` (
  `id` int(11) NOT NULL,
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

  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  CONSTRAINT pk_taskschedule_idx PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;


DROP TABLE IF EXISTS `scheduledTask`;
CREATE TABLE IF NOT EXISTS `scheduledTask` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `startDateTime` datetime DEFAULT NULL, 
  `expireDateTime` datetime DEFAULT NULL, 
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  CONSTRAINT pk_scheduledtask_idx PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `ressourcePool`;
CREATE TABLE IF NOT EXISTS `ressourcePool` (
  `id` int(11) NOT NULL,
  `ressourcePoolName` varchar(250) COLLATE utf8_danish_ci NOT NULL,
  `ressourcePoolDescription` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `ressourcePoolOwner` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_ressourcepool_idx PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `humanPooling`;
CREATE TABLE IF NOT EXISTS `humanPooling` (
  `ressourcePool_id` int(11) NOT NULL,
  `humanRessource_id` int(11) NOT NULL,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `exppireDatetime` datetime DEFAULT NULL, -- if the pooling depends on a certification that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_humanPooling_idx PRIMARY KEY (`ressourcePool_id`,`humanRessource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `servicePooling`;
CREATE TABLE IF NOT EXISTS `servicePooling` (
  `ressourcePool_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `exppireDatetime` datetime DEFAULT NULL, -- if the pooling depends on a certification that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_servicePooling_idx PRIMARY KEY (`ressourcePool_id`,`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;


DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int(11) NOT NULL,
  `humanRessource_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `status` varchar(40) COLLATE utf8_danish_ci DEFAULT NULL,  -- completed, cancelled, expired, rescheduled,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `durationMinutes` int(11) NOT NULL, -- duration in minutes 
  `durationHours` int(11) NOT NULL, -- duration in hours
  `createdDatetime` datetime DEFAULT NULL,
  CONSTRAINT pk_feedback_idx PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;


DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL,
  `humanRessource_id` int(11) NOT NULL,
  `role` varchar(40) COLLATE utf8_danish_ci DEFAULT NULL,  -- completed, cancelled, expired, rescheduled,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_role_idx PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

DROP TABLE IF EXISTS `humanRole`;
CREATE TABLE IF NOT EXISTS `humanRole` (
  `role_id` int(11) NOT NULL,
  `humanRessource_id` int(11) NOT NULL,
  `note` varchar(4000) COLLATE utf8_danish_ci DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdDatetime` datetime DEFAULT NULL,
  `exppireDatetime` datetime DEFAULT NULL, -- if the role depends on a permit that runs out, this date is set.
  `updatedBy` int(11) DEFAULT NULL,
  `updatedDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  CONSTRAINT pk_humanRole_idx PRIMARY KEY (`role_id`,`humanRessource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


