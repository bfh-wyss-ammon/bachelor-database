-- database schemas
-- 28.09.2017 authority

CREATE DATABASE IF NOT EXISTS `authority` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE authority;

-------------------------------------
-- table: authority.user
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: authority.publickey
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
-- table: authority.managerkey
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
-- table: authority.cryptogroup
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------
CREATE TABLE `cryptogroup` (
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
-- table: authority.membership
-- created: 28.09.2017
-- creator: Pascal Ammon
-------------------------------------

CREATE TABLE `membership` (
  `membershipId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `bigY` varchar(1400) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`membershipId`),
  KEY `userId_idx` (`userId`),
  KEY `groupId_idx` (`groupId`),
  CONSTRAINT `groupId` FOREIGN KEY (`groupId`) REFERENCES `cryptogroup` (`groupId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: authority.session
-- created: 29.09.2017
-- creator: Pascal Ammon
-------------------------------------

CREATE TABLE `session` (
  `sessionId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` varchar(36) NOT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`sessionId`),
  KEY `buserId_idx` (`userId`),
  CONSTRAINT `buserId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-------------------------------------
-- database: provider
-- created: 30.09.2017
-- creator: Gabriel Wyss
-------------------------------------

CREATE DATABASE IF NOT EXISTS `provider` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE provider;
-------------------------------------
-- table: provider.publickey
-- created: 05.10.2017
-- creator: Gabriel Wyss
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
-------------------------------------
-- table: provider.cryptogroup
-- created: 05.10.2017
-- creator: Gabriel Wyss
-------------------------------------
CREATE TABLE `cryptogroup` (
  `providerGroupId` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `publicKeyId` int(11) NOT NULL,
  PRIMARY KEY (`providerGroupId`),
  KEY `FK_groupId_idx` (`publicKeyId`),
  KEY `FK_groupId_id_idx` (`groupId`),
  CONSTRAINT `FK_publicKey` FOREIGN KEY (`publicKeyId`) REFERENCES `publickey` (`publicKeyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: provider.signature
-- created: 05.10.2017
-- creator: Gabriel Wyss
-------------------------------------
CREATE TABLE `signature` (
  `signatureId` int(11) NOT NULL AUTO_INCREMENT,
  `u` varchar(1400) NOT NULL,
  `bigU1` varchar(1400) NOT NULL,
  `bigU2` varchar(1400) NOT NULL,
  `bigU3` varchar(1400) NOT NULL,
  `zx` varchar(1400) NOT NULL,
  `zr` varchar(1400) NOT NULL,
  `ze` varchar(1400) NOT NULL,
  `zbigR` varchar(1400) NOT NULL,
  `c` varchar(1400) NOT NULL,
  PRIMARY KEY (`signatureId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-------------------------------------
-- table: provider.tuple
-- created: 05.10.2017
-- creator: Gabriel Wyss
-------------------------------------
CREATE TABLE `tuple` (
  `tupleId` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `signatureId` int(11) NOT NULL,
  `longitude` decimal(13,10) NOT NULL,
  `latitude` decimal(13,10) NOT NULL,
  `created` datetime NOT NULL,
  `received` datetime NOT NULL,
  `hash`varchar(200) NOT NULL,
  PRIMARY KEY (`tupleId`),
  KEY `fk_tuple_to_signature_idx` (`signatureId`),
  KEY `fk_tuple_to_group_idx` (`groupId`),
  CONSTRAINT `fk_tuple_to_group` FOREIGN KEY (`groupId`) REFERENCES `cryptogroup` (`providerGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tuple_to_signature` FOREIGN KEY (`signatureId`) REFERENCES `signature` (`signatureId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: provider.session
-- created: 18.10.2017
-- creator: Gabriel Wyss
-------------------------------------
CREATE TABLE `session` (
  `sessionId` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `signatureId` int(11) DEFAULT NULL,
  `state` varchar(50) NOT NULL,
  `token` varchar(36) NOT NULL,
  `created` datetime DEFAULT NULL,
  `invoiceItemsCreated` datetime DEFAULT NULL,
  `period` datetime DEFAULT NULL,
  `signatureOnTuples` varchar(700) DEFAULT NULL,
  `paidAmount` int(11) DEFAULT NULL,
  `hash` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`sessionId`),
  KEY `fk_tollsession_idx` (`groupId`),
  KEY `fk_session_signature_idx` (`signatureId`),
  CONSTRAINT `fk_session_signature` FOREIGN KEY (`signatureId`) REFERENCES `signature` (`signatureId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tollsession` FOREIGN KEY (`groupId`) REFERENCES `cryptogroup` (`providerGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-------------------------------------
-- table: provider.disputesession
-- created: 09.11.2017
-- creator: Gabriel Wyss
-------------------------------------
CREATE TABLE `disputesession` (
  `sessionId` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `state` varchar(50) NOT NULL,
  `token` varchar(36) NOT NULL,
  `created` datetime DEFAULT NULL,
  `period` datetime DEFAULT NULL,
  `signatureOnResult` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`sessionId`),
  KEY `fk_disputesession_idx` (`groupId`),
  CONSTRAINT `fk_disputesession_group` FOREIGN KEY (`groupId`) REFERENCES `cryptogroup` (`providerGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-------------------------------------
-- table: provider.disputeresult
-- created: 09.11.2017
-- creator: Gabriel Wyss
-------------------------------------
CREATE TABLE `disputeresult` (
  `resultId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `disputesessionId` int(11) NOT NULL,
  `deltaToll` int(11) NOT NULL,
  `idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`resultId`),
  KEY `fk_disputesession_idx` (`disputesessionId`),
  CONSTRAINT `fk_disputesession` FOREIGN KEY (`disputesessionId`) REFERENCES `disputesession` (`sessionId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `provider`.`vtuples` AS  SELECT `t`.`tupleId` AS `tupleId`, `t`.`hash` AS `hash`, `t`.`created` AS `created`, `g`.`groupId` AS `groupId`, 1 AS `price` FROM (`provider`.`tuple` `t` JOIN `provider`.`cryptogroup` `g`) WHERE (`t`.`groupId` = `g`.`providerGroupId`);

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `provider`.`payments` AS select `provider`.`session`.`period` AS `period`,`provider`.`session`.`groupId` AS `groupId`,sum(`provider`.`session`.`paidAmount`) AS `total` from `provider`.`session` group by `provider`.`session`.`groupId`,`provider`.`session`.`period`;
