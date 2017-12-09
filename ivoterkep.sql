-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Gép: den1.mysql5.gear.host
-- Létrehozás ideje: 2017. Dec 09. 23:36
-- Kiszolgáló verziója: 5.7.19-log
-- PHP verzió: 7.0.21-1~ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `ivoterkep`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) NOT NULL,
  `created_date` int(11) NOT NULL,
  `deleted_by` int(10) DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category_lang`
--

CREATE TABLE `category_lang` (
  `lang_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `content`
--

CREATE TABLE `content` (
  `id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL,
  `lead_image` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_date` int(11) NOT NULL,
  `modified_by` int(10) UNSIGNED DEFAULT NULL,
  `modified_date` int(11) DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `publish_date` int(11) DEFAULT NULL,
  `unpublish_date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `content`
--

INSERT INTO `content` (`id`, `active`, `lead_image`, `category_id`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted_by`, `deleted_date`, `publish_date`, `unpublish_date`) VALUES
(1, 1, NULL, NULL, 1, 1510047601, 1, 1510047802, NULL, NULL, NULL, NULL),
(2, 0, NULL, NULL, 1, 1512841165, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `content_lang`
--

CREATE TABLE `content_lang` (
  `lang_id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `title` varchar(50) DEFAULT NULL,
  `sef` varchar(50) DEFAULT NULL,
  `keywords` varchar(150) DEFAULT NULL,
  `lead` text,
  `content` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `content_lang`
--

INSERT INTO `content_lang` (`lang_id`, `content_id`, `enabled`, `title`, `sef`, `keywords`, `lead`, `content`) VALUES
(1, 1, 1, 'Trabant', 'trabi', 'trabi', 'lead szoveg', '<p>Lorem Ipsum&nbsp;Trabant</p>'),
(2, 1, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `groupstopermissions`
--

CREATE TABLE `groupstopermissions` (
  `groupId` int(10) UNSIGNED NOT NULL,
  `permId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `groupstopermissions`
--

INSERT INTO `groupstopermissions` (`groupId`, `permId`) VALUES
(4, 1),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `shortname` varchar(5) NOT NULL,
  `longname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `layouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `filename` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `layouts`
--

INSERT INTO `layouts` (`id`, `name`, `filename`) VALUES
(0, 'Alapértelmezett', 'def');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `pub` (
  `id` int(10) UNSIGNED NOT NULL,
  `comment` varchar(1000) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `contactId` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `pub`
--

INSERT INTO `pub` (`id`, `comment`, `address`, `contactId`, `name`) VALUES
(2, '', 'df', NULL, 'namee'),
(20, 'kordRossz', 'addr', NULL, 'nammme');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub_contact`
--

CREATE TABLE `pub_contact` (
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` int(11) UNSIGNED DEFAULT NULL,
  `pubId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- A tábla adatainak kiíratása `pub_contact`
--

INSERT INTO `pub_contact` (`email`, `phone`, `pubId`) VALUES
('wazemaki@gmail.com', 1234, 20);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub_coordinates`
--

CREATE TABLE `pub_coordinates` (
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `pubId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `pub_coordinates`
--

INSERT INTO `pub_coordinates` (`latitude`, `longitude`, `pubId`) VALUES
(23234, 12, 20);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pub_open`
--

CREATE TABLE `pub_open` (
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
  `pubId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `pub_open`
--

INSERT INTO `pub_open` (`mondayOpen`, `mondayClose`, `tuesdayOpen`, `tuesdayClose`, `wednesdayOpen`, `wednesdayClose`, `thursdayOpen`, `thursdayClose`, `fridayOpen`, `fridayClose`, `saturdayOpen`, `saturdayClose`, `sundayOpen`, `sundayClose`, `pubId`) VALUES
(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `routes`
--

CREATE TABLE `routes` (
  `id` int(10) UNSIGNED NOT NULL,
  `templateId` int(10) UNSIGNED DEFAULT NULL,
  `route` varchar(250) CHARACTER SET utf8 DEFAULT NULL,
  `parameters` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `routes`
--

INSERT INTO `routes` (`id`, `templateId`, `route`, `parameters`) VALUES
(1, 3, NULL, 0),
(2, 4, 'tartalom', 1),
(5, 5, 'kocsma', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(32) NOT NULL,
  `created` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `uid` int(10) UNSIGNED DEFAULT NULL,
  `ip4` varchar(15) NOT NULL,
  `stayLoggedIn` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `sessions`
--

INSERT INTO `sessions` (`id`, `created`, `modified`, `uid`, `ip4`, `stayLoggedIn`) VALUES
('075785e54e066a280825071fd6c43061', 1512487267, 1512487294, 1, 'proba_ip', 1),
('2fa1fdd2044f61cae1c33d11fb73b289', 1512850746, 1512853036, 1, 'proba_ip', 1),
('3d74a9380e0aab2a72aa40a2996a6d02', 1508845059, 1508845065, 2, 'proba_ip', 1),
('48a30ca8aac6e33bf83dd51233eff155', 1510049781, 1510050882, 1, 'proba_ip', 1),
('558c56f0ee85254d4dc920dc22df0074', 1512485512, 1512492827, 1, 'proba_ip', 1),
('5832c6d8760f341a19748d38852cc192', 1510049673, 1510049678, NULL, 'proba_ip', 1),
('82f50cfc787accce9d8d3f53289dbef4', 1512487279, 1512487279, NULL, 'proba_ip', 1),
('863f05d20c2ae4a4cca76f12f55f3728', 1511266490, 1511266491, 1, 'proba_ip', 1),
('8994f33f35e879fa7830041efbc53e5f', 1512487278, 1512487278, NULL, 'proba_ip', 1),
('bacc810fd37e1066c88dcf26583bc471', 1512857988, 1512858033, 2, 'proba_ip', 1),
('cbbeecd7c72e50a02728b7e0d1916a03', 1510055641, 1510056781, 1, 'proba_ip', 1),
('cd8c6f97469e07ee60cd00d9a5c0bd81', 1510659762, 1510662918, 1, 'proba_ip', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `templates`
--

CREATE TABLE `templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `layoutId` int(10) UNSIGNED DEFAULT NULL,
  `places` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `templates`
--

INSERT INTO `templates` (`id`, `name`, `layoutId`, `places`) VALUES
(3, 'terkep', 0, '{"content":[{"module":"pubMap","action":"showMap","modulePart":"map"}],"section-top":[{"module":"login","action":"","modulePart":"login"}]}'),
(4, 'tartalom', 0, '{"content":[{"module":"content","action":"show","modulePart":"content","params":{}}]}'),
(5, 'kocsma', 0, '{"content":[{"module":"pubMap","action":"showPub","modulePart":"pub"}]}');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `usergroups`
--

CREATE TABLE `usergroups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `adminAccess` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `usergroups`
--

INSERT INTO `usergroups` (`id`, `name`, `description`, `adminAccess`) VALUES
(3, 'vezetoseg', 'Vezetoségi Tagok', 0),
(4, 'admin', 'Az oldal Admin felhasználói', 1),
(5, 'superadmin', 'Szuper Adminnnn mindent megteheet', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `nick` varchar(25) NOT NULL,
  `fullName` varchar(60) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `regDate` int(11) NOT NULL,
  `lastDate` int(11) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  `passw` varchar(40) NOT NULL,
  `langId` int(10) UNSIGNED NOT NULL,
  `settings` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `nick`, `fullName`, `email`, `regDate`, `lastDate`, `deleted`, `passw`, `langId`, `settings`) VALUES
(1, 'wazemaki', 'Mato Zoltan', 'wazemaki@gmail.com', 0, 0, NULL, '90a24d234e8fc7269a068a5ccba4f43a36676d89', 1, NULL),
(2, 'pinterg', 'Pinter Gergely', 'a', 0, 0, NULL, '924e1e7e13ff02b79a8510990bb488dc21d63aa2', 1, NULL),
(3, 'hegedusa', 'Hegedus Attila', 'b', 0, 0, NULL, '924e1e7e13ff02b79a8510990bb488dc21d63aa2', 1, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userstogroups`
--

CREATE TABLE `userstogroups` (
  `userId` int(10) UNSIGNED NOT NULL,
  `groupId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `userstogroups`
--

INSERT INTO `userstogroups` (`userId`, `groupId`) VALUES
(1, 5),
(2, 5),
(3, 5);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- A tábla indexei `category_lang`
--
ALTER TABLE `category_lang`
  ADD PRIMARY KEY (`lang_id`,`category_id`),
  ADD KEY `content_id` (`category_id`);

--
-- A tábla indexei `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created` (`created_by`),
  ADD KEY `deleted` (`deleted_by`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `modified_by` (`modified_by`);

--
-- A tábla indexei `content_lang`
--
ALTER TABLE `content_lang`
  ADD PRIMARY KEY (`lang_id`,`content_id`),
  ADD KEY `content_id` (`content_id`);

--
-- A tábla indexei `groupstopermissions`
--
ALTER TABLE `groupstopermissions`
  ADD UNIQUE KEY `ids` (`groupId`,`permId`),
  ADD KEY `permission_idx` (`permId`);

--
-- A tábla indexei `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `layouts`
--
ALTER TABLE `layouts`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- A tábla indexei `pub`
--
ALTER TABLE `pub`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contactId` (`contactId`);

--
-- A tábla indexei `pub_contact`
--
ALTER TABLE `pub_contact`
  ADD PRIMARY KEY (`pubId`) USING BTREE;

--
-- A tábla indexei `pub_coordinates`
--
ALTER TABLE `pub_coordinates`
  ADD PRIMARY KEY (`pubId`) USING BTREE;

--
-- A tábla indexei `pub_open`
--
ALTER TABLE `pub_open`
  ADD PRIMARY KEY (`pubId`) USING BTREE;

--
-- A tábla indexei `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lay` (`templateId`);

--
-- A tábla indexei `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`uid`);

--
-- A tábla indexei `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `layoutId` (`layoutId`);

--
-- A tábla indexei `usergroups`
--
ALTER TABLE `usergroups`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `nick_UNIQUE` (`nick`),
  ADD KEY `langId` (`langId`);

--
-- A tábla indexei `userstogroups`
--
ALTER TABLE `userstogroups`
  ADD UNIQUE KEY `ids` (`userId`,`groupId`),
  ADD KEY `gid` (`groupId`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `content`
--
ALTER TABLE `content`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT a táblához `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT a táblához `layouts`
--
ALTER TABLE `layouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `pub`
--
ALTER TABLE `pub`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT a táblához `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `usergroups`
--
ALTER TABLE `usergroups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
-- Megkötések a táblához `groupstopermissions`
--
ALTER TABLE `groupstopermissions`
  ADD CONSTRAINT `group` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission` FOREIGN KEY (`permId`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `pub_contact`
--
ALTER TABLE `pub_contact`
  ADD CONSTRAINT `pub_contact_ibfk_1` FOREIGN KEY (`pubId`) REFERENCES `pub` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `pub_coordinates`
--
ALTER TABLE `pub_coordinates`
  ADD CONSTRAINT `pub_coordinates_ibfk_1` FOREIGN KEY (`pubId`) REFERENCES `pub` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `pub_open`
--
ALTER TABLE `pub_open`
  ADD CONSTRAINT `pub_open_ibfk_1` FOREIGN KEY (`pubId`) REFERENCES `pub` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Megkötések a táblához `userstogroups`
--
ALTER TABLE `userstogroups`
  ADD CONSTRAINT `usersToGroups_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usersToGroups_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
