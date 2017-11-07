-- phpMyAdmin SQL Dump
-- version 4.6.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 04, 2017 at 10:00 PM
-- Server version: 5.6.22-log
-- PHP Version: 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `evk`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(10) UNSIGNED NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `county` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `post_code` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `address_type_id` int(10) UNSIGNED NOT NULL,
  `external_user_data_id` int(10) UNSIGNED NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `address_type`
--

CREATE TABLE `address_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `multiple` tinyint(1) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `default_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address_type`
--

INSERT INTO `address_type` (`id`, `user_group_id`, `multiple`, `required`, `default_type`) VALUES
(1, 1, 1, 1, NULL),
(2, 1, 1, 1, NULL),
(3, 2, 1, 1, 'shipping_address'),
(4, 2, 1, 1, 'billing_address'),
(5, 3, 1, 1, 'shipping_address'),
(6, 3, 1, 1, 'billing_address');

-- --------------------------------------------------------

--
-- Table structure for table `address_type_lang`
--

CREATE TABLE `address_type_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `address_type_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address_type_lang`
--

INSERT INTO `address_type_lang` (`id`, `address_type_id`, `name`, `lang_id`) VALUES
(1, 1, 'Számlázási cím', 1),
(2, 2, 'Szállítási cím', 1),
(3, 3, 'Szállítási cím', 1),
(4, 3, 'Shipping address', 2),
(5, 4, 'Számlázási cím', 1),
(6, 4, 'Billing address', 2),
(7, 5, 'Szállítási cím', 1),
(8, 5, 'Shipping address', 2),
(9, 6, 'Számlázási cím', 1),
(10, 6, 'Billing address', 2);

-- --------------------------------------------------------

--
-- Table structure for table `admin_moduls`
--

CREATE TABLE `admin_moduls` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `modul_name` varchar(255) NOT NULL COMMENT 'A modul neve - egyben külső kulcs a privileges tablaho'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `assembled_product`
--

CREATE TABLE `assembled_product` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchased_product_id` varchar(255) DEFAULT NULL,
  `part_purchased_product_id` varchar(255) DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `net_price` float UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `bank_account_numbers`
--

CREATE TABLE `bank_account_numbers` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'bankszámlaszámok a céghez',
  `bank_account_number` varchar(255) NOT NULL,
  `financial_institution_id` int(10) UNSIGNED NOT NULL,
  `firm_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `banner`
--

CREATE TABLE `banner` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `show_title` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `unique_folder_name` varchar(255) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `banner_item`
--

CREATE TABLE `banner_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `banner_id` int(10) UNSIGNED NOT NULL,
  `modul_type` varchar(255) DEFAULT NULL,
  `modul_type_id_or_text` text,
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `ordering` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `banner_item_lang`
--

CREATE TABLE `banner_item_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `banner_item_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `banner_lang`
--

CREATE TABLE `banner_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `banner_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billing_data`
--

CREATE TABLE `billing_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `tax_number` varchar(100) DEFAULT NULL,
  `bank_account_number` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `external_user_data_id` int(10) UNSIGNED NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cash_register`
--

CREATE TABLE `cash_register` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cash_register_financial_flows`
--

CREATE TABLE `cash_register_financial_flows` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `cash_register_id` int(10) UNSIGNED NOT NULL,
  `open_date` int(10) UNSIGNED NOT NULL,
  `close_date` int(10) UNSIGNED DEFAULT NULL,
  `denominations` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cash_voucher`
--

CREATE TABLE `cash_voucher` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_voucher_data` longtext,
  `cash_voucher_number` varchar(255) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `note` longtext,
  `create_date` int(10) UNSIGNED NOT NULL,
  `invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `cash_register_financial_flows_id` int(10) UNSIGNED DEFAULT NULL,
  `total_gross_price` double NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `claim_type` int(10) UNSIGNED NOT NULL,
  `cash_voucher_claim_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cash_voucher_claim`
--

CREATE TABLE `cash_voucher_claim` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `claim_type` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `ico_class` varchar(50) DEFAULT '',
  `privilege` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `lead_image_unique_dir` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `user_group_id`, `ico_class`, `privilege`, `active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted`, `deleted_by`, `deleted_date`, `lead_image_unique_dir`) VALUES
(1, 2, '', NULL, 1, 3, 1462961027, 3, 1464166663, 0, NULL, NULL, NULL),
(2, 2, NULL, NULL, 1, 3, 1463664883, 3, 1477951884, 0, NULL, NULL, '5817cf4855b463');

-- --------------------------------------------------------

--
-- Table structure for table `category_contents`
--

CREATE TABLE `category_contents` (
  `id` varchar(255) NOT NULL COMMENT 'ez a létrehozás dátuma mikro sec ben + a hozzáadó id-je',
  `category_id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `flag_ids` text NOT NULL COMMENT 'ez egy olyan JSON amiben fel vannak sorolva content besorolásai',
  `created_date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_contents`
--

INSERT INTO `category_contents` (`id`, `category_id`, `content_id`, `flag_ids`, `created_date`) VALUES
('57332116a4f08_d3d9446802a44259755d38e6d163e820', 1, 5, '[]', 1462961398),
('5733303b801d7_d3d9446802a44259755d38e6d163e820', 1, 6, '[]', 1462965275),
('573dde842e287_98f13708210194c475687be6106a3b84', 2, 8, '[]', 1463665252),
('5747489e64528_98f13708210194c475687be6106a3b84', 2, 7, '[]', 1464282238),
('576d135c0aaa9_98f13708210194c475687be6106a3b84', 2, 9, '[]', 1466758972),
('579fe02ec711b_98f13708210194c475687be6106a3b84', 2, 11, '[]', 1470088206),
('57a092dfaf6f5_98f13708210194c475687be6106a3b84', 2, 12, '[]', 1470133951),
('57a0943b14adc_98f13708210194c475687be6106a3b84', 2, 14, '[]', 1470134299),
('57a0943b14b8f_3c59dc048e8850243be8079a5c74d079', 2, 13, '[]', 1470134299),
('57a0976aac8b6_98f13708210194c475687be6106a3b84', 2, 19, '[]', 1470135114),
('57a0976aac96b_3c59dc048e8850243be8079a5c74d079', 2, 18, '[]', 1470135114),
('57a0976aaca18_b6d767d2f8ed5d21a44b0e5886680cb9', 2, 17, '[]', 1470135114),
('57a0976aacac2_37693cfc748049e45d87b8c7d8b9aacd', 2, 16, '[]', 1470135114),
('57a0976aacb6c_1ff1de774005f8da13f42943881c655f', 2, 15, '[]', 1470135114),
('5817d04bdd4d9_98f13708210194c475687be6106a3b84', 2, 21, '[]', 1477952059),
('5817dc223019e_98f13708210194c475687be6106a3b84', 2, 22, '[]', 1477955090),
('5817dfad6400f_98f13708210194c475687be6106a3b84', 2, 23, '[]', 1477955997),
('5817e0e61d15f_98f13708210194c475687be6106a3b84', 2, 24, '[]', 1477956310),
('5817e27874dd9_98f13708210194c475687be6106a3b84', 2, 25, '[]', 1477956712),
('5817e3a056b63_98f13708210194c475687be6106a3b84', 2, 26, '[]', 1477957008),
('5827d6e024fdf_d3d9446802a44259755d38e6d163e820', 1, 10, '[]', 1479002320),
('586ac79bc8984_98f13708210194c475687be6106a3b84', 2, 27, '[]', 1483389323),
('5880ba1cb9dce_98f13708210194c475687be6106a3b84', 2, 28, '[]', 1484827660),
('5883c0603a2e5_98f13708210194c475687be6106a3b84', 2, 29, '[]', 1485025872),
('5883c102a8fc7_98f13708210194c475687be6106a3b84', 2, 30, '[]', 1485026034),
('5883c2733acaa_d3d9446802a44259755d38e6d163e820', 1, 4, '[]', 1485026403),
('5883d40037fab_98f13708210194c475687be6106a3b84', 2, 31, '[]', 1485030896),
('588676011fc64_98f13708210194c475687be6106a3b84', 2, 32, '[]', 1485203441),
('588676e9011f4_98f13708210194c475687be6106a3b84', 2, 33, '[]', 1485203673),
('5886792f0104f_98f13708210194c475687be6106a3b84', 2, 34, '[]', 1485204255);

-- --------------------------------------------------------

--
-- Table structure for table `category_flags`
--

CREATE TABLE `category_flags` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category_flag_lang`
--

CREATE TABLE `category_flag_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `category_flag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category_lang`
--

CREATE TABLE `category_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'ez kerül be a route ba mint megnevezes' COMMENT 'a név - (lehet át lesz alakítva: az ékezetes betűket átváltjuk a neki megfelelő rövid alakjának - de csak az url-ben)',
  `description` longtext,
  `use_default_lang_lead_image` tinyint(1) NOT NULL DEFAULT '1',
  `lead_image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_lang`
--

INSERT INTO `category_lang` (`id`, `category_id`, `lang_id`, `name`, `description`, `use_default_lang_lead_image`, `lead_image`) VALUES
(1, 1, 1, 'MUSIC', NULL, 1, NULL),
(2, 1, 2, 'MUSIC', NULL, 1, NULL),
(3, 2, 1, 'Tours', 'Orfeum@Budapest', 1, NULL),
(4, 2, 2, 'Tours', 'Liquid@Orfeum, Budapest', 0, '5817cf9c68a7c-5817cf9c64a4b-orfeumjpg.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `category_products`
--

CREATE TABLE `category_products` (
  `product_category_id` int(10) UNSIGNED NOT NULL,
  `product_category_item_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Meghatározza hogy a termék melyik categória alapján szedje fel a ttk számokat'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category_to_page`
--

CREATE TABLE `category_to_page` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_to_page`
--

INSERT INTO `category_to_page` (`category_id`, `page_id`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type_id` int(10) UNSIGNED NOT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `number_length` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `number` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'utolsó használt sorszám',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `created_date` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `default_cashvoucher_claim_in_id` int(10) UNSIGNED DEFAULT NULL,
  `default_cashvoucher_claim_out_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_type`
--

CREATE TABLE `certificate_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `certificate_type`
--

INSERT INTO `certificate_type` (`id`, `name`) VALUES
(1, 'invoice'),
(2, 'packing_slip'),
(3, 'cash_voucher_in'),
(4, 'order_confirmation'),
(5, 'procurementdocument'),
(6, 'tender'),
(7, 'warranty'),
(8, 'cash_voucher_out');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'kapcsolattartó neve',
  `phone_number` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL COMMENT 'kihez tartozik a kapcsolattartó'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `lead_image` varchar(255) DEFAULT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `created_by` int(11) UNSIGNED NOT NULL,
  `created_date` int(11) NOT NULL,
  `modified_by` int(11) UNSIGNED NOT NULL,
  `modified_date` int(11) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` int(11) UNSIGNED DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `publish_date` int(10) UNSIGNED DEFAULT NULL,
  `unpublish_date` int(10) UNSIGNED DEFAULT NULL,
  `files` text,
  `show_create_date` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='"Cikk" -> de inkább tartalom';

--
-- Dumping data for table `content`
--

INSERT INTO `content` (`id`, `user_group_id`, `lead_image`, `uid`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted`, `deleted_by`, `deleted_date`, `active`, `publish_date`, `unpublish_date`, `files`, `show_create_date`) VALUES
(1, 2, NULL, '56efd754a8375', 2, 1458555204, 2, 1475829637, 0, NULL, NULL, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(2, 2, NULL, '56f1726ef0cb6', 2, 1458660446, 2, 1475829636, 0, NULL, NULL, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(3, 2, '', '56f262fb7c65a', 2, 1458722027, 2, 1475829634, 0, NULL, NULL, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(4, 2, NULL, '571dd9206f788', 3, 1461566720, 3, 1485026403, 0, NULL, NULL, 1, 1483221600, 1517695200, '{"document":[],"video":[],"audio":[]}', 1),
(5, 2, NULL, '573320fc41216', 3, 1462961372, 3, 1462961372, 0, NULL, NULL, 1, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(6, 2, NULL, '57333025c7d0c', 3, 1462965253, 3, 1483816850, 0, NULL, NULL, 1, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(7, 2, 'journey_574808fae17e7.png', '573dddd1b5407', 3, 1463665073, 2, 1466692961, 1, 2, 1466693053, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(8, 2, NULL, '573dde75ebcd6', 3, 1463665237, 3, 1470105951, 0, NULL, NULL, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(9, 2, NULL, '573dde75ebcd6', 3, 1463665237, 3, 1470105950, 0, NULL, NULL, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(10, 2, NULL, '576bea95edb6d', 2, 1466682997, 3, 1485035430, 0, NULL, NULL, 1, 1480975200, 1487887200, '{"document":[],"video":[],"audio":[]}', 0),
(11, 2, 'ozora-festival_57a09b15c4e61.png', '579fe011c9ac7', 3, 1470088177, 3, 1470150920, 0, NULL, NULL, 1, NULL, 1470427200, '{"document":[],"video":[],"audio":[]}', 0),
(12, 2, 'kexx-festival_57a0a1d4a7a96.jpg', '57a091ae54484', 2, 1470133646, 3, 1470137780, 0, NULL, NULL, 1, NULL, 1470427200, '{"document":[],"video":[],"audio":[]}', 0),
(13, 2, 'butiq_57a0ad9092931.png', '57a09391b369c', 2, 1470134129, 2, 1470140784, 0, NULL, NULL, 1, NULL, 1470513600, '{"document":[],"video":[],"audio":[]}', 0),
(14, 2, NULL, '57a09413bf1ba', 2, 1470134259, 2, 1470134259, 0, NULL, NULL, 1, NULL, 1471032000, '{"document":[],"video":[],"audio":[]}', 0),
(15, 2, 'club-escape_57a0d6496a9ee.jpg', '57a09640e20aa', 2, 1470134816, 3, 1470151209, 0, NULL, NULL, 1, NULL, 1471118400, '{"document":[],"video":[],"audio":[]}', 0),
(16, 2, 'sziget-festival_57a0af3e6c90f.png', '57a0967bc3c35', 2, 1470134875, 2, 1470141214, 0, NULL, NULL, 1, NULL, 1471204800, '{"document":[],"video":[],"audio":[]}', 0),
(17, 2, 'volcz-birtok_57a0b0306baba.png', '57a096b751fde', 2, 1470134935, 2, 1470141456, 0, NULL, NULL, 1, NULL, 1473451200, '{"document":[],"video":[],"audio":[]}', 0),
(18, 2, 'cinema-hall_57a0b0d640548.png', '57a096f81b541', 2, 1470135000, 2, 1470141622, 0, NULL, NULL, 1, NULL, 1474142400, '{"document":[],"video":[],"audio":[]}', 0),
(19, 2, 'corvin-club_57c934f769cfd.jpg', '57a097366b08c', 2, 1470135062, 2, 1475647540, 0, NULL, NULL, 1, NULL, 1477684800, '{"document":[],"video":[],"audio":[]}', 0),
(20, 2, NULL, '57f4b43d553be', 2, 1475647517, 2, 1475647655, 0, NULL, NULL, 0, NULL, NULL, '{"document":[],"video":[],"audio":[]}', 0),
(21, 2, NULL, '5817cfdab34b4', 3, 1477952059, 3, 1479002945, 0, NULL, NULL, 1, 1477951200, 1480888800, '{"document":[],"video":[],"audio":[]}', 0),
(22, 2, NULL, '5817dad763c9f', 3, 1477955090, 3, 1479003428, 0, NULL, NULL, 1, 1477951200, 1482184800, '{"document":[],"video":[],"audio":[]}', 0),
(23, 2, NULL, '5817de4f8a7a4', 3, 1477955997, 3, 1479003845, 0, NULL, NULL, 1, 1477951200, 1483135200, '{"document":[],"video":[],"audio":[]}', 0),
(24, 2, NULL, '5817dffe2bfbb', 3, 1477956310, 3, 1479003511, 0, NULL, NULL, 1, 1477951200, 1483221600, '{"document":[],"video":[],"audio":[]}', 0),
(25, 2, NULL, '5817e1a47b71f', 3, 1477956712, 3, 1483387691, 0, NULL, NULL, 0, 1477951200, 1483912800, '{"document":[],"video":[],"audio":[]}', 0),
(26, 2, NULL, '5817e2dd2dd18', 3, 1477957008, 3, 1484831425, 1, 3, 1485025517, 1, 1483480800, 1488751200, '{"document":[],"video":[],"audio":[]}', 1),
(27, 2, NULL, '586ac4d1ca09a', 3, 1483389323, 3, 1484831398, 1, 3, 1485025522, 1, 1484517600, 1490479200, '{"document":[],"video":[],"audio":[]}', 1),
(28, 2, NULL, '5880b7d731603', 3, 1484827660, 3, 1485025637, 0, NULL, NULL, 1, 1483221600, 1488232800, '{"document":[],"video":[],"audio":[]}', 1),
(29, 2, NULL, '5883c004433bd', 3, 1485025872, 3, 1485203886, 0, NULL, NULL, 1, 1483308000, 1488751200, '{"document":[],"video":[],"audio":[]}', 1),
(30, 2, NULL, '5883c0a690767', 3, 1485026034, 3, 1485203921, 0, NULL, NULL, 1, 1483394400, 1490558400, '{"document":[],"video":[],"audio":[]}', 1),
(31, 2, NULL, '5883d34699c93', 3, 1485030896, 3, 1485203977, 0, NULL, NULL, 1, 1483826400, 1502222400, '{"document":[],"video":[],"audio":[]}', 1),
(32, 2, NULL, '5886741fb11af', 3, 1485203441, 3, 1485203469, 1, 3, 1485203778, 1, 1485813600, 1495915200, '{"document":[],"video":[],"audio":[]}', 1),
(33, 2, NULL, '58867657733f3', 3, 1485203672, 3, 1485203948, 0, NULL, NULL, 1, 1483480800, 1495915200, '{"document":[],"video":[],"audio":[]}', 1),
(34, 2, NULL, '5886785b57322', 3, 1485204254, 3, 1485204731, 0, NULL, NULL, 1, 1484604000, 1493496000, '{"document":[],"video":[],"audio":[]}', 1);

-- --------------------------------------------------------

--
-- Table structure for table `content_lang`
--

CREATE TABLE `content_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'a content címe az adott nyelven',
  `SEF` varchar(255) NOT NULL,
  `key_words` text,
  `description` text,
  `lead` text,
  `content` longtext,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `lead_image` varchar(255) DEFAULT NULL,
  `use_lang_as_lead_image` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='a tartalom fordításai';

-- --
-- -- Dumping data for table `content_lang`
-- --
-- 
-- INSERT INTO `content_lang` (`id`, `content_id`, `title`, `SEF`, `key_words`, `description`, `lead`, `content`, `lang_id`, `lead_image`, `use_lang_as_lead_image`) VALUES
-- (1, 1, 'BIO', 'bio', 'bio', 'bio_info', '-', '<p></p><p>Age: 25</p>\r\n\r\n<p>Later he earned\r\nresidency on Digitally Imported (USA), Golden Wings Music Radio (ARG), DNA FM\r\n(ARG), NUBE FM (ARG), houseradio.pl (POL) too. </p>\r\n\r\n<p>He\'s been spinning tracks regularly on other stations as\r\nwell like Frisky Radio (USA), JustMusic FM (HUN) and Rádió1 (HUN).</p>\r\n\r\n<p>He is the co-founder\r\n&amp; manager of Stellar Fountain Records (and it’s sublabel Stellar Fountain\r\nDeep), which he estabilished and run together with MiraculuM (Udvardy György)\r\nand Greyloop (Németh Gergő) since the summer of 2011.</p>\r\n\r\n<p>He began producing in\r\n2010. After acquiring enough knowledge he began to write tracks, and fulfill\r\nremix requests. He has been supported and played by well-known names, like\r\nHernan Cattaneo, Nick Warren, Cid Inc, Soundexile, Solid Stone, Fernando\r\nFerreyra and more…</p>\r\n\r\n<p>After some great events\r\nErich debuted on the biggest festivals of Europe in 2015, like Sziget Festival\r\nin Hungary and Bloque Festival in Greece.</p>He got the opportunity to play\r\nlive with his biggest influence Hernan Cattaneo on 8th April 2016…<p></p>\r\n', 2, NULL, NULL),
-- (2, 2, ' ERICH VON KOLLAR', 'erich-von-kollar', ' ERICH VON KOLLAR', '_', '_', '<iframe class="actAsDiv" width="100%" height="900" src="http://www.youtube.com/embed/mkrK3_08U5o?autoplay=1&amp;loop=1&amp;playlist=mkrK3_08U5o&amp;showinfo=0&amp;theme=dark&amp;color=red&amp;controls=0&amp;modestbranding=1&amp;start=0&amp;fs=0&amp;iv_load_policy=3&amp;wmode=transparent&amp;rel=0" frameborder="0" allowfullscreen=""></iframe>\n', 2, NULL, NULL),
-- (3, 3, 'HISTORY', 'history', 'history', '_', '_', '<div><div><p>After taking a deep dive in the world of electronic music Erich turned his interest to the dj profession in 2006. After a few, smaller radio appereances he debuted on the legendary Proton Radio (USA) in October 2009. He reached numerous top list positions on the channel, which resulted a 5-year exclusive contract with Proton in the beginning of 2010, he had the chance to release a mix album every year called Relations. Along with the contract Erich started a monthly show here, under the same name as his mix series.</p></div></div>', 2, NULL, NULL),
-- (4, 4, 'BIOGRAPHY', 'biography', 'biography, erich von kollar, evk', 'biography', 'biography', '<p>After taking a deep dive in the world of electronic music Erich turned his interest to the dj profession in 2006. After a few, smaller radio appereances he debuted on the legendary Proton Radio (USA) in October 2009. He reached numerous top list positions on the channel, which resulted a 5-year exclusive contract with Proton in the beginning of 2010, he had the chance to release a mix album every year called Relations. Along with the contract Erich started a monthly show here, under the same name as his mix series.</p>\r\n<p>&nbsp;Later he earned residency on Digitally Imported (USA), Golden Wings Music Radio (ARG), DNA FM (ARG), NUBE FM (ARG), houseradio.pl (POL) too.</p>\r\n<p>He\'s been spinning tracks regularly on other stations as well like Frisky Radio (USA), JustMusic FM (HUN) and R&aacute;di&oacute;1 (HUN).</p>\r\n<p>&nbsp;He is the co-founder &amp; manager of Stellar Fountain Records (and it&rsquo;s sublabel Astrowave), which he estabilished and run together with MiraculuM (Udvardy Gy&ouml;rgy) and Greyloop (N&eacute;meth Gergő) since the summer of 2011.</p>\r\n<p>&nbsp;He began producing in 2010. After acquiring enough knowledge he began to write tracks, and fulfill remix requests. He has been supported and played by well-known names, like Hernan Cattaneo, Nick Warren, Cid Inc, Soundexile, Solid Stone, Fernando Ferreyra and more&hellip;</p>\r\n<p>&nbsp;After some great events around Budapest, Amsterdam and Madrid, Erich debuted on the biggest festivals of Europe in 2015, like Sziget Festival in Hungary and Bloque Festival in Greece.</p>\r\n<p>&nbsp;He got the opportunity to play live with his biggest influence Hernan Cattaneo on 8th April 2016&hellip;</p>\r\n<p>&nbsp;</p>\r\n<p>Discography: Balkan Connection, Balkan Connection South America, Proton Compiled &amp; Mixed, Stellar Fountain, Dopamine Music, 3rd Avenue, Forward Music, Soundteller Records, Underground Music Records, Massive Harmony, System Recordings, Per-vurt Records, SexOnWax, Manual Music, Suffused Music, Axon, Visceral, Hot Cue Music, ICONYC Music, Clinique&hellip;&nbsp;&nbsp;&nbsp;</p>\r\n<p><span style="line-height: 1.45em; background-color: initial;">&nbsp;</span></p>', 2, NULL, NULL),
-- (5, 5, 'sound01', 'sound01', 'sound01', 'sound01', 'sound01', '<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/261497651&amp;color=ff9900&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"></iframe>', 2, NULL, NULL),
-- (6, 6, 'sound02', 'sound02', 'sound02', 'sound02', 'sound02', '<p><iframe src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/267583573&amp;color=ff9900&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false" width="100%" height="166" frameborder="no" scrolling="no"></iframe></p>', 2, NULL, NULL),
-- (7, 7, 'Track Terrace, Budapest', 'track-terrace-budapest', 'tour001', 'tour001', '2016.07.02.@Track Terrace, Budapest (HUN)', '2016.07.02.@Track Terrace, Budapest (HUN)\r\n', 2, NULL, NULL),
-- (8, 9, 'Track Terrace', 'track-terrace', 'tour001', 'tour001', '2016.07.09.@Track Terrace, Budapest (HUN)', '<p>07.09.@Track Terrace, Budapest (HUN)</p>\r\n', 2, NULL, NULL),
-- (9, 8, 'Track Terrace', 'tour', 'tour002', 'tour002', '2016.07.02.@Track Terrace, Budapest (HUN)', '07.02.@Track Terrace, Budapest (HUN)\r\n', 2, NULL, NULL),
-- (11, 10, 'Chart - January 2017', 'chart-january-2017', 'chart', 'chart', 'chart', '<p class="charts-list"><span class="c1">01</span><span class="c2">&ndash;</span><span class="c3">Hubert Gomez - Death Lurks (Petar Dundov Remix) [Sudbeat]</span><br /> <span class="c1">02</span><span class="c2">&ndash;</span><span class="c3">Guy J - Been Here Before (Namatjira\'s Ode To Jerry Remix) [Manual]</span><br /> <span class="c1">03</span><span class="c2">&ndash;</span><span class="c3">Madloch - Circle (Dahu Remix) [Sound Avenue]</span><br /> <span class="c1">04</span><span class="c2">&ndash;</span><span class="c3">Cristian R - Mystic [Proton Music]</span><br /> <span class="c1">05</span><span class="c2">&ndash;</span><span class="c3">Peter Makto &amp; Gregory S - The Game [TrueSounds]</span><br /> <span class="c1">06</span><span class="c2">&ndash;</span><span class="c3">Kastis Torrau &amp; Donatello - Ida (Rick Pier O\'Neil &amp; Desaturate Remix) [Particles]</span><br /> <span class="c1">07</span><span class="c2">&ndash;</span><span class="c3">Hot Tuneik - Close Encounters (Nicolas Petracca Remix) [Dopamine Music]</span><br /> <span class="c1">08</span><span class="c2">&ndash;</span><span class="c3">Guy Mantzur - Blooming Fields [PlattenBank]</span><br /> <span class="c1">09</span><span class="c2">&ndash;</span><span class="c3">Traveltech - Invasion (Ziger Remix) [ICONYC]</span><br /> <span class="c1">10</span><span class="c2">&ndash;</span><span class="c3">Marboc - Questions (Erdi Irmak Remix) [Stellar Fountain]</span><br /> <span class="c1">11</span><span class="c2">&ndash;</span><span class="c3">Following Light - Defoliation (Federico Monachesi Remix) [Specific Music]</span><br /> <span class="c1">12</span><span class="c2">&ndash;</span><span class="c3">Huminal - We Dwell in the Past (D-Formation Remix) [Proton Music]</span><br /> <span class="c1">13</span><span class="c2">&ndash;</span><span class="c3">Nicolas Rada - Tempelhof [Sound Avenue]</span><br /> <span class="c1">14</span><span class="c2">&ndash;</span><span class="c3">Simos Tagias - Disco Freak [Proton Music]</span><br /> <span class="c1">15</span><span class="c2">&ndash;</span><span class="c3">Luc Angenehm - Sendher (Orsen Remix) [Proton Music]</span><br /> <span class="c1">16</span><span class="c2">&ndash;</span><span class="c3">Idham - Akhir (Hot TuneiK Remix) [Particles]</span><br /> <span class="c1">17</span><span class="c2">&ndash;</span><span class="c3">Vlada D\'Shake - Ballistic [Dichotomic]</span><br /> <span class="c1">18</span><span class="c2">&ndash;</span><span class="c3">Safinteam - City Legend [Vurtical]</span><br /> <span class="c1">19</span><span class="c2">&ndash;</span><span class="c3">Martin Merkel - Pollux [Promo]</span><br /> <span class="c1">20</span><span class="c2">&ndash;</span><span class="c3">Pritam J - Serene (Erich Von Kollar Frozen Remix) [Itom Records]</span></p>', 2, NULL, NULL),
-- (12, 11, 'Ozora Festival', 'ozora-festival', 'tour, erich von kollar', 'tour003', '2016.08.04.@Ozora Festival, Dádpuszta', '<p>08.04.@Ozora Festival, Dádpuszta</p>\r\n', 2, NULL, NULL),
-- (13, 12, 'Kexx Festival', 'kexx-festival', 'tour', 'tour', '2016.08.05.@Kexx Festival, Hajdöböszörmény', '08.05.@Kexx Festival, Hajdöböszörmény', 2, NULL, NULL),
-- (14, 13, 'Butiq', 'butiq', 'tour', 'tour', '2016.08.06.@Butiq, Debrecen', '08.06.@Butiq, Debrecen', 2, NULL, NULL),
-- (15, 14, 'Udvarground', 'udvarground', 'tour', 'tour', '2016.08.12.@Udvarground, Balmazújváros', '08.12.@Udvarground, Balmazújváros', 2, NULL, NULL),
-- (16, 15, 'Club Escape', 'club-escape', 'tura', 'tour', '2016.08.13.@Club Escape, Szentgotthárd', '08.13.@Club Escape, Szentgotthárd', 2, NULL, NULL),
-- (17, 16, 'Sziget Festival', 'sziget-festival', 'tour', 'tour', '2016.08.14.@Sziget Festival, Budapest', '08.14.@Sziget Festival, Budapest', 2, NULL, NULL),
-- (18, 17, 'Volcz Birtok', 'volcz-birtok', 'tour', 'tour', '2016.09.09.@Volcz Birtok, Ajka', '09.09.@Volcz Birtok, Ajka', 2, NULL, NULL),
-- (19, 18, 'Cinema Hall', 'cinema-hall', 'tour', 'tour', '2016.09.17.@Cinema Hall, Budapest', '09.17.@Cinema Hall, Budapest', 2, NULL, NULL),
-- (20, 19, 'Corvin Club', 'corvin-club', 'tour', 'tour', '2016.10.28.@Corvin Club, Budapest', '10.28.@Corvin Club, Budapest\r\n', 2, NULL, NULL),
-- (21, 20, 'Proba Tartalom', 'proba-tartalom', 'bzhsud', 'proba proba', 'bshuzdfbhzuwe', 'stzjdtzjedtz', 2, NULL, NULL),
-- (22, 21, 'Liquid Album Launch Party', 'liquid-album-launch-party', '', '', '2016.12.03.@Orfeum, Budapest', '<p>K&uuml;hl - Liquid album launch party - The New Era@Orfeum, Budapest (HUN)</p>\r\n<p>w/ K&uuml;hl - East Cafe - Robert R. Hardy - Goyes - Andre</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5817cfdab34b4/en_orfeum_a_pesti_mulato_logo_220x200.png', NULL),
-- (24, 22, 'Members of Prog. House', 'members-of-prog-house', '', '', '2016.12.18.@Cinema Hall, Budapest', '<p>Members of Progressive House - After Party@Cinema Hall, Budapest (HUN)</p>\r\n<p>w/ Quivver - Kintar - Habischman - Slam Jr. - K&uuml;hl - Goyes</p>\r\n<p>- Robert R. Hardy - East Cafe - Andre</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5817dad763c9f/en_CH.png', NULL),
-- (25, 23, 'Butiq XXL Winter Fest', 'butiq-xxl-winter-fest', '', '', '2016.12.28.@Hall, Debrecen', '<p>Butiq XXL Winter Fest@Hall, Debrecen (HUN)</p>\r\n<p>w/ Budai - Dandy - N&eacute;meti </p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5817de4f8a7a4/en_hall.jpg', NULL),
-- (26, 24, 'Mind Against by Corvin Black', 'mind-against-by-corvin-black', '', '', '2016.12.30.@Corvin Club, Budapest', '<p>Corvin Black pres. Mind Against@Corvin Club, Budapest (HUN)</p>\r\n<p>w/ Mind Against - East Cafe - Robert R. Hardy - Goyes - Andre</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5817dffe2bfbb/en_corvin.jpg', NULL),
-- (27, 25, 'SLAM by Legendary Moments and CultUs', 'slam-by-legendary-moments-and-cultus', '', '', '2017.01.07.@Corvin Club, Budapest', '<p>SLAM presented by Legendary Moments &amp; CultUs@Corvin Club, Budapest (HUN)</p>\r\n<p>w/ SLAM - Robert R. Hardy - East Cafe - Goyes - Andre</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5817e1a47b71f/en_corvin.jpg', NULL),
-- (28, 26, 'Fernando Ferreyra - Darin Epsilon by Legendary Moments', 'fernando-ferreyra-darin-epsilon', '', '', '2017.03.04.@Cinema Hall, Budapest', '<p>Fernando Ferreyra &amp; Darin Epsilon by Legendary Moments@Cinema Hall, Budapest (HUN)</p>\r\n<p>w/ Fernando Ferreyra - Darin Epsilon - Robert R. Hardy - East Cafe - Goyes - Andre&nbsp;</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5817e2dd2dd18/en_14203100_980790655377281_341738585835460199_n.jpg', NULL),
-- (29, 27, 'Area-51', 'area-51', '', '', '2017.03.25.@RLGC44, Amsterdam', '<p>Area 51: Buddy\'s B-Day Bash@RLGC44, Amsterdam (NED)</p>\r\n<p>w/ Chris Halen &amp; Buddy Suwijn</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/586ac4d1ca09a/en_artworks-000162311875-ni48m0-t500x500.jpg', NULL),
-- (30, 28, 'Wild at Gate', 'wild-at-gate', '', '', '2017.02.26.@Golden Gate, Berlin', '<p>Wild at Gate@Golden Gate, Berlin (GER)</p>\r\n<p>&nbsp;</p>\r\n<p>w/ Chorris - Alessandra Suit Kei - Kris Adrian - Andrea Chiovelli - Indra/Lilithh</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5880b7d731603/en_gggg.jpg', NULL),
-- (31, 29, 'Fernando Ferreyra - Darin Epsilon by Legendary Moments', 'fernando-ferreyra-darin-epsilon-by-legendary-moments', '', '', '2017.03.04.@Cinema Hall, Budapest', '<p>Fernando Ferreyra &amp; Darin Epsilon by Legendary Moments@Cinema Hall, Budapest (HUN)</p>\r\n<p><br /><br />w/ Fernando Ferreyra - Darin Epsilon - Robert R. Hardy - East Cafe - Goyes - Andre <br /><br /><br /></p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5883c004433bd/en_leggg.jpg', NULL),
-- (32, 30, 'Area-51', 'area-51', '', '', '2017.03.25.@RLGC44, Amsterdam', '<p>Area 51: Buddy\'s B-Day Bash@RLGC44, Amsterdam (NED)</p>\r\n<p><br /><br />w/ Chris Halen &amp; Buddy Suwijn <br /><br />&nbsp;</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5883c0a690767/en_rlllll.jpg', NULL),
-- (33, 31, 'Ozora Festival', 'ozora-festival', '', '', '2017.08.01.@Ozora, Dádpuszta', '<p>Ozora Festival 2017@D&aacute;dpuszta (HUN)</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5883d34699c93/en_20130806ozorafestival_20130410105211.jpg', NULL),
-- (34, 32, 'Side Delight', 'side-delight', '', '', '2017.05.26.@Kikötő, Budapest', '<p>Fine Beats &amp; Stellar Fountain pres. Side Delight@Kik&ouml;tő, Budapest (HUN)</p>\r\n<p>&nbsp;</p>\r\n<p>w/ Levente</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5886741fb11af/en_kikkk.jpg', NULL),
-- (35, 33, 'Side Delight', 'side-delight', '', '', '2017.05.26.@Kikötő, Budapest', '<p>Fine Beats &amp; Stellar Fountain pres. Side Delight@Kik&ouml;tő, Budapest (HUN)</p>\r\n<p>&nbsp;</p>\r\n<p>w/ Levente</p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/58867657733f3/en_kikkk.jpg', NULL),
-- (36, 34, 'TBA', 'tba', '', '', 'TBA@Debrecen', '<p>To Be Announced.... @Debrecen (HUN)</p>\r\n<p>&nbsp;</p>\r\n<p>more info soon.... </p>', 2, '/_projects/evk/uploads/common/content/images/lead_images/5886785b57322/en_check-back-soon.gif', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `content_temp`
--

CREATE TABLE `content_temp` (
  `id` int(10) UNSIGNED NOT NULL,
  `content_temp_text` longtext,
  `content_id` varchar(255) NOT NULL,
  `uid` varchar(50) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_date` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `content_to_page`
--

CREATE TABLE `content_to_page` (
  `content_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `content_to_page`
--

INSERT INTO `content_to_page` (`content_id`, `page_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `code`) VALUES
(1, 'HU');

-- --------------------------------------------------------

--
-- Table structure for table `country_lang`
--

CREATE TABLE `country_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `country_lang`
--

INSERT INTO `country_lang` (`id`, `name`, `lang_id`, `country_id`) VALUES
(1, 'Magyarország', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `date` int(11) NOT NULL COMMENT 'Melyik nap árfolyama(timestamp)',
  `currency_id` int(10) UNSIGNED NOT NULL COMMENT 'Melyik valutához tartoznak az árfolyamok. 3 betűs ISO kódja a valutának(pl: HUF, USD, EUR)',
  `currencies_json` longtext NOT NULL COMMENT 'Árfolyamok JSON-ben. Azért JSON, hogyha bővül, akkor ne kelljen hozzányúlni.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='MNB-től lekért forint árfolyam';

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(3) NOT NULL COMMENT 'a valuta iso kódja',
  `specie_name` varchar(20) DEFAULT NULL COMMENT 'váltópénz neve',
  `specie_token` varchar(5) DEFAULT NULL COMMENT 'a váltópénz jele',
  `change_number` int(11) NOT NULL DEFAULT '0' COMMENT 'a váltópénz váltószáma',
  `display_name` varchar(6) DEFAULT NULL,
  `display_specie_name` varchar(6) DEFAULT NULL,
  `position` varchar(6) NOT NULL DEFAULT 'after'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`id`, `name`, `specie_name`, `specie_token`, `change_number`, `display_name`, `display_specie_name`, `position`) VALUES
(1, 'HUF', NULL, NULL, 0, NULL, NULL, 'after');

-- --------------------------------------------------------

--
-- Table structure for table `date_time_formats`
--

CREATE TABLE `date_time_formats` (
  `id` int(10) UNSIGNED NOT NULL,
  `format` varchar(50) NOT NULL COMMENT 'a formátum',
  `date_separator` varchar(1) NOT NULL,
  `time_separator` varchar(1) NOT NULL,
  `date_time_separator` varchar(1) NOT NULL,
  `date_order` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `date_time_formats`
--

INSERT INTO `date_time_formats` (`id`, `format`, `date_separator`, `time_separator`, `date_time_separator`, `date_order`) VALUES
(1, 'Y-m-d H:i:s', '-', ':', ' ', '["year","month","day"]');

-- --------------------------------------------------------

--
-- Table structure for table `denominations`
--

CREATE TABLE `denominations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `denomination_type_id` int(10) UNSIGNED DEFAULT NULL,
  `specie` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `value` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `denomination_types`
--

CREATE TABLE `denomination_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

CREATE TABLE `document` (
  `id` int(10) UNSIGNED NOT NULL,
  `document_category_item_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `privilege` longtext,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_category`
--

CREATE TABLE `document_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `structure` longtext,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_category_item`
--

CREATE TABLE `document_category_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `document_category_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_category_item_lang`
--

CREATE TABLE `document_category_item_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `document_category_item_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_category_lang`
--

CREATE TABLE `document_category_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `document_category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_flag`
--

CREATE TABLE `document_flag` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_flags`
--

CREATE TABLE `document_flags` (
  `document_flag_id` int(10) UNSIGNED NOT NULL,
  `document_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_flag_lang`
--

CREATE TABLE `document_flag_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `document_flag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `document_lang`
--

CREATE TABLE `document_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `document_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dir` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `mime_type` varchar(150) DEFAULT NULL,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `start_time` int(10) UNSIGNED DEFAULT NULL,
  `end_time` int(10) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `public_event` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `date_time_zone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Események';

-- --------------------------------------------------------

--
-- Table structure for table `events_to_page`
--

CREATE TABLE `events_to_page` (
  `events_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Események page-ekhez';

-- --------------------------------------------------------

--
-- Table structure for table `event_categories`
--

CREATE TABLE `event_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `color` varchar(255) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_categories_lang`
--

CREATE TABLE `event_categories_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `event_categories_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_categories_to_events`
--

CREATE TABLE `event_categories_to_events` (
  `event_categories_id` int(10) UNSIGNED NOT NULL,
  `events_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_categories_to_page`
--

CREATE TABLE `event_categories_to_page` (
  `event_categories_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_locations`
--

CREATE TABLE `event_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `web_page` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Események helyszínek';

-- --------------------------------------------------------

--
-- Table structure for table `event_locations_to_events`
--

CREATE TABLE `event_locations_to_events` (
  `events_id` int(10) UNSIGNED NOT NULL,
  `event_locations_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esemény helyszínei';

-- --------------------------------------------------------

--
-- Table structure for table `event_organisers`
--

CREATE TABLE `event_organisers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `fax` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `web_page` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rendezők vagy szervezők';

-- --------------------------------------------------------

--
-- Table structure for table `event_organisers_to_events`
--

CREATE TABLE `event_organisers_to_events` (
  `events_id` int(10) UNSIGNED NOT NULL,
  `event_organisers_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Esemény szervezői';

-- --------------------------------------------------------

--
-- Table structure for table `event_schedule`
--

CREATE TABLE `event_schedule` (
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `external_privilege`
--

CREATE TABLE `external_privilege` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `privilege` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `external_privilege_group`
--

CREATE TABLE `external_privilege_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `privileges` longtext NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `use_in_registration` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `external_user`
--

CREATE TABLE `external_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `last_login` int(10) UNSIGNED DEFAULT NULL,
  `active` int(1) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `self_modified_date` int(10) UNSIGNED DEFAULT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `external_privilege_group_id` int(10) UNSIGNED DEFAULT NULL,
  `page_id` int(10) UNSIGNED DEFAULT NULL,
  `external_user_data_id` int(10) UNSIGNED NOT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `date_time_formats_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `external_user_data`
--

CREATE TABLE `external_user_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `shop_id` int(10) UNSIGNED DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `title` varchar(50) DEFAULT '',
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `shopper_group_id` int(10) UNSIGNED DEFAULT NULL,
  `payment_deadline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `payment_method_flag` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `currency_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `financial_institution`
--

CREATE TABLE `financial_institution` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'A pénzintézet id-ja',
  `name` varchar(255) NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `firm`
--

CREATE TABLE `firm` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `home` int(10) UNSIGNED DEFAULT NULL COMMENT 'székhely -  egy telephely id-ja',
  `tax_number` varchar(255) NOT NULL COMMENT 'adószám',
  `community_tax_number` varchar(255) DEFAULT NULL COMMENT 'közösségi adószám',
  `firm_registration_number` varchar(255) NOT NULL COMMENT 'cégjegyzékszám',
  `email` varchar(255) NOT NULL COMMENT 'a cég email címe',
  `web_sites` text COMMENT 'webcímek',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `date_time_formats_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `date` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(100) NOT NULL,
  `cover_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `path`, `user_group_id`, `date`, `created_by`, `created_date`, `modified_by`, `modified_date`, `active`, `type`, `cover_image`) VALUES
(12, '2016-03-25', 2, 1458922424, 2, 1458895980, 3, 1466691224, 1, 'image', 'galery_56f50a7c105c2.jpg'),
(13, '2016-03-25', 2, 1458900197, 2, 1458899177, 3, 1463644997, 1, 'video', 'video_56f516f9bbaf3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_item`
--

CREATE TABLE `gallery_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `gallery_id` int(10) UNSIGNED NOT NULL,
  `source` varchar(255) NOT NULL,
  `preview` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallery_item`
--

INSERT INTO `gallery_item` (`id`, `gallery_id`, `source`, `preview`) VALUES
(36, 12, '56f52ef5797bd-erich1.jpg', NULL),
(38, 12, '56f52ef759867-erich-press4-new.png', NULL),
(46, 12, '576c065ad4058-erich3.jpg', NULL),
(47, 12, '576c0669c68f4-press2.jpg', NULL),
(48, 12, '576c067a12ea8-press6.jpg', NULL),
(49, 12, '576c0684c234e-press3.jpg', NULL),
(50, 12, '576c06ffedec4-erich2.jpg', NULL),
(51, 12, '576c07c0091d2-hand2.jpg', NULL),
(52, 12, '576c07f8c4c59-13071843-1037047106383895-4782864020871892666-o.jpg', NULL),
(54, 12, '576c09a2b36b5-12241484-642752379215204-6016550115931705838-n.jpg', NULL),
(55, 12, '576c09b1d55c7-press4.jpg', NULL),
(56, 12, '576c09d49d7ce-12439194-642717522552023-1806008524370962806-n.jpg', NULL),
(57, 12, '576c0a2f67a63-12891079-642713215885787-6065684223815625037-o.jpg', NULL),
(58, 12, '576c0a66f1aca-erich7.jpg', NULL),
(59, 12, '576c0ab42e782-12891115-642701619220280-2234341311662855381-o.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gallery_item_lang`
--

CREATE TABLE `gallery_item_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `gallery_item_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `gallery_lang`
--

CREATE TABLE `gallery_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `gallery_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sef` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallery_lang`
--

INSERT INTO `gallery_lang` (`id`, `gallery_id`, `lang_id`, `name`, `sef`) VALUES
(18, 12, 1, 'GALLERY', 'galery'),
(19, 12, 2, 'GALLERY', 'galery'),
(20, 13, 1, 'Video', 'video'),
(21, 13, 2, 'Video', 'video');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_to_page`
--

CREATE TABLE `gallery_to_page` (
  `gallery_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gallery_to_page`
--

INSERT INTO `gallery_to_page` (`gallery_id`, `page_id`) VALUES
(12, 1),
(13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(10) UNSIGNED NOT NULL,
  `invoice_data` longtext,
  `number_of_copy` int(11) NOT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `reverse_invoice_id` int(11) DEFAULT NULL,
  `payment_deadline` int(11) NOT NULL,
  `billing_date` int(11) NOT NULL,
  `note` longtext,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `lang`
--

CREATE TABLE `lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `lang` varchar(255) NOT NULL,
  `lang_short_name` varchar(10) NOT NULL,
  `date_time_formats_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A felhasználócsoport nyelveit tartalmazó file';

--
-- Dumping data for table `lang`
--

INSERT INTO `lang` (`id`, `lang`, `lang_short_name`, `date_time_formats_id`) VALUES
(1, 'Magyar', 'hu', 1),
(2, 'Angol', 'en', 1);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'a telephely neve',
  `fax` varchar(45) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `post_code` varchar(12) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `firm_id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `manufacturer`
--

CREATE TABLE `manufacturer` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'a gyártó neve',
  `web_address` varchar(255) DEFAULT NULL COMMENT 'a gyártó hivatalos oldalának címe',
  `ico` varchar(255) DEFAULT NULL COMMENT 'a gyártó logóképémek neve',
  `user_group_id` int(10) UNSIGNED NOT NULL COMMENT 'a felhasználói csoport amelyben felvitték a gyártót'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `media_album`
--

CREATE TABLE `media_album` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `cover_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_album`
--

INSERT INTO `media_album` (`id`, `user_group_id`, `created_by`, `created_date`, `modified_by`, `modified_date`, `active`, `cover_image`) VALUES
(100, 2, 2, 1469800809, 3, 1483817054, 1, NULL),
(101, 2, 2, 1469802155, 3, 1477959197, 1, NULL),
(102, 2, 3, 1470048097, 3, 1470048097, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media_album_lang`
--

CREATE TABLE `media_album_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `media_album_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sef` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_album_lang`
--

INSERT INTO `media_album_lang` (`id`, `media_album_id`, `lang_id`, `name`, `sef`) VALUES
(50, 100, 1, 'Soundcloud', NULL),
(51, 100, 2, 'Soundcloud', 'https://soundcloud.com/erichvonkollar/erich-von-kollar-relations-2016-december'),
(52, 101, 1, 'Képek', NULL),
(53, 101, 2, 'Photos', NULL),
(54, 102, 1, 'Video', NULL),
(55, 102, 2, 'Video', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media_album_to_page`
--

CREATE TABLE `media_album_to_page` (
  `album_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_album_to_page`
--

INSERT INTO `media_album_to_page` (`album_id`, `page_id`) VALUES
(100, 1),
(101, 1),
(102, 1);

-- --------------------------------------------------------

--
-- Table structure for table `media_category`
--

CREATE TABLE `media_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_category`
--

INSERT INTO `media_category` (`id`, `lft`, `rgt`, `user_group_id`, `active`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted`, `deleted_by`, `deleted_date`) VALUES
(40, 1, 8, 2, 1, 2, 1458555204, 2, 1458555204, 0, NULL, NULL),
(41, 2, 3, 2, 1, 2, 1469800732, 2, 1469800732, 0, NULL, NULL),
(43, 4, 5, 2, 1, 3, 1470047346, 3, 1470047346, 0, NULL, NULL),
(44, 6, 7, 2, 1, 3, 1470047348, 3, 1470047348, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `media_category_items`
--

CREATE TABLE `media_category_items` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_category_items`
--

INSERT INTO `media_category_items` (`category_id`, `item_id`) VALUES
(43, 418);

-- --------------------------------------------------------

--
-- Table structure for table `media_category_lang`
--

CREATE TABLE `media_category_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_category_lang`
--

INSERT INTO `media_category_lang` (`id`, `lang_id`, `category_id`, `name`, `description`) VALUES
(152, 1, 40, '', ''),
(153, 2, 40, '', ''),
(154, 1, 41, 'Zene', ''),
(155, 2, 41, 'Music', ''),
(156, 1, 43, 'Videó', ''),
(157, 2, 43, 'Video', ''),
(158, 1, 44, 'Képek', ''),
(159, 2, 44, 'Photos', '');

-- --------------------------------------------------------

--
-- Table structure for table `media_item`
--

CREATE TABLE `media_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `media_album_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `publish_date` int(10) UNSIGNED DEFAULT NULL,
  `unpublish_date` int(10) UNSIGNED DEFAULT NULL,
  `source` varchar(255) NOT NULL,
  `preview` varchar(255) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `mime` varchar(200) DEFAULT NULL,
  `sort` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_item`
--

INSERT INTO `media_item` (`id`, `media_album_id`, `created_by`, `created_date`, `modified_by`, `modified_date`, `publish_date`, `unpublish_date`, `source`, `preview`, `type`, `mime`, `sort`) VALUES
(394, 101, 2, 1469802262, 2, 1469802262, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b8336ae438-56f52ef66c7bd-erich3.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b8336ae438-56f52ef66c7bd-erich3.jpg', 'image', 'image/jpeg', 394),
(395, 101, 2, 1469802263, 2, 1469802263, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b8336e7294-56f52ef5797bd-erich1.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b8336e7294-56f52ef5797bd-erich1.jpg', 'image', 'image/jpeg', 395),
(397, 101, 2, 1469802264, 2, 1469802264, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b8337d466e-576c0a2f67a63-12891079-642713215885787-6065684223815625037-o.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b8337d466e-576c0a2f67a63-12891079-642713215885787-6065684223815625037-o.jpg', 'image', 'image/jpeg', 397),
(398, 101, 2, 1469802264, 2, 1469802264, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b83388f7b0-576c0a66f1aca-erich7.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b83388f7b0-576c0a66f1aca-erich7.jpg', 'image', 'image/jpeg', 398),
(399, 101, 2, 1469802265, 2, 1469802265, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b8338cf1ed-576c0ab42e782-12891115-642701619220280-2234341311662855381-o.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b8338cf1ed-576c0ab42e782-12891115-642701619220280-2234341311662855381-o.jpg', 'image', 'image/jpeg', 399),
(400, 101, 2, 1469802265, 2, 1469802265, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833987e7d-574d62ecc5fbf-12928305-642758139214628-8604491769126697464-n.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833987e7d-574d62ecc5fbf-12928305-642758139214628-8604491769126697464-n.jpg', 'image', 'image/jpeg', 400),
(401, 101, 2, 1469802266, 2, 1469802266, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b8339e4c3a-576c06ffedec4-erich2.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b8339e4c3a-576c06ffedec4-erich2.jpg', 'image', 'image/jpeg', 401),
(402, 101, 2, 1469802266, 2, 1469802266, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833a2a807-576c07c0091d2-hand2.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833a2a807-576c07c0091d2-hand2.jpg', 'image', 'image/jpeg', 402),
(403, 101, 2, 1469802267, 2, 1469802267, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833ad2d7d-576c07f8c4c59-13071843-1037047106383895-4782864020871892666-o.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833ad2d7d-576c07f8c4c59-13071843-1037047106383895-4782864020871892666-o.jpg', 'image', 'image/jpeg', 403),
(404, 101, 2, 1469802267, 2, 1469802267, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833b25769-576c09d49d7ce-12439194-642717522552023-1806008524370962806-n.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833b25769-576c09d49d7ce-12439194-642717522552023-1806008524370962806-n.jpg', 'image', 'image/jpeg', 404),
(405, 101, 2, 1469802267, 2, 1469802267, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833b69adb-576c09b1d55c7-press4.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833b69adb-576c09b1d55c7-press4.jpg', 'image', 'image/jpeg', 405),
(406, 101, 2, 1469802267, 2, 1469802267, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833ba9c72-576c09a2b36b5-12241484-642752379215204-6016550115931705838-n.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833ba9c72-576c09a2b36b5-12241484-642752379215204-6016550115931705838-n.jpg', 'image', 'image/jpeg', 406),
(407, 101, 2, 1469802268, 2, 1469802268, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833beda2c-576c0669c68f4-press2.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833beda2c-576c0669c68f4-press2.jpg', 'image', 'image/jpeg', 407),
(409, 101, 2, 1469802268, 2, 1469802268, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833c6f645-576c067a12ea8-press6.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833c6f645-576c067a12ea8-press6.jpg', 'image', 'image/jpeg', 409),
(410, 101, 2, 1469802268, 2, 1469802268, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/579b833cadfd8-576c0684c234e-press3.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/579b833cadfd8-576c0684c234e-press3.jpg', 'image', 'image/jpeg', 410),
(418, 102, 3, 1470048114, 3, 1470048147, NULL, NULL, 'JllGL4lkO6A', 'https://img.youtube.com/vi/JllGL4lkO6A/2.jpg', 'youtube', NULL, 418),
(422, 100, 2, 1470142834, 2, 1470142834, NULL, NULL, '220981959', 'http://i1.sndcdn.com/artworks-000127562694-xinnrm-t500x500.jpg', 'soundcloud', NULL, 423),
(423, 100, 2, 1470142856, 2, 1470142856, NULL, NULL, '206575446', 'http://i1.sndcdn.com/artworks-000117576706-y3jqx6-t500x500.jpg', 'soundcloud', NULL, 421),
(424, 100, 2, 1470142874, 2, 1470142874, NULL, NULL, '199691240', 'http://i1.sndcdn.com/artworks-000112620157-zh3mqj-t500x500.jpg', 'soundcloud', NULL, 426),
(425, 100, 2, 1470142891, 2, 1470142891, NULL, NULL, '193383971', 'http://i1.sndcdn.com/artworks-000108319048-wuh6zz-t500x500.jpg', 'soundcloud', NULL, 425),
(426, 100, 2, 1470142920, 2, 1470142920, NULL, NULL, '103291238', 'http://i1.sndcdn.com/artworks-000054138319-0l4g4a-t500x500.jpg', 'soundcloud', NULL, 429),
(431, 101, 3, 1477958221, 3, 1477958221, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/5817e85db3ca9-13502100-1408514819174104-2731654858290933523-n.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/5817e85db3ca9-13502100-1408514819174104-2731654858290933523-n.jpg', 'image', 'image/jpeg', 431),
(432, 101, 3, 1477959030, 3, 1477959030, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/5817eb8511d9e-hungary.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/5817eb8511d9e-hungary.jpg', 'image', 'image/jpeg', 432),
(433, 101, 3, 1477959547, 3, 1477959547, NULL, NULL, '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/large/5817ed8a46625-hand1.jpg', '/_projects/evk/uploads/common/mediacenter/albums/album_101/image/small/5817ed8a46625-hand1.jpg', 'image', 'image/jpeg', 433),
(439, 100, 3, 1485027124, 3, 1485027124, NULL, NULL, '278853732', 'http://i1.sndcdn.com/artworks-000177338528-zbo8op-t500x500.jpg', 'soundcloud', NULL, 424),
(442, 100, 3, 1485027602, 3, 1485027602, NULL, NULL, '261497651', 'http://i1.sndcdn.com/artworks-000160416271-imr170-t500x500.jpg', 'soundcloud', NULL, 0),
(443, 100, 3, 1485027776, 3, 1485027776, NULL, NULL, '280458561', 'http://i1.sndcdn.com/artworks-000183172829-sj2fws-t500x500.jpg', 'soundcloud', NULL, 422),
(445, 100, 3, 1485851272, 3, 1485851272, NULL, NULL, '305275453', 'http://i1.sndcdn.com/artworks-000205454997-cfg7fd-t500x500.jpg', 'soundcloud', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `media_item_lang`
--

CREATE TABLE `media_item_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `media_item_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `media_item_lang`
--

INSERT INTO `media_item_lang` (`id`, `media_item_id`, `lang_id`, `title`, `description`) VALUES
(551, 394, 1, '56f52ef66c7bd-erich3.jpg', NULL),
(552, 394, 2, '56f52ef66c7bd-erich3.jpg', NULL),
(553, 395, 1, '56f52ef5797bd-erich1.jpg', NULL),
(554, 395, 2, '56f52ef5797bd-erich1.jpg', NULL),
(557, 397, 1, '576c0a2f67a63-12891079-642713215885787-6065684223815625037-o.jpg', NULL),
(558, 397, 2, '576c0a2f67a63-12891079-642713215885787-6065684223815625037-o.jpg', NULL),
(559, 398, 1, '576c0a66f1aca-erich7.jpg', NULL),
(560, 398, 2, '576c0a66f1aca-erich7.jpg', NULL),
(561, 399, 1, '576c0ab42e782-12891115-642701619220280-2234341311662855381-o.jpg', NULL),
(562, 399, 2, '576c0ab42e782-12891115-642701619220280-2234341311662855381-o.jpg', NULL),
(563, 400, 1, '574d62ecc5fbf-12928305-642758139214628-8604491769126697464-n.jpg', NULL),
(564, 400, 2, '574d62ecc5fbf-12928305-642758139214628-8604491769126697464-n.jpg', NULL),
(565, 401, 1, '576c06ffedec4-erich2.jpg', NULL),
(566, 401, 2, '576c06ffedec4-erich2.jpg', NULL),
(567, 402, 1, '576c07c0091d2-hand2.jpg', NULL),
(568, 402, 2, '576c07c0091d2-hand2.jpg', NULL),
(569, 403, 1, '576c07f8c4c59-13071843-1037047106383895-4782864020871892666-o.jpg', NULL),
(570, 403, 2, '576c07f8c4c59-13071843-1037047106383895-4782864020871892666-o.jpg', NULL),
(571, 404, 1, '576c09d49d7ce-12439194-642717522552023-1806008524370962806-n.jpg', NULL),
(572, 404, 2, '576c09d49d7ce-12439194-642717522552023-1806008524370962806-n.jpg', NULL),
(573, 405, 1, '576c09b1d55c7-press4.jpg', NULL),
(574, 405, 2, '576c09b1d55c7-press4.jpg', NULL),
(575, 406, 1, '576c09a2b36b5-12241484-642752379215204-6016550115931705838-n.jpg', NULL),
(576, 406, 2, '576c09a2b36b5-12241484-642752379215204-6016550115931705838-n.jpg', NULL),
(577, 407, 1, '576c0669c68f4-press2.jpg', NULL),
(578, 407, 2, '576c0669c68f4-press2.jpg', NULL),
(581, 409, 1, '576c067a12ea8-press6.jpg', NULL),
(582, 409, 2, '576c067a12ea8-press6.jpg', NULL),
(583, 410, 1, '576c0684c234e-press3.jpg', NULL),
(584, 410, 2, '576c0684c234e-press3.jpg', NULL),
(599, 418, 1, 'RLGC44 Amsterdam 260316', NULL),
(600, 418, 2, 'RLGC44 Amsterdam 260316', NULL),
(607, 422, 1, 'John Cosani - Love Song (Erich Von Kollar Remix) -preview by Erich Von Kollar', NULL),
(608, 422, 2, 'John Cosani - Love Song (Erich Von Kollar Remix) -preview by Erich Von Kollar', NULL),
(609, 423, 1, 'Erich Von Kollar - Stardust & Bubbles /preview/ by Erich Von Kollar', NULL),
(610, 423, 2, 'Erich Von Kollar - Stardust & Bubbles /preview/ by Erich Von Kollar', NULL),
(611, 424, 1, 'Anton MAKe - Lost In Amsterdam (Erich Von Kollar Remix) -preview by Erich Von Kollar', NULL),
(612, 424, 2, 'Anton MAKe - Lost In Amsterdam (Erich Von Kollar Remix) -preview by Erich Von Kollar', NULL),
(613, 425, 1, 'Erich Von Kollar & East Cafe - Dimensions Crossed [Per -vurt Records] -preview by Erich Von Kollar', NULL),
(614, 425, 2, 'Erich Von Kollar & East Cafe - Dimensions Crossed [Per -vurt Records] -preview by Erich Von Kollar', NULL),
(615, 426, 1, 'Erich Von Kollar - Parallel Flashbacks (Original Mix) -preview by Erich Von Kollar', NULL),
(616, 426, 2, 'Erich Von Kollar - Parallel Flashbacks (Original Mix) -preview by Erich Von Kollar', NULL),
(629, 431, 1, '13502100_1408514819174104_2731654858290933523_n.jpg', NULL),
(630, 431, 2, '13502100_1408514819174104_2731654858290933523_n.jpg', NULL),
(631, 432, 1, 'hungary.jpg', NULL),
(632, 432, 2, 'hungary.jpg', NULL),
(633, 433, 1, 'hand1.jpg', NULL),
(634, 433, 2, 'hand1.jpg', NULL),
(645, 439, 1, 'One Opinion - Bright Matter (Erich Von Kollar Remix) [Manual Music] -preview by Erich Von Kollar', NULL),
(646, 439, 2, 'One Opinion - Bright Matter (Erich Von Kollar Remix) [Manual Music] -preview by Erich Von Kollar', NULL),
(651, 442, 1, 'Erich Von Kollar - Warm Up For Hernan Cattaneo@HALL - Debrecen, Hungary 2016.04.08. by Erich Von Kollar', NULL),
(652, 442, 2, 'Erich Von Kollar - Warm Up For Hernan Cattaneo@HALL - Debrecen, Hungary 2016.04.08. by Erich Von Kollar', NULL),
(653, 443, 1, 'Verve - Sweeps (Erich Von Kollar Remix) -preview by Erich Von Kollar', NULL),
(654, 443, 2, 'Verve - Sweeps (Erich Von Kollar Remix) -preview by Erich Von Kollar', NULL),
(657, 445, 1, 'Erich Von Kollar - Relations 2017 January by Erich Von Kollar', NULL),
(658, 445, 2, 'Erich Von Kollar - Relations 2017 January by Erich Von Kollar', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `menu_tree` text,
  `created_by` int(11) NOT NULL,
  `created_date` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_date` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `dir` varchar(255) DEFAULT NULL COMMENT 'az itemek ikonjainak mappája',
  `system_menu` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `active`, `user_group_id`, `name`, `menu_tree`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted`, `deleted_by`, `deleted_date`, `dir`, `system_menu`) VALUES
(1, 1, 2, 'Főmenü', '[{ "id" : "4","childs":[]},{ "id" : "5","childs":[]},{ "id" : "6","childs":[]},{ "id" : "7","childs":[]},{ "id" : "13","childs":[]},{ "id" : "8","childs":[]},{ "id" : "9","childs":[]},{ "id" : "11","childs":[]},{ "id" : "14","childs":[]},{ "id" : "12","childs":[]},{ "id" : "10","childs":[]}]', 2, 1458310766, 2, 1470037452, 0, NULL, NULL, '56ec1c7ed1e17', 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu_item`
--

CREATE TABLE `menu_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED NOT NULL,
  `ico` varchar(255) DEFAULT NULL,
  `component_name` varchar(150) NOT NULL DEFAULT '',
  `modul_type` text NOT NULL,
  `modul_type_content_id` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `visibility` varchar(20) NOT NULL DEFAULT 'always',
  `created_by` int(11) NOT NULL,
  `created_date` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modified_date` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `privilege` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`id`, `menu_id`, `ico`, `component_name`, `modul_type`, `modul_type_content_id`, `active`, `visibility`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted`, `deleted_by`, `deleted_date`, `privilege`) VALUES
(4, 1, NULL, 'externallink', '["externallink"]', '["\\/#top-page"]', 1, 'always', 2, 1458545679, 2, 1458545679, 0, NULL, NULL, ''),
(5, 1, NULL, 'externallink', '["externallink"]', '["\\/#bio"]', 1, 'always', 2, 1458546582, 2, 1458547073, 0, NULL, NULL, ''),
(6, 1, NULL, 'externallink', '["externallink"]', '["\\/#tours"]', 1, 'always', 2, 1458546914, 2, 1458546914, 0, NULL, NULL, ''),
(7, 1, NULL, 'externallink', '["externallink"]', '["\\/#music"]', 1, 'always', 2, 1458546975, 2, 1458547093, 0, NULL, NULL, ''),
(8, 1, NULL, 'externallink', '["externallink"]', '["news"]', 0, 'always', 2, 1458547006, 2, 1458554865, 0, NULL, NULL, ''),
(9, 1, NULL, 'externallink', '["externallink"]', '["store"]', 0, 'always', 2, 1458547131, 2, 1458554858, 0, NULL, NULL, ''),
(10, 1, NULL, 'externallink', '["externallink"]', '["\\/#contact"]', 1, 'always', 2, 1458547188, 2, 1458547188, 0, NULL, NULL, ''),
(11, 1, NULL, 'externallink', '["externallink"]', '["\\/#gallery"]', 1, 'always', 3, 1461136640, 3, 1461136640, 0, NULL, NULL, ''),
(12, 1, NULL, 'externallink', '["externallink"]', '["https:\\/\\/www.facebook.com\\/Stellar-Fountain-Records-228059947236825\\/?fref=ts"]', 1, 'always', 3, 1461136967, 2, 1466683190, 0, NULL, NULL, ''),
(13, 1, NULL, 'externallink', '["externallink"]', '["\\/#video"]', 1, 'always', 2, 1464010587, 2, 1464010587, 0, NULL, NULL, ''),
(14, 1, NULL, 'externallink', '["externallink"]', '["\\/#chart"]', 1, 'always', 2, 1464010587, 2, 1464010587, 0, NULL, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_lang`
--

CREATE TABLE `menu_item_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_item_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `sef` varchar(255) DEFAULT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu_item_lang`
--

INSERT INTO `menu_item_lang` (`id`, `menu_item_id`, `name`, `sef`, `lang_id`) VALUES
(6, 4, 'HOME', NULL, 1),
(7, 4, 'HOME', NULL, 2),
(8, 5, 'BIO', '', 1),
(9, 5, 'BIO', '', 2),
(10, 6, 'TOURS', NULL, 1),
(11, 6, 'TOURS', NULL, 2),
(12, 7, 'MUSIC', '', 1),
(13, 7, 'MUSIC', '', 2),
(14, 8, 'NEWS', '', 1),
(15, 8, 'NEWS', '', 2),
(16, 9, 'STORE', '', 1),
(17, 9, 'STORE', '', 2),
(18, 10, 'CONTACT', NULL, 1),
(19, 10, 'CONTACT', NULL, 2),
(20, 11, 'GALLERY', NULL, 1),
(21, 11, 'GALLERY', NULL, 2),
(22, 12, 'STELLAR', '', 1),
(23, 12, 'STELLAR', '', 2),
(24, 13, 'VIDEO', NULL, 1),
(25, 13, 'VIDEO', NULL, 2),
(26, 14, 'CHART', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `menu_to_page`
--

CREATE TABLE `menu_to_page` (
  `menu_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu_to_page`
--

INSERT INTO `menu_to_page` (`menu_id`, `page_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscribers`
--

CREATE TABLE `newsletter_subscribers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subscribe_date` int(10) UNSIGNED NOT NULL,
  `unsubscribe_date` int(11) DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `external_user_data_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `billing_data_id` int(10) UNSIGNED NOT NULL,
  `address` varchar(255) NOT NULL,
  `billing_address_id` int(10) UNSIGNED NOT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `shipping_address_id` int(10) UNSIGNED DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `tax_number` varchar(255) DEFAULT NULL,
  `bank_account_number` varchar(255) DEFAULT NULL,
  `shipping_method_id` int(10) UNSIGNED DEFAULT NULL,
  `shipping_date` int(10) UNSIGNED DEFAULT NULL,
  `invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `payment_method_flag` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `payment_method_id` int(10) UNSIGNED DEFAULT NULL,
  `payed` double NOT NULL DEFAULT '0',
  `payment_deadline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `net_price` double NOT NULL,
  `gross_price` double NOT NULL,
  `from_web_shop` tinyint(1) NOT NULL DEFAULT '0',
  `shop_id` int(10) UNSIGNED NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL COMMENT 'a rendelést létrehozó',
  `created_date` int(10) UNSIGNED DEFAULT NULL,
  `expire_time` int(10) UNSIGNED DEFAULT NULL COMMENT 'lejárati idő a szerkesztésnél, hogy egyszerre csak 1 user használja',
  `modified_by` int(10) UNSIGNED DEFAULT NULL,
  `modified_date` int(10) UNSIGNED DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `location_id` int(10) UNSIGNED DEFAULT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_content`
--

CREATE TABLE `order_content` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `number_of_product` double NOT NULL,
  `total_net_price` double NOT NULL,
  `total_gross_price` double NOT NULL,
  `vat` float NOT NULL,
  `excise_tax` float NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `ttk_code` varchar(100) DEFAULT NULL,
  `note` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_packing_slip`
--

CREATE TABLE `order_packing_slip` (
  `id` int(10) UNSIGNED NOT NULL,
  `packing_slip_data` longtext,
  `shipping_date` int(10) UNSIGNED NOT NULL,
  `note` longtext,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `order_packing_slip_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  `packing_slip_number` varchar(255) DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `purchased_product_id` varchar(255) DEFAULT NULL,
  `net_price` double NOT NULL,
  `vat` float NOT NULL,
  `excise_tax` float NOT NULL,
  `gross_price` double NOT NULL,
  `order_content_id` bigint(20) UNSIGNED NOT NULL,
  `returned_product_order_content_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `packet`
--

CREATE TABLE `packet` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL COMMENT 'A felhasználói csoport amihez a csomagolási típust hozzá adták'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `packet_lang`
--

CREATE TABLE `packet_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `packet_id` int(10) UNSIGNED NOT NULL COMMENT 'a csomagolás id-je amihez a fordítás tartozik',
  `lang_id` int(10) UNSIGNED NOT NULL COMMENT 'A fordítás nyelve',
  `name` varchar(255) NOT NULL COMMENT 'a fordítás'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip`
--

CREATE TABLE `packing_slip` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `certificate_number` varchar(255) NOT NULL,
  `packing_slip_number` varchar(255) DEFAULT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `supplier_data` mediumtext,
  `packing_slip_date` int(10) UNSIGNED DEFAULT NULL,
  `total_net_price` double DEFAULT NULL,
  `total_gross_price` double DEFAULT NULL,
  `currency_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED DEFAULT NULL,
  `modified_date` int(10) UNSIGNED DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(10) UNSIGNED NOT NULL,
  `reverse_packingslip_id` int(10) UNSIGNED DEFAULT NULL,
  `reverse_packingslip` tinyint(1) DEFAULT '0',
  `reverse_note` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_content`
--

CREATE TABLE `packing_slip_content` (
  `id` varchar(255) NOT NULL COMMENT 'az id: uniquid() . ''_'' .(user_group_id).''_''.(packing_slip_id).''_''.(row_in)',
  `packing_slip_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `number_of_product` int(10) NOT NULL,
  `total_net_price` double NOT NULL,
  `total_gross_price` double NOT NULL,
  `vat` float UNSIGNED NOT NULL,
  `excise_tax` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `packing_unit`
--

CREATE TABLE `packing_unit` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT 'A termék id-ja amihez a csomagolási beállítás tartozik',
  `packet_id` int(10) UNSIGNED NOT NULL COMMENT 'A csomagolás idje',
  `products_in_packet` int(10) UNSIGNED NOT NULL COMMENT 'termék egy csomagolási egységben',
  `user_group_id` int(10) UNSIGNED NOT NULL COMMENT 'felhasználói csoport amelyben a a csomagolás létezik',
  `deleted` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE `page` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `domain_name` varchar(255) NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'Page_id, parent subdomain',
  `domain_page_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'annak az oldalnak az id-ja ami a fodomain-je',
  `shop_id` int(10) UNSIGNED DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `home` varchar(255) DEFAULT NULL,
  `default_template_id` int(10) UNSIGNED DEFAULT NULL,
  `state` varchar(20) NOT NULL DEFAULT 'hidden',
  `connect_us_address` varchar(255) DEFAULT NULL,
  `connect_us_email` varchar(255) DEFAULT NULL,
  `connect_us_phone` varchar(45) DEFAULT NULL,
  `default_lang_id` int(10) UNSIGNED NOT NULL,
  `default_time_zone` varchar(255) NOT NULL,
  `langs` varchar(255) NOT NULL,
  `templates` text,
  `login_mode` int(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '1 = email, 2 = username',
  `date_time_formats_id` int(10) UNSIGNED NOT NULL,
  `default_external_privilege_group_id` int(10) UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `page`
--

INSERT INTO `page` (`id`, `name`, `domain_name`, `parent_id`, `domain_page_id`, `shop_id`, `user_group_id`, `home`, `default_template_id`, `state`, `connect_us_address`, `connect_us_email`, `connect_us_phone`, `default_lang_id`, `default_time_zone`, `langs`, `templates`, `login_mode`, `date_time_formats_id`, `default_external_privilege_group_id`) VALUES
(1, 'Erich von Kollar', 'erichvonkollar.com', NULL, NULL, NULL, 2, NULL, 1, 'active', NULL, NULL, NULL, 2, 'Europe/Budapest', '["hu","en"]', '[1]', 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_log`
--

CREATE TABLE `password_reset_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `external_user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `password_reset_requested` int(10) UNSIGNED NOT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `used` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `used_date` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `shop_id` int(10) UNSIGNED NOT NULL,
  `flag` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method_lang`
--

CREATE TABLE `payment_method_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_method_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'a fizetési mód neve'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pd_field_in_pd_fields`
--

CREATE TABLE `pd_field_in_pd_fields` (
  `product_data_field_id` int(10) UNSIGNED NOT NULL,
  `product_data_fields_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `shopper_group_id` int(10) UNSIGNED NOT NULL,
  `price` double UNSIGNED NOT NULL COMMENT 'a termék nettó ára árréssel együtt!',
  `special_price` double UNSIGNED DEFAULT NULL COMMENT 'akciós ár',
  `discount_price` double UNSIGNED DEFAULT NULL COMMENT 'kedvezményes ár darabtól',
  `special_price_begin_date` int(10) UNSIGNED DEFAULT NULL COMMENT 'akció időtartalma ha kezdete van de a vége 0 akkor nincs beállítva határa',
  `special_price_end_date` int(10) UNSIGNED DEFAULT NULL COMMENT 'az akció vége (utolsó napja)',
  `discount_price_begin_date` int(10) UNSIGNED DEFAULT NULL COMMENT 'a darabtól függő kedvezmény kezdete ha 0 akkor nincs beállítva határ',
  `discount_price_end_date` int(10) UNSIGNED DEFAULT NULL COMMENT 'a darabtol függő árengedmény vége',
  `discount_price_from_piece` int(10) UNSIGNED DEFAULT '0' COMMENT 'hány darabtol érvényes a kedvezményes ár',
  `purchase_net_price` double UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `privileges`
--

CREATE TABLE `privileges` (
  `id` int(10) UNSIGNED NOT NULL,
  `modul_name` varchar(255) NOT NULL COMMENT 'modul neve a jogosultsághoz',
  `privilege` varchar(100) NOT NULL COMMENT 'az adott modul egy jogosultsága',
  `user_group_id` int(10) UNSIGNED DEFAULT NULL,
  `custom_privilege` tinyint(1) UNSIGNED DEFAULT '0',
  `lang_data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `privileges`
--

INSERT INTO `privileges` (`id`, `modul_name`, `privilege`, `user_group_id`, `custom_privilege`, `lang_data`) VALUES
(53, 'xsuzy_full', 'all', NULL, 0, '{"hu":{"name":"Teljes rendszerszintű hozzáférés","description":"Teljes hozzáférés a rendszer összes funkciójához."}}'),
(54, 'login', 'administrator', NULL, 0, '{"hu":{"name":"Admin bejelentkezés","description":"Bejelentkezhet az admin felületre."}}'),
(55, 'user', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti az admin felhasználók listáját és az admin felhasználók adatait."}}'),
(56, 'user', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Felvehet új admin felhasználót."}}'),
(57, 'user', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti az admin felhasználók adatait."}}'),
(58, 'user', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti az admin felhasználókat."}}'),
(59, 'external_user', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a felhasználók listáját és a felhasználók adatait."}}'),
(60, 'external_user', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Felvehet új felhasználót."}}'),
(61, 'external_user', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a felhasználók adatait."}}'),
(62, 'external_user', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a felhasználókat."}}'),
(63, 'usergroup', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a felhasználói csoportok listáját és a felhasználói csoportok adatait."}}'),
(64, 'usergroup', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat felhasználói csoportot."}}'),
(65, 'usergroup', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a felghasználói csoportokat."}}'),
(66, 'usergroup', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet felhasználói csoportokat."}}'),
(67, 'privileges', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti az admin jogosultságok listáját."}}'),
(68, 'privileges', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új admin jogosultságot."}}'),
(69, 'privileges', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti az admin jogosultságokat."}}'),
(70, 'privileges', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a admin jogosultságokat."}}'),
(71, 'privileges', 'grant_revoke', NULL, 0, '{"hu":{"name":"Felhasználók jogosultságainak kezelése","description":"Egyedileg adhat és elvehet admin jogosultságot egy admin felhasználótól."}}'),
(72, 'privilegesgroup', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Hozzáadhat új admin jogosultság csoportot."}}'),
(73, 'privilegesgroup', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Hozzáadhat új admin jogosultság csoportot."}}'),
(74, 'privilegesgroup', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti az admin jogosultságcsoportokat."}}'),
(75, 'privilegesgroup', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet felhasználói csoportot."}}'),
(76, 'menu', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Kilistázhatja és megnézheti a menük adatait."}}'),
(77, 'menu', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új menüket."}}'),
(78, 'menu', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a menü adatait és a menüpontjait."}}'),
(79, 'menu', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet menüket."}}'),
(80, 'menu', 'handle_system_menu', NULL, 0, '{"hu":{"name":"Rendszermenü kezelés","description":"Kezelheti a rendszermenüket."}}'),
(81, 'content', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Listázhatja és megtekintheti a tartalmakat."}}'),
(82, 'content', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat tartalmakat."}}'),
(83, 'content', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a tartalmakat."}}'),
(84, 'content', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet tartalmakat."}}'),
(85, 'content', 'create_without_category', NULL, 0, '{"hu":{"name":"Létrehozás kategória nélkül","description":"Létrehozhat tartalmat kategorizálás nélkül."}}'),
(86, 'template', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a sablonok listáját és a sablonok adatait."}}'),
(87, 'template', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a sablonokat."}}'),
(88, 'template', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a sablonokat."}}'),
(89, 'product', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a termékek listáját és a termékek adatait."}}'),
(90, 'product', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új terméket."}}'),
(91, 'product', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a termékek adatait."}}'),
(92, 'product', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet termékeket."}}'),
(93, 'product', 'use_childs', NULL, 0, '{"hu":{"name":"Gyerek termékek létrehozás","description":"Létrehozhat a termékekhez gyerektermékeket."}}'),
(94, 'product', 'product_category_edit', NULL, 0, '{"hu":{"name":"Kategória szerkesztés","description":"Szerkesztheti a termék kategóriák adatait és szerkezetét."}}'),
(95, 'procurement', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a bezerzési bizonylatokat."}}'),
(96, 'procurement', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Rögzítheti egy beszerzési bizonylat adatait."}}'),
(97, 'procurement', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a felrögzített beszerzési bizonylat adatait."}}'),
(98, 'procurement', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a beszerzési bizonylatokat."}}'),
(99, 'procurement', 'pay', NULL, 0, '{"hu":{"name":"Kiegyenlítés","description":"A beszerzési bizonylatot kifizetett státuszra állíthatja."}}'),
(100, 'category', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a tartalom kategóriák listáját és a tartalom kategóriák adatait."}}'),
(101, 'category', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új tartalom kategóriát."}}'),
(102, 'category', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a tartalom kategóriák adatait."}}'),
(103, 'category', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a tartalom kategóriák adatait."}}'),
(104, 'category', 'category_use_flag', NULL, 0, '{"hu":{"name":"Címke használat","description":"Használhatja a tartalom kategóriák címkéit."}}'),
(105, 'category', 'category_read_flag', NULL, 0, '{"hu":{"name":"Címke megtekintés","description":"Megnézheti a tartalom kategória címkék listáját és a címkék adatait."}}'),
(106, 'category', 'category_add_flag', NULL, 0, '{"hu":{"name":"Címke rögzítés","description":"Felvehet új tartalom kategória címkét."}}'),
(107, 'category', 'category_edit_flag', NULL, 0, '{"hu":{"name":"Címke szerkesztés","description":"Szerkesztheti a tartalom kategória címkéket."}}'),
(108, 'category', 'all', NULL, 0, '{"hu":{"name":"Hozzáférés az összes tartalom kategóriához","description":"A jogosultságaihoz mérten bármilyen tartalom kategóriát módosíthat, törölhet, megtekinthet."}}'),
(109, 'order', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a rendelések listáját és a rendelések adatait."}}'),
(110, 'order', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Felvehet új rendelést."}}'),
(111, 'order', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet rendelést."}}'),
(112, 'firmdata', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a cég adatait."}}'),
(113, 'firmdata', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a cég adatait."}}'),
(114, 'externalprivilegegroup', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti az oldal jogosultságcsoportjainak listáját és a jogosultságcsoportok adatait."}}'),
(115, 'externalprivilegegroup', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új jogosultságcsoportot az oldalon."}}'),
(116, 'externalprivilegegroup', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti az oldal jogosultságcsoportjait."}}'),
(117, 'tender', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti az árajánlatok listáját és az árajánlatok adatait."}}'),
(118, 'tender', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új árajánlatot."}}'),
(119, 'tender', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja az árajánlatok adatait."}}'),
(120, 'shoppergroup', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a vásárlói csoportok listáját és a vásárlói csoportok adatait."}}'),
(121, 'shoppergroup', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új vásárlói csoportot."}}'),
(122, 'shoppergroup', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a vásárlói csoportok adatait."}}'),
(123, 'shoppergroup', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a vásárlói csoportokat."}}'),
(124, 'cashregister', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a kasszák listáját és a kasszák adatait."}}'),
(125, 'cashregister', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Felvehet új kasszát."}}'),
(126, 'cashregister', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a kasszák adatait."}}'),
(127, 'cashregister', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a kasszákat."}}'),
(128, 'cashregister', 'use_cashregister', NULL, 0, '{"hu":{"name":"Használat","description":"Használhat kasszát."}}'),
(129, 'events', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti az események listáját és az eseméynek adatait."}}'),
(130, 'events', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új eseményt."}}'),
(131, 'events', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja az események adatait."}}'),
(132, 'events', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti az eseményeket."}}'),
(133, 'assembledproduct', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a legyártott termékek listáját és azok adatait."}}'),
(134, 'assembledproduct', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új terméket több meglévő termékből."}}'),
(135, 'assembledproduct', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a legyártott termék adatait."}}'),
(136, 'assembledproduct', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a legyártott termékeket."}}'),
(137, 'invoice', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a számlák listáját és a számlák részleteit."}}'),
(138, 'invoice', 'create_invoice', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új számlát."}}'),
(139, 'invoice', 'print', NULL, 0, '{"hu":{"name":"Nyomtatás","description":"Nyomtathat számlát."}}'),
(140, 'invoice', 'generatepdf', NULL, 0, '{"hu":{"name":"PDF lérehozás","description":"Létrehozhat számláz PDF formátumban."}}'),
(141, 'invoice', 'downloadpdf', NULL, 0, '{"hu":{"name":"Letöltése PDF formátumban","description":"Letöltheti a számlát PDF formátumban."}}'),
(142, 'banner', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a bannerek listáját és a bannerek adatait."}}'),
(143, 'banner', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új bannert."}}'),
(144, 'banner', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a bannerek adatait."}}'),
(145, 'banner', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a bannereket."}}'),
(146, 'certificate', 'downloadpdf', NULL, 0, '{"hu":{"name":"Letöltése PDF formátumban","description":"Letöltheti a bizonylatokat PDF-ként."}}'),
(147, 'certificate', 'generatepdf', NULL, 0, '{"hu":{"name":"PDF lérehozás","description":"Létrehozhat bizonylatot PDF formátumban."}}'),
(148, 'certificate', 'print', NULL, 0, '{"hu":{"name":"Nyomtatás","description":"Nyomtathat bizonylatokat."}}'),
(149, 'shipping_methods', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a szállítási módok listáját és azok adatait."}}'),
(150, 'shipping_methods', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat új szállítási módot."}}'),
(151, 'shipping_methods', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Módosíthatja a szállítási módok adatait."}}'),
(152, 'shipping_methods', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölhet szállítási módot."}}'),
(153, 'gallery', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti a galériák listáját és a galériák adfatait."}}'),
(154, 'gallery', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":"Szerkesztheti a galériákat."}}'),
(155, 'gallery', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Törölheti a galériákat."}}'),
(156, 'loggedinuser', 'changepassword', NULL, 0, '{"hu":{"name":"Admin felhasználó jelszó csere","description":"Lecserélheti e a jelszavát az admin felhasználó."}}'),
(157, 'packingslip', 'showpackingslip', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Megnézheti e a szállítólevél részleteit."}}'),
(158, 'packingslip', 'listpackingslip', NULL, 0, '{"hu":{"name":"Listázás","description":"Láthatja a szállítólevelek listáját."}}'),
(159, 'packingslip', 'create', NULL, 0, '{"hu":{"name":"Létrehozás","description":"Létrehozhat szállítólevelet."}}'),
(160, 'packingslip', 'downloadpdf', NULL, 0, '{"hu":{"name":"Letöltése PDF formátumban","description":"Letöltheti a szállítólevelet PDF-ként."}}'),
(161, 'packingslip', 'generatepdf', NULL, 0, '{"hu":{"name":"PDF lérehozás","description":"Létrehozhat szállítólevelt PDF formátumban."}}'),
(162, 'packingslip', 'print', NULL, 0, '{"hu":{"name":"Nyomtatás","description":"Nyomtathat szállítólevelet."}}'),
(163, 'langhandler', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":""}}'),
(164, 'langhandler', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":""}}'),
(165, 'langhandler', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":""}}'),
(166, 'langhandler', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":""}}'),
(167, 'document', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":""}}'),
(168, 'document', 'add', NULL, 0, '{"hu":{"name":"Létrehozás","description":""}}'),
(169, 'document', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":""}}'),
(170, 'document', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":""}}'),
(171, 'document', 'manage', NULL, 0, '{"hu":{"name":"Kezelés","description":""}}'),
(172, 'page_contact', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":""}}'),
(173, 'page_contact', 'add', NULL, 0, '{"hu":{"name":"Hozzáadás","description":""}}'),
(174, 'page_contact', 'edit', NULL, 0, '{"hu":{"name":"Szerkesztés","description":""}}'),
(175, 'page_contact', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":""}}'),
(176, 'mediacenter', 'read', NULL, 0, '{"hu":{"name":"Megtekintés","description":"Listázhatja az albumokat"}}'),
(177, 'mediacenter', 'edit', NULL, 0, '{"hu":{"name":"Szerkeszt\\u00e9s","description":"Albumok szerkeszt\\u00e9se, l\\u00e9trehoz\\u00e1sa"},"en":{"name":"","description":""}}'),
(178, 'mediacenter', 'delete', NULL, 0, '{"hu":{"name":"Törlés","description":"Albumok törlése"},"en":{"name":"Törlés","description":""}}'),
(179, 'mediacenter', 'add', NULL, 0, '{"hu":{"name":"Hozzáadás","description":"Albumok hozzáadása"},"en":{"name":"Törlés","description":""}}');

-- --------------------------------------------------------

--
-- Table structure for table `privileges-old`
--

CREATE TABLE `privileges-old` (
  `id` int(10) UNSIGNED NOT NULL,
  `modul_name` varchar(255) NOT NULL COMMENT 'modul neve a jogosultsághoz',
  `privilege` varchar(100) NOT NULL COMMENT 'az adott modul egy jogosultsága'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `privileges-old`
--

INSERT INTO `privileges-old` (`id`, `modul_name`, `privilege`) VALUES
(1, 'xsuzy_full', 'all'),
(2, 'login', 'administrator'),
(3, 'user', 'read'),
(4, 'user', 'edit'),
(5, 'user', 'add'),
(6, 'user', 'delete'),
(7, 'user', 'reada'),
(8, 'user', 'edita'),
(9, 'user', 'adda'),
(10, 'user', 'deletea'),
(11, 'usergroup', 'setup'),
(12, 'usergroup', 'read'),
(13, 'privilege', 'grant'),
(14, 'privilege', 'revoke'),
(15, 'privilege', 'read'),
(16, 'privilege', 'group add'),
(17, 'privilege', 'group edit'),
(18, 'privilege', 'group delete'),
(19, 'menu', 'read'),
(20, 'menu', 'add'),
(21, 'menu', 'delete'),
(22, 'menu', 'edit'),
(23, 'menu', 'public_read'),
(24, 'content', 'read'),
(25, 'content', 'edit'),
(26, 'content', 'add'),
(27, 'content', 'public_read'),
(28, 'content', 'delete'),
(29, 'template', 'read'),
(30, 'template', 'edit'),
(31, 'template', 'delete'),
(32, 'product', 'read'),
(33, 'product', 'add'),
(34, 'product', 'edit'),
(35, 'product', 'public_read'),
(36, 'product', 'product_category_edit'),
(37, 'product', 'delete'),
(38, 'product', 'use_childs'),
(39, 'procurement', 'read'),
(40, 'procurement', 'add'),
(41, 'procurement', 'edit'),
(42, 'procurement', 'delete'),
(43, 'category', 'read'),
(44, 'category', 'add'),
(45, 'category', 'edit'),
(46, 'category', 'public_read'),
(47, 'category', 'category_use_flag'),
(48, 'category', 'category_read_flag'),
(49, 'category', 'category_add_flag'),
(50, 'category', 'category_edit_flag'),
(51, 'order', 'add'),
(52, 'order', 'delete'),
(53, 'firmdata', 'read'),
(54, 'firmdata', 'edit'),
(55, 'externalprivilegegroup', 'read'),
(56, 'externalprivilegegroup', 'add'),
(57, 'order', 'read'),
(58, 'tender', 'read'),
(59, 'tender', 'add'),
(60, 'externalprivilegegroup', 'delete'),
(61, 'procurement', 'pay'),
(62, 'shoppergroup', 'read'),
(63, 'shoppergroup', 'add'),
(64, 'shoppergroup', 'edit'),
(65, 'shoppergroup', 'delete'),
(66, 'cashregister', 'use_cashregister'),
(67, 'cashregister', 'edit'),
(68, 'cashregister', 'read'),
(69, 'cashregister', 'delete'),
(70, 'cashregister', 'add'),
(71, 'events', 'add'),
(72, 'events', 'edit'),
(73, 'events', 'delete'),
(74, 'events', 'read'),
(75, 'assembledproduct', 'read'),
(76, 'assembledproduct', 'add'),
(77, 'assembledproduct', 'edit'),
(78, 'assembledproduct', 'delete'),
(79, 'invoice', 'create_invoice'),
(80, 'invoice', 'read'),
(81, 'invoice', 'print'),
(82, 'invoice', 'generatepdf'),
(83, 'invoice', 'listinvoice'),
(84, 'invoice', 'showinvoice'),
(85, 'menu', 'handle_system_menu'),
(86, 'banner', 'read'),
(87, 'banner', 'add'),
(88, 'banner', 'edit'),
(89, 'banner', 'delete'),
(90, 'invoice', 'downloadpdf'),
(91, 'certificate', 'downloadpdf'),
(92, 'certificate', 'generatepdf'),
(93, 'certificate', 'print'),
(94, 'tender', 'edit'),
(95, 'shipping_methods', 'add'),
(96, 'shipping_methods', 'read'),
(97, 'shipping_methods', 'edit'),
(98, 'shipping_methods', 'delete'),
(99, 'gallery', 'read'),
(100, 'gallery', 'edit'),
(101, 'gallery', 'delete'),
(102, 'loggedinuser', 'changepassword'),
(103, 'packingslip', 'create'),
(104, 'packingslip', 'downloadpdf'),
(105, 'packingslip', 'generatepdf'),
(106, 'packingslip', 'print'),
(107, 'packingslip', 'listpackingslip'),
(108, 'packingslip', 'showpackingslip'),
(109, 'langhandler', 'read'),
(110, 'langhandler', 'delete'),
(111, 'langhandler', 'edit'),
(112, 'langhandler', 'add'),
(113, 'dt_championship', 'read'),
(114, 'dt_championship', 'add'),
(115, 'dt_championship', 'edit'),
(116, 'dt_championship', 'delete'),
(117, 'dt_team', 'read'),
(118, 'dt_team', 'add'),
(119, 'dt_team', 'edit'),
(120, 'dt_team', 'delete'),
(121, 'dt_player', 'read'),
(122, 'dt_player', 'add'),
(123, 'dt_player', 'edit'),
(124, 'dt_player', 'delete'),
(125, 'dt_matches', 'read'),
(126, 'dt_matches', 'add'),
(127, 'dt_matches', 'edit'),
(128, 'dt_matches', 'delete'),
(129, 'dt_userteam', 'read'),
(130, 'dt_userteam', 'add'),
(131, 'dt_userteam', 'edit'),
(132, 'dt_userteam', 'delete'),
(133, 'document', 'read'),
(134, 'document', 'add'),
(135, 'document', 'edit'),
(136, 'document', 'manage'),
(137, 'document', 'delete'),
(138, 'researchgroup', 'read'),
(139, 'researchgroup', 'add'),
(140, 'researchgroup', 'edit'),
(141, 'researchgroup', 'delete'),
(142, 'mediacenter', 'read'),
(143, 'mediacenter', 'edit'),
(144, 'mediacenter', 'add'),
(145, 'mediacenter', 'delete');

-- --------------------------------------------------------

--
-- Table structure for table `privileges_group`
--

CREATE TABLE `privileges_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_name` varchar(255) NOT NULL COMMENT 'jogosultság csoport neve',
  `privileges` text NOT NULL COMMENT 'a group lehetséges joga',
  `user_group_id` int(10) UNSIGNED NOT NULL COMMENT 'a felhasználócsoport idje amihez a jogosultságcsoport tartozik',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `full_access` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `privileges_group`
--

INSERT INTO `privileges_group` (`id`, `group_name`, `privileges`, `user_group_id`, `created_by`, `created_date`, `modified_by`, `modified_date`, `deleted`, `deleted_by`, `deleted_date`, `full_access`) VALUES
(1, 'xsuzy', '{"xsuzy_full":["all"]}', 1, 1, 0, 1, 0, 0, NULL, NULL, 0),
(2, 'xsuzy', '{"xsuzy_full":["all"]}', 2, 2, 1458229255, 2, 1458229255, 0, NULL, NULL, 1),
(3, 'evk_admin', '{"category":["add","category_add_flag","category_edit_flag","category_read_flag","category_use_flag","edit","read","all"],"content":["add","delete","edit","read"],"gallery":["delete","edit","read"],"login":["administrator"],"menu":["add","delete","edit","read"],"mediacenter":["read","edit","delete","add"]}', 2, 2, 1458229452, 2, 1475669010, 0, NULL, NULL, 0),
(4, 'xsuzy', '{"xsuzy_full":["all"]}', 3, 2, 1462431575, 2, 1462431575, 0, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'A termék rendszerben tárolt id-je',
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `product_number` varchar(255) NOT NULL COMMENT 'a cikkszám -amin az üzemeltető tárolja',
  `manufacturer_id` int(10) UNSIGNED NOT NULL COMMENT 'A gyártó külső kulcsa',
  `manufacturer_product_number` varchar(255) NOT NULL COMMENT 'A gyártói csikkszám',
  `barcode` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `weight` float UNSIGNED DEFAULT NULL,
  `weight_unit_id` int(10) UNSIGNED NOT NULL COMMENT 'ebben benne van a termék mértékegysége !! aminek súlynak kell lennie minden esetben',
  `quantity_unit_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'mennyiségi egység',
  `quantity_unit_value` float UNSIGNED DEFAULT NULL COMMENT 'A menyiségi egységben a számérték',
  `show_note` tinyint(1) NOT NULL DEFAULT '0',
  `product_type_id` int(10) UNSIGNED NOT NULL,
  `use_stock` tinyint(1) NOT NULL DEFAULT '1',
  `product_in_stock` int(11) DEFAULT '0' COMMENT 'A készleten lévő termékek ',
  `min_product_in_stock` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `reorderable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'utánrendelhető e a termék',
  `run_out` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Kifutott e a termék',
  `useable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'kiállítható e ról aszámla',
  `guarantee` int(11) NOT NULL DEFAULT '0' COMMENT 'termékgarancia hónapban',
  `product_web_page` tinytext COMMENT 'a termék hivatalos oldala',
  `vat` float UNSIGNED DEFAULT NULL COMMENT 'az afa egyedi mértéke a termékre (ha a kategóriábol áfá-t felül akarjuk bírálni)',
  `excise_tax` float UNSIGNED DEFAULT '0',
  `use_serial_number` tinyint(1) DEFAULT '1' COMMENT 'kötelező e a termékhez széria számot felvinni bevételezésnél - vagy utólag',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `data` longtext,
  `images` longtext,
  `default_product` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `assembled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'összeszerelt termék'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'kategória neve (fordítatlan)',
  `product_category_tree` longtext NOT NULL COMMENT 'a kategóriafa struktúrája',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_category_item`
--

CREATE TABLE `product_category_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_category_id` int(10) UNSIGNED NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `ttk_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'TEÁOR/TESZOR/KSH id',
  `product_data_fields_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'a kötelezően kitöltendő adatok a terméknél'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_category_item_lang`
--

CREATE TABLE `product_category_item_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_category_item_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'a categória az adott nyelven',
  `sef` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_category_price_margin`
--

CREATE TABLE `product_category_price_margin` (
  `id` int(10) UNSIGNED NOT NULL,
  `from` double DEFAULT NULL,
  `to` double DEFAULT NULL,
  `price_margin` float NOT NULL DEFAULT '0',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_item_id` int(10) UNSIGNED NOT NULL,
  `shopper_group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_category_to_page`
--

CREATE TABLE `product_category_to_page` (
  `shop_id` int(10) UNSIGNED NOT NULL,
  `product_category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_data_field`
--

CREATE TABLE `product_data_field` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `attr_code` varchar(50) NOT NULL COMMENT 'Az attribútum kódja',
  `type` varchar(45) NOT NULL COMMENT 'milyen mező jelenjen meg az adatbevitelhez',
  `unit_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_data_fields`
--

CREATE TABLE `product_data_fields` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_data_fields_lang`
--

CREATE TABLE `product_data_fields_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_data_fields_id` int(10) UNSIGNED NOT NULL COMMENT 'melyik adat csoportnak a fordítása',
  `lang_id` int(10) UNSIGNED NOT NULL COMMENT 'milyen nyelvű a fordítás',
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_data_field_lang`
--

CREATE TABLE `product_data_field_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_data_field_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_lang`
--

CREATE TABLE `product_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT 'a termék megjegyzésének id-je',
  `note` text,
  `lang_id` int(10) UNSIGNED NOT NULL COMMENT 'a megjegyzés nyelve',
  `description` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `sef` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_state`
--

CREATE TABLE `product_state` (
  `id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_state`
--

INSERT INTO `product_state` (`id`) VALUES
(1),
(2),
(3),
(4);

-- --------------------------------------------------------

--
-- Table structure for table `product_state_lang`
--

CREATE TABLE `product_state_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_state_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_state_lang`
--

INSERT INTO `product_state_lang` (`id`, `product_state_id`, `lang_id`, `name`) VALUES
(1, 1, 1, 'szabad'),
(2, 1, 2, 'free'),
(3, 2, 1, 'foglalt'),
(4, 2, 2, 'reserved'),
(5, 3, 1, 'eladva'),
(6, 3, 2, 'saled'),
(9, 4, 1, 'Összeszerelés alatt'),
(10, 4, 2, 'Under assmble');

-- --------------------------------------------------------

--
-- Table structure for table `product_synced_price_data`
--

CREATE TABLE `product_synced_price_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sync_config_id` int(10) UNSIGNED NOT NULL,
  `net_price` double NOT NULL DEFAULT '0',
  `in_stock` int(11) NOT NULL DEFAULT '0',
  `sync_date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_sync_config`
--

CREATE TABLE `product_sync_config` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `sync_data` mediumtext,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `last_synced` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_type`
--

CREATE TABLE `product_type` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL COMMENT 'a felhasználói csoport neve amelyben a besorolás létre lett hozva'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_type_lang`
--

CREATE TABLE `product_type_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_type_id` int(10) UNSIGNED NOT NULL COMMENT 'a termékbesorolás id-je amihez a fordítás tartozik',
  `lang_id` int(10) UNSIGNED NOT NULL COMMENT 'a nyelv id-ja main a frodítás van',
  `name` varchar(255) NOT NULL COMMENT 'a fordítás az adott nyelven'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `progress`
--

CREATE TABLE `progress` (
  `id` varchar(255) NOT NULL,
  `url` text NOT NULL,
  `status` text NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `purchased_product`
--

CREATE TABLE `purchased_product` (
  `id` varchar(255) NOT NULL COMMENT 'id: uniqueid() . ''_'' . (product_id) . ''_'' . i',
  `packing_slip_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'szállítólevél id-ja',
  `purchase_invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `user_group_id` varchar(45) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `net_price` double NOT NULL,
  `gross_price` double NOT NULL,
  `gar_in_month` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `product_state_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `recipient` int(10) UNSIGNED DEFAULT NULL COMMENT 'az átvevő felhasználó id-ja',
  `receipt_date` int(10) UNSIGNED DEFAULT NULL COMMENT 'az átvétel dátuma',
  `stock_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'a raktár id-je',
  `stock_poz` varchar(255) DEFAULT NULL COMMENT 'a raktáron belüli pontos hely(ez nem kötelező)',
  `product_id` int(10) UNSIGNED NOT NULL,
  `reserve_id_code` varchar(255) DEFAULT NULL COMMENT 'unique_id() + _ + user_id',
  `old_purchase_invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `location_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_invoice`
--

CREATE TABLE `purchase_invoice` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'beszerzési számla',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `invoice_number` varchar(255) NOT NULL,
  `purchase_invoice_number` varchar(255) DEFAULT NULL COMMENT 'a beszerzési számla száma',
  `supplier_id` int(10) UNSIGNED DEFAULT NULL,
  `supplier_data` mediumtext,
  `payment_method_id` int(10) UNSIGNED DEFAULT NULL,
  `payment_deadline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `billing_date` int(10) UNSIGNED DEFAULT NULL,
  `performance_date` int(10) UNSIGNED DEFAULT NULL,
  `total_net_price` double DEFAULT NULL,
  `total_gross_price` double DEFAULT NULL,
  `currency_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'a valuta azonosítója',
  `payed` double NOT NULL DEFAULT '0',
  `arrears` double DEFAULT NULL COMMENT 'hátralék',
  `created_date` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED DEFAULT NULL,
  `modified_date` int(10) UNSIGNED DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(10) UNSIGNED NOT NULL,
  `reverse_purchase_invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `reverse_invoice` tinyint(1) NOT NULL DEFAULT '0',
  `reverse_note` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_invoice_content`
--

CREATE TABLE `purchase_invoice_content` (
  `id` varchar(255) NOT NULL COMMENT 'az id: uniquid() . ''_'' .(user_group_id).''_''.(purchase_invoice_id).''_''.(row_in)',
  `purchase_invoice_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `number_of_product` int(10) NOT NULL,
  `total_net_price` double NOT NULL COMMENT 'az x darab termék össz nettó ára',
  `total_gross_price` double NOT NULL COMMENT 'az x termék bruttó össz ára',
  `vat` float UNSIGNED NOT NULL,
  `excise_tax` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `routes_templates`
--

CREATE TABLE `routes_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL COMMENT 'az oldal amihez a beállítások tartoznak',
  `shop_id` int(10) UNSIGNED DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL COMMENT 'a nyelv amira a root beállítás érvényes',
  `modul_type` varchar(45) NOT NULL COMMENT 'modul típusa',
  `url` varchar(255) NOT NULL COMMENT 'url amire a beállítás vonatkozik',
  `template_id` int(10) UNSIGNED NOT NULL,
  `template_setup` longtext NOT NULL COMMENT 'a poziciók és a poziciókba betöltendő modulok listája',
  `params` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `routes_templates`
--

INSERT INTO `routes_templates` (`id`, `page_id`, `shop_id`, `user_group_id`, `lang_id`, `modul_type`, `url`, `template_id`, `template_setup`, `params`) VALUES
(1, 1, NULL, 2, 1, 'home', '/', 1, '{"tracking_codes":[{"modul":"google_tag_manager","params":{"code":"GTM-KTD3NL"},"style_type":"googletagmanager"}],"header_top":[{"style_type":"horizontalmenu","params":{"id":"1","send_menu_item_data":false,"only_home":false},"modul":"menu"}],"header_navigation":[],"bottom_menu":[],"footer_top":[],"footer_bottom":[],"gallery":[{"style_type":"gallery","params":{"id":"12","only_home":true},"modul":"gallery"}],"content_right_box":[{"style_type":"contents","params":{"contents":["4"],"only_home":true},"modul":"contents"}],"mainpageslider":[],"mainpagemenu":[],"video_slider":[{"style_type":"contents","params":{"contents":["2"],"only_home":false},"modul":"contents"}],"social_icons":[{"style_type":"socialicons","params":{"icons":{"facebook":"https:\\/\\/www.facebook.com\\/erichvonkollarofficial","twitter":"https:\\/\\/twitter.com\\/erichvonkollar?lang=en@erichvonkollar","youtube":"https:\\/\\/www.youtube.com\\/channel\\/UCNapHTKxBCCT0rIFezAiLDQ","soundcloud":"https:\\/\\/soundcloud.com\\/erichvonkollar"},"only_home":true},"modul":"social_media"}],"videoo":[],"contact":[{"style_type":"contactform","params":{"only_home":true},"modul":"contact_form"}],"soundcloud":[{"style_type":"latestcontents","params":{"category_id":"1","content_per_page":"2","only_home":true},"modul":"contentcategory"}],"tours":[{"style_type":"latestcontents_style2","params":{"category_id":"2","content_per_page":"1000","only_home":true},"modul":"contentcategory"}]}', '[]'),
(2, 1, NULL, 2, 2, 'home', '/', 1, '{"tracking_codes":[{"modul":"google_tag_manager","params":{"code":"GTM-KTD3NL"},"style_type":"googletagmanager"}],"header_top":[{"style_type":"horizontalmenu","params":{"id":"1","send_menu_item_data":false,"only_home":false},"modul":"menu"}],"header_navigation":[],"bottom_menu":[],"footer_top":[],"footer_bottom":[],"gallery":[{"style_type":"mediacenter","params":{"categories":"","types":["image"],"dom_classes":"blueimp","only_home":true},"modul":"mediacenter"}],"bio":[{"style_type":"contents","params":{"contents":["4"],"only_home":true},"modul":"contents"}],"content2":[{"style_type":"contents","params":{"contents":["10"],"only_home":true},"modul":"contents"}],"mainpageslider":[],"mainpagemenu":[],"social_icons":[{"style_type":"socialicons","params":{"icons":{"facebook":"https:\\/\\/www.facebook.com\\/erichvonkollarofficial","twitter":"https:\\/\\/twitter.com\\/erichvonkollar?lang=en@erichvonkollar","youtube":"https:\\/\\/www.youtube.com\\/channel\\/UCNapHTKxBCCT0rIFezAiLDQ","soundcloud":"https:\\/\\/soundcloud.com\\/erichvonkollar"},"only_home":true},"modul":"social_media"}],"video":[{"style_type":"mediacenter","params":{"categories":"","types":["youtube","video"],"dom_classes":"scrollable fullwidth","only_home":true},"modul":"mediacenter"}],"contact":[{"style_type":"contactform","params":{"only_home":true},"modul":"contact_form"}],"soundcloud":[{"style_type":"mediacenter","params":{"categories":"","types":["soundcloud"],"dom_classes":"scrollable","only_home":false},"modul":"mediacenter"}],"tours":[{"style_type":"latestcontents_style2","params":{"category_id":"2","orderby":"1","content_per_page":"1000","only_home":true},"modul":"contentcategory"}]}', '[]');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_method`
--

CREATE TABLE `shipping_method` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `net_price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `vat` float UNSIGNED NOT NULL DEFAULT '0',
  `rules` mediumtext,
  `shop_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_methods_by_country`
--

CREATE TABLE `shipping_methods_by_country` (
  `id` int(10) UNSIGNED NOT NULL,
  `country_id` int(10) UNSIGNED NOT NULL,
  `shipping_method_id` int(10) UNSIGNED NOT NULL,
  `net_price` float UNSIGNED NOT NULL DEFAULT '0',
  `rules` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_method_lang`
--

CREATE TABLE `shipping_method_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `shipping_method_id` int(10) UNSIGNED NOT NULL,
  `lang_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `state` varchar(20) NOT NULL DEFAULT 'hidden'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shopper_group`
--

CREATE TABLE `shopper_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'vásárlói csoport neve',
  `price_margin` float DEFAULT NULL COMMENT 'alapértelmezett árrés',
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(10) UNSIGNED NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shop_shopper_groups`
--

CREATE TABLE `shop_shopper_groups` (
  `shop_id` int(10) UNSIGNED NOT NULL,
  `shopper_group_id` int(10) UNSIGNED NOT NULL,
  `default` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'a raktár megnevezése',
  `location_id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'partner neve (személy/cég)',
  `country` varchar(255) NOT NULL COMMENT 'ország',
  `city` varchar(255) NOT NULL COMMENT 'város',
  `address` varchar(255) NOT NULL COMMENT 'cím',
  `post_code` varchar(12) NOT NULL COMMENT 'irányítószám',
  `tax_number` varchar(255) NOT NULL COMMENT 'adószám',
  `bank_account_number` varchar(255) NOT NULL COMMENT 'bankszámlaszám',
  `payment_method_id` int(10) UNSIGNED NOT NULL COMMENT 'fizetési mód',
  `payment_deadline` int(10) UNSIGNED NOT NULL COMMENT 'fizetési határidő napokban',
  `user_group_id` int(10) UNSIGNED NOT NULL COMMENT 'felhasználói csoport azonosítója',
  `deleted` tinyint(1) DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_date` int(10) UNSIGNED NOT NULL,
  `modified_by` int(10) UNSIGNED NOT NULL,
  `modified_date` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE `templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `path` mediumtext NOT NULL COMMENT 'a template elérési útja a public mappában',
  `template_positions` longtext NOT NULL COMMENT 'Json-ben a pozíciólista',
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id`, `name`, `path`, `template_positions`, `type`) VALUES
(1, 'evk', 'templates/evk', '["header_top","header_navigation","bottom_menu","footer_top","footer_bottom","gallery","bio","content2","content_right_box","mainpageslider","mainpagemenu","social_icons","video","contact","soundcloud","tours"]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tender`
--

CREATE TABLE `tender` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `external_user_data_id` int(10) UNSIGNED DEFAULT NULL,
  `net_price` double NOT NULL,
  `shop_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL COMMENT 'a rendelést létrehozó',
  `created_date` int(10) UNSIGNED DEFAULT NULL,
  `expire_time` int(10) UNSIGNED DEFAULT NULL COMMENT 'lejárati idő a szerkesztésnél, hogy egyszerre csak 1 user használja',
  `modified_by` int(10) UNSIGNED DEFAULT NULL,
  `modified_date` int(10) UNSIGNED DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tender_content`
--

CREATE TABLE `tender_content` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `number_of_product` int(11) NOT NULL,
  `net_price` int(11) NOT NULL,
  `tender_id` int(10) UNSIGNED NOT NULL,
  `ttk_code` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ttk`
--

CREATE TABLE `ttk` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` varchar(45) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(50) NOT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `vat` float UNSIGNED DEFAULT NULL,
  `excise_tax` float UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_type` varchar(45) NOT NULL COMMENT 'A mértékegység rövid neve - langfájlal fordított',
  `short_name` varchar(45) NOT NULL COMMENT 'a mértékegység típusa -  az átszámításhoz kell',
  `conversion_factor` float NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(10) UNSIGNED NOT NULL COMMENT 'A felhasználó egyedi azonosítója',
  `user_name` varchar(100) NOT NULL COMMENT 'A felhasználó választott neve',
  `email` varchar(100) NOT NULL COMMENT 'A felhasználó email címe',
  `password` varchar(255) NOT NULL COMMENT 'A felhasználó jelszava',
  `name` varchar(255) NOT NULL,
  `last_login` int(11) NOT NULL DEFAULT '0' COMMENT 'utolsó bejelentkezés ideje',
  `reg_date` int(11) NOT NULL DEFAULT '0' COMMENT 'a user regisztráció dátuma',
  `user_created_by` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'A felhasználót létrehozó. Létrehozható adminfelületen vagy regisztr�',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Logikai törlés megvalósítása.',
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `deleted_date` int(10) UNSIGNED DEFAULT NULL,
  `user_group_ids` varchar(255) NOT NULL COMMENT 'a felhasználó felhasználói csoportjai',
  `default_user_group_id` int(10) UNSIGNED DEFAULT NULL,
  `user_lang` int(11) NOT NULL,
  `date_time_zone` varchar(255) NOT NULL COMMENT 'a felhasználó által kiválasztott időzóna',
  `date_time_format` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `email`, `password`, `name`, `last_login`, `reg_date`, `user_created_by`, `deleted`, `deleted_by`, `deleted_date`, `user_group_ids`, `default_user_group_id`, `user_lang`, `date_time_zone`, `date_time_format`) VALUES
(1, 'Sys@xsuzy', 'system@system.hu', 'sys', 'Xsuzy', 0, 0, 1, 0, NULL, NULL, '1', 1, 1, 'Europe/Budapest', 1),
(2, 'xpsr@xsuzy', 'kiss.adam@xpsr.hu', '35cd3c105ae346acac7d940ab23253d4ee504a57', 'Gizi Developer Test', 1486195815, 0, 1, 0, NULL, NULL, '1,2,3', 2, 1, 'Europe/Budapest', 1),
(3, 'evk_admin', 'erich@erichvonkollar.com', 'a032ddc871d3667daf861c998f725781ba1d9026', 'evk_admin', 1485851073, 1458229515, 2, 0, NULL, NULL, '2', 2, 1, 'Europe/Budapest', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_name` varchar(255) NOT NULL COMMENT 'felhasználócsoport neve',
  `group_privileges` text NOT NULL COMMENT 'felhasználócsoport jogosultságai',
  `default_privileges_group_to_user` int(10) UNSIGNED DEFAULT NULL COMMENT 'az adott felhasználó csoport alapértelmezett jogosultság csoportja a regisztrációnál.',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `created_date` int(11) NOT NULL,
  `deleted_date` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_by` int(10) UNSIGNED DEFAULT NULL,
  `modified_date` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `group_name`, `group_privileges`, `default_privileges_group_to_user`, `deleted`, `created_date`, `deleted_date`, `created_by`, `deleted_by`, `modified_date`, `modified_by`) VALUES
(1, 'xsuzy', '{"assembledproduct":["add","delete","edit","read"],"cashregister":["add","delete","edit","read","use_cashregister"],"category":["add","category_add_flag","category_edit_flag","category_read_flag","category_use_flag","edit","public_read","read"],"content":["add","delete","edit","public_read","read"],"events":["add","delete","edit","read"],"externalprivilegegroup":["add","delete","read"],"firmdata":["edit","read"],"invoice":["create_invoice","generatepdf","listinvoice","print","read","showinvoice"],"login":["administrator"],"menu":["add","delete","edit","public_read","read"],"order":["add","delete","read"],"privilege":["grant","group add","group delete","group edit","read","revoke"],"procurement":["add","delete","edit","pay","read"],"product":["add","delete","edit","product_category_edit","public_read","read","use_childs"],"shoppergroup":["add","delete","edit","read"],"template":["delete","edit","read"],"tender":["add","read"],"user":["add","adda","delete","deletea","edit","edita","read","reada"],"usergroup":["read","setup"]}', 16, 0, 0, NULL, 1, NULL, 1428394319, 2),
(2, 'evk_user', '{"category":["read","add","edit","category_use_flag","category_read_flag","category_add_flag","category_edit_flag","all"],"content":["read","add","edit","delete"],"firmdata":["read","edit"],"gallery":["read","edit","delete"],"loggedinuser":["changepassword"],"login":["administrator"],"mediacenter":["read","edit","delete","add"],"menu":["read","add","edit","delete"],"product":["read","add","edit","delete","use_childs","product_category_edit"],"template":["read","edit","delete"]}', 3, 0, 1458229254, NULL, 2, NULL, 1475668951, 2),
(3, 'udtech', '{"content":["add","delete","edit","public_read","read"],"firmdata":["edit","read"],"loggedinuser":["changepassword"],"login":["administrator"],"menu":["add","delete","edit","public_read","read"],"privilege":["grant","group add","group delete","group edit","read","revoke"],"template":["delete","edit","read"]}', NULL, 1, 1462431575, 1475653023, 2, 2, 1462433746, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_privilege`
--

CREATE TABLE `user_privilege` (
  `id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `privilege_group_id` int(10) UNSIGNED DEFAULT NULL,
  `unique_privileges` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_privilege`
--

INSERT INTO `user_privilege` (`id`, `user_id`, `privilege_group_id`, `unique_privileges`) VALUES
(1, 1, 1, '{"grant":[],"revoke":[]}'),
(2, 2, 1, '{"grant":[],"revoke":[]}'),
(3, 2, 2, '{"grant":[],"revoke":[]}'),
(4, 3, 3, '{"grant":[],"revoke":[]}'),
(5, 2, 4, '{"grant":[],"revoke":[]}');

-- --------------------------------------------------------

--
-- Table structure for table `webshop_search_temp`
--

CREATE TABLE `webshop_search_temp` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `term` text NOT NULL,
  `sef` varchar(255) DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `images` longtext,
  `type` varchar(13) NOT NULL,
  `lang_id` int(10) UNSIGNED DEFAULT NULL,
  `user_group_id` int(10) UNSIGNED NOT NULL,
  `shop_id` int(10) UNSIGNED DEFAULT NULL,
  `category_sef` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `zip_code`
--

CREATE TABLE `zip_code` (
  `id` int(10) UNSIGNED NOT NULL,
  `country_id` int(10) UNSIGNED DEFAULT NULL,
  `zip_code` varchar(50) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_ADD_T_idx` (`address_type_id`),
  ADD KEY `IDX_ADD_EXT_U_D_ID_idx` (`external_user_data_id`),
  ADD KEY `IDX_ADD_COUNTRY_id_idx` (`country_id`);

--
-- Indexes for table `address_type`
--
ALTER TABLE `address_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_address_type_user_group_id` (`user_group_id`);

--
-- Indexes for table `address_type_lang`
--
ALTER TABLE `address_type_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_ADD_T_I_idx` (`address_type_id`),
  ADD KEY `IDX_address_type_lang_lang_id` (`lang_id`);

--
-- Indexes for table `admin_moduls`
--
ALTER TABLE `admin_moduls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_modul_name_UNIQUE` (`modul_name`);

--
-- Indexes for table `assembled_product`
--
ALTER TABLE `assembled_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_purchased_product_id_idx` (`purchased_product_id`),
  ADD KEY `IDX_part_purchased_product_id_idx` (`part_purchased_product_id`),
  ADD KEY `IDX_assembled_product_product_id` (`product_id`);

--
-- Indexes for table `bank_account_numbers`
--
ALTER TABLE `bank_account_numbers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_financial_institution_idx` (`financial_institution_id`),
  ADD KEY `IDX_firm_b_a_ns_idx` (`firm_id`);

--
-- Indexes for table `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banner_user_group_id` (`user_group_id`),
  ADD KEY `idx_banner_page_id` (`page_id`),
  ADD KEY `idx_banner_created_by` (`created_by`),
  ADD KEY `idx_banner_modified_by` (`modified_by`);

--
-- Indexes for table `banner_item`
--
ALTER TABLE `banner_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banner_item_banner_id` (`banner_id`),
  ADD KEY `idx_banner_item_created_by` (`created_by`),
  ADD KEY `idx_banner_item_modified_by` (`modified_by`);

--
-- Indexes for table `banner_item_lang`
--
ALTER TABLE `banner_item_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banner_item_lang_banner_item_id` (`banner_item_id`),
  ADD KEY `idx_banner_item_lang_lang_id` (`lang_id`);

--
-- Indexes for table `banner_lang`
--
ALTER TABLE `banner_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_banner_lang_lang_id` (`lang_id`),
  ADD KEY `idx_banner_lang_banner_id` (`banner_id`);

--
-- Indexes for table `billing_data`
--
ALTER TABLE `billing_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B_D_E_U_ID_idx` (`external_user_data_id`);

--
-- Indexes for table `cash_register`
--
ALTER TABLE `cash_register`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_location_id` (`location_id`),
  ADD KEY `IDX_user_group_id` (`user_group_id`);

--
-- Indexes for table `cash_register_financial_flows`
--
ALTER TABLE `cash_register_financial_flows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_user_id` (`user_id`),
  ADD KEY `IDX_cash_register_id` (`cash_register_id`);

--
-- Indexes for table `cash_voucher`
--
ALTER TABLE `cash_voucher`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_invoice_id` (`invoice_id`),
  ADD KEY `IDX_user_id` (`user_id`),
  ADD KEY `IDX_cash_voucher_user_group_id_idx` (`user_group_id`),
  ADD KEY `IDX_cash_voucher_cash_register_financial_flow_idx` (`cash_register_financial_flows_id`),
  ADD KEY `IDX_cash_voucher_currency_id_idx` (`currency_id`),
  ADD KEY `FK_cash_voucher_cwcid_idx` (`cash_voucher_claim_id`);

--
-- Indexes for table `cash_voucher_claim`
--
ALTER TABLE `cash_voucher_claim`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_cw_user_group_id_idx` (`user_group_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_cat_user_group_id` (`user_group_id`);

--
-- Indexes for table `category_contents`
--
ALTER TABLE `category_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_category_contents_category_id_idx` (`category_id`);

--
-- Indexes for table `category_flags`
--
ALTER TABLE `category_flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_catf_user_group_id` (`user_group_id`);

--
-- Indexes for table `category_flag_lang`
--
ALTER TABLE `category_flag_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_category_flag_lang_cf_idx` (`category_flag_id`),
  ADD KEY `IDX_cfl_lang_id` (`lang_id`);

--
-- Indexes for table `category_lang`
--
ALTER TABLE `category_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_category_lang_category_id_idx` (`category_id`),
  ADD KEY `IDX_catil_lang_id` (`lang_id`);

--
-- Indexes for table `category_products`
--
ALTER TABLE `category_products`
  ADD KEY `IDX_PRODUCT_ID_idx` (`product_id`),
  ADD KEY `IDX_PRODUCT_CATEGORY_ID_idx` (`product_category_id`),
  ADD KEY `IDX_PRODUCT_CATEGORY_ITEM_ID_idx` (`product_category_item_id`);

--
-- Indexes for table `category_to_page`
--
ALTER TABLE `category_to_page`
  ADD UNIQUE KEY `IDX_CTPA` (`category_id`,`page_id`),
  ADD KEY `IDX_CTPA_idx` (`page_id`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_certificates_certificate_type_idx` (`type_id`),
  ADD KEY `IDX_certificates_user_group_id_idx` (`user_group_id`),
  ADD KEY `IDX_certificate_c_user_id_idx` (`created_by`),
  ADD KEY `IDX_certificate_d_user_id_idx` (`deleted_by`),
  ADD KEY `FK_def_cvci_id_idx` (`default_cashvoucher_claim_in_id`),
  ADD KEY `FK_def_cvco_id_idx` (`default_cashvoucher_claim_out_id`);

--
-- Indexes for table `certificate_type`
--
ALTER TABLE `certificate_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_supplier_idx` (`supplier_id`);

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_user_group_id_content_idx` (`user_group_id`),
  ADD KEY `IDX_createdby_uid_idx` (`created_by`),
  ADD KEY `IDX_modified_by_uid_idx` (`modified_by`),
  ADD KEY `IDX_deletedby_uid_idx` (`deleted_by`);

--
-- Indexes for table `content_lang`
--
ALTER TABLE `content_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_content_id_content_idx` (`content_id`),
  ADD KEY `IDX_lang_id_to_lang_idx` (`lang_id`),
  ADD KEY `IDX_content_title` (`title`);

--
-- Indexes for table `content_temp`
--
ALTER TABLE `content_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `content_to_page`
--
ALTER TABLE `content_to_page`
  ADD UNIQUE KEY `IN_U` (`content_id`,`page_id`) USING BTREE,
  ADD KEY `IDX_CTP_idx` (`page_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country_lang`
--
ALTER TABLE `country_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_COUNTRY_TO_LANG_idx` (`country_id`),
  ADD KEY `IDX_country_lang_lang_id` (`lang_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD KEY `FK_currencies_currency_idx` (`currency_id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `date_time_formats`
--
ALTER TABLE `date_time_formats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_format_UNIQUE` (`format`);

--
-- Indexes for table `denominations`
--
ALTER TABLE `denominations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_denom_user_user_group_id_idx` (`user_group_id`),
  ADD KEY `IDX_denom_cirrency_id_idx` (`currency_id`),
  ADD KEY `IDX_denom_denom_type_id_idx` (`denomination_type_id`);

--
-- Indexes for table `denomination_types`
--
ALTER TABLE `denomination_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_denom_type_user_group_u` (`user_group_id`,`name`) COMMENT 'ez a kettő egyedi',
  ADD KEY `IDX_denom_type_user_group_id_idx` (`user_group_id`),
  ADD KEY `FK_denom_type_curr_id_currency_id_idx` (`currency_id`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_d_dcii_idx` (`document_category_item_id`),
  ADD KEY `FK_d_ugi_idx` (`user_group_id`),
  ADD KEY `FK_d_cui_idx` (`created_by`),
  ADD KEY `FK_d_mui_idx` (`modified_by`);

--
-- Indexes for table `document_category`
--
ALTER TABLE `document_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dc_ugi_idx` (`user_group_id`),
  ADD KEY `FK_dc_cb_idx` (`created_by`),
  ADD KEY `FK_dc_mb_idx` (`modified_by`),
  ADD KEY `FK_dc_db_idx` (`deleted_by`);

--
-- Indexes for table `document_category_item`
--
ALTER TABLE `document_category_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dci_dc_idx` (`document_category_id`),
  ADD KEY `FK_dci_cb_idx` (`created_by`),
  ADD KEY `FK_dci_mb_idx` (`modified_by`),
  ADD KEY `FK_dci_db_idx` (`deleted_by`);

--
-- Indexes for table `document_category_item_lang`
--
ALTER TABLE `document_category_item_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dcii_dci_idx` (`document_category_item_id`),
  ADD KEY `FK_dcii_li_idx` (`lang_id`);

--
-- Indexes for table `document_category_lang`
--
ALTER TABLE `document_category_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_DC_LI_idx` (`lang_id`),
  ADD KEY `FK_DCL_DC_idx` (`document_category_id`);

--
-- Indexes for table `document_flag`
--
ALTER TABLE `document_flag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_ugi_code` (`user_group_id`,`code`),
  ADD KEY `FK_doc_u_g_i_idx` (`user_group_id`);

--
-- Indexes for table `document_flags`
--
ALTER TABLE `document_flags`
  ADD KEY `FK_df_dfs_idx` (`document_flag_id`),
  ADD KEY `FK_df_d_idx` (`document_id`);

--
-- Indexes for table `document_flag_lang`
--
ALTER TABLE `document_flag_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_df_dfl_idx` (`document_flag_id`),
  ADD KEY `FK_dfl_li_idx` (`lang_id`);

--
-- Indexes for table `document_lang`
--
ALTER TABLE `document_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dl_di_idx` (`document_id`),
  ADD KEY `FK_dl_li_idx` (`lang_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_events_content_id` (`content_id`),
  ADD KEY `idx_events_created_by` (`created_by`),
  ADD KEY `idx_events_modified_by` (`modified_by`),
  ADD KEY `idx_events_deleted_by` (`deleted_by`),
  ADD KEY `idx_events_user_group_id` (`user_group_id`);

--
-- Indexes for table `events_to_page`
--
ALTER TABLE `events_to_page`
  ADD PRIMARY KEY (`events_id`,`page_id`),
  ADD KEY `idx_events_to_page_page_id` (`page_id`),
  ADD KEY `idx_events_to_page_events_id` (`events_id`);

--
-- Indexes for table `event_categories`
--
ALTER TABLE `event_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_categories_user_group_id` (`user_group_id`),
  ADD KEY `idx_event_categories_created_by` (`created_by`),
  ADD KEY `idx_event_categories_deleted_by` (`deleted_by`),
  ADD KEY `idx_event_categories_modified_by` (`modified_by`);

--
-- Indexes for table `event_categories_lang`
--
ALTER TABLE `event_categories_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_categories_lang_lang_id` (`lang_id`),
  ADD KEY `idx_event_categories_lang_event_categories_id` (`event_categories_id`);

--
-- Indexes for table `event_categories_to_events`
--
ALTER TABLE `event_categories_to_events`
  ADD PRIMARY KEY (`event_categories_id`,`events_id`),
  ADD KEY `idx_event_categories_to_events_event_categories_id` (`event_categories_id`),
  ADD KEY `idx_event_categories_to_events_events_id` (`events_id`);

--
-- Indexes for table `event_categories_to_page`
--
ALTER TABLE `event_categories_to_page`
  ADD PRIMARY KEY (`event_categories_id`,`page_id`),
  ADD KEY `idx_event_categories_to_page_event_categories_id` (`event_categories_id`),
  ADD KEY `idx_event_categories_to_page_page_id` (`page_id`);

--
-- Indexes for table `event_locations`
--
ALTER TABLE `event_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_locations_country_id` (`country_id`),
  ADD KEY `idx_event_locations_created_by` (`created_by`),
  ADD KEY `idx_event_locations_modified_by` (`modified_by`),
  ADD KEY `idx_event_locations_deleted_by` (`deleted_by`),
  ADD KEY `idx_event_locations_user_group_id` (`user_group_id`);

--
-- Indexes for table `event_locations_to_events`
--
ALTER TABLE `event_locations_to_events`
  ADD PRIMARY KEY (`events_id`,`event_locations_id`),
  ADD KEY `idx_event_locations_to_events_events_id` (`events_id`),
  ADD KEY `idx_event_locations_to_events_event_locations_id` (`event_locations_id`);

--
-- Indexes for table `event_organisers`
--
ALTER TABLE `event_organisers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_organisers_user_group_id` (`user_group_id`),
  ADD KEY `idx_event_organisers_created_by` (`created_by`),
  ADD KEY `idx_event_organisers_modified_by` (`modified_by`),
  ADD KEY `idx_event_organisers_deleted_by` (`deleted_by`);

--
-- Indexes for table `event_organisers_to_events`
--
ALTER TABLE `event_organisers_to_events`
  ADD UNIQUE KEY `primary_event_organisers_to_events` (`events_id`,`event_organisers_id`),
  ADD KEY `idx_event_organisers_to_events_events_id` (`events_id`),
  ADD KEY `idx_event_organisers_to_events_event_organisers_id` (`event_organisers_id`);

--
-- Indexes for table `event_schedule`
--
ALTER TABLE `event_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_privilege`
--
ALTER TABLE `external_privilege`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_privilege_group`
--
ALTER TABLE `external_privilege_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PAGE_ID_EPG_idx` (`page_id`),
  ADD KEY `IDX_external_privilege_group_user_group_id` (`user_group_id`);

--
-- Indexes for table `external_user`
--
ALTER TABLE `external_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `IDX_USER_NAME_U_G` (`user_name`,`user_group_id`,`page_id`),
  ADD UNIQUE KEY `IDX_USER_EMAIL_U_G` (`email`,`user_group_id`,`page_id`),
  ADD KEY `IDX_EXT_P_G_idx` (`external_privilege_group_id`),
  ADD KEY `IDX_EXT_P_ID_idx` (`page_id`),
  ADD KEY `IDX_EXT_UD_ID_idx` (`external_user_data_id`),
  ADD KEY `IDX_external_user_user_group_id` (`user_group_id`),
  ADD KEY `IDX_external_user_created_by` (`created_by`),
  ADD KEY `IDX_external_user_modified_by` (`modified_by`),
  ADD KEY `IDX_external_user_deleted_by` (`deleted_by`),
  ADD KEY `FK_EXT_US_DTFI_idx` (`date_time_formats_id`);

--
-- Indexes for table `external_user_data`
--
ALTER TABLE `external_user_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E_U_D_SHOP_ID_idx` (`shop_id`),
  ADD KEY `IDX_epg_external_user_data_shopper_group_id` (`shopper_group_id`),
  ADD KEY `IDX_external_user_data_user_group_id` (`user_group_id`),
  ADD KEY `IDX_external_user_data_created_by` (`created_by`),
  ADD KEY `IDX_external_data_user_modified_by` (`modified_by`),
  ADD KEY `IDX_external_user_data_deleted_by` (`deleted_by`),
  ADD KEY `FK_ex_u_d_currency_id_idx` (`currency_id`);

--
-- Indexes for table `financial_institution`
--
ALTER TABLE `financial_institution`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_UNIQ_IDX` (`name`,`user_group_id`),
  ADD KEY `IDX_financial_institution_user_group_id` (`user_group_id`);

--
-- Indexes for table `firm`
--
ALTER TABLE `firm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_firm_home_idx` (`home`),
  ADD KEY `IDX_firm_user_group_id` (`user_group_id`),
  ADD KEY `fk_firm_date_time_formats_id_idx` (`date_time_formats_id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gallery_ugi_user_group_id_idx` (`user_group_id`),
  ADD KEY `FK_gallery_cui_user_id_idx` (`created_by`),
  ADD KEY `FK_gallery_mui_user_id_idx` (`modified_by`);

--
-- Indexes for table `gallery_item`
--
ALTER TABLE `gallery_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_gallery_item_gallery_id` (`gallery_id`);

--
-- Indexes for table `gallery_item_lang`
--
ALTER TABLE `gallery_item_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_gallery_item_lang_lang_id` (`lang_id`),
  ADD KEY `idx_gallery_item_lang_gallery_iem_id` (`gallery_item_id`);

--
-- Indexes for table `gallery_lang`
--
ALTER TABLE `gallery_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gallery_gi_gallery_id_idx` (`gallery_id`),
  ADD KEY `FK_gallery_li_lang_id_idx` (`lang_id`);

--
-- Indexes for table `gallery_to_page`
--
ALTER TABLE `gallery_to_page`
  ADD UNIQUE KEY `U_gi_pi_idx` (`gallery_id`,`page_id`),
  ADD KEY `FK_ftp_gi_gallery_id_idx` (`gallery_id`),
  ADD KEY `FK_ftp_pi_page_id_idx` (`page_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_invoice_user_id_idx` (`user_id`),
  ADD KEY `FK_invoice_user_group_id_idx` (`user_group_id`);

--
-- Indexes for table `lang`
--
ALTER TABLE `lang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_lang_short_name_UNIQUE` (`lang_short_name`),
  ADD KEY `FK_d_t_f_i_d_t_f_idx` (`date_time_formats_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FIRM_LOCATION_idx` (`firm_id`);

--
-- Indexes for table `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_MANUF_user_group_id` (`user_group_id`);

--
-- Indexes for table `media_album`
--
ALTER TABLE `media_album`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_gallery_ugi_user_group_id_idx` (`user_group_id`),
  ADD KEY `FK_gallery_cui_user_id_idx` (`created_by`),
  ADD KEY `FK_gallery_mui_user_id_idx` (`modified_by`);

--
-- Indexes for table `media_album_lang`
--
ALTER TABLE `media_album_lang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_album_id` (`media_album_id`,`lang_id`) USING BTREE,
  ADD KEY `FK_gallery_gi_gallery_id_idx` (`media_album_id`),
  ADD KEY `FK_gallery_li_lang_id_idx` (`lang_id`);

--
-- Indexes for table `media_album_to_page`
--
ALTER TABLE `media_album_to_page`
  ADD UNIQUE KEY `U_gi_pi_idx` (`album_id`,`page_id`),
  ADD KEY `FK_ftp_gi_gallery_id_idx` (`album_id`),
  ADD KEY `FK_ftp_pi_page_id_idx` (`page_id`);

--
-- Indexes for table `media_category`
--
ALTER TABLE `media_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idxLeft` (`lft`),
  ADD KEY `idxRight` (`rgt`);

--
-- Indexes for table `media_category_items`
--
ALTER TABLE `media_category_items`
  ADD KEY `category_id` (`category_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `media_category_lang`
--
ALTER TABLE `media_category_lang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lang_id_3` (`lang_id`,`category_id`),
  ADD KEY `lang_id` (`lang_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `media_item`
--
ALTER TABLE `media_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_gallery_item_gallery_id` (`media_album_id`),
  ADD KEY `created_by` (`created_by`,`modified_by`),
  ADD KEY `modifiedby_user` (`modified_by`);

--
-- Indexes for table `media_item_lang`
--
ALTER TABLE `media_item_lang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_item_id` (`media_item_id`,`lang_id`) USING BTREE,
  ADD KEY `idx_gallery_item_lang_lang_id` (`lang_id`),
  ADD KEY `idx_gallery_item_lang_gallery_iem_id` (`media_item_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_dir_UNIQUE` (`dir`),
  ADD KEY `IDX_user_group_id_menu_idx` (`user_group_id`);

--
-- Indexes for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_menu_id_idx` (`menu_id`);

--
-- Indexes for table `menu_item_lang`
--
ALTER TABLE `menu_item_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_lang_id_idx` (`lang_id`),
  ADD KEY `IDX_menu_item_id_idx` (`menu_item_id`);

--
-- Indexes for table `menu_to_page`
--
ALTER TABLE `menu_to_page`
  ADD UNIQUE KEY `IDX_IND_MTP` (`menu_id`,`page_id`),
  ADD KEY `IDX_MTP_idx` (`page_id`);

--
-- Indexes for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_newsletter_subscribers_page_id_idx` (`page_id`),
  ADD KEY `idx_newsletter_subscribers_user_group_id_idx` (`user_group_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_INVOICE_IDD_idx` (`invoice_id`),
  ADD KEY `IDX_order_user_group_id` (`user_group_id`),
  ADD KEY `IDX_order_created_by` (`created_by`),
  ADD KEY `IDX_order_modified_by` (`modified_by`),
  ADD KEY `IDX_order_deleted_by` (`deleted_by`),
  ADD KEY `IDX_order_external_user_data_id` (`external_user_data_id`),
  ADD KEY `IDX_order_shop_id` (`shop_id`),
  ADD KEY `IDX_order_payment_method_id_idx` (`payment_method_id`),
  ADD KEY `IDX_order_reserve_location_id_idx` (`location_id`),
  ADD KEY `IDX_order_currency_ud_idx` (`currency_id`),
  ADD KEY `IDX_order_billing_data_id_idx` (`billing_data_id`),
  ADD KEY `IDX_order_billing_address_id_idx` (`billing_address_id`),
  ADD KEY `IDX_order_shipping_address_id_idx` (`shipping_address_id`);

--
-- Indexes for table `order_content`
--
ALTER TABLE `order_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_ORDER_C_P_ID_idx` (`product_id`),
  ADD KEY `IDX_ORDER_C_O_ID_idx` (`order_id`);

--
-- Indexes for table `order_packing_slip`
--
ALTER TABLE `order_packing_slip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_packing_slip_order_id_idx` (`order_id`),
  ADD KEY `IDX_packing_slip_u_g_id_idx` (`user_group_id`),
  ADD KEY `IDX_packing_slip_order_packing_slip_id_idx` (`order_packing_slip_id`),
  ADD KEY `IDX_order_packing_slip_user_id_idx` (`user_id`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_order_products_product_id` (`product_id`),
  ADD KEY `IDX_order_products_purchased_product_id` (`purchased_product_id`),
  ADD KEY `IDX_ORDER_CONTENT_ID_idx` (`order_content_id`),
  ADD KEY `IDX_returned_product_order_content_id_idx` (`returned_product_order_content_id`);

--
-- Indexes for table `packet`
--
ALTER TABLE `packet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_packet_user_group_id` (`user_group_id`);

--
-- Indexes for table `packet_lang`
--
ALTER TABLE `packet_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_LANG_TO_PACKET_idx` (`packet_id`),
  ADD KEY `IDX_PACL_lang_id` (`lang_id`);

--
-- Indexes for table `packing_slip`
--
ALTER TABLE `packing_slip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_supplier_IID_idx` (`supplier_id`),
  ADD KEY `IDX_packing_slip_user_group_id` (`user_group_id`),
  ADD KEY `IDX_packing_slip_currency_id` (`currency_id`),
  ADD KEY `IDX_packing_slip_created_by` (`created_by`),
  ADD KEY `IDX_packing_slip_modified_by` (`modified_by`),
  ADD KEY `IDX_packing_slip_deleted_by` (`deleted_by`),
  ADD KEY `IDX_packing_slip_location_id_idx` (`location_id`),
  ADD KEY `IDX_packing_slip_reverse_packingslip_id_idx` (`reverse_packingslip_id`);

--
-- Indexes for table `packing_slip_content`
--
ALTER TABLE `packing_slip_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PS_psc_id_idx` (`packing_slip_id`),
  ADD KEY `IDX_packing_slip_content_product_id` (`product_id`);

--
-- Indexes for table `packing_unit`
--
ALTER TABLE `packing_unit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PACKET_ID_idx` (`packet_id`),
  ADD KEY `IDX_PRODUCT_ID_idx` (`product_id`),
  ADD KEY `IDX_packing_unit_user_group_id` (`user_group_id`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `U_domain_name` (`domain_name`),
  ADD KEY `IDX_SHOP_ID_idx` (`shop_id`),
  ADD KEY `IDX_page_user_group_id` (`user_group_id`),
  ADD KEY `IDX_pg_tmpl_id_tmpl_id_idx` (`default_template_id`),
  ADD KEY `FK_pg_dli_idx` (`default_lang_id`),
  ADD KEY `FK_pg_date_time_formats_id_idx` (`date_time_formats_id`),
  ADD KEY `FK_page_parent_id_idx` (`parent_id`),
  ADD KEY `FK_domain_page_id_idx` (`domain_page_id`);

--
-- Indexes for table `password_reset_log`
--
ALTER TABLE `password_reset_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_password_reset_log_external_user_id` (`external_user_id`),
  ADD KEY `fk_password_e_l_page_id_idx` (`page_id`),
  ADD KEY `fk_password_e_l_user_group_id_idx` (`user_group_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_payment_method_user_group_id` (`user_group_id`),
  ADD KEY `IDX_payment_method_to_shop_id` (`shop_id`);

--
-- Indexes for table `payment_method_lang`
--
ALTER TABLE `payment_method_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_payment_m_l_idx` (`payment_method_id`),
  ADD KEY `IDX_PML_lang_id` (`lang_id`);

--
-- Indexes for table `pd_field_in_pd_fields`
--
ALTER TABLE `pd_field_in_pd_fields`
  ADD KEY `IDX_FIELD_ID_idx` (`product_data_field_id`),
  ADD KEY `IDX_FIELDS_ID_idx` (`product_data_fields_id`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRODUCT_ID_idx` (`product_id`),
  ADD KEY `IDX_SHOPPER_GROUP_ID_idx` (`shopper_group_id`),
  ADD KEY `IDX_PRI_user_group_id` (`user_group_id`);

--
-- Indexes for table `privileges`
--
ALTER TABLE `privileges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `privileges-old`
--
ALTER TABLE `privileges-old`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `privileges_group`
--
ALTER TABLE `privileges_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_user_group_id_idx` (`user_group_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_MAN_ID_idx` (`manufacturer_id`),
  ADD KEY `IDX_WUI_ID_idx` (`weight_unit_id`),
  ADD KEY `IDX_QU_ID_idx` (`quantity_unit_id`),
  ADD KEY `IDX_PT_ID_idx` (`product_type_id`),
  ADD KEY `IDX_PARENT_ID_idx` (`parent_id`),
  ADD KEY `IDX_INDEX_BARCODE` (`barcode`),
  ADD KEY `IDX_PRODU_user_group_id` (`user_group_id`),
  ADD KEY `IDX_product_c_user_id` (`created_by`),
  ADD KEY `IDX_product_m_user_id` (`modified_by`),
  ADD KEY `IDX_product_d_user_id` (`deleted_by`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_product_category_user_group_id` (`user_group_id`),
  ADD KEY `IDX_product_category_c_user_id` (`created_by`),
  ADD KEY `IDX_product_category_m_user_id` (`modified_by`),
  ADD KEY `IDX_product_category_d_user_id` (`deleted_by`);

--
-- Indexes for table `product_category_item`
--
ALTER TABLE `product_category_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRODUCT_CATEGORY_ID_idx` (`product_category_id`),
  ADD KEY `IDX_TTK_DATA_ID_idx` (`ttk_id`),
  ADD KEY `IDX_PRODUCT_DATA_FIELDS_ID_idx` (`product_data_fields_id`);

--
-- Indexes for table `product_category_item_lang`
--
ALTER TABLE `product_category_item_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRODUCT_CATEGORY_ITEM_ID_idx` (`product_category_item_id`),
  ADD KEY `IDX_PCIL_lang_id` (`lang_id`);

--
-- Indexes for table `product_category_price_margin`
--
ALTER TABLE `product_category_price_margin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_pc_price_margin_user_group_id_idx` (`user_group_id`),
  ADD KEY `FK_pc_price_margin_category_id_idx` (`category_id`),
  ADD KEY `FK_pc_price_margin_category_item_id_idx` (`category_item_id`),
  ADD KEY `FK_pc_price_margin_shopper_group_id_idx` (`shopper_group_id`);

--
-- Indexes for table `product_category_to_page`
--
ALTER TABLE `product_category_to_page`
  ADD UNIQUE KEY `IN_PCTP` (`shop_id`,`product_category_id`),
  ADD KEY `IDX_product_category_id_to_page_id` (`product_category_id`);

--
-- Indexes for table `product_data_field`
--
ALTER TABLE `product_data_field`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PDFEE_user_group_id` (`user_group_id`),
  ADD KEY `FK_PDFUI_unit_id_idx` (`unit_id`);

--
-- Indexes for table `product_data_fields`
--
ALTER TABLE `product_data_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_product_data_fields_user_group_id` (`user_group_id`);

--
-- Indexes for table `product_data_fields_lang`
--
ALTER TABLE `product_data_fields_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRODUCT_DATA_FIELDS_ID_idx` (`product_data_fields_id`),
  ADD KEY `IDX_PDFLDD_lang_id` (`lang_id`);

--
-- Indexes for table `product_data_field_lang`
--
ALTER TABLE `product_data_field_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRODUCT_DATA_FIELD_ID_idx` (`product_data_field_id`),
  ADD KEY `IDX_PDFLDDD_lang_id` (`lang_id`);

--
-- Indexes for table `product_lang`
--
ALTER TABLE `product_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRODUCT_NOTE_ID_idx` (`product_id`),
  ADD KEY `IDX_P_lang_id` (`lang_id`);

--
-- Indexes for table `product_state`
--
ALTER TABLE `product_state`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_state_lang`
--
ALTER TABLE `product_state_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_prduct_st_l_idx` (`product_state_id`),
  ADD KEY `IDX_PSL_lang_id` (`lang_id`);

--
-- Indexes for table `product_synced_price_data`
--
ALTER TABLE `product_synced_price_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_p_sync_price_d_product_id_idx` (`product_id`),
  ADD KEY `FK_sync_config_id_idx` (`sync_config_id`);

--
-- Indexes for table `product_sync_config`
--
ALTER TABLE `product_sync_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_p_sync_c_user_group_id_idx` (`user_group_id`);

--
-- Indexes for table `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PT_user_group_id` (`user_group_id`);

--
-- Indexes for table `product_type_lang`
--
ALTER TABLE `product_type_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PRO_TYPE_idx` (`product_type_id`),
  ADD KEY `IDX_PTL_lang_id` (`lang_id`);

--
-- Indexes for table `progress`
--
ALTER TABLE `progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `FK_progress_user_group_id_idx` (`user_group_id`),
  ADD KEY `FK_progress_user_id_idx` (`user_id`);

--
-- Indexes for table `purchased_product`
--
ALTER TABLE `purchased_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_PI_p_id_idx` (`purchase_invoice_id`),
  ADD KEY `IDX_P_s_id_idx` (`stock_id`),
  ADD KEY `IDX_PS_ps_id_idx` (`product_state_id`),
  ADD KEY `IDX_PS_p_id_idx` (`packing_slip_id`),
  ADD KEY `IDX_RESERV_ID_INDEX` (`reserve_id_code`) COMMENT 'Hogy a befoglaláskor a lekérdezés gyors legyen',
  ADD KEY `IDX_purchased_product_product_id` (`product_id`),
  ADD KEY `IDX_PI_old_PI_id_idx` (`old_purchase_invoice_id`),
  ADD KEY `IDX_FP_PP_location_id_idx` (`location_id`);

--
-- Indexes for table `purchase_invoice`
--
ALTER TABLE `purchase_invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_supp_id_idx` (`supplier_id`),
  ADD KEY `IDX_purchase_invoice_user_group_id` (`user_group_id`),
  ADD KEY `IDX_purchase_invoice_currency_id` (`currency_id`),
  ADD KEY `IDX_purchase_invoice_created_by` (`created_by`),
  ADD KEY `IDX_purchase_invoice_modified_by` (`modified_by`),
  ADD KEY `IDX_purchase_invoice_deleted_by` (`deleted_by`),
  ADD KEY `IDX_purchase_invoice_location_id_idx` (`location_id`);

--
-- Indexes for table `purchase_invoice_content`
--
ALTER TABLE `purchase_invoice_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_pi_id_idx` (`purchase_invoice_id`),
  ADD KEY `IDX_purchase_invoice_content_product_id` (`product_id`);

--
-- Indexes for table `routes_templates`
--
ALTER TABLE `routes_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_rtemp_pg_url_lng_u` (`page_id`,`url`,`lang_id`,`template_id`),
  ADD KEY `IDX_rtemp_page_idx` (`page_id`),
  ADD KEY `IDX_rtemp_shop_idx` (`shop_id`),
  ADD KEY `IDX_rtemp_user_group_id_idx` (`user_group_id`),
  ADD KEY `IDX_rtemp_lang_idx` (`lang_id`),
  ADD KEY `IDX_rtemp_templates_idx` (`template_id`);

--
-- Indexes for table `shipping_method`
--
ALTER TABLE `shipping_method`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_SHOP_ID_SM_idx` (`shop_id`),
  ADD KEY `IDX_shipping_method_user_group_id` (`user_group_id`);

--
-- Indexes for table `shipping_methods_by_country`
--
ALTER TABLE `shipping_methods_by_country`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_SHIPP_ID_idx` (`shipping_method_id`),
  ADD KEY `IDX_SHIPPCOUNTRY_idx` (`country_id`);

--
-- Indexes for table `shipping_method_lang`
--
ALTER TABLE `shipping_method_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_SHI_ID_idx` (`shipping_method_id`),
  ADD KEY `IDX_shipping_method_lang_lang_id` (`lang_id`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_shop_user_group_id` (`user_group_id`);

--
-- Indexes for table `shopper_group`
--
ALTER TABLE `shopper_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_SHG_user_group_id` (`user_group_id`),
  ADD KEY `IDX_shopper_group_c_user_id` (`created_by`),
  ADD KEY `IDX_shopper_group_m_user_id` (`modified_by`),
  ADD KEY `IDX_shopper_group_d_user_id` (`deleted_by`);

--
-- Indexes for table `shop_shopper_groups`
--
ALTER TABLE `shop_shopper_groups`
  ADD KEY `IDX_SOP_FK_ID_idx` (`shop_id`),
  ADD KEY `IDX_shopper_group_id_to_shop` (`shopper_group_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_LOCATION_idx` (`location_id`),
  ADD KEY `IDX_stock_user_group_id` (`user_group_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_sup_azon_name_usergid` (`name`,`user_group_id`) COMMENT 'hogy gyorsabb legyen keresni az adott felhasználói csoportba tartozó neveket',
  ADD KEY `IDX_supplier_user_group_id` (`user_group_id`),
  ADD KEY `IDX_supplier_created_by` (`created_by`),
  ADD KEY `IDX_supplier_modified_by` (`modified_by`),
  ADD KEY `IDX_supplier_deleted_by` (`deleted_by`);

--
-- Indexes for table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tender`
--
ALTER TABLE `tender`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_t_user_group_id` (`user_group_id`),
  ADD KEY `IDX_t_created_by` (`created_by`),
  ADD KEY `IDX_t_modified_by` (`modified_by`),
  ADD KEY `IDX_t_deleted_by` (`deleted_by`),
  ADD KEY `IDX_t_external_user_data_id` (`external_user_data_id`),
  ADD KEY `IDX_t_shop_id` (`shop_id`);

--
-- Indexes for table `tender_content`
--
ALTER TABLE `tender_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_ORDER_C_P_ID_idx` (`product_id`),
  ADD KEY `IDX_TENDER_ID_idx` (`tender_id`);

--
-- Indexes for table `ttk`
--
ALTER TABLE `ttk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_TTTTK_user_group_id` (`user_group_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `IDX_eamil_UNIQUE` (`email`),
  ADD UNIQUE KEY `IDX_user_name_UNIQUE` (`user_name`),
  ADD KEY `IDX_user_group_id_idx` (`default_user_group_id`),
  ADD KEY `IDX_auser_date_format_idx` (`date_time_format`),
  ADD KEY `IDX_d_user_id_idx` (`deleted_by`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_privilege`
--
ALTER TABLE `user_privilege`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_user_id_idx` (`user_id`),
  ADD KEY `IDX_privilege_group_id_idx` (`privilege_group_id`);

--
-- Indexes for table `webshop_search_temp`
--
ALTER TABLE `webshop_search_temp`
  ADD KEY `WSS_T_type_IDX` (`type`),
  ADD KEY `WSS_T_lang_id_IDX` (`lang_id`),
  ADD KEY `WSS_T_user_group_id_IDX` (`user_group_id`),
  ADD KEY `WSS_T_shop_id_IDX` (`shop_id`);

--
-- Indexes for table `zip_code`
--
ALTER TABLE `zip_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_zip_code_country_id_idx` (`country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `address_type`
--
ALTER TABLE `address_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `address_type_lang`
--
ALTER TABLE `address_type_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `admin_moduls`
--
ALTER TABLE `admin_moduls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `assembled_product`
--
ALTER TABLE `assembled_product`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bank_account_numbers`
--
ALTER TABLE `bank_account_numbers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'bankszámlaszámok a céghez';
--
-- AUTO_INCREMENT for table `banner`
--
ALTER TABLE `banner`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `banner_item`
--
ALTER TABLE `banner_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `banner_item_lang`
--
ALTER TABLE `banner_item_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `banner_lang`
--
ALTER TABLE `banner_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `billing_data`
--
ALTER TABLE `billing_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cash_register`
--
ALTER TABLE `cash_register`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cash_register_financial_flows`
--
ALTER TABLE `cash_register_financial_flows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cash_voucher`
--
ALTER TABLE `cash_voucher`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cash_voucher_claim`
--
ALTER TABLE `cash_voucher_claim`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `category_flags`
--
ALTER TABLE `category_flags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category_flag_lang`
--
ALTER TABLE `category_flag_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category_lang`
--
ALTER TABLE `category_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `certificate_type`
--
ALTER TABLE `certificate_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `content_lang`
--
ALTER TABLE `content_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `content_temp`
--
ALTER TABLE `content_temp`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `country_lang`
--
ALTER TABLE `country_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `date_time_formats`
--
ALTER TABLE `date_time_formats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `denominations`
--
ALTER TABLE `denominations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `denomination_types`
--
ALTER TABLE `denomination_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_category`
--
ALTER TABLE `document_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_category_item`
--
ALTER TABLE `document_category_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_category_item_lang`
--
ALTER TABLE `document_category_item_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_category_lang`
--
ALTER TABLE `document_category_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_flag`
--
ALTER TABLE `document_flag`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_flag_lang`
--
ALTER TABLE `document_flag_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `document_lang`
--
ALTER TABLE `document_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_categories`
--
ALTER TABLE `event_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_categories_lang`
--
ALTER TABLE `event_categories_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_locations`
--
ALTER TABLE `event_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_organisers`
--
ALTER TABLE `event_organisers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `event_schedule`
--
ALTER TABLE `event_schedule`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `external_privilege`
--
ALTER TABLE `external_privilege`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `external_privilege_group`
--
ALTER TABLE `external_privilege_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `external_user`
--
ALTER TABLE `external_user`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `external_user_data`
--
ALTER TABLE `external_user_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `financial_institution`
--
ALTER TABLE `financial_institution`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A pénzintézet id-ja';
--
-- AUTO_INCREMENT for table `firm`
--
ALTER TABLE `firm`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `gallery_item`
--
ALTER TABLE `gallery_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT for table `gallery_item_lang`
--
ALTER TABLE `gallery_item_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `gallery_lang`
--
ALTER TABLE `gallery_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lang`
--
ALTER TABLE `lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `manufacturer`
--
ALTER TABLE `manufacturer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `media_album`
--
ALTER TABLE `media_album`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `media_album_lang`
--
ALTER TABLE `media_album_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT for table `media_category`
--
ALTER TABLE `media_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT for table `media_category_lang`
--
ALTER TABLE `media_category_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;
--
-- AUTO_INCREMENT for table `media_item`
--
ALTER TABLE `media_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=446;
--
-- AUTO_INCREMENT for table `media_item_lang`
--
ALTER TABLE `media_item_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=659;
--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `menu_item_lang`
--
ALTER TABLE `menu_item_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_content`
--
ALTER TABLE `order_content`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_packing_slip`
--
ALTER TABLE `order_packing_slip`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `packet`
--
ALTER TABLE `packet`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `packet_lang`
--
ALTER TABLE `packet_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `packing_slip`
--
ALTER TABLE `packing_slip`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `packing_unit`
--
ALTER TABLE `packing_unit`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `page`
--
ALTER TABLE `page`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `password_reset_log`
--
ALTER TABLE `password_reset_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `payment_method_lang`
--
ALTER TABLE `payment_method_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `privileges`
--
ALTER TABLE `privileges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;
--
-- AUTO_INCREMENT for table `privileges-old`
--
ALTER TABLE `privileges-old`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;
--
-- AUTO_INCREMENT for table `privileges_group`
--
ALTER TABLE `privileges_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A termék rendszerben tárolt id-je';
--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_category_item`
--
ALTER TABLE `product_category_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_category_item_lang`
--
ALTER TABLE `product_category_item_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_category_price_margin`
--
ALTER TABLE `product_category_price_margin`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_data_field`
--
ALTER TABLE `product_data_field`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_data_fields`
--
ALTER TABLE `product_data_fields`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_data_fields_lang`
--
ALTER TABLE `product_data_fields_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_data_field_lang`
--
ALTER TABLE `product_data_field_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_lang`
--
ALTER TABLE `product_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_state`
--
ALTER TABLE `product_state`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `product_state_lang`
--
ALTER TABLE `product_state_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `product_synced_price_data`
--
ALTER TABLE `product_synced_price_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_sync_config`
--
ALTER TABLE `product_sync_config`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_type`
--
ALTER TABLE `product_type`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_type_lang`
--
ALTER TABLE `product_type_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `purchase_invoice`
--
ALTER TABLE `purchase_invoice`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'beszerzési számla';
--
-- AUTO_INCREMENT for table `routes_templates`
--
ALTER TABLE `routes_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `shipping_method`
--
ALTER TABLE `shipping_method`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shipping_methods_by_country`
--
ALTER TABLE `shipping_methods_by_country`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shipping_method_lang`
--
ALTER TABLE `shipping_method_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shopper_group`
--
ALTER TABLE `shopper_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tender`
--
ALTER TABLE `tender`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tender_content`
--
ALTER TABLE `tender_content`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ttk`
--
ALTER TABLE `ttk`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A felhasználó egyedi azonosítója', AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_privilege`
--
ALTER TABLE `user_privilege`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK_ADD_COUNTRY_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ADD_EXT_U_D_ID` FOREIGN KEY (`external_user_data_id`) REFERENCES `external_user_data` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ADD_T` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `address_type`
--
ALTER TABLE `address_type`
  ADD CONSTRAINT `FK_address_type_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `address_type_lang`
--
ALTER TABLE `address_type_lang`
  ADD CONSTRAINT `FK_ADD_T_I` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_address_type_lang_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `assembled_product`
--
ALTER TABLE `assembled_product`
  ADD CONSTRAINT `FK_assembled_product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_part_purchased_product_id` FOREIGN KEY (`part_purchased_product_id`) REFERENCES `purchased_product` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchased_product_id` FOREIGN KEY (`purchased_product_id`) REFERENCES `purchased_product` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `bank_account_numbers`
--
ALTER TABLE `bank_account_numbers`
  ADD CONSTRAINT `FK_financial_institution` FOREIGN KEY (`financial_institution_id`) REFERENCES `financial_institution` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_firm_b_a_ns` FOREIGN KEY (`firm_id`) REFERENCES `firm` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `banner`
--
ALTER TABLE `banner`
  ADD CONSTRAINT `fk_banner_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_page_id` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `banner_item`
--
ALTER TABLE `banner_item`
  ADD CONSTRAINT `fk_banner_item_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `banner` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_item_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_item_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `banner_item_lang`
--
ALTER TABLE `banner_item_lang`
  ADD CONSTRAINT `fk_banner_item_lang_banner_item_id` FOREIGN KEY (`banner_item_id`) REFERENCES `banner_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_item_lang_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `banner_lang`
--
ALTER TABLE `banner_lang`
  ADD CONSTRAINT `fk_banner_lang_banner_id` FOREIGN KEY (`banner_id`) REFERENCES `banner` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banner_lang_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `billing_data`
--
ALTER TABLE `billing_data`
  ADD CONSTRAINT `FK_B_D_E_U_ID` FOREIGN KEY (`external_user_data_id`) REFERENCES `external_user_data` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cash_register`
--
ALTER TABLE `cash_register`
  ADD CONSTRAINT `cash_register_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cash_register_ibfk_2` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `cash_register_financial_flows`
--
ALTER TABLE `cash_register_financial_flows`
  ADD CONSTRAINT `cash_register_financial_flows_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cash_register_financial_flows_ibfk_2` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_register` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `cash_voucher`
--
ALTER TABLE `cash_voucher`
  ADD CONSTRAINT `FK_cash_voucher_cash_register_financial_flow` FOREIGN KEY (`cash_register_financial_flows_id`) REFERENCES `cash_register_financial_flows` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cash_voucher_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cash_voucher_cwcid` FOREIGN KEY (`cash_voucher_claim_id`) REFERENCES `cash_voucher_claim` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cash_voucher_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cash_voucher_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cash_voucher_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `cash_voucher_claim`
--
ALTER TABLE `cash_voucher_claim`
  ADD CONSTRAINT `FK_cw_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `FK_cat_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `category_contents`
--
ALTER TABLE `category_contents`
  ADD CONSTRAINT `FK_category_contents_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `category_flags`
--
ALTER TABLE `category_flags`
  ADD CONSTRAINT `FK_catf_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `category_flag_lang`
--
ALTER TABLE `category_flag_lang`
  ADD CONSTRAINT `FK_category_flag_lang_cf` FOREIGN KEY (`category_flag_id`) REFERENCES `category_flags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cfl_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `category_lang`
--
ALTER TABLE `category_lang`
  ADD CONSTRAINT `FK_category_lang_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_catil_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `category_products`
--
ALTER TABLE `category_products`
  ADD CONSTRAINT `FK_PRODUCT_CATEGORY_ID_1` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_CATEGORY_ITEM_ID_2` FOREIGN KEY (`product_category_item_id`) REFERENCES `product_category_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ID_TO_CP` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `category_to_page`
--
ALTER TABLE `category_to_page`
  ADD CONSTRAINT `FK_CTPA` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_category_id_to_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `FK_certificate_c_user_id` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_certificate_d_user_id` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_certificates_certificate_type` FOREIGN KEY (`type_id`) REFERENCES `certificate_type` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_certificates_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_def_cvci_id` FOREIGN KEY (`default_cashvoucher_claim_in_id`) REFERENCES `cash_voucher_claim` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_def_cvco_id` FOREIGN KEY (`default_cashvoucher_claim_out_id`) REFERENCES `cash_voucher_claim` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `FK_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `FK_createdby_uid` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_modified_by_uid` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_user_group_id_content` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_deletedby_uid` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `content_lang`
--
ALTER TABLE `content_lang`
  ADD CONSTRAINT `FK_content_id_content` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_lang_id_to_lang` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `content_to_page`
--
ALTER TABLE `content_to_page`
  ADD CONSTRAINT `FK_CTP` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_content_id_content_p` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `country_lang`
--
ALTER TABLE `country_lang`
  ADD CONSTRAINT `FK_COUNTRY_TO_LANG` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_country_lang_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `currencies`
--
ALTER TABLE `currencies`
  ADD CONSTRAINT `FK_currencies_currency` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `denominations`
--
ALTER TABLE `denominations`
  ADD CONSTRAINT `FK_denom_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_denom_denom_type_id` FOREIGN KEY (`denomination_type_id`) REFERENCES `denomination_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_denom_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `denomination_types`
--
ALTER TABLE `denomination_types`
  ADD CONSTRAINT `FK_denom_type_curr_id_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_denom_type_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `FK_d_cui` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_d_dcii` FOREIGN KEY (`document_category_item_id`) REFERENCES `document_category_item` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_d_mui` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_d_ugi` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_category`
--
ALTER TABLE `document_category`
  ADD CONSTRAINT `FK_dc_cb` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dc_db` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dc_mb` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dc_ugi` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_category_item`
--
ALTER TABLE `document_category_item`
  ADD CONSTRAINT `FK_dci_cb` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dci_db` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dci_dc` FOREIGN KEY (`document_category_id`) REFERENCES `document_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dci_mb` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_category_item_lang`
--
ALTER TABLE `document_category_item_lang`
  ADD CONSTRAINT `FK_dcii_dci` FOREIGN KEY (`document_category_item_id`) REFERENCES `document_category_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dcii_li` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `document_category_lang`
--
ALTER TABLE `document_category_lang`
  ADD CONSTRAINT `FK_DCL_I_DC_I` FOREIGN KEY (`document_category_id`) REFERENCES `document_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_DCL_LI_LI` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_flag`
--
ALTER TABLE `document_flag`
  ADD CONSTRAINT `FK_doc_u_g_i` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_flags`
--
ALTER TABLE `document_flags`
  ADD CONSTRAINT `FK_df_d` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_df_dfs` FOREIGN KEY (`document_flag_id`) REFERENCES `document_flag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `document_flag_lang`
--
ALTER TABLE `document_flag_lang`
  ADD CONSTRAINT `FK_df_dfl` FOREIGN KEY (`document_flag_id`) REFERENCES `document_flag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dfl_li` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_lang`
--
ALTER TABLE `document_lang`
  ADD CONSTRAINT `FK_dl_di` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_dl_li` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `FK_ev_cb` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_db` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_mb` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_ugid` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `events_to_page`
--
ALTER TABLE `events_to_page`
  ADD CONSTRAINT `FK_ev_t_p_ev_id` FOREIGN KEY (`events_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_t_p_pid` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event_categories`
--
ALTER TABLE `event_categories`
  ADD CONSTRAINT `FK_ev_c_ug_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_c_cb` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_c_db` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_c_mb` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `event_categories_lang`
--
ALTER TABLE `event_categories_lang`
  ADD CONSTRAINT `FK_ev_c_l_ev_c_id` FOREIGN KEY (`event_categories_id`) REFERENCES `event_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_c_l_lid` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `event_categories_to_events`
--
ALTER TABLE `event_categories_to_events`
  ADD CONSTRAINT `Fk_ev_c_t_ev_ev_c_id` FOREIGN KEY (`event_categories_id`) REFERENCES `event_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_c_t_ev_ev_id` FOREIGN KEY (`events_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event_categories_to_page`
--
ALTER TABLE `event_categories_to_page`
  ADD CONSTRAINT `FK_ev_cat_t_p_ev_cat` FOREIGN KEY (`event_categories_id`) REFERENCES `event_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_cat_t_p_pid` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event_locations`
--
ALTER TABLE `event_locations`
  ADD CONSTRAINT `Fk_ev_l_cb` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_l_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_l_db` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_l_ig_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_l_mb` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `event_locations_to_events`
--
ALTER TABLE `event_locations_to_events`
  ADD CONSTRAINT `Fk_ev_l_t_ev_ev_id` FOREIGN KEY (`events_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_l_t_ev_ev_l_id` FOREIGN KEY (`event_locations_id`) REFERENCES `event_locations` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `event_organisers`
--
ALTER TABLE `event_organisers`
  ADD CONSTRAINT `FK_ev_o_cb` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_o_db` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_o_mb` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ev_o_ui` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `event_organisers_to_events`
--
ALTER TABLE `event_organisers_to_events`
  ADD CONSTRAINT `Fk_ev_o_t_ev_ev_id` FOREIGN KEY (`event_organisers_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_ev_o_t_ev_ev_o_id` FOREIGN KEY (`event_organisers_id`) REFERENCES `event_organisers` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `external_privilege_group`
--
ALTER TABLE `external_privilege_group`
  ADD CONSTRAINT `FK_PAGE_ID_EPG` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_external_privilege_group_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `external_user`
--
ALTER TABLE `external_user`
  ADD CONSTRAINT `FK_EXT_P_G` FOREIGN KEY (`external_privilege_group_id`) REFERENCES `external_privilege_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EXT_P_ID` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EXT_UD_ID` FOREIGN KEY (`external_user_data_id`) REFERENCES `external_user_data` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EXT_US_DTFI` FOREIGN KEY (`date_time_formats_id`) REFERENCES `date_time_formats` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_epg_external_privilege_group_id` FOREIGN KEY (`external_privilege_group_id`) REFERENCES `external_privilege_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `external_user_data`
--
ALTER TABLE `external_user_data`
  ADD CONSTRAINT `FK_E_U_D_SHOP_ID` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_epg_external_user_data_shopper_group_id` FOREIGN KEY (`shopper_group_id`) REFERENCES `shopper_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ex_u_d_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_data_user_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_data_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_data_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_external_user_data_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `financial_institution`
--
ALTER TABLE `financial_institution`
  ADD CONSTRAINT `FK_financial_institution_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `firm`
--
ALTER TABLE `firm`
  ADD CONSTRAINT `FK_firm_home` FOREIGN KEY (`home`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_firm_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_firm_date_time_formats_id` FOREIGN KEY (`date_time_formats_id`) REFERENCES `date_time_formats` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `gallery`
--
ALTER TABLE `gallery`
  ADD CONSTRAINT `FK_gallery_cui_user_id` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_gallery_mui_user_id` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_gallery_ugi_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `gallery_item`
--
ALTER TABLE `gallery_item`
  ADD CONSTRAINT `fk_gallery_item_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `gallery` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `gallery_item_lang`
--
ALTER TABLE `gallery_item_lang`
  ADD CONSTRAINT `fk_gallery_item_lang_gallery_item_id` FOREIGN KEY (`gallery_item_id`) REFERENCES `gallery_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_gallery_item_lang_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `gallery_lang`
--
ALTER TABLE `gallery_lang`
  ADD CONSTRAINT `FK_gallery_gi_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `gallery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_gallery_li_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `gallery_to_page`
--
ALTER TABLE `gallery_to_page`
  ADD CONSTRAINT `FK_ftp_gi_gallery_id` FOREIGN KEY (`gallery_id`) REFERENCES `gallery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ftp_pi_page_id` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `FK_invoice_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_invoice_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `lang`
--
ALTER TABLE `lang`
  ADD CONSTRAINT `FK_d_t_f_i_d_t_f` FOREIGN KEY (`date_time_formats_id`) REFERENCES `date_time_formats` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `FK_FIRM_LOCATION` FOREIGN KEY (`firm_id`) REFERENCES `firm` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD CONSTRAINT `FK_MANUF_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `media_album`
--
ALTER TABLE `media_album`
  ADD CONSTRAINT `media_album_ibfk_1` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `media_album_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `media_album_ibfk_3` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `media_album_lang`
--
ALTER TABLE `media_album_lang`
  ADD CONSTRAINT `media_album_lang_ibfk_1` FOREIGN KEY (`media_album_id`) REFERENCES `media_album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `media_album_lang_ibfk_2` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `media_album_to_page`
--
ALTER TABLE `media_album_to_page`
  ADD CONSTRAINT `media_album_to_page_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `media_album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `media_category_items`
--
ALTER TABLE `media_category_items`
  ADD CONSTRAINT `media_category_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `media_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `media_category_items_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `media_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `media_category_lang`
--
ALTER TABLE `media_category_lang`
  ADD CONSTRAINT `med_cat` FOREIGN KEY (`category_id`) REFERENCES `media_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `med_cat_lang` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `media_item`
--
ALTER TABLE `media_item`
  ADD CONSTRAINT `createdby_user` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `media_item_ibfk_1` FOREIGN KEY (`media_album_id`) REFERENCES `media_album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modifiedby_user` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `media_item_lang`
--
ALTER TABLE `media_item_lang`
  ADD CONSTRAINT `media_item_lang_ibfk_1` FOREIGN KEY (`media_item_id`) REFERENCES `media_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `media_item_lang_ibfk_2` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `FK_user_group_id_menu` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `menu_item`
--
ALTER TABLE `menu_item`
  ADD CONSTRAINT `FK_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `menu_item_lang`
--
ALTER TABLE `menu_item_lang`
  ADD CONSTRAINT `FK_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_to_page`
--
ALTER TABLE `menu_to_page`
  ADD CONSTRAINT `FK_MTP` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_menu_id_to_page_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  ADD CONSTRAINT `fk_newsletter_subscribers_page_id` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_newsletter_subscribers_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_INVOICE_IDD` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  ADD CONSTRAINT `FK_order_billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_billing_data_id` FOREIGN KEY (`billing_data_id`) REFERENCES `billing_data` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_currency_ud` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_external_user_data_id` FOREIGN KEY (`external_user_data_id`) REFERENCES `external_user_data` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_reserve_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_content`
--
ALTER TABLE `order_content`
  ADD CONSTRAINT `FK_ORDER_C_O_ID` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ORDER_C_P_ID` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_packing_slip`
--
ALTER TABLE `order_packing_slip`
  ADD CONSTRAINT `FK_order_packing_slip_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_order_packing_slip_id` FOREIGN KEY (`order_packing_slip_id`) REFERENCES `order_packing_slip` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_u_g_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `FK_ORDER_CONTENT_ID` FOREIGN KEY (`order_content_id`) REFERENCES `order_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_products_purchased_product_id` FOREIGN KEY (`purchased_product_id`) REFERENCES `purchased_product` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_returned_product_order_content_id` FOREIGN KEY (`returned_product_order_content_id`) REFERENCES `order_content` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `packet`
--
ALTER TABLE `packet`
  ADD CONSTRAINT `FK_packet_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `packet_lang`
--
ALTER TABLE `packet_lang`
  ADD CONSTRAINT `FK_LANG_TO_PACKET` FOREIGN KEY (`packet_id`) REFERENCES `packet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PACL_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `packing_slip`
--
ALTER TABLE `packing_slip`
  ADD CONSTRAINT `FK_packing_slip_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_reverse_packingslip_id` FOREIGN KEY (`reverse_packingslip_id`) REFERENCES `packing_slip` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_supplier_IID` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `packing_slip_content`
--
ALTER TABLE `packing_slip_content`
  ADD CONSTRAINT `FK_PS_psc_id` FOREIGN KEY (`packing_slip_id`) REFERENCES `packing_slip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_slip_content_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `packing_unit`
--
ALTER TABLE `packing_unit`
  ADD CONSTRAINT `FK_PACKET_ID` FOREIGN KEY (`packet_id`) REFERENCES `packet` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ID` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_packing_unit_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `page`
--
ALTER TABLE `page`
  ADD CONSTRAINT `FK_SHOP_ID` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_domain_page_id` FOREIGN KEY (`domain_page_id`) REFERENCES `page` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_page_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `page` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_page_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pg_date_time_formats_id` FOREIGN KEY (`date_time_formats_id`) REFERENCES `date_time_formats` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pg_dli` FOREIGN KEY (`default_lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pg_tmpl_id_tmpl_id` FOREIGN KEY (`default_template_id`) REFERENCES `templates` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `password_reset_log`
--
ALTER TABLE `password_reset_log`
  ADD CONSTRAINT `fk_password_e_l_page_id` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_password_e_l_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_password_reset_log_external_user_id` FOREIGN KEY (`external_user_id`) REFERENCES `external_user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD CONSTRAINT `FK_payment_method_to_shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_payment_method_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_method_lang`
--
ALTER TABLE `payment_method_lang`
  ADD CONSTRAINT `FK_PML_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_payment_m_l` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pd_field_in_pd_fields`
--
ALTER TABLE `pd_field_in_pd_fields`
  ADD CONSTRAINT `FK_FIELDS_ID` FOREIGN KEY (`product_data_fields_id`) REFERENCES `product_data_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_FIELD_ID` FOREIGN KEY (`product_data_field_id`) REFERENCES `product_data_field` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `price`
--
ALTER TABLE `price`
  ADD CONSTRAINT `FK_PRI_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_ID_TO_PRICE` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SHOPPER_GROUP_ID` FOREIGN KEY (`shopper_group_id`) REFERENCES `shopper_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `privileges_group`
--
ALTER TABLE `privileges_group`
  ADD CONSTRAINT `FK_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_MAN_ID` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PARENT_ID` FOREIGN KEY (`parent_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODU_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PT_ID` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_QU_ID` FOREIGN KEY (`quantity_unit_id`) REFERENCES `units` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_WUI_ID` FOREIGN KEY (`weight_unit_id`) REFERENCES `units` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_c_user_id` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_d_user_id` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_m_user_id` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `FK_product_category_c_user_id` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_category_d_user_id` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_category_m_user_id` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_category_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_category_item`
--
ALTER TABLE `product_category_item`
  ADD CONSTRAINT `FK_PRODUCT_CATEGORY_ID` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_DATA_FIELDS_ID` FOREIGN KEY (`product_data_fields_id`) REFERENCES `product_data_fields` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TTK_DATA_ID` FOREIGN KEY (`ttk_id`) REFERENCES `ttk` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_category_item_lang`
--
ALTER TABLE `product_category_item_lang`
  ADD CONSTRAINT `FK_PCIL_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_CATEGORY_ITEM_ID` FOREIGN KEY (`product_category_item_id`) REFERENCES `product_category_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_category_price_margin`
--
ALTER TABLE `product_category_price_margin`
  ADD CONSTRAINT `FK_pc_price_margin_category_id` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pc_price_margin_category_item_id` FOREIGN KEY (`category_item_id`) REFERENCES `product_category_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pc_price_margin_shopper_group_id` FOREIGN KEY (`shopper_group_id`) REFERENCES `shopper_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_pc_price_margin_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_category_to_page`
--
ALTER TABLE `product_category_to_page`
  ADD CONSTRAINT `FK_PCTP_ID` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_product_category_id_to_page_id` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_data_field`
--
ALTER TABLE `product_data_field`
  ADD CONSTRAINT `FK_PDFEE_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PDFUI_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_data_fields`
--
ALTER TABLE `product_data_fields`
  ADD CONSTRAINT `FK_product_data_fields_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_data_fields_lang`
--
ALTER TABLE `product_data_fields_lang`
  ADD CONSTRAINT `FK_PDFLDD_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_DATA_FIELDS_ID_1001` FOREIGN KEY (`product_data_fields_id`) REFERENCES `product_data_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_data_field_lang`
--
ALTER TABLE `product_data_field_lang`
  ADD CONSTRAINT `FK_PDFLDDD_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PRODUCT_DATA_FIELD_ID_1000` FOREIGN KEY (`product_data_field_id`) REFERENCES `product_data_field` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_lang`
--
ALTER TABLE `product_lang`
  ADD CONSTRAINT `FK_PRODUCT_NOTE_ID` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_P_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_state_lang`
--
ALTER TABLE `product_state_lang`
  ADD CONSTRAINT `FK_PSL_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FKprduct_st_l` FOREIGN KEY (`product_state_id`) REFERENCES `product_state` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_synced_price_data`
--
ALTER TABLE `product_synced_price_data`
  ADD CONSTRAINT `FK_p_sync_price_d_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_sync_config_id` FOREIGN KEY (`sync_config_id`) REFERENCES `product_sync_config` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_sync_config`
--
ALTER TABLE `product_sync_config`
  ADD CONSTRAINT `FK_p_sync_c_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_type`
--
ALTER TABLE `product_type`
  ADD CONSTRAINT `FK_PT_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `product_type_lang`
--
ALTER TABLE `product_type_lang`
  ADD CONSTRAINT `FK_PRO_TYPE` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PTL_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `progress`
--
ALTER TABLE `progress`
  ADD CONSTRAINT `FK_progress_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_progress_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchased_product`
--
ALTER TABLE `purchased_product`
  ADD CONSTRAINT `FK_PI_old_PI_id` FOREIGN KEY (`old_purchase_invoice_id`) REFERENCES `purchase_invoice` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PI_p_id` FOREIGN KEY (`purchase_invoice_id`) REFERENCES `purchase_invoice` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PS_p_id` FOREIGN KEY (`packing_slip_id`) REFERENCES `packing_slip` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_PS_ps_id` FOREIGN KEY (`product_state_id`) REFERENCES `product_state` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_P_s_id` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchased_product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FP_PP_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase_invoice`
--
ALTER TABLE `purchase_invoice`
  ADD CONSTRAINT `FK_purchase_invoice_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchase_invoice_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchase_invoice_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchase_invoice_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchase_invoice_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchase_invoice_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_supp_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase_invoice_content`
--
ALTER TABLE `purchase_invoice_content`
  ADD CONSTRAINT `FK_pi_id` FOREIGN KEY (`purchase_invoice_id`) REFERENCES `purchase_invoice` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_purchase_invoice_content_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `routes_templates`
--
ALTER TABLE `routes_templates`
  ADD CONSTRAINT `FK_rtemp_lang` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rtemp_page` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rtemp_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rtemp_templates` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_rtemp_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shipping_method`
--
ALTER TABLE `shipping_method`
  ADD CONSTRAINT `FK_SHOP_ID_SM` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shipping_method_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `shipping_methods_by_country`
--
ALTER TABLE `shipping_methods_by_country`
  ADD CONSTRAINT `FK_SHIPPCOUNTRY` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SHIPP_ID` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shipping_method_lang`
--
ALTER TABLE `shipping_method_lang`
  ADD CONSTRAINT `FK_SHI_ID` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_method` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shipping_method_lang_lang_id` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `shop`
--
ALTER TABLE `shop`
  ADD CONSTRAINT `FK_shop_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `shopper_group`
--
ALTER TABLE `shopper_group`
  ADD CONSTRAINT `FK_SHG_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shopper_group_c_user_id` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shopper_group_d_user_id` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shopper_group_m_user_id` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `shop_shopper_groups`
--
ALTER TABLE `shop_shopper_groups`
  ADD CONSTRAINT `FK_SOP_FK_ID` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shopper_group_id_to_shop` FOREIGN KEY (`shopper_group_id`) REFERENCES `shopper_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `FK_LOCATION` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_stock_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `FK_supplier_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_supplier_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_supplier_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_supplier_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tender`
--
ALTER TABLE `tender`
  ADD CONSTRAINT `FK_t_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_deleted_by` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_external_user_data_id` FOREIGN KEY (`external_user_data_id`) REFERENCES `external_user_data` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_shop_id` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tender_content`
--
ALTER TABLE `tender_content`
  ADD CONSTRAINT `FK_OR_C_P_ID` FOREIGN KEY (`product_id`) REFERENCES `product` (`parent_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_TENDER_t_ID` FOREIGN KEY (`tender_id`) REFERENCES `tender` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ttk`
--
ALTER TABLE `ttk`
  ADD CONSTRAINT `FK_TTTTK_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_auser_date_format` FOREIGN KEY (`date_time_format`) REFERENCES `date_time_formats` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_d_user_id` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_default_user_group_id` FOREIGN KEY (`default_user_group_id`) REFERENCES `user_group` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_privilege`
--
ALTER TABLE `user_privilege`
  ADD CONSTRAINT `FK_privilege_group_id` FOREIGN KEY (`privilege_group_id`) REFERENCES `privileges_group` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `webshop_search_temp`
--
ALTER TABLE `webshop_search_temp`
  ADD CONSTRAINT `WSS_T_lang_id_FK` FOREIGN KEY (`lang_id`) REFERENCES `lang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `WSS_T_shop_id_FK` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `WSS_T_user_group_id_FK` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
