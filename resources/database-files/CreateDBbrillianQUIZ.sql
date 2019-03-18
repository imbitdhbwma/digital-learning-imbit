/* This Script should be executed by the database admin (e.g. root) to create the database for brillianICM. */
-- <<Reset database>>
-- Danger!! if the the following statements are uncommented the database and connection user will be reset. Any exising content is lost! Use this in case you want to start with the initial database.
-- DROP USER brillianquiz@localhost;
-- DROP database brillianquiz; 

-- <<General Configuration>>
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- <<Create database>>
CREATE DATABASE IF NOT EXISTS brillianquiz;
USE brillianquiz;


-- <<Create tables>>
-- 'group' Table
CREATE TABLE IF NOT EXISTS `group` (
  GROUP_ID int(11) NOT NULL AUTO_INCREMENT,
  GROUP_NAME varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  PROFESSOR_ID int(11) NOT NULL,
  CERTIFICATE int(11) NOT NULL DEFAULT 0,
  ORG varchar(256) COLLATE utf8mb4_general_ci,
  DESCRIPTION varchar(256) COLLATE utf8mb4_general_ci,
  URL varchar(256) COLLATE utf8mb4_general_ci,
  PRIMARY KEY (GROUP_ID),
  KEY GROUP_ID (GROUP_ID),
  KEY PROFESSOR_ID (PROFESSOR_ID)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=4 ;

-- 'user' Table
CREATE TABLE IF NOT EXISTS user (
  USER_ID int(11) NOT NULL AUTO_INCREMENT,
  EMAIL varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  FIRST_NAME varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  LAST_NAME varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  PASSWORD varchar(256) COLLATE utf8mb4_general_ci NOT NULL,
  ROLE varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `GROUP` int(10) DEFAULT NULL,
  REG_DATE timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  GENDER tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = MALE, 0 = FEMALE',
  PRIMARY KEY (USER_ID),
  KEY `GROUP` (`GROUP`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=19 ;

-- 'user_progress' Table 
DROP TABLE IF EXISTS `user_progress`;
CREATE TABLE user_progress (
  USER_ID int(11) NOT NULL,
  COST int(11) NOT NULL,
  QUALITY int(11) NOT NULL,
  TIME int(11) NOT NULL,
  PATH text COLLATE utf8mb4_general_ci DEFAULT NULL,
  L1 boolean NOT NULL,
  L2 boolean NOT NULL,
  L3 boolean NOT NULL,
  L4 boolean NOT NULL,
  L5 boolean NOT NULL,
  L6 boolean NOT NULL,
  L7 boolean NOT NULL,
  PRIMARY KEY (USER_ID),
  KEY USER_ID (USER_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 'quiz_user_progress' Table 
DROP TABLE IF EXISTS `quiz_user_progress`;
CREATE TABLE quiz_user_progress (
  USER_ID int(11) NOT NULL,
  TIME timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PROGRESS LONGTEXT NOT NULL,
  PRIMARY KEY (USER_ID),
  KEY USER_ID (USER_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 'settings' Table 
CREATE TABLE IF NOT EXISTS settings (
  ID TINYINT(1) NOT NULL,
  AUDIO BOOLEAN NOT NULL,
  VIDEO BOOLEAN NOT NULL,
  TTS BOOLEAN NOT NULL,
  SUBTITLES BOOLEAN NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 'badges' Table 
CREATE TABLE IF NOT EXISTS badges (
  UID INT(11) NOT NULL,
  RECIPIENT VARCHAR(256) NOT NULL,
  ISSUEDON DATE NOT NULL,
  BADGE VARCHAR(256),
  PRIMARY KEY (UID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- <<Create initial table content>>
-- 'group' Table Content
INSERT INTO `group` (GROUP_ID, GROUP_NAME, PROFESSOR_ID, CERTIFICATE, ORG, DESCRIPTION, URL) VALUES
(3, 'WIMBIT', 17, 0, 'DHBW', 'DHBW Mannheim Studiengang IMBIT', 'http://www.imbit.dhbw-mannheim.de/'), (0, 'Public', 0, 0, NULL, NULL, NULL);

-- 'user' table content
INSERT INTO user (USER_ID, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, ROLE, `GROUP`, REG_DATE, GENDER) VALUES
(16, 'admin@brillianquiz.com', 'Dorothea', 'Langer', '$shiro1$SHA-256$500000$DhdIuSNhEvqrvOmyfIfcuw==$AzmajwrcT/UxrYO50+zkTIFxjyazOhiiAY1xsSyPxBI=', 'admin', NULL, '2014-05-07 15:19:51', 0),
(17, 'dozent@brillianquiz.com', 'Lukas', 'Steigerwald', '$shiro1$SHA-256$500000$DhdIuSNhEvqrvOmyfIfcuw==$AzmajwrcT/UxrYO50+zkTIFxjyazOhiiAY1xsSyPxBI=', 'professor', NULL, '2014-04-13 05:13:08', 1),
(18, 'student@brillianquiz.com', 'Fred', 'Feuerstein', '$shiro1$SHA-256$500000$DhdIuSNhEvqrvOmyfIfcuw==$AzmajwrcT/UxrYO50+zkTIFxjyazOhiiAY1xsSyPxBI=', 'student', 3, '2014-04-21 14:45:32', 1),
(0, 'public@brillianquiz.com', 'Public', 'Public', '$shiro1$SHA-256$500000$DhdIuSNhEvqrvOmyfIfcuw==$AzmajwrcT/UxrYO50+zkTIFxjyazOhiiAY1xsSyPxBI=', 'professor', NULL, '2014-04-21 14:45:32', 1);

-- 'user_progress' content
INSERT INTO user_progress (USER_ID, COST, QUALITY, TIME, PATH, L1, L2, L3, L4, L5, L6, L7) VALUES
(18, 0, 0, 0, 'l000e000', false, false, false, false, false, false, false);


-- 'quiz_user_progress' content
INSERT INTO quiz_user_progress (USER_ID, PROGRESS) VALUES
(18, '{}');

-- 'settings' content
INSERT INTO settings (ID, AUDIO, VIDEO, TTS, SUBTITLES) VALUES
(1, true, true, true, true);


-- <<Create Constraints>>
-- for table 'group'
ALTER TABLE `group`
  ADD CONSTRAINT group_ibfk_1 FOREIGN KEY (PROFESSOR_ID) REFERENCES user (USER_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- for table 'user'
ALTER TABLE user
  ADD CONSTRAINT user_ibfk_1 FOREIGN KEY (`GROUP`) REFERENCES `group` (GROUP_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- for table 'user_progress'
ALTER TABLE user_progress
  ADD CONSTRAINT user_progress_ibfk_1 FOREIGN KEY (USER_ID) REFERENCES user (USER_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- for table 'quiz_user_progress'
ALTER TABLE quiz_user_progress
  ADD CONSTRAINT quiz_user_progress_ibfk_1 FOREIGN KEY (USER_ID) REFERENCES user (USER_ID) ON DELETE CASCADE ON UPDATE CASCADE;
  
-- <<Create Users>>
CREATE USER brillianquiz@localhost identified by 'quiz@IMBIT'; -- //TODO remove password

GRANT ALL PRIVILEGES ON brillianquiz.* TO brillianquiz@localhost;