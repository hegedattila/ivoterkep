-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Hoszt: localhost
-- Létrehozás ideje: 2017. Dec 09. 14:40
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
  `pubId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pubId` (`pubId`),
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
  `pubId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pubId` (`pubId`)
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
  `pubId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pubId` (`pubId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `pub`
--
ALTER TABLE `pub`
  ADD CONSTRAINT `pub_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `pub_contact` (`id`),
  ADD CONSTRAINT `pub_ibfk_2` FOREIGN KEY (`coordinatesId`) REFERENCES `pub_coordinates` (`id`),
  ADD CONSTRAINT `pub_ibfk_3` FOREIGN KEY (`openId`) REFERENCES `pub_open` (`id`);

--
-- Megkötések a táblához `pub_contact`
--
ALTER TABLE `pub_contact`
  ADD CONSTRAINT `pub_contact_ibfk_1` FOREIGN KEY (`pubId`) REFERENCES `pub` (`id`);

--
-- Megkötések a táblához `pub_coordinates`
--
ALTER TABLE `pub_coordinates`
  ADD CONSTRAINT `pub_coordinates_ibfk_1` FOREIGN KEY (`pubId`) REFERENCES `pub` (`id`);

--
-- Megkötések a táblához `pub_open`
--
ALTER TABLE `pub_open`
  ADD CONSTRAINT `pub_open_ibfk_1` FOREIGN KEY (`pubId`) REFERENCES `pub` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
