-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Hoszt: localhost
-- Létrehozás ideje: 2017. Dec 09. 13:43
-- Szerver verzió: 5.5.58-0ubuntu0.14.04.1
-- PHP verzió: 7.0.25-1+ubuntu14.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Adatbázis: `ivoterkep`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_by` int(10) NOT NULL,
  `created_date` int(11) NOT NULL,
  `deleted_by` int(10) DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `deleted_by` (`deleted_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category_lang`
--

CREATE TABLE IF NOT EXISTS `category_lang` (
  `lang_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`lang_id`,`category_id`),
  KEY `content_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `content`
--

CREATE TABLE IF NOT EXISTS `content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `lead_image` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT NULL,
  `created_date` int(11) NOT NULL,
  `modified_by` int(10) unsigned DEFAULT NULL,
  `modified_date` int(11) DEFAULT NULL,
  `deleted_by` int(10) unsigned DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `publish_date` int(11) DEFAULT NULL,
  `unpublish_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created` (`created_by`),
  KEY `deleted` (`deleted_by`),
  KEY `category_id` (`category_id`),
  KEY `modified_by` (`modified_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- A tábla adatainak kiíratása `content`
--

INSERT INTO `content` (`id`, `active`, `lead_image`, `category_id`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted_by`, `deleted_date`, `publish_date`, `unpublish_date`) VALUES
(1, 1, NULL, NULL, 1, 1510047601, 1, 1510047802, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `content_lang`
--

CREATE TABLE IF NOT EXISTS `content_lang` (
  `lang_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `title` varchar(50) DEFAULT NULL,
  `sef` varchar(50) DEFAULT NULL,
  `keywords` varchar(150) DEFAULT NULL,
  `lead` text,
  `content` mediumtext,
  PRIMARY KEY (`lang_id`,`content_id`),
  KEY `content_id` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `content_lang`
--

INSERT INTO `content_lang` (`lang_id`, `content_id`, `enabled`, `title`, `sef`, `keywords`, `lead`, `content`) VALUES
(1, 1, 1, 'Trabant', 'trabi', 'trabi', 'lead szoveg', '<p>Lorem Ipsum&nbsp;Trabant</p>'),
(2, 1, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `groupsToPermissions`
--

CREATE TABLE IF NOT EXISTS `groupsToPermissions` (
  `groupId` int(10) unsigned NOT NULL,
  `permId` int(10) unsigned NOT NULL,
  UNIQUE KEY `ids` (`groupId`,`permId`),
  KEY `permission_idx` (`permId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `groupsToPermissions`
--

INSERT INTO `groupsToPermissions` (`groupId`, `permId`) VALUES
(4, 1),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shortname` varchar(5) NOT NULL,
  `longname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- A tábla adatainak kiíratása `languages`
--

INSERT INTO `languages` (`id`, `shortname`, `longname`) VALUES
(1, 'hu', 'Magyar'),
(2, 'en', 'English');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `layouts`
--

CREATE TABLE IF NOT EXISTS `layouts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `filename` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- A tábla adatainak kiíratása `layouts`
--

INSERT INTO `layouts` (`id`, `name`, `filename`) VALUES
(0, 'Alapértelmezett', 'def');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- A tábla adatainak kiíratása `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `description`) VALUES
(1, 'handleSystem', 'System beállításokat babrálhatja'),
(2, 'handlePerms', 'Jogosultságokhoz hozzáfér'),
(3, 'setPermToGroup', 'Jogosultségot adhat-elvehet'),
(4, 'handleUgroups', 'Felhasználói csoportokhoz hozzáfér'),
(5, 'all', 'Minden');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub`
--

CREATE TABLE IF NOT EXISTS `pub` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment` varchar(1000) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `contactId` int(10) unsigned NOT NULL,
  `coordinatesId` int(10) unsigned NOT NULL,
  `openId` int(10) unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`address`),
  UNIQUE KEY `contact` (`contactId`),
  UNIQUE KEY `coordinatesId` (`coordinatesId`),
  UNIQUE KEY `openId` (`openId`),
  KEY `contactId` (`contactId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub_contact`
--

CREATE TABLE IF NOT EXISTS `pub_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub_coordinates`
--

CREATE TABLE IF NOT EXISTS `pub_coordinates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub_open`
--

CREATE TABLE IF NOT EXISTS `pub_open` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mondayOpen` time DEFAULT NULL,
  `mondayClose` time DEFAULT NULL,
  `tuesdayOpen` time DEFAULT NULL,
  `tuesdayClose` time DEFAULT NULL,
  `wednesdayOpen` time DEFAULT NULL,
  `wednesdayClose` time DEFAULT NULL,
  `thursdayOpen` time DEFAULT NULL,
  `thursdayClose` time DEFAULT NULL,
  `fridayOpen` time DEFAULT NULL,
  `fridayClose` time DEFAULT NULL,
  `saturdayOpen` time DEFAULT NULL,
  `saturdayClose` time DEFAULT NULL,
  `sundayOpen` time DEFAULT NULL,
  `sundayClose` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `routes`
--

CREATE TABLE IF NOT EXISTS `routes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `templateId` int(10) unsigned DEFAULT NULL,
  `route` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `parameters` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lay` (`templateId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- A tábla adatainak kiíratása `routes`
--

INSERT INTO `routes` (`id`, `templateId`, `route`, `parameters`) VALUES
(1, 3, 'terkep', 1),
(2, 4, 'tartalom', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(32) NOT NULL,
  `created` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `uid` int(10) unsigned DEFAULT NULL,
  `ip4` varchar(15) NOT NULL,
  `stayLoggedIn` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `sessions`
--

INSERT INTO `sessions` (`id`, `created`, `modified`, `uid`, `ip4`, `stayLoggedIn`) VALUES
('32d8de3b3004c1a231895f262fa5fd99', 1511266932, 1511266932, NULL, 'proba_ip', 1),
('39e2c884a815af6d30b60569e2006508', 1512593246, 1512593247, 3, 'proba_ip', 1),
('3d74a9380e0aab2a72aa40a2996a6d02', 1508845059, 1508845065, 2, 'proba_ip', 1),
('8e0db5fa77c9bb05200d862e9971c3a3', 1511871909, 1511871909, NULL, 'proba_ip', 1),
('d732c09f5d4f423e12777d9600867e36', 1510046210, 1510047814, 1, 'proba_ip', 1),
('e83b23821bb906421b4d8d96997b93d9', 1512811190, 1512811191, NULL, 'proba_ip', 1),
('ecf92668f6f089908a91b23de94620e7', 1511266589, 1511267429, 3, 'proba_ip', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `templates`
--

CREATE TABLE IF NOT EXISTS `templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `layoutId` int(10) unsigned DEFAULT NULL,
  `places` longtext,
  PRIMARY KEY (`id`),
  KEY `layoutId` (`layoutId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- A tábla adatainak kiíratása `templates`
--

INSERT INTO `templates` (`id`, `name`, `layoutId`, `places`) VALUES
(3, 'terkep', 0, '{"content":[{"module":"content","action":"show","modulePart":"content","params":{}}],"section-top":[{"module":"login","action":"","modulePart":"login"},{"module":"forum","action":"route1","modulePart":"sub3"}]}'),
(4, 'tartalom', 0, '{"content":[{"module":"content","action":"show","modulePart":"content","params":{}}]}');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userGroups`
--

CREATE TABLE IF NOT EXISTS `userGroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `adminAccess` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- A tábla adatainak kiíratása `userGroups`
--

INSERT INTO `userGroups` (`id`, `name`, `description`, `adminAccess`) VALUES
(3, 'vezetoseg', 'Vezetoségi Tagok', 0),
(4, 'admin', 'Az oldal Admin felhasználói', 1),
(5, 'superadmin', 'Szuper Adminnnn mindent megteheet', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(25) NOT NULL,
  `fullName` varchar(60) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `regDate` int(11) NOT NULL,
  `lastDate` int(11) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  `passw` varchar(40) NOT NULL,
  `langId` int(10) unsigned NOT NULL,
  `settings` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `nick_UNIQUE` (`nick`),
  KEY `langId` (`langId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `nick`, `fullName`, `email`, `regDate`, `lastDate`, `deleted`, `passw`, `langId`, `settings`) VALUES
(1, 'wazemaki', 'Mato Zoltan', 'wazemaki@gmail.com', 0, 0, NULL, '90a24d234e8fc7269a068a5ccba4f43a36676d89', 1, NULL),
(2, 'pinterg', 'Pinter Gergely', 'a', 0, 0, NULL, '924e1e7e13ff02b79a8510990bb488dc21d63aa2', 1, NULL),
(3, 'hegedusa', 'Hegedus Attila', 'b', 0, 0, NULL, '924e1e7e13ff02b79a8510990bb488dc21d63aa2', 1, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `usersToGroups`
--

CREATE TABLE IF NOT EXISTS `usersToGroups` (
  `userId` int(10) unsigned NOT NULL,
  `groupId` int(10) unsigned NOT NULL,
  UNIQUE KEY `ids` (`userId`,`groupId`),
  KEY `gid` (`groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `usersToGroups`
--

INSERT INTO `usersToGroups` (`userId`, `groupId`) VALUES
(1, 5),
(2, 5),
(3, 5);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `category_lang`
--
ALTER TABLE `category_lang`
  ADD CONSTRAINT `category_lang_ibfk_1` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `category_lang_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `content_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `content_ibfk_2` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `content_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `content_ibfk_4` FOREIGN KEY (`modified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Megkötések a táblához `content_lang`
--
ALTER TABLE `content_lang`
  ADD CONSTRAINT `content_lang_ibfk_1` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `content_lang_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `groupsToPermissions`
--
ALTER TABLE `groupsToPermissions`
  ADD CONSTRAINT `group` FOREIGN KEY (`groupId`) REFERENCES `userGroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission` FOREIGN KEY (`permId`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `pub`
--
ALTER TABLE `pub`
  ADD CONSTRAINT `pub_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `pub_contact` (`id`),
  ADD CONSTRAINT `pub_ibfk_2` FOREIGN KEY (`coordinatesId`) REFERENCES `pub_coordinates` (`id`),
  ADD CONSTRAINT `pub_ibfk_3` FOREIGN KEY (`openId`) REFERENCES `pub_open` (`id`);

--
-- Megkötések a táblához `routes`
--
ALTER TABLE `routes`
  ADD CONSTRAINT `routes_ibfk_1` FOREIGN KEY (`templateId`) REFERENCES `templates` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Megkötések a táblához `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `user` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `templates`
--
ALTER TABLE `templates`
  ADD CONSTRAINT `templates_ibfk_1` FOREIGN KEY (`layoutId`) REFERENCES `layouts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Megkötések a táblához `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `lang` FOREIGN KEY (`langId`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `usersToGroups`
--
ALTER TABLE `usersToGroups`
  ADD CONSTRAINT `usersToGroups_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usersToGroups_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `userGroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
