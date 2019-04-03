DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `devices`;
DROP TABLE IF EXISTS `channels`;
DROP TABLE IF EXISTS `groups`;
DROP TABLE IF EXISTS `groupings`;
DROP TABLE IF EXISTS `usages`;
DROP TABLE IF EXISTS `charts`;
DROP TABLE IF EXISTS `chartlings`;

-- Stores information about individual users
CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(100) NOT NULL, 
    `name` varchar(100) NOT NULL, 
    `password` binary(60) NOT NULL, 
    `family_size` int(2) DEFAULT NULL, 
    `created` datetime(3) NOT NULL, 
    `updated` datetime(3) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE UNIQUE INDEX `idx_email` ON `users` (`email`);


-- Stores device name and deviceID
CREATE TABLE `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `channels` int(2) NOT NULL,
  `created` datetime(3) NOT NULL,
  `updated` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE UNIQUE INDEX `idx_device` ON `devices` (`deviceID`);

-- Stores channelID to channel name association
CREATE TABLE `channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` varchar(36) NOT NULL,
  `channelID` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created` datetime(3) NOT NULL,
  `updated` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE UNIQUE INDEX `idx_channel` ON `channels` (`channelID`);

-- Stores group IDs with their associated name
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupID` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `members` int(4) DEFAULT NULL, 
  `created` datetime(3) NOT NULL,
  `updated` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE UNIQUE INDEX `idx_group` ON `groups` (`groupID`);

-- Stores which UUIDs (could be deviceID, channelID or groupID) are associated with each group and its type
CREATE TABLE `groupings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupID` varchar(36) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `type` varchar(10) NOT NULL,
  `added` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `idx_group` ON `groupings` (`groupID`);

-- Stores channel usage data where each channel's usage is associated with its channel and device ID
CREATE TABLE `usages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channelID` varchar(36) NOT NULL,
  `deviceID` varchar(36) NOT NULL,
  `amps` double(5,3) NOT NULL,
  `time` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `idx_usage` ON `usages` (`channelID`);

-- Stores chart IDs with their associated metadata
CREATE TABLE `charts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chartID` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `members` int(4) NOT NULL,
  `chartType` varchar(20) NOT NULL,
  `usageType` varchar(20) NOT NULL,
  `from` datetime(3) DEFAULT NULL,
  `until` datetime(3) DEFAULT NULL,
  `created` datetime(3) NOT NULL,
  `updated` datetime(3) NOT NULL,
  `all` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE UNIQUE INDEX `idx_chart` ON `charts` (`chartID`);

-- Stores which channels are associated with each chart
CREATE TABLE `chartlings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chartID` varchar(36) NOT NULL DEFAULT '',
  `uuid` varchar(36) NOT NULL DEFAULT '',
  `type` varchar(10) NOT NULL,
  `added` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `idx_chart` ON `chartlings` (`chartID`);