CREATE DATABASE IF NOT EXISTS `GymSQL` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `GymSQL`;

-- Table USERS
CREATE TABLE `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `dni` VARCHAR(20) NOT NULL,
  `user_type` INT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table CLIENTS
CREATE TABLE `clients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `birth_date` DATE NOT NULL,
  `height` FLOAT NOT NULL,
  `weight` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_clients_user` (`user_id`),
  CONSTRAINT `fk_clients_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table MONITORS
CREATE TABLE `monitors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `specialty` VARCHAR(100) NOT NULL,
  `experience_years` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_monitors_user` (`user_id`),
  CONSTRAINT `fk_monitors_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table ROOMS
CREATE TABLE `rooms` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `capacity` INT NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table MONITOR_ROOMS
CREATE TABLE `monitor_rooms` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` INT(11) NOT NULL,
  `room_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_monitor_room_monitor` (`monitor_id`),
  KEY `idx_monitor_room_room` (`room_id`),
  CONSTRAINT `fk_monitor_rooms_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitors` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_monitor_rooms_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table MONITOR_SPECIALIZATIONS
CREATE TABLE `monitor_specializations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` INT(11) NOT NULL,
  `specialization` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_monitor_specialization_monitor` (`monitor_id`),
  CONSTRAINT `fk_monitor_specializations_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table VLOGS
CREATE TABLE `vlogs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `monitor_id` INT(11) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `created_at` DATE NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`id`),
  KEY `idx_vlogs_monitor` (`monitor_id`),
  CONSTRAINT `fk_vlogs_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table VLOG_CONTENT
CREATE TABLE `vlog_content` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `vlog_id` INT(11) NOT NULL,
  `step_number` INT NOT NULL,
  `content` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_vlog_content_vlog` (`vlog_id`),
  CONSTRAINT `fk_vlog_content_vlog` FOREIGN KEY (`vlog_id`) REFERENCES `vlogs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table MESSAGES
CREATE TABLE `messages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `sender_id` INT(11) NOT NULL,
  `receiver_id` INT(11) NOT NULL,
  `content` TEXT NOT NULL,
  `sent_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_messages_sender` (`sender_id`),
  KEY `idx_messages_receiver` (`receiver_id`),
  CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_messages_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table CLIENT_MONITOR_ASSIGNMENTS
CREATE TABLE `client_monitor_assignments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NOT NULL,
  `monitor_id` INT(11) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE,
  PRIMARY KEY (`id`),
  KEY `idx_assignment_client` (`client_id`),
  KEY `idx_assignment_monitor` (`monitor_id`),
  CONSTRAINT `fk_assignment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_assignment_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table REPORTS
CREATE TABLE `reports` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NOT NULL,
  `monitor_id` INT(11) NOT NULL,
  `report_date` DATE NOT NULL,
  `content` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reports_client` (`client_id`),
  KEY `idx_reports_monitor` (`monitor_id`),
  CONSTRAINT `fk_reports_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reports_monitor` FOREIGN KEY (`monitor_id`) REFERENCES `monitors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table ASSISTANCES
CREATE TABLE `assistances` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `client_id` INT(11) NOT NULL,
  `assistance_date` DATE NOT NULL,
  `status` ENUM('present', 'absent') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_assistances_client` (`client_id`),
  CONSTRAINT `fk_assistances_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Users
INSERT INTO users (username, password, email, dni, user_type)
VALUES 
('juan_client', 'hashedpass123', 'juan@example.com', '12345678A', 0),
('laura_monitor', 'hashedpass456', 'laura@example.com', '87654321B', 1);

-- Client
INSERT INTO clients (user_id, birth_date, height, weight)
VALUES (1, '1995-05-20', 1.75, 70.0);

-- Monitor
INSERT INTO monitors (user_id, specialty, experience_years)
VALUES (2, 'Cardio & Fitness', 5);

-- Room
INSERT INTO rooms (name, capacity, description)
VALUES ('Cardio Room', 30, 'Room equipped with bikes, treadmills, and ellipticals.');

-- Assign monitor to room
INSERT INTO monitor_rooms (monitor_id, room_id)
VALUES (1, 1);

-- Monitor's specializations
INSERT INTO monitor_specializations (monitor_id, specialization)
VALUES (1, 'Functional Training'), (1, 'HIIT');

-- Monitor vlog
INSERT INTO vlogs (monitor_id, title, created_at, description)
VALUES (1, 'Getting Started with Cardio', '2025-04-10', 'Quick guide to start cardio workouts.');

-- Vlog content steps
INSERT INTO vlog_content (vlog_id, step_number, content)
VALUES 
(1, 1, 'Warm up for 5 minutes on the bike.'),
(1, 2, 'Run for 10 minutes on the treadmill at a moderate pace.'),
(1, 3, 'Finish with stretches.');

-- Assign monitor to client
INSERT INTO client_monitor_assignments (client_id, monitor_id, start_date)
VALUES (1, 1, '2025-04-01');

-- Progress report
INSERT INTO reports (client_id, monitor_id, report_date, content)
VALUES (1, 1, '2025-04-10', 'Client has improved endurance and maintains a steady pace.');

-- Client attendance records
INSERT INTO assistances (client_id, assistance_date, status)
VALUES 
(1, '2025-04-08', 'present'),
(1, '2025-04-09', 'absent'),
(1, '2025-04-10', 'present');

-- Messages between monitor and client
INSERT INTO messages (sender_id, receiver_id, content, sent_at)
VALUES 
(2, 1, 'Hi Juan, remember to hydrate before your workout.', '2025-04-10 09:30:00'),
(1, 2, 'Thanks Laura! I’ll keep that in mind.', '2025-04-10 10:00:00');
