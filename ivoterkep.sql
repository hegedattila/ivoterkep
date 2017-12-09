-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Gép: localhost
-- Létrehozás ideje: 2017. Nov 07. 10:45
-- Kiszolgáló verziója: 5.7.18-0ubuntu0.16.04.1
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
(1, 1, NULL, NULL, 1, 1510047601, 1, 1510047802, NULL, NULL, NULL, NULL);

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
-- Tábla szerkezet ehhez a táblához `groupsToPermissions`
--

CREATE TABLE `groupsToPermissions` (
  `groupId` int(10) UNSIGNED NOT NULL,
  `permId` int(10) UNSIGNED NOT NULL
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
(1, 3, 'terkep', 1),
(2, 4, 'tartalom', 1);

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
('3d74a9380e0aab2a72aa40a2996a6d02', 1508845059, 1508845065, 2, 'proba_ip', 1),
('d732c09f5d4f423e12777d9600867e36', 1510046210, 1510047814, 1, 'proba_ip', 1);

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
(3, 'terkep', 0, '{"content":[{"module":"content","action":"show","modulePart":"content","params":{}}],"section-top":[{"module":"login","action":"","modulePart":"login"},{"module":"forum","action":"route1","modulePart":"sub3"}]}'),
(4, 'tartalom', 0, '{"content":[{"module":"content","action":"show","modulePart":"content","params":{}}]}');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userGroups`
--

CREATE TABLE `userGroups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `adminAccess` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Tábla szerkezet ehhez a táblához `usersToGroups`
--

CREATE TABLE `usersToGroups` (
  `userId` int(10) UNSIGNED NOT NULL,
  `groupId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `usersToGroups`
--

INSERT INTO `usersToGroups` (`userId`, `groupId`) VALUES
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
-- A tábla indexei `groupsToPermissions`
--
ALTER TABLE `groupsToPermissions`
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
-- A tábla indexei `userGroups`
--
ALTER TABLE `userGroups`
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
-- A tábla indexei `usersToGroups`
--
ALTER TABLE `usersToGroups`
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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
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
-- AUTO_INCREMENT a táblához `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT a táblához `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT a táblához `userGroups`
--
ALTER TABLE `userGroups`
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
-- Megkötések a táblához `groupsToPermissions`
--
ALTER TABLE `groupsToPermissions`
  ADD CONSTRAINT `group` FOREIGN KEY (`groupId`) REFERENCES `userGroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission` FOREIGN KEY (`permId`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
