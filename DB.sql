-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 02, 2022 at 06:25 PM
-- Server version: 8.0.30-0ubuntu0.22.04.1
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Fallout2d20`
--

-- --------------------------------------------------------

--
-- Table structure for table `apparel`
--

CREATE TABLE `apparel` (
  `apparel_id` int UNSIGNED NOT NULL,
  `type` enum('Outfit','Armor','Headgear','') NOT NULL,
  `name` varchar(50) NOT NULL,
  `physical_dr` int NOT NULL DEFAULT '0',
  `energy_dr` int NOT NULL DEFAULT '0',
  `radiation_dr` int NOT NULL DEFAULT '0',
  `head` tinyint(1) NOT NULL DEFAULT '0',
  `left_arm` tinyint(1) NOT NULL DEFAULT '0',
  `torso` tinyint(1) NOT NULL DEFAULT '0',
  `right_arm` tinyint(1) NOT NULL DEFAULT '0',
  `left_leg` tinyint(1) NOT NULL DEFAULT '0',
  `right_leg` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int NOT NULL DEFAULT '1',
  `cost` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de diversas roupas e armaduras';

--
-- Dumping data for table `apparel`
--

INSERT INTO `apparel` (`apparel_id`, `type`, `name`, `physical_dr`, `energy_dr`, `radiation_dr`, `head`, `left_arm`, `torso`, `right_arm`, `left_leg`, `right_leg`, `weight`, `cost`) VALUES
(1, 'Outfit', 'Brotherhood of Steel Uniform', 0, 1, 1, 0, 1, 1, 1, 1, 1, 2, 15);

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `character_id` int UNSIGNED NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Gary' COMMENT 'Nome do Personagem',
  `origin` enum('Brotherhood Initiate','Ghoul','Mister Handy','Super Mutant','Survivor','Vault Dweller') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'No futuro, é melhor colocar isso numa tabela',
  `experience` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Experiência Atual',
  `level` int UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Level do personagem',
  `action_points` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quantidade atual de Action Points\r\n',
  `luck_points` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quantidade atual de Luck Points',
  `health_points` int NOT NULL DEFAULT '0' COMMENT 'Vida atual do personagem'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Características Básicas de Personagens';

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`character_id`, `name`, `origin`, `experience`, `level`, `action_points`, `luck_points`, `health_points`) VALUES
(1, 'Teddy', 'Brotherhood Initiate', 100, 2, 1, 4, 14);

-- --------------------------------------------------------

--
-- Table structure for table `character_apparel`
--

CREATE TABLE `character_apparel` (
  `character_id` int UNSIGNED NOT NULL,
  `apparel_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armaduras e Roupas do Personagem';

--
-- Dumping data for table `character_apparel`
--

INSERT INTO `character_apparel` (`character_id`, `apparel_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `character_perks`
--

CREATE TABLE `character_perks` (
  `character_id` int UNSIGNED NOT NULL,
  `perk_id` int UNSIGNED NOT NULL,
  `perk_rank` int UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Perks que um personagem tem';

--
-- Dumping data for table `character_perks`
--

INSERT INTO `character_perks` (`character_id`, `perk_id`, `perk_rank`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `character_weapons`
--

CREATE TABLE `character_weapons` (
  `character_id` int UNSIGNED NOT NULL,
  `weapon_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armas que o personagem possui';

--
-- Dumping data for table `character_weapons`
--

INSERT INTO `character_weapons` (`character_id`, `weapon_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `level` int UNSIGNED NOT NULL DEFAULT '1',
  `xp` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Xp necessária pra pegar esse level',
  `skill_ranks` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quantidade de skill ranks que o personagem tem nesse level',
  `hp_bonus` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quantos incrementos de vida o personagem tem nesse level',
  `perks` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quantos perks o personagem tem nesse level'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Benefícios associados a cada level';

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` (`level`, `xp`, `skill_ranks`, `hp_bonus`, `perks`) VALUES
(1, 100, 0, 0, 1),
(2, 300, 1, 1, 1),
(3, 600, 2, 1, 2),
(4, 1000, 3, 1, 2),
(5, 1500, 4, 2, 2),
(6, 2100, 5, 2, 3),
(7, 2800, 6, 2, 3),
(8, 3600, 7, 3, 3),
(9, 4500, 8, 3, 4),
(10, 5500, 9, 3, 4),
(11, 6600, 10, 4, 4),
(12, 7800, 11, 4, 5),
(13, 9100, 12, 4, 5),
(14, 10500, 13, 5, 5),
(15, 12000, 14, 5, 6),
(16, 13600, 15, 5, 6),
(17, 15300, 16, 6, 6),
(18, 17100, 17, 6, 7),
(19, 19000, 18, 6, 7),
(20, 21000, 19, 7, 7),
(21, 999999, 20, 7, 8);

-- --------------------------------------------------------

--
-- Table structure for table `perks`
--

CREATE TABLE `perks` (
  `perk_id` int UNSIGNED NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `max_rank` int UNSIGNED NOT NULL DEFAULT '1',
  `requirements` varchar(100) DEFAULT NULL COMMENT 'Por enquanto é um texto, mas o ideal é uma tabela',
  `description` varchar(1000) DEFAULT NULL COMMENT 'Por enquanto é um texto, mas o ideal é uma tabela'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Descrição dos Perks';

--
-- Dumping data for table `perks`
--

INSERT INTO `perks` (`perk_id`, `name`, `max_rank`, `requirements`, `description`) VALUES
(1, 'Science!', 3, 'Energy Weapons 2', 'You can modify energy weapons with rank 1 energy weapon mods. At rank 2 you gain access to rank 2 mods, and at rank 3 you gain access to rank 3 mods.');

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int UNSIGNED NOT NULL,
  `dbase` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `query` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_length` text COLLATE utf8mb3_bin,
  `col_collation` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `col_default` text COLLATE utf8mb3_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Central list of columns';

--
-- Dumping data for table `pma__central_columns`
--

INSERT INTO `pma__central_columns` (`db_name`, `col_name`, `col_type`, `col_length`, `col_collation`, `col_isNull`, `col_extra`, `col_default`) VALUES
('Fallout2d20', 'apparel_id', 'int', '', '', 0, 'auto_increment,UNSIGNED', ''),
('Fallout2d20', 'character_id', 'int', '', '', 0, 'auto_increment,UNSIGNED', ''),
('Fallout2d20', 'perk_id', 'INT', '', '', 0, 'auto_increment,UNSIGNED', ''),
('Fallout2d20', 'weapon_id', 'int', '', '', 0, 'auto_increment,UNSIGNED', '');

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `settings_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Settings related to Designer';

--
-- Dumping data for table `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('Gabriel', '{\"angular_direct\":\"direct\",\"snap_to_grid\":\"off\",\"relation_lines\":\"true\",\"full_screen\":\"on\",\"small_big_all\":\"v\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8mb3_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `template_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tables` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Favorite tables';

--
-- Dumping data for table `pma__favorite`
--

INSERT INTO `pma__favorite` (`username`, `tables`) VALUES
('Gabriel', '[{\"db\":\"Fallout2d20\",\"table\":\"tagged-skills\"},{\"db\":\"Fallout2d20\",\"table\":\"special_attributes\"},{\"db\":\"Fallout2d20\",\"table\":\"skills\"},{\"db\":\"Fallout2d20\",\"table\":\"levels\"},{\"db\":\"Fallout2d20\",\"table\":\"character_perks\"},{\"db\":\"Fallout2d20\",\"table\":\"characters\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Hidden items of navigation tree';

--
-- Dumping data for table `pma__navigationhiding`
--

INSERT INTO `pma__navigationhiding` (`username`, `item_name`, `item_type`, `db_name`, `table_name`) VALUES
('Gabriel', 'pma__bookmark', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__central_columns', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__column_info', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__designer_settings', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__export_templates', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__favorite', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__history', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__navigationhiding', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__pdf_pages', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__recent', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__relation', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__savedsearches', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__table_coords', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__table_info', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__table_uiprefs', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__tracking', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__userconfig', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__usergroups', 'table', 'Fallout2d20', ''),
('Gabriel', 'pma__users', 'table', 'Fallout2d20', '');

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `page_nr` int UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='PDF relation pages for phpMyAdmin';

--
-- Dumping data for table `pma__pdf_pages`
--

INSERT INTO `pma__pdf_pages` (`db_name`, `page_nr`, `page_descr`) VALUES
('Fallout2d20', 1, 'Layout Geral');

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tables` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('Gabriel', '[{\"db\":\"Fallout2d20\",\"table\":\"characters\"},{\"db\":\"Fallout2d20\",\"table\":\"levels\"},{\"db\":\"Fallout2d20\",\"table\":\"apparel\"},{\"db\":\"Fallout2d20\",\"table\":\"character_apparel\"},{\"db\":\"Fallout2d20\",\"table\":\"weapons\"},{\"db\":\"Fallout2d20\",\"table\":\"tagged-skills\"},{\"db\":\"Fallout2d20\",\"table\":\"special_attributes\"},{\"db\":\"Fallout2d20\",\"table\":\"perks\"},{\"db\":\"Fallout2d20\",\"table\":\"character_weapons\"},{\"db\":\"Fallout2d20\",\"table\":\"character_perks\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `pdf_page_number` int NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

--
-- Dumping data for table `pma__table_coords`
--

INSERT INTO `pma__table_coords` (`db_name`, `table_name`, `pdf_page_number`, `x`, `y`) VALUES
('Fallout2d20', 'apparel', 1, 1247, 248),
('Fallout2d20', 'character_apparel', 1, 854, 347),
('Fallout2d20', 'character_perks', 1, 233, 439),
('Fallout2d20', 'character_weapons', 1, 837, 199),
('Fallout2d20', 'characters', 1, 488, 350),
('Fallout2d20', 'levels', 1, 244, 218),
('Fallout2d20', 'perks', 1, 231, 556),
('Fallout2d20', 'skills', 1, 1050, 553),
('Fallout2d20', 'special_attributes', 1, 491, 102),
('Fallout2d20', 'tagged-skills', 1, 778, 557),
('Fallout2d20', 'weapons', 1, 1145, 199);

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Table information for phpMyAdmin';

--
-- Dumping data for table `pma__table_info`
--

INSERT INTO `pma__table_info` (`db_name`, `table_name`, `display_field`) VALUES
('Fallout2d20', 'characters', 'name');

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `prefs` text COLLATE utf8mb3_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('Gabriel', 'Fallout2d20', 'characters', '{\"CREATE_TIME\":\"2022-11-02 17:06:31\",\"col_order\":[0,1,2,3,4,5,6,7],\"col_visib\":[1,1,1,1,1,1,1,1]}', '2022-11-04 22:33:50');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `version` int UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8mb3_bin NOT NULL,
  `schema_sql` text COLLATE utf8mb3_bin,
  `data_sql` longtext COLLATE utf8mb3_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8mb3_bin DEFAULT NULL,
  `tracking_active` int UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('Gabriel', '2022-12-02 21:24:37', '{\"Console\\/Mode\":\"collapse\",\"NavigationWidth\":283,\"Console\\/Height\":89.002}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8mb3_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Users and their assignments to user groups';

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `character_id` int UNSIGNED NOT NULL,
  `athletics` int UNSIGNED NOT NULL DEFAULT '0',
  `barter` int UNSIGNED NOT NULL DEFAULT '0',
  `big_guns` int UNSIGNED NOT NULL DEFAULT '0',
  `energy_weapons` int UNSIGNED NOT NULL DEFAULT '0',
  `explosives` int UNSIGNED NOT NULL DEFAULT '0',
  `lockpick` int UNSIGNED NOT NULL DEFAULT '0',
  `medicine` int UNSIGNED NOT NULL DEFAULT '0',
  `melee_weapons` int UNSIGNED NOT NULL DEFAULT '0',
  `pilot` int UNSIGNED NOT NULL DEFAULT '0',
  `repair` int UNSIGNED NOT NULL DEFAULT '0',
  `science` int UNSIGNED NOT NULL DEFAULT '0',
  `small_guns` int UNSIGNED NOT NULL DEFAULT '0',
  `sneak` int UNSIGNED NOT NULL DEFAULT '0',
  `speech` int UNSIGNED NOT NULL DEFAULT '0',
  `survival` int UNSIGNED NOT NULL DEFAULT '0',
  `throwing` int UNSIGNED NOT NULL DEFAULT '0',
  `unarmed` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Nível atual de cada skill do personagem, SEM contar os tags';

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`character_id`, `athletics`, `barter`, `big_guns`, `energy_weapons`, `explosives`, `lockpick`, `medicine`, `melee_weapons`, `pilot`, `repair`, `science`, `small_guns`, `sneak`, `speech`, `survival`, `throwing`, `unarmed`) VALUES
(1, 3, 2, 1, 3, 1, 1, 3, 1, 1, 1, 3, 1, 1, 2, 3, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `special_attributes`
--

CREATE TABLE `special_attributes` (
  `character_id` int UNSIGNED NOT NULL,
  `strength` int UNSIGNED NOT NULL DEFAULT '6',
  `perception` int UNSIGNED NOT NULL DEFAULT '6',
  `endurance` int UNSIGNED NOT NULL DEFAULT '6',
  `charisma` int UNSIGNED NOT NULL DEFAULT '6',
  `intelligence` int UNSIGNED NOT NULL DEFAULT '6',
  `agility` int UNSIGNED NOT NULL DEFAULT '6',
  `luck` int UNSIGNED NOT NULL DEFAULT '6'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `special_attributes`
--

INSERT INTO `special_attributes` (`character_id`, `strength`, `perception`, `endurance`, `charisma`, `intelligence`, `agility`, `luck`) VALUES
(1, 4, 6, 6, 7, 7, 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `tagged-skills`
--

CREATE TABLE `tagged-skills` (
  `character_id` int UNSIGNED NOT NULL,
  `athletics` int UNSIGNED NOT NULL DEFAULT '0',
  `barter` int UNSIGNED NOT NULL DEFAULT '0',
  `big_guns` int UNSIGNED NOT NULL DEFAULT '0',
  `energy_weapons` int UNSIGNED NOT NULL DEFAULT '0',
  `explosives` int UNSIGNED NOT NULL DEFAULT '0',
  `lockpick` int UNSIGNED NOT NULL DEFAULT '0',
  `medicine` int UNSIGNED NOT NULL DEFAULT '0',
  `melee_weapons` int UNSIGNED NOT NULL DEFAULT '0',
  `pilot` int UNSIGNED NOT NULL DEFAULT '0',
  `repair` int UNSIGNED NOT NULL DEFAULT '0',
  `science` int UNSIGNED NOT NULL DEFAULT '0',
  `small_guns` int UNSIGNED NOT NULL DEFAULT '0',
  `sneak` int UNSIGNED NOT NULL DEFAULT '0',
  `speech` int UNSIGNED NOT NULL DEFAULT '0',
  `survival` int UNSIGNED NOT NULL DEFAULT '0',
  `throwing` int UNSIGNED NOT NULL DEFAULT '0',
  `unarmed` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Marcar quais skills o personagem tem proficiência';

--
-- Dumping data for table `tagged-skills`
--

INSERT INTO `tagged-skills` (`character_id`, `athletics`, `barter`, `big_guns`, `energy_weapons`, `explosives`, `lockpick`, `medicine`, `melee_weapons`, `pilot`, `repair`, `science`, `small_guns`, `sneak`, `speech`, `survival`, `throwing`, `unarmed`) VALUES
(1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `weapons`
--

CREATE TABLE `weapons` (
  `weapon_id` int UNSIGNED NOT NULL,
  `weapon_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `weapon_type` enum('Big Guns','Energy Weapons','Explosives','Melee Weapons','Small Guns','Throwing','Unarmed') DEFAULT NULL,
  `damage_rating` int UNSIGNED NOT NULL DEFAULT '1',
  `damage_effects` enum('Burst','Breaking','Persistent','Piercing X','Radioactive','Spread','Stun','Vicious') DEFAULT NULL,
  `damage_type` enum('Physical','Energy','Radiation','Poison') DEFAULT NULL,
  `fire_rate` int UNSIGNED NOT NULL DEFAULT '1',
  `firing_range` enum('Close','Medium','Long','Extreme') DEFAULT NULL,
  `qualities` enum('Accurate','Blast','Close Quarters','Concealed','Debilitating','Gatling','Inaccurate','Mine','Night Vision','Parry','Recon','Reliable','Suppressed','Thrown','Two-Handed','Unreliable') DEFAULT NULL,
  `weight` int UNSIGNED NOT NULL DEFAULT '0',
  `cost` int UNSIGNED NOT NULL DEFAULT '0',
  `rarity` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Características Completas das Armas';

--
-- Dumping data for table `weapons`
--

INSERT INTO `weapons` (`weapon_id`, `weapon_name`, `weapon_type`, `damage_rating`, `damage_effects`, `damage_type`, `fire_rate`, `firing_range`, `qualities`, `weight`, `cost`, `rarity`) VALUES
(1, 'Laser Gun', 'Energy Weapons', 4, 'Piercing X', 'Energy', 3, 'Close', NULL, 4, 69, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apparel`
--
ALTER TABLE `apparel`
  ADD PRIMARY KEY (`apparel_id`),
  ADD UNIQUE KEY `APPAREL_NAME` (`name`),
  ADD KEY `APPAREL_TYPE` (`type`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`character_id`),
  ADD KEY `character_level` (`level`);

--
-- Indexes for table `character_apparel`
--
ALTER TABLE `character_apparel`
  ADD PRIMARY KEY (`character_id`),
  ADD KEY `apparel_id` (`apparel_id`);

--
-- Indexes for table `character_perks`
--
ALTER TABLE `character_perks`
  ADD PRIMARY KEY (`character_id`),
  ADD UNIQUE KEY `character_perk` (`character_id`,`perk_id`) USING BTREE,
  ADD KEY `perk_id` (`perk_id`);

--
-- Indexes for table `character_weapons`
--
ALTER TABLE `character_weapons`
  ADD PRIMARY KEY (`character_id`),
  ADD KEY `weapon_id` (`weapon_id`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`level`);

--
-- Indexes for table `perks`
--
ALTER TABLE `perks`
  ADD PRIMARY KEY (`perk_id`),
  ADD UNIQUE KEY `Name` (`name`);

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `special_attributes`
--
ALTER TABLE `special_attributes`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `tagged-skills`
--
ALTER TABLE `tagged-skills`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `weapons`
--
ALTER TABLE `weapons`
  ADD PRIMARY KEY (`weapon_id`),
  ADD KEY `WEAPON_TYPE` (`weapon_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apparel`
--
ALTER TABLE `apparel`
  MODIFY `apparel_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `character_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `character_apparel`
--
ALTER TABLE `character_apparel`
  MODIFY `character_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `character_perks`
--
ALTER TABLE `character_perks`
  MODIFY `character_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `character_weapons`
--
ALTER TABLE `character_weapons`
  MODIFY `character_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `perks`
--
ALTER TABLE `perks`
  MODIFY `perk_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `character_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tagged-skills`
--
ALTER TABLE `tagged-skills`
  MODIFY `character_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `weapons`
--
ALTER TABLE `weapons`
  MODIFY `weapon_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `characters`
--
ALTER TABLE `characters`
  ADD CONSTRAINT `character_level` FOREIGN KEY (`level`) REFERENCES `levels` (`level`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `character_apparel`
--
ALTER TABLE `character_apparel`
  ADD CONSTRAINT `character_apparel_ibfk_1` FOREIGN KEY (`apparel_id`) REFERENCES `apparel` (`apparel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `character_apparel_ibfk_2` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `character_perks`
--
ALTER TABLE `character_perks`
  ADD CONSTRAINT `character_perks_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `character_perks_ibfk_2` FOREIGN KEY (`perk_id`) REFERENCES `perks` (`perk_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `character_weapons`
--
ALTER TABLE `character_weapons`
  ADD CONSTRAINT `character_weapons_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `character_weapons_ibfk_2` FOREIGN KEY (`weapon_id`) REFERENCES `weapons` (`weapon_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `character_skills` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `special_attributes`
--
ALTER TABLE `special_attributes`
  ADD CONSTRAINT `special_attributes_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tagged-skills`
--
ALTER TABLE `tagged-skills`
  ADD CONSTRAINT `tagged-skills_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
