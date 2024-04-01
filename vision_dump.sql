-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : jeu. 07 sep. 2023 à 22:07
-- Version du serveur : 8.0.33
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb3 */;

--
-- Base de données : `visionrp_v1`
--

-- --------------------------------------------------------

--
-- Structure de la table `ban`
--

CREATE TABLE `ban` (
  `id` int NOT NULL,
  `ids` text,
  `raison` varchar(255) DEFAULT NULL,
  `by` varchar(255) DEFAULT NULL,
  `expiration` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `bank`
--

CREATE TABLE `bank` (
  `id` int NOT NULL,
  `player` int DEFAULT NULL,
  `society` int DEFAULT NULL,
  `account_number` varchar(50) NOT NULL,
  `balance` int NOT NULL DEFAULT '0',
  `common` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `bank_transaction`
--

CREATE TABLE `bank_transaction` (
  `id` int NOT NULL,
  `sender` int DEFAULT NULL,
  `receiver` int DEFAULT NULL,
  `date` int NOT NULL,
  `amount` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `basketball_rpg`
--

CREATE TABLE `basketball_rpg` (
  `id` int NOT NULL,
  `identifier` varchar(64) NOT NULL,
  `score` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `camera_recordings`
--

CREATE TABLE `camera_recordings` (
  `id` varchar(8) NOT NULL,
  `groupId` int NOT NULL,
  `stored` varchar(64) NOT NULL,
  `recordedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `casier`
--

CREATE TABLE `casier` (
  `id` int NOT NULL,
  `num` int NOT NULL,
  `job` varchar(55) NOT NULL,
  `inventory` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `command_tablet`
--

CREATE TABLE `command_tablet` (
  `id` int NOT NULL,
  `order` text NOT NULL,
  `time` varchar(5) NOT NULL,
  `date` varchar(30) NOT NULL,
  `total` int NOT NULL,
  `typeObject` varchar(64) NOT NULL,
  `done` tinyint(1) NOT NULL,
  `crewName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `crew`
--

CREATE TABLE `crew` (
  `id` int NOT NULL,
  `name` varchar(55) NOT NULL,
  `tag` varchar(4) NOT NULL,
  `owner` int NOT NULL,
  `rank` int DEFAULT NULL,
  `perm` text NOT NULL,
  `color` varchar(10) NOT NULL DEFAULT '#FFFFFF',
  `devise` varchar(255) NOT NULL DEFAULT 'empty',
  `exp` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `crew_members`
--

CREATE TABLE `crew_members` (
  `id` int NOT NULL,
  `crew_id` int NOT NULL,
  `player_id` int NOT NULL,
  `rank_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `perm` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `crew_rank`
--

CREATE TABLE `crew_rank` (
  `id` int NOT NULL,
  `crew_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `rank` int NOT NULL,
  `perm` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `election`
--

CREATE TABLE `election` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `party` varchar(255) NOT NULL,
  `votes` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `golfhits`
--

CREATE TABLE `golfhits` (
  `identifier` varchar(60) NOT NULL,
  `name` text NOT NULL,
  `distance` float NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `weight` int NOT NULL,
  `rare` int NOT NULL,
  `can_remove` tinyint(1) NOT NULL,
  `cols` tinyint(1) NOT NULL,
  `rows` tinyint(1) NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT 'items'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `license`
--

CREATE TABLE `license` (
  `id` int NOT NULL,
  `id_player` int DEFAULT NULL,
  `license_type` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `license_type`
--

CREATE TABLE `license_type` (
  `id` int NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `owned_themepark`
--

CREATE TABLE `owned_themepark` (
  `id` int NOT NULL,
  `identifier` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `balance` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Structure de la table `papiers`
--

CREATE TABLE `papiers` (
  `id` int NOT NULL,
  `type` varchar(24) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `phone_backups`
--

CREATE TABLE `phone_backups` (
  `identifier` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_clock_alarms`
--

CREATE TABLE `phone_clock_alarms` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `hours` int NOT NULL DEFAULT '0',
  `minutes` int NOT NULL DEFAULT '0',
  `label` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_crypto`
--

CREATE TABLE `phone_crypto` (
  `identifier` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `coin` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `invested` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_accounts`
--

CREATE TABLE `phone_darkchat_accounts` (
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_channels`
--

CREATE TABLE `phone_darkchat_channels` (
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_message` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_members`
--

CREATE TABLE `phone_darkchat_members` (
  `channel_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_messages`
--

CREATE TABLE `phone_darkchat_messages` (
  `id` int NOT NULL,
  `channel` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_accounts`
--

CREATE TABLE `phone_instagram_accounts` (
  `display_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `profile_image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `bio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `verified` tinyint(1) DEFAULT '0',
  `date_joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_comments`
--

CREATE TABLE `phone_instagram_comments` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `post_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `like_count` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_follows`
--

CREATE TABLE `phone_instagram_follows` (
  `followed` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `follower` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_likes`
--

CREATE TABLE `phone_instagram_likes` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_comment` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_loggedin`
--

CREATE TABLE `phone_instagram_loggedin` (
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_messages`
--

CREATE TABLE `phone_instagram_messages` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `recipient` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_notifications`
--

CREATE TABLE `phone_instagram_notifications` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `from` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `post_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_posts`
--

CREATE TABLE `phone_instagram_posts` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `media` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `caption` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `location` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `like_count` int NOT NULL DEFAULT '0',
  `comment_count` int NOT NULL DEFAULT '0',
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_stories`
--

CREATE TABLE `phone_instagram_stories` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_stories_views`
--

CREATE TABLE `phone_instagram_stories_views` (
  `story_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `viewer` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_last_phone`
--

CREATE TABLE `phone_last_phone` (
  `identifier` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_logged_in_accounts`
--

CREATE TABLE `phone_logged_in_accounts` (
  `phone_number` varchar(15) COLLATE utf8mb3_unicode_ci NOT NULL,
  `app` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_mail_accounts`
--

CREATE TABLE `phone_mail_accounts` (
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_mail_loggedin`
--

CREATE TABLE `phone_mail_loggedin` (
  `address` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_mail_messages`
--

CREATE TABLE `phone_mail_messages` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `recipient` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `subject` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `attachments` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `actions` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_maps_locations`
--

CREATE TABLE `phone_maps_locations` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `x_pos` float NOT NULL,
  `y_pos` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_marketplace_posts`
--

CREATE TABLE `phone_marketplace_posts` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `price` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_channels`
--

CREATE TABLE `phone_message_channels` (
  `channel_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_group` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_message` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `last_message_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_members`
--

CREATE TABLE `phone_message_members` (
  `channel_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_owner` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_messages`
--

CREATE TABLE `phone_message_messages` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `channel_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_unread`
--

CREATE TABLE `phone_message_unread` (
  `channel_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `unread` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_music_playlists`
--

CREATE TABLE `phone_music_playlists` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cover` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_music_saved_playlists`
--

CREATE TABLE `phone_music_saved_playlists` (
  `playlist_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_music_songs`
--

CREATE TABLE `phone_music_songs` (
  `song_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `playlist_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_notes`
--

CREATE TABLE `phone_notes` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_notifications`
--

CREATE TABLE `phone_notifications` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `app` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `avatar` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `show_avatar` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phones`
--

CREATE TABLE `phone_phones` (
  `id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pin` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `face_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `settings` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `is_setup` tinyint(1) DEFAULT '0',
  `assigned` tinyint(1) DEFAULT '0',
  `battery` int NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_blocked_numbers`
--

CREATE TABLE `phone_phone_blocked_numbers` (
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `blocked_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_calls`
--

CREATE TABLE `phone_phone_calls` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `caller` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `callee` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `duration` int NOT NULL DEFAULT '0',
  `answered` tinyint(1) DEFAULT '0',
  `hide_caller_id` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_contacts`
--

CREATE TABLE `phone_phone_contacts` (
  `contact_phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `firstname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `lastname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `profile_image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT '0',
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_photos`
--

CREATE TABLE `phone_photos` (
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `link` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_video` tinyint(1) DEFAULT '0',
  `size` float NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_services_channels`
--

CREATE TABLE `phone_services_channels` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `company` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_message` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_services_messages`
--

CREATE TABLE `phone_services_messages` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `channel_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `message` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `x_pos` int DEFAULT NULL,
  `y_pos` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_accounts`
--

CREATE TABLE `phone_tiktok_accounts` (
  `name` varchar(30) COLLATE utf8mb3_unicode_ci NOT NULL,
  `bio` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `avatar` varchar(200) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `verified` tinyint(1) DEFAULT '0',
  `follower_count` int NOT NULL DEFAULT '0',
  `following_count` int NOT NULL DEFAULT '0',
  `like_count` int NOT NULL DEFAULT '0',
  `video_count` int NOT NULL DEFAULT '0',
  `twitter` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `instagram` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `show_likes` tinyint(1) DEFAULT '1',
  `phone_number` varchar(15) COLLATE utf8mb3_unicode_ci NOT NULL,
  `date_joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_channels`
--

CREATE TABLE `phone_tiktok_channels` (
  `id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_message` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `member_1` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `member_2` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_comments`
--

CREATE TABLE `phone_tiktok_comments` (
  `id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `reply_to` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `video_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` varchar(550) COLLATE utf8mb3_unicode_ci NOT NULL,
  `likes` int NOT NULL DEFAULT '0',
  `replies` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_comments_likes`
--

CREATE TABLE `phone_tiktok_comments_likes` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_follows`
--

CREATE TABLE `phone_tiktok_follows` (
  `followed` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `follower` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_likes`
--

CREATE TABLE `phone_tiktok_likes` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `video_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_loggedin`
--

CREATE TABLE `phone_tiktok_loggedin` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_messages`
--

CREATE TABLE `phone_tiktok_messages` (
  `id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `channel_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(500) COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_notifications`
--

CREATE TABLE `phone_tiktok_notifications` (
  `id` int NOT NULL,
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `from` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `video_id` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `comment_id` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_pinned_videos`
--

CREATE TABLE `phone_tiktok_pinned_videos` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `video_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_saves`
--

CREATE TABLE `phone_tiktok_saves` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `video_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_unread_messages`
--

CREATE TABLE `phone_tiktok_unread_messages` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `channel_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_videos`
--

CREATE TABLE `phone_tiktok_videos` (
  `id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `src` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
  `caption` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `metadata` longtext COLLATE utf8mb3_unicode_ci,
  `music` text COLLATE utf8mb3_unicode_ci,
  `likes` int NOT NULL DEFAULT '0',
  `comments` int NOT NULL DEFAULT '0',
  `views` int NOT NULL DEFAULT '0',
  `saves` int NOT NULL DEFAULT '0',
  `pinned_comment` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_views`
--

CREATE TABLE `phone_tiktok_views` (
  `username` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `video_id` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_accounts`
--

CREATE TABLE `phone_tinder_accounts` (
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `photos` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `bio` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `dob` date NOT NULL,
  `is_male` tinyint(1) NOT NULL,
  `interested_men` tinyint(1) NOT NULL,
  `interested_women` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_matches`
--

CREATE TABLE `phone_tinder_matches` (
  `phone_number_1` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number_2` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `latest_message` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `latest_message_timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_messages`
--

CREATE TABLE `phone_tinder_messages` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `recipient` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_swipes`
--

CREATE TABLE `phone_tinder_swipes` (
  `swiper` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `swipee` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `liked` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_accounts`
--

CREATE TABLE `phone_twitter_accounts` (
  `display_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `bio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `profile_image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `profile_header` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pinned_tweet` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '0',
  `follower_count` int NOT NULL DEFAULT '0',
  `following_count` int NOT NULL DEFAULT '0',
  `date_joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_follows`
--

CREATE TABLE `phone_twitter_follows` (
  `followed` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `follower` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notifications` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_hashtags`
--

CREATE TABLE `phone_twitter_hashtags` (
  `hashtag` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` int NOT NULL DEFAULT '0',
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_likes`
--

CREATE TABLE `phone_twitter_likes` (
  `tweet_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_loggedin`
--

CREATE TABLE `phone_twitter_loggedin` (
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_messages`
--

CREATE TABLE `phone_twitter_messages` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sender` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `recipient` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_notifications`
--

CREATE TABLE `phone_twitter_notifications` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `from` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `tweet_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_promoted`
--

CREATE TABLE `phone_twitter_promoted` (
  `tweet_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `promotions` int NOT NULL DEFAULT '0',
  `views` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_retweets`
--

CREATE TABLE `phone_twitter_retweets` (
  `tweet_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_tweets`
--

CREATE TABLE `phone_twitter_tweets` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` varchar(280) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `reply_to` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `like_count` int DEFAULT '0',
  `reply_count` int DEFAULT '0',
  `retweet_count` int DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_wallet_transactions`
--

CREATE TABLE `phone_wallet_transactions` (
  `id` int NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` int NOT NULL,
  `company` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `logo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_yellow_pages_posts`
--

CREATE TABLE `phone_yellow_pages_posts` (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `attachment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `players`
--

CREATE TABLE `players` (
  `id` int NOT NULL,
  `skin` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `tattoos` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `license` varchar(50) NOT NULL,
  `banque` float NOT NULL DEFAULT '0',
  `pos` varchar(255) DEFAULT NULL,
  `permission` int NOT NULL DEFAULT '0',
  `job` varchar(50) NOT NULL DEFAULT '',
  `job_grade` int NOT NULL DEFAULT '0',
  `crew` varchar(50) DEFAULT NULL,
  `weapons` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `status` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `vip` int DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `last_property` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `demarche` varchar(50) DEFAULT NULL,
  `degrader` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `hasvoted` int NOT NULL DEFAULT '0',
  `coupe2` varchar(50) DEFAULT NULL,
  `active` float NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `age` varchar(11) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `size` int DEFAULT NULL,
  `inventaire` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `cloths` text NOT NULL,
  `birthplaces` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `players_unique`
--

CREATE TABLE `players_unique` (
  `license` varchar(255) DEFAULT NULL,
  `permission` int DEFAULT NULL,
  `balance` int DEFAULT NULL,
  `subscription` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `postop_commands`
--

CREATE TABLE `postop_commands` (
  `id` int NOT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `society` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `items` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `postop_storages`
--

CREATE TABLE `postop_storages` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `items` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `property`
--

CREATE TABLE `property` (
  `id` int NOT NULL,
  `name` text NOT NULL,
  `enter_pos` varchar(255) NOT NULL,
  `data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `inventory` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `garage` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `owner` int DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `co_owner` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `rentedat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `rentalEnd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `crew` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `weight` int NOT NULL DEFAULT '0',
  `decoration` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `property_inventory`
--

CREATE TABLE `property_inventory` (
  `id` int NOT NULL,
  `id_property` int NOT NULL,
  `item` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `count` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `radiocar_music`
--

CREATE TABLE `radiocar_music` (
  `id` int NOT NULL,
  `label` varchar(64) NOT NULL,
  `url` varchar(256) NOT NULL,
  `plate` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `radiocar_owned`
--

CREATE TABLE `radiocar_owned` (
  `id` int NOT NULL,
  `spz` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `radiocar_playlist`
--

CREATE TABLE `radiocar_playlist` (
  `id` int NOT NULL,
  `playlist` text NOT NULL,
  `plate` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `rcore_tattoos`
--

CREATE TABLE `rcore_tattoos` (
  `identifier` varchar(100) NOT NULL,
  `tattoos` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `society`
--

CREATE TABLE `society` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `inventory` text NOT NULL,
  `color` varchar(10) NOT NULL DEFAULT '#00FF00',
  `perm` varchar(255) NOT NULL DEFAULT '{"recrute":1,"exclure":1, "editPerm":1,"editMembres":1,"sendDm":1 }',
  `devise` varchar(255) NOT NULL DEFAULT 'empty devise'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `society_inventory`
--

CREATE TABLE `society_inventory` (
  `id` int NOT NULL,
  `id_society` int NOT NULL,
  `item` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `count` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `sprays`
--

CREATE TABLE `sprays` (
  `id` int NOT NULL,
  `identifier` varchar(64) DEFAULT NULL,
  `x` float(8,4) NOT NULL,
  `y` float(8,4) NOT NULL,
  `z` float(8,4) NOT NULL,
  `origX` float(8,4) NOT NULL,
  `origY` float(8,4) NOT NULL,
  `origZ` float(8,4) NOT NULL,
  `rx` float(8,4) NOT NULL,
  `ry` float(8,4) NOT NULL,
  `rz` float(8,4) NOT NULL,
  `scale` float(8,4) NOT NULL,
  `text` varchar(32) DEFAULT NULL,
  `image` varchar(64) DEFAULT NULL,
  `imageDict` varchar(64) DEFAULT NULL,
  `font` varchar(32) DEFAULT NULL,
  `color` varchar(32) DEFAULT NULL,
  `interior` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `tablet`
--

CREATE TABLE `tablet` (
  `id` int NOT NULL,
  `id_crew` int DEFAULT NULL,
  `tablet_type` int DEFAULT NULL,
  `cooldown` int NOT NULL,
  `outofstockdate` date NOT NULL,
  `orderNumber` int NOT NULL,
  `stock` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `tablet_armes`
--

CREATE TABLE `tablet_armes` (
  `id` int NOT NULL,
  `crew_name` varchar(255) NOT NULL,
  `weapon_name` varchar(255) NOT NULL,
  `quantity` int NOT NULL,
  `cooldown` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `tablet_type`
--

CREATE TABLE `tablet_type` (
  `id` int NOT NULL,
  `name` varchar(55) NOT NULL,
  `typeObject` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `user_inventory`
--

CREATE TABLE `user_inventory` (
  `id` int NOT NULL,
  `id_player` int NOT NULL,
  `item` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `count` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `plate` varchar(50) NOT NULL,
  `currentPlate` varchar(50) DEFAULT NULL,
  `owner` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `props` text NOT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `stored` int NOT NULL DEFAULT '1',
  `vente` varchar(50) DEFAULT NULL,
  `coowner` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `job` varchar(50) DEFAULT NULL,
  `inventory` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_inventory`
--

CREATE TABLE `vehicle_inventory` (
  `id` int NOT NULL,
  `id_plate` varchar(50) NOT NULL,
  `item` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `count` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `xsoundboard`
--

CREATE TABLE `xsoundboard` (
  `id` int NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `identifier` varchar(64) DEFAULT NULL,
  `steamid` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `zoneDrugs`
--

CREATE TABLE `zoneDrugs` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_society_id` (`society`),
  ADD KEY `player_bank_id` (`player`);

--
-- Index pour la table `bank_transaction`
--
ALTER TABLE `bank_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_trans_receiver_id` (`receiver`),
  ADD KEY `bank_trans_sender_id` (`sender`);

--
-- Index pour la table `basketball_rpg`
--
ALTER TABLE `basketball_rpg`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `camera_recordings`
--
ALTER TABLE `camera_recordings`
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `casier`
--
ALTER TABLE `casier`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `command_tablet`
--
ALTER TABLE `command_tablet`
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `crew`
--
ALTER TABLE `crew`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_id` (`owner`);

--
-- Index pour la table `crew_members`
--
ALTER TABLE `crew_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_crew_members_crew` (`crew_id`),
  ADD KEY `FK_crew_members_players` (`player_id`),
  ADD KEY `FK_crew_members_crew_rank` (`rank_id`);

--
-- Index pour la table `crew_rank`
--
ALTER TABLE `crew_rank`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_crew` (`crew_id`);

--
-- Index pour la table `election`
--
ALTER TABLE `election`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `golfhits`
--
ALTER TABLE `golfhits`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `license`
--
ALTER TABLE `license`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_license_id` (`id_player`),
  ADD KEY `license_id` (`license_type`);

--
-- Index pour la table `license_type`
--
ALTER TABLE `license_type`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_themepark`
--
ALTER TABLE `owned_themepark`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`(191));

--
-- Index pour la table `papiers`
--
ALTER TABLE `papiers`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_backups`
--
ALTER TABLE `phone_backups`
  ADD PRIMARY KEY (`identifier`),
  ADD KEY `phone_backups_ibfk_1` (`phone_number`);

--
-- Index pour la table `phone_clock_alarms`
--
ALTER TABLE `phone_clock_alarms`
  ADD PRIMARY KEY (`id`,`phone_number`),
  ADD KEY `phone_clock_alarms_ibfk_1` (`phone_number`);

--
-- Index pour la table `phone_crypto`
--
ALTER TABLE `phone_crypto`
  ADD PRIMARY KEY (`identifier`,`coin`);

--
-- Index pour la table `phone_darkchat_accounts`
--
ALTER TABLE `phone_darkchat_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `phone_darkchat_accounts_ibfk_1` (`phone_number`);

--
-- Index pour la table `phone_darkchat_channels`
--
ALTER TABLE `phone_darkchat_channels`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `phone_darkchat_members`
--
ALTER TABLE `phone_darkchat_members`
  ADD PRIMARY KEY (`channel_name`,`username`);

--
-- Index pour la table `phone_darkchat_messages`
--
ALTER TABLE `phone_darkchat_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_instagram_accounts`
--
ALTER TABLE `phone_instagram_accounts`
  ADD PRIMARY KEY (`username`);

--
-- Index pour la table `phone_instagram_comments`
--
ALTER TABLE `phone_instagram_comments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_instagram_follows`
--
ALTER TABLE `phone_instagram_follows`
  ADD PRIMARY KEY (`followed`,`follower`);

--
-- Index pour la table `phone_instagram_likes`
--
ALTER TABLE `phone_instagram_likes`
  ADD PRIMARY KEY (`id`,`username`);

--
-- Index pour la table `phone_instagram_loggedin`
--
ALTER TABLE `phone_instagram_loggedin`
  ADD PRIMARY KEY (`phone_number`);

--
-- Index pour la table `phone_instagram_messages`
--
ALTER TABLE `phone_instagram_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_instagram_notifications`
--
ALTER TABLE `phone_instagram_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_instagram_posts`
--
ALTER TABLE `phone_instagram_posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_instagram_stories`
--
ALTER TABLE `phone_instagram_stories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_instagram_stories_views`
--
ALTER TABLE `phone_instagram_stories_views`
  ADD PRIMARY KEY (`story_id`,`viewer`);

--
-- Index pour la table `phone_last_phone`
--
ALTER TABLE `phone_last_phone`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `phone_logged_in_accounts`
--
ALTER TABLE `phone_logged_in_accounts`
  ADD PRIMARY KEY (`phone_number`,`app`,`username`);

--
-- Index pour la table `phone_mail_accounts`
--
ALTER TABLE `phone_mail_accounts`
  ADD PRIMARY KEY (`address`);

--
-- Index pour la table `phone_mail_loggedin`
--
ALTER TABLE `phone_mail_loggedin`
  ADD PRIMARY KEY (`phone_number`),
  ADD KEY `address` (`address`);

--
-- Index pour la table `phone_mail_messages`
--
ALTER TABLE `phone_mail_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_maps_locations`
--
ALTER TABLE `phone_maps_locations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_marketplace_posts`
--
ALTER TABLE `phone_marketplace_posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_message_channels`
--
ALTER TABLE `phone_message_channels`
  ADD PRIMARY KEY (`channel_id`);

--
-- Index pour la table `phone_message_members`
--
ALTER TABLE `phone_message_members`
  ADD PRIMARY KEY (`channel_id`,`phone_number`);

--
-- Index pour la table `phone_message_messages`
--
ALTER TABLE `phone_message_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_message_unread`
--
ALTER TABLE `phone_message_unread`
  ADD PRIMARY KEY (`channel_id`,`phone_number`);

--
-- Index pour la table `phone_music_playlists`
--
ALTER TABLE `phone_music_playlists`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_music_saved_playlists`
--
ALTER TABLE `phone_music_saved_playlists`
  ADD PRIMARY KEY (`playlist_id`,`phone_number`);

--
-- Index pour la table `phone_music_songs`
--
ALTER TABLE `phone_music_songs`
  ADD PRIMARY KEY (`song_id`,`playlist_id`),
  ADD KEY `playlist_id` (`playlist_id`);

--
-- Index pour la table `phone_notes`
--
ALTER TABLE `phone_notes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_notifications`
--
ALTER TABLE `phone_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_phones`
--
ALTER TABLE `phone_phones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `phone_number_2` (`phone_number`),
  ADD UNIQUE KEY `phone_number_3` (`phone_number`);

--
-- Index pour la table `phone_phone_blocked_numbers`
--
ALTER TABLE `phone_phone_blocked_numbers`
  ADD PRIMARY KEY (`phone_number`,`blocked_number`);

--
-- Index pour la table `phone_phone_calls`
--
ALTER TABLE `phone_phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_phone_contacts`
--
ALTER TABLE `phone_phone_contacts`
  ADD PRIMARY KEY (`contact_phone_number`,`phone_number`);

--
-- Index pour la table `phone_photos`
--
ALTER TABLE `phone_photos`
  ADD PRIMARY KEY (`phone_number`,`link`);

--
-- Index pour la table `phone_services_channels`
--
ALTER TABLE `phone_services_channels`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_services_messages`
--
ALTER TABLE `phone_services_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_id` (`channel_id`);

--
-- Index pour la table `phone_tiktok_accounts`
--
ALTER TABLE `phone_tiktok_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_tiktok_channels`
--
ALTER TABLE `phone_tiktok_channels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_1` (`member_1`,`member_2`),
  ADD KEY `member_2` (`member_2`);

--
-- Index pour la table `phone_tiktok_comments`
--
ALTER TABLE `phone_tiktok_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `video_id` (`video_id`),
  ADD KEY `username` (`username`),
  ADD KEY `reply_to` (`reply_to`);

--
-- Index pour la table `phone_tiktok_comments_likes`
--
ALTER TABLE `phone_tiktok_comments_likes`
  ADD PRIMARY KEY (`username`,`comment_id`),
  ADD KEY `comment_id` (`comment_id`);

--
-- Index pour la table `phone_tiktok_follows`
--
ALTER TABLE `phone_tiktok_follows`
  ADD PRIMARY KEY (`followed`,`follower`),
  ADD KEY `follower` (`follower`);

--
-- Index pour la table `phone_tiktok_likes`
--
ALTER TABLE `phone_tiktok_likes`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tiktok_loggedin`
--
ALTER TABLE `phone_tiktok_loggedin`
  ADD PRIMARY KEY (`phone_number`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_tiktok_messages`
--
ALTER TABLE `phone_tiktok_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_id` (`channel_id`),
  ADD KEY `sender` (`sender`);

--
-- Index pour la table `phone_tiktok_notifications`
--
ALTER TABLE `phone_tiktok_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `from` (`from`),
  ADD KEY `video_id` (`video_id`),
  ADD KEY `comment_id` (`comment_id`);

--
-- Index pour la table `phone_tiktok_pinned_videos`
--
ALTER TABLE `phone_tiktok_pinned_videos`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tiktok_saves`
--
ALTER TABLE `phone_tiktok_saves`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tiktok_unread_messages`
--
ALTER TABLE `phone_tiktok_unread_messages`
  ADD PRIMARY KEY (`username`,`channel_id`),
  ADD KEY `channel_id` (`channel_id`);

--
-- Index pour la table `phone_tiktok_videos`
--
ALTER TABLE `phone_tiktok_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_tiktok_views`
--
ALTER TABLE `phone_tiktok_views`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tinder_accounts`
--
ALTER TABLE `phone_tinder_accounts`
  ADD PRIMARY KEY (`phone_number`);

--
-- Index pour la table `phone_tinder_matches`
--
ALTER TABLE `phone_tinder_matches`
  ADD PRIMARY KEY (`phone_number_1`,`phone_number_2`);

--
-- Index pour la table `phone_tinder_messages`
--
ALTER TABLE `phone_tinder_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_tinder_swipes`
--
ALTER TABLE `phone_tinder_swipes`
  ADD PRIMARY KEY (`swiper`,`swipee`);

--
-- Index pour la table `phone_twitter_accounts`
--
ALTER TABLE `phone_twitter_accounts`
  ADD PRIMARY KEY (`username`);

--
-- Index pour la table `phone_twitter_follows`
--
ALTER TABLE `phone_twitter_follows`
  ADD PRIMARY KEY (`followed`,`follower`);

--
-- Index pour la table `phone_twitter_hashtags`
--
ALTER TABLE `phone_twitter_hashtags`
  ADD PRIMARY KEY (`hashtag`);

--
-- Index pour la table `phone_twitter_likes`
--
ALTER TABLE `phone_twitter_likes`
  ADD PRIMARY KEY (`tweet_id`,`username`);

--
-- Index pour la table `phone_twitter_loggedin`
--
ALTER TABLE `phone_twitter_loggedin`
  ADD PRIMARY KEY (`phone_number`);

--
-- Index pour la table `phone_twitter_messages`
--
ALTER TABLE `phone_twitter_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_twitter_notifications`
--
ALTER TABLE `phone_twitter_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_twitter_promoted`
--
ALTER TABLE `phone_twitter_promoted`
  ADD PRIMARY KEY (`tweet_id`);

--
-- Index pour la table `phone_twitter_retweets`
--
ALTER TABLE `phone_twitter_retweets`
  ADD PRIMARY KEY (`tweet_id`,`username`);

--
-- Index pour la table `phone_twitter_tweets`
--
ALTER TABLE `phone_twitter_tweets`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_wallet_transactions`
--
ALTER TABLE `phone_wallet_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_yellow_pages_posts`
--
ALTER TABLE `phone_yellow_pages_posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `postop_commands`
--
ALTER TABLE `postop_commands`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `postop_storages`
--
ALTER TABLE `postop_storages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_property_id` (`owner`);

--
-- Index pour la table `property_inventory`
--
ALTER TABLE `property_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`id_property`);

--
-- Index pour la table `radiocar_music`
--
ALTER TABLE `radiocar_music`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `radiocar_owned`
--
ALTER TABLE `radiocar_owned`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `radiocar_playlist`
--
ALTER TABLE `radiocar_playlist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rcore_tattoos`
--
ALTER TABLE `rcore_tattoos`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `society`
--
ALTER TABLE `society`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `society_inventory`
--
ALTER TABLE `society_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `society_id` (`id_society`);

--
-- Index pour la table `sprays`
--
ALTER TABLE `sprays`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `tablet`
--
ALTER TABLE `tablet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `crew_id` (`id_crew`),
  ADD KEY `tablet_id` (`tablet_type`);

--
-- Index pour la table `tablet_armes`
--
ALTER TABLE `tablet_armes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `tablet_type`
--
ALTER TABLE `tablet_type`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_inventory_id` (`id_player`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`plate`),
  ADD KEY `player_id` (`owner`);

--
-- Index pour la table `vehicle_inventory`
--
ALTER TABLE `vehicle_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehicle_plate` (`id_plate`);

--
-- Index pour la table `xsoundboard`
--
ALTER TABLE `xsoundboard`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `zoneDrugs`
--
ALTER TABLE `zoneDrugs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ban`
--
ALTER TABLE `ban`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bank_transaction`
--
ALTER TABLE `bank_transaction`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `basketball_rpg`
--
ALTER TABLE `basketball_rpg`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `casier`
--
ALTER TABLE `casier`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `command_tablet`
--
ALTER TABLE `command_tablet`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crew`
--
ALTER TABLE `crew`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crew_members`
--
ALTER TABLE `crew_members`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `crew_rank`
--
ALTER TABLE `crew_rank`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `election`
--
ALTER TABLE `election`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `license`
--
ALTER TABLE `license`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `license_type`
--
ALTER TABLE `license_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `owned_themepark`
--
ALTER TABLE `owned_themepark`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `papiers`
--
ALTER TABLE `papiers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_darkchat_messages`
--
ALTER TABLE `phone_darkchat_messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_tiktok_notifications`
--
ALTER TABLE `phone_tiktok_notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_wallet_transactions`
--
ALTER TABLE `phone_wallet_transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `players`
--
ALTER TABLE `players`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `postop_commands`
--
ALTER TABLE `postop_commands`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `postop_storages`
--
ALTER TABLE `postop_storages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `property`
--
ALTER TABLE `property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `property_inventory`
--
ALTER TABLE `property_inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `radiocar_music`
--
ALTER TABLE `radiocar_music`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `radiocar_owned`
--
ALTER TABLE `radiocar_owned`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `radiocar_playlist`
--
ALTER TABLE `radiocar_playlist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `society`
--
ALTER TABLE `society`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `society_inventory`
--
ALTER TABLE `society_inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `sprays`
--
ALTER TABLE `sprays`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tablet`
--
ALTER TABLE `tablet`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tablet_armes`
--
ALTER TABLE `tablet_armes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tablet_type`
--
ALTER TABLE `tablet_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicle_inventory`
--
ALTER TABLE `vehicle_inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `xsoundboard`
--
ALTER TABLE `xsoundboard`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `zoneDrugs`
--
ALTER TABLE `zoneDrugs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `bank`
--
ALTER TABLE `bank`
  ADD CONSTRAINT `bank_society_id` FOREIGN KEY (`society`) REFERENCES `society` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_bank_id` FOREIGN KEY (`player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `bank_transaction`
--
ALTER TABLE `bank_transaction`
  ADD CONSTRAINT `bank_trans_receiver_id` FOREIGN KEY (`receiver`) REFERENCES `bank` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `bank_trans_sender_id` FOREIGN KEY (`sender`) REFERENCES `bank` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `owner_id` FOREIGN KEY (`owner`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `crew_members`
--
ALTER TABLE `crew_members`
  ADD CONSTRAINT `FK_crew_members_crew` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_crew_members_crew_rank` FOREIGN KEY (`rank_id`) REFERENCES `crew_rank` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_crew_members_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `crew_rank`
--
ALTER TABLE `crew_rank`
  ADD CONSTRAINT `fk_crew` FOREIGN KEY (`crew_id`) REFERENCES `crew` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Contraintes pour la table `license`
--
ALTER TABLE `license`
  ADD CONSTRAINT `license_id` FOREIGN KEY (`license_type`) REFERENCES `license` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_license_id` FOREIGN KEY (`id_player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_backups`
--
ALTER TABLE `phone_backups`
  ADD CONSTRAINT `phone_backups_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_clock_alarms`
--
ALTER TABLE `phone_clock_alarms`
  ADD CONSTRAINT `phone_clock_alarms_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_darkchat_accounts`
--
ALTER TABLE `phone_darkchat_accounts`
  ADD CONSTRAINT `phone_darkchat_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_stories`
--
ALTER TABLE `phone_instagram_stories`
  ADD CONSTRAINT `phone_instagram_stories_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_instagram_stories_views`
--
ALTER TABLE `phone_instagram_stories_views`
  ADD CONSTRAINT `phone_instagram_stories_views_ibfk_1` FOREIGN KEY (`story_id`) REFERENCES `phone_instagram_stories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_mail_loggedin`
--
ALTER TABLE `phone_mail_loggedin`
  ADD CONSTRAINT `phone_mail_loggedin_ibfk_1` FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts` (`address`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_music_saved_playlists`
--
ALTER TABLE `phone_music_saved_playlists`
  ADD CONSTRAINT `phone_music_saved_playlists_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_music_songs`
--
ALTER TABLE `phone_music_songs`
  ADD CONSTRAINT `phone_music_songs_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_services_messages`
--
ALTER TABLE `phone_services_messages`
  ADD CONSTRAINT `phone_services_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_services_channels` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_accounts`
--
ALTER TABLE `phone_tiktok_accounts`
  ADD CONSTRAINT `phone_tiktok_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_channels`
--
ALTER TABLE `phone_tiktok_channels`
  ADD CONSTRAINT `phone_tiktok_channels_ibfk_1` FOREIGN KEY (`member_1`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_channels_ibfk_2` FOREIGN KEY (`member_2`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_comments`
--
ALTER TABLE `phone_tiktok_comments`
  ADD CONSTRAINT `phone_tiktok_comments_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_comments_ibfk_3` FOREIGN KEY (`reply_to`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_comments_likes`
--
ALTER TABLE `phone_tiktok_comments_likes`
  ADD CONSTRAINT `phone_tiktok_comments_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_comments_likes_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_follows`
--
ALTER TABLE `phone_tiktok_follows`
  ADD CONSTRAINT `phone_tiktok_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_likes`
--
ALTER TABLE `phone_tiktok_likes`
  ADD CONSTRAINT `phone_tiktok_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_likes_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_loggedin`
--
ALTER TABLE `phone_tiktok_loggedin`
  ADD CONSTRAINT `phone_tiktok_loggedin_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_loggedin_ibfk_2` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_messages`
--
ALTER TABLE `phone_tiktok_messages`
  ADD CONSTRAINT `phone_tiktok_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_messages_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_notifications`
--
ALTER TABLE `phone_tiktok_notifications`
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_3` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_pinned_videos`
--
ALTER TABLE `phone_tiktok_pinned_videos`
  ADD CONSTRAINT `phone_tiktok_pinned_videos_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_pinned_videos_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_saves`
--
ALTER TABLE `phone_tiktok_saves`
  ADD CONSTRAINT `phone_tiktok_saves_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_saves_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_unread_messages`
--
ALTER TABLE `phone_tiktok_unread_messages`
  ADD CONSTRAINT `phone_tiktok_unread_messages_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_unread_messages_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_videos`
--
ALTER TABLE `phone_tiktok_videos`
  ADD CONSTRAINT `phone_tiktok_videos_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_views`
--
ALTER TABLE `phone_tiktok_views`
  ADD CONSTRAINT `phone_tiktok_views_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_views_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_promoted`
--
ALTER TABLE `phone_twitter_promoted`
  ADD CONSTRAINT `phone_twitter_promoted_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `phone_twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `player_property_id` FOREIGN KEY (`owner`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `property_inventory`
--
ALTER TABLE `property_inventory`
  ADD CONSTRAINT `property_id` FOREIGN KEY (`id_property`) REFERENCES `property` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `society_inventory`
--
ALTER TABLE `society_inventory`
  ADD CONSTRAINT `society_id` FOREIGN KEY (`id_society`) REFERENCES `society` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `tablet`
--
ALTER TABLE `tablet`
  ADD CONSTRAINT `crew_id` FOREIGN KEY (`id_crew`) REFERENCES `crew` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tablet_id` FOREIGN KEY (`tablet_type`) REFERENCES `tablet_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD CONSTRAINT `player_inventory_id` FOREIGN KEY (`id_player`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `player_id` FOREIGN KEY (`owner`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `vehicle_inventory`
--
ALTER TABLE `vehicle_inventory`
  ADD CONSTRAINT `vehicle_plate` FOREIGN KEY (`id_plate`) REFERENCES `vehicles` (`plate`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
