# database schemas

CREATE DATABASE IF NOT EXISTS `authority` /*!40100 DEFAULT CHARACTER SET utf8 */;


CREATE TABLE IF NOT EXISTS `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;


CREATE TABLE  IF NOT EXISTS `group` (
  `groupId` int(11) NOT NULL AUTO_INCREMENT,
  `p` varchar(700) DEFAULT NULL,
  `q` varchar(700) DEFAULT NULL,
  `n` varchar(700) DEFAULT NULL,
  `nsquared` varchar(700) DEFAULT NULL,
  `a` varchar(700) DEFAULT NULL,
  `g` varchar(700) DEFAULT NULL,
  `w` varchar(700) DEFAULT NULL,
  `bigQ` varchar(700) DEFAULT NULL,
  `bigP` varchar(700) DEFAULT NULL,
  `bigF` varchar(700) DEFAULT NULL,
  `bigG` varchar(700) DEFAULT NULL,
  `bigH` varchar(700) DEFAULT NULL,
  `Xg` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE  IF NOT EXISTS `membership` (
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `bigY` varchar(700) NOT NULL,
  PRIMARY KEY (`groupId`,`userId`),
  KEY `fkUser_idx` (`userId`),
  CONSTRAINT `fkGroup` FOREIGN KEY (`groupId`) REFERENCES `group` (`groupId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkUser` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;