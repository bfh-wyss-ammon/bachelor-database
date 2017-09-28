-- database schemas
-- 28.09.2017 authority

CREATE DATABASE IF NOT EXISTS `authority` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE authority;

-------------------------------------
-- table: user
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: publickey
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `publickey` (
  `publicKeyId` int(11) NOT NULL AUTO_INCREMENT,
  `n` varchar(1400) NOT NULL,
  `a` varchar(1400) NOT NULL,
  `g` varchar(1400) NOT NULL,
  `h` varchar(1400) NOT NULL,
  `w` varchar(1400) NOT NULL,
  `bigQ` varchar(1400) NOT NULL,
  `bigP` varchar(1400) NOT NULL,
  `bigF` varchar(1400) NOT NULL,
  `bigG` varchar(1400) NOT NULL,
  `bigH` varchar(1400) NOT NULL,
  PRIMARY KEY (`publicKeyId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: managerkey
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `managerkey` (
  `managerKeyId` int(11) NOT NULL AUTO_INCREMENT,
  `Xg` varchar(1400) NOT NULL,
  `p` varchar(1400) NOT NULL,
  `q` varchar(1400) NOT NULL,
  PRIMARY KEY (`managerKeyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: cyrptogroup
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `cyrptogroup` (
  `groupId` int(11) NOT NULL AUTO_INCREMENT,
  `managerKeyId` int(11) NOT NULL,
  `publicKeyId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`),
  KEY `managerKey_idx` (`managerKeyId`),
  KEY `publicKey_idx` (`publicKeyId`),
  CONSTRAINT `managerKey` FOREIGN KEY (`managerKeyId`) REFERENCES `managerkey` (`managerKeyId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `publicKey` FOREIGN KEY (`publicKeyId`) REFERENCES `publickey` (`publicKeyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: membership
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `membership` (
  `membershipId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `bigY` varchar(1400) DEFAULT NULL,
  `approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`membershipId`),
  KEY `userId_idx` (`userId`),
  KEY `groupId_idx` (`groupId`),
  CONSTRAINT `groupId` FOREIGN KEY (`groupId`) REFERENCES `cyrptogroup` (`groupId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;



