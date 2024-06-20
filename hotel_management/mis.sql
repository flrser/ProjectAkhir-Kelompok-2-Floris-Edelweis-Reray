-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2024 at 09:35 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mis`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_room` (IN `room_id_input` INT)   BEGIN
    DELETE FROM room WHERE room_id = room_id_input;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_staff` (IN `emp_id_input` INT)   BEGIN
    DELETE FROM staff WHERE emp_id = emp_id_input;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_room` (IN `room_type_input` VARCHAR(20), IN `room_no_input` VARCHAR(20))   BEGIN
    INSERT INTO room (room_type_id, room_no)
    VALUES (room_type_input, room_no_input);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_staff` (IN `name_input` VARCHAR(100), IN `staff_type_input` INT, IN `shift_input` INT, IN `id_card_input` INT, IN `id_card_no_input` VARCHAR(20), IN `address_input` VARCHAR(100), IN `contact_input` VARCHAR(20), IN `salary_input` BIGINT(20))   BEGIN
    INSERT INTO staff (emp_name, staff_type_id, shift_id, id_card_type, id_card_no, address, contact_no, salary)
    VALUES (name_input, staff_type_input, shift_input, id_card_input, id_card_no_input, address_input, contact_input, salary_input);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalpendapatan` ()   BEGIN
    # deklarasi variabel yang akan digunakan
    DECLARE total_masuk INT DEFAULT 0;
    DECLARE current_id INT DEFAULT 0;
    DECLARE max_id INT;
    
    # untuk dapet banyak data di dalam tabel booking
    SELECT MAX(booking_id) INTO max_id FROM booking;
    
    WHILE current_id <= max_id DO
        SET current_id = current_id + 1;
        
        -- menambahkan total harga jika payment_status = 1
        IF (SELECT payment_status FROM booking WHERE booking_id = current_id) = 1 THEN
            SET total_masuk = total_masuk + (SELECT total_price FROM booking WHERE booking_id = current_id);
        END IF;
    END WHILE;
    
    -- Menampilkan total pendapatan
    SELECT total_masuk AS total_pendapatan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_room` (IN `room_id_input` INT(5), IN `room_type_input` INT(5), IN `room_no_input` VARCHAR(20))   BEGIN
    UPDATE room
    SET room_type_id = room_type_input, room_no = room_no_input
    WHERE room_id = room_id_input;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_staff` (IN `emp_id_input` INT, IN `name_input` VARCHAR(100), IN `staff_type_input` INT, IN `shift_input` INT, IN `id_card_input` INT, IN `id_card_no_input` VARCHAR(20), IN `address_input` VARCHAR(100), IN `contact_input` VARCHAR(20), IN `salary_input` BIGINT(20))   BEGIN
    UPDATE staff
    SET emp_name = name_input, staff_type_id = staff_type_input, shift_id = shift_input, id_card_type = id_card_input, id_card_no = id_card_no_input, address = address_input, contact_no = contact_input, salary = salary_input
    WHERE emp_id = emp_id_input;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `room_id` int(10) NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `check_in` varchar(100) DEFAULT NULL,
  `check_out` varchar(100) NOT NULL,
  `total_price` int(10) NOT NULL,
  `remaining_price` int(10) NOT NULL,
  `payment_status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `customer_id`, `room_id`, `booking_date`, `check_in`, `check_out`, `total_price`, `remaining_price`, `payment_status`) VALUES
(8, 8, 20, '2024-05-23 04:44:06', '25-05-2024', '27-05-2024', 3000, 0, 1),
(9, 9, 22, '2024-05-22 04:46:53', '25-05-2024', '26-05-2024', 4000, 0, 1),
(10, 10, 26, '2024-05-26 04:47:53', '27-05-2024', '29-05-2024', 3000, 0, 1),
(11, 11, 24, '2024-06-26 04:48:49', '28-05-2024', '30-05-2024', 4500, 0, 1),
(12, 12, 29, '2024-06-30 04:50:11', '01-06-2024', '02-06-2024', 3000, 0, 1),
(13, 13, 34, '2024-07-01 04:50:55', '04-06-2024', '06-06-2024', 6000, 0, 1),
(14, 14, 30, '2024-06-02 04:51:43', '03-06-2024', '06-06-2024', 12000, 0, 1),
(15, 15, 23, '2024-06-05 04:52:34', '08-06-2024', '11-06-2024', 4000, 0, 1),
(16, 16, 24, '2024-06-13 05:02:07', '13-06-2024', '16-06-2024', 6000, 0, 0),
(17, 17, 23, '2024-06-13 05:02:58', '18-06-2024', '20-06-2024', 3000, 0, 1),
(18, 18, 28, '2024-06-13 06:41:30', '15-06-2024', '18-06-2024', 6000, 6000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE `complaint` (
  `id` int(11) NOT NULL,
  `complainant_name` varchar(100) NOT NULL,
  `complaint_type` varchar(100) NOT NULL,
  `complaint` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolve_status` tinyint(1) NOT NULL,
  `resolve_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `budget` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `complaint`
--

INSERT INTO `complaint` (`id`, `complainant_name`, `complaint_type`, `complaint`, `created_at`, `resolve_status`, `resolve_date`, `budget`) VALUES
(5, 'Rahman', 'AC', 'AC tidak dingin', '2024-05-25 05:03:43', 1, '2024-05-25 05:05:30', 500),
(6, 'Sodik Januar', 'Air kamar mandi', 'Air tidak nyala', '2024-05-27 05:04:39', 1, '2024-05-27 05:05:36', 500),
(7, 'Rosa', 'AC mati', 'AC tidak bisa dihidupkan', '2024-06-04 05:05:21', 1, '2024-06-04 05:05:49', 500);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(10) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `id_card_type_id` int(10) NOT NULL,
  `id_card_no` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_name`, `contact_no`, `email`, `id_card_type_id`, `id_card_no`, `address`) VALUES
(8, 'Rahman Abdullah', '087801233284', 'abdulrah@gmail.com', 1, '320441234821230', 'Surabaya'),
(9, 'Fia Rahani', '088284214282', 'Fiara@gmail.com', 2, '3022842421222334', 'Malang'),
(10, 'Sodik Januar', '088127346222', 'januar123@gmail.com', 2, '1288228120800123', 'Gorontalo'),
(11, 'Handanu Akbar', '081273645822', 'handanuak12@gmail.com', 1, '8826440263880173', 'Depok\n'),
(12, 'Yogi Iriawan', '088273652233', 'yogiyogi@gmail.com', 1, '82742412849172846', 'Jakarta'),
(13, 'Rosa Amelia', '088124658819', 'rosaamel@gmail.com', 1, '1273469238167722', 'Yogyakarta'),
(14, 'Rahmat Arianda', '088172847722', 'rahmatjoko@gmail.com', 1, '2239327100737118', 'Banyuwangi'),
(15, 'Tariq Fialino', '081284322711', 'filinotar@gmail.com', 1, '7128478271002768', 'Tangerang'),
(16, 'Rika Rofianti', '088124582123', 'rikaa@gmail.com', 1, '1241253253441234', 'Lamongan'),
(17, 'Eri Afrianto', '082177442812', 'eriaf@gmail.com', 2, '284912824882371', 'Surabaya'),
(18, 'Jaka Radian', '087273828747', 'jaka@gmail.com', 1, '8192728472266211', 'Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `id_card_type`
--

CREATE TABLE `id_card_type` (
  `id_card_type_id` int(10) NOT NULL,
  `id_card_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `id_card_type`
--

INSERT INTO `id_card_type` (`id_card_type_id`, `id_card_type`) VALUES
(1, 'KTP'),
(2, 'KK'),
(3, 'SIM'),
(4, 'Paspor');

-- --------------------------------------------------------

--
-- Table structure for table `log_room`
--

CREATE TABLE `log_room` (
  `id_log_room` int(11) NOT NULL,
  `aktivitas` varchar(10) DEFAULT NULL,
  `old_room_type` varchar(11) DEFAULT NULL,
  `old_room_no` varchar(10) DEFAULT NULL,
  `new_room_type` varchar(11) DEFAULT NULL,
  `new_room_no` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_room`
--

INSERT INTO `log_room` (`id_log_room`, `aktivitas`, `old_room_type`, `old_room_no`, `new_room_type`, `new_room_no`, `created_at`) VALUES
(25, 'INSERT', '-', '-', '1', 'A-101', '2024-06-13 04:36:57'),
(26, 'INSERT', '-', '-', '2', 'A-102', '2024-06-13 04:37:06'),
(27, 'INSERT', '-', '-', '3', 'A-103', '2024-06-13 04:37:18'),
(28, 'INSERT', '-', '-', '1', 'A-104', '2024-06-13 04:37:25'),
(29, 'INSERT', '-', '-', '2', 'A-105', '2024-06-13 04:37:33'),
(30, 'INSERT', '-', '-', '4', 'A-106', '2024-06-13 04:37:42'),
(31, 'INSERT', '-', '-', '1', 'B-101', '2024-06-13 04:37:51'),
(32, 'INSERT', '-', '-', '1', 'B-102', '2024-06-13 04:37:57'),
(33, 'INSERT', '-', '-', '2', 'B-103', '2024-06-13 04:38:07'),
(34, 'INSERT', '-', '-', '2', 'B-104', '2024-06-13 04:38:15'),
(35, 'INSERT', '-', '-', '4', 'B-105', '2024-06-13 04:38:20'),
(36, 'INSERT', '-', '-', '4', 'B-106', '2024-06-13 04:38:30'),
(37, 'INSERT', '-', '-', '2', 'C-101', '2024-06-13 04:38:58'),
(38, 'INSERT', '-', '-', '1', 'C-102', '2024-06-13 04:39:04'),
(39, 'INSERT', '-', '-', '3', 'C-103', '2024-06-13 04:39:10'),
(40, 'INSERT', '-', '-', '1', 'C-104', '2024-06-13 04:39:17'),
(41, 'UPDATE', '1', 'A-101', '1', 'A-101', '2024-06-13 04:44:06'),
(42, 'UPDATE', '3', 'A-103', '3', 'A-103', '2024-06-13 04:46:53'),
(43, 'UPDATE', '1', 'B-101', '1', 'B-101', '2024-06-13 04:47:53'),
(44, 'UPDATE', '2', 'A-105', '2', 'A-105', '2024-06-13 04:48:49'),
(45, 'UPDATE', '2', 'A-105', '2', 'A-105', '2024-06-13 04:49:00'),
(46, 'UPDATE', '2', 'A-105', '2', 'A-105', '2024-06-13 04:49:07'),
(47, 'UPDATE', '1', 'A-101', '1', 'A-101', '2024-06-13 04:49:15'),
(48, 'UPDATE', '1', 'A-101', '1', 'A-101', '2024-06-13 04:49:21'),
(49, 'UPDATE', '2', 'B-104', '2', 'B-104', '2024-06-13 04:50:11'),
(50, 'UPDATE', '3', 'C-103', '3', 'C-103', '2024-06-13 04:50:55'),
(51, 'UPDATE', '4', 'B-105', '4', 'B-105', '2024-06-13 04:51:43'),
(52, 'UPDATE', '1', 'A-104', '1', 'A-104', '2024-06-13 04:52:34'),
(53, 'UPDATE', '3', 'C-103', '3', 'C-103', '2024-06-13 04:52:44'),
(54, 'UPDATE', '3', 'C-103', '3', 'C-103', '2024-06-13 04:52:51'),
(55, 'UPDATE', '4', 'B-105', '4', 'B-105', '2024-06-13 04:53:00'),
(56, 'UPDATE', '4', 'B-105', '4', 'B-105', '2024-06-13 04:53:06'),
(57, 'UPDATE', '1', 'B-101', '1', 'B-101', '2024-06-13 04:53:12'),
(58, 'UPDATE', '1', 'B-101', '1', 'B-101', '2024-06-13 04:53:27'),
(59, 'INSERT', '-', '-', '1', 'F-101', '2024-06-13 04:54:19'),
(60, 'UPDATE', '1', 'F-101', '1', 'F-102', '2024-06-13 04:54:26'),
(61, 'DELETE', '1', 'F-102', '-', '-', '2024-06-13 04:54:37'),
(62, 'UPDATE', '1', 'A-104', '1', 'A-104', '2024-06-13 04:58:03'),
(63, 'UPDATE', '1', 'A-104', '1', 'A-104', '2024-06-13 04:58:06'),
(64, 'UPDATE', '2', 'B-104', '2', 'B-104', '2024-06-13 04:58:11'),
(65, 'UPDATE', '2', 'B-104', '2', 'B-104', '2024-06-13 04:58:14'),
(66, 'UPDATE', '3', 'A-103', '3', 'A-103', '2024-06-13 04:58:19'),
(67, 'UPDATE', '3', 'A-103', '3', 'A-103', '2024-06-13 04:58:25'),
(68, 'UPDATE', '2', 'A-105', '2', 'A-105', '2024-06-13 05:02:07'),
(69, 'UPDATE', '1', 'A-104', '1', 'A-104', '2024-06-13 05:02:58'),
(70, 'UPDATE', '2', 'A-105', '2', 'A-105', '2024-06-13 05:03:07'),
(71, 'UPDATE', '1', 'A-104', '1', 'A-104', '2024-06-13 06:38:59'),
(72, 'UPDATE', '1', 'A-104', '1', 'A-104', '2024-06-13 06:39:02'),
(73, 'UPDATE', '2', 'B-103', '2', 'B-103', '2024-06-13 06:41:30');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` int(10) NOT NULL,
  `room_type_id` int(10) NOT NULL,
  `room_no` varchar(10) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `check_in_status` tinyint(1) NOT NULL,
  `check_out_status` tinyint(1) NOT NULL,
  `deleteStatus` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_id`, `room_type_id`, `room_no`, `status`, `check_in_status`, `check_out_status`, `deleteStatus`) VALUES
(20, 1, 'A-101', NULL, 0, 1, 0),
(21, 2, 'A-102', NULL, 0, 0, 0),
(22, 3, 'A-103', NULL, 0, 1, 0),
(23, 1, 'A-104', NULL, 0, 1, 0),
(24, 2, 'A-105', 1, 1, 1, 0),
(25, 4, 'A-106', NULL, 0, 0, 0),
(26, 1, 'B-101', NULL, 0, 1, 0),
(27, 1, 'B-102', NULL, 0, 0, 0),
(28, 2, 'B-103', 1, 0, 0, 0),
(29, 2, 'B-104', NULL, 0, 1, 0),
(30, 4, 'B-105', NULL, 0, 1, 0),
(31, 4, 'B-106', NULL, 0, 0, 0),
(32, 2, 'C-101', NULL, 0, 0, 0),
(33, 1, 'C-102', NULL, 0, 0, 0),
(34, 3, 'C-103', NULL, 0, 1, 0),
(35, 1, 'C-104', NULL, 0, 0, 0);

--
-- Triggers `room`
--
DELIMITER $$
CREATE TRIGGER `delete_room_new` AFTER DELETE ON `room` FOR EACH ROW BEGIN
	INSERT INTO log_room SET
	aktivitas = "DELETE",
	old_room_type = old.room_type_id,
	old_room_no = old.room_no,
	new_room_type = "-",
	new_room_no = "-";
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_room_new` AFTER INSERT ON `room` FOR EACH ROW BEGIN
	INSERT INTO log_room SET
	aktivitas = "INSERT",
	old_room_type = "-",
	old_room_no = "-",
	new_room_type = new.room_type_id,
	new_room_no = new.room_no;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_room_new` AFTER UPDATE ON `room` FOR EACH ROW BEGIN
	INSERT INTO log_room SET
	aktivitas = "UPDATE",
	old_room_type = old.room_type_id,
	old_room_no = old.room_no,
	new_room_type = new.room_type_id,
	new_room_no = new.room_no;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(10) NOT NULL,
  `room_type` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `max_person` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `room_type`
--

INSERT INTO `room_type` (`room_type_id`, `room_type`, `price`, `max_person`) VALUES
(1, 'Single', 1000, 1),
(2, 'Double', 1500, 2),
(3, 'Triple', 2000, 3),
(4, 'Family', 3000, 2);

-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
  `shift_id` int(10) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `shift_timing` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `shift`
--

INSERT INTO `shift` (`shift_id`, `shift`, `shift_timing`) VALUES
(1, 'Pagi', '04.00 - 10.00'),
(2, 'Siang', '10.00 - 16.00'),
(3, 'Sore', '16.00 - 22:00'),
(4, 'Malam', '22.00 - 04.00');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `staff_type_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `id_card_type` int(11) NOT NULL,
  `id_card_no` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `salary` bigint(20) NOT NULL,
  `joining_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`emp_id`, `emp_name`, `staff_type_id`, `shift_id`, `id_card_type`, `id_card_no`, `address`, `contact_no`, `salary`, `joining_date`, `updated_at`) VALUES
(30, 'Hani Amanda', 1, 2, 1, '3002123487465342', 'Bandung', '88923448122', 4000, '2024-06-13 04:27:24', '2024-06-13 04:27:24'),
(31, 'Juan Andri', 2, 2, 1, '3033124385748243', 'Depok', '87823241242', 4000, '2024-06-13 04:28:19', '2024-06-13 04:28:19'),
(32, 'Yoga Sindhara', 3, 2, 2, '200241234858223', 'Magelang', '82354328845', 4000, '2024-06-13 04:28:56', '2024-06-13 04:28:56'),
(33, 'Rahma Gina', 4, 2, 1, '1002348232314721', 'Surabaya', '81236483677', 4000, '2024-06-13 04:29:36', '2024-06-13 04:29:36'),
(34, 'Trias Adinda', 5, 2, 1, '2248712422448888', 'Jombang', '85248588842', 4000, '2024-06-13 04:30:20', '2024-06-13 04:30:20'),
(35, 'Jaka Dimas', 1, 1, 3, '1234678912', 'Banyuwangi', '85812487223', 4000, '2024-06-13 04:31:24', '2024-06-13 04:31:24'),
(36, 'Bima Satria', 3, 1, 1, '200048483122323', 'Gresik', '87824370012', 4000, '2024-06-13 04:32:09', '2024-06-13 04:32:09'),
(37, 'Tia Maharani', 1, 3, 1, '8124182401247722', 'Surabaya', '81274838242', 4000, '2024-06-13 04:32:39', '2024-06-13 04:32:39'),
(38, 'Yogi Rosidin', 1, 4, 1, '8824181248201234', 'Depok', '82375843373', 4000, '2024-06-13 04:33:11', '2024-06-13 04:33:11'),
(39, 'Agus Fido', 2, 3, 1, '8422416326462442', 'Tulungagung', '82127429942', 4000, '2024-06-13 04:34:03', '2024-06-13 04:34:03'),
(40, 'Rendi Ananda', 4, 3, 2, '8212752018492274', 'Rembang', '83258338384', 4000, '2024-06-13 04:35:04', '2024-06-13 04:35:04'),
(41, 'Handanu Fiardi', 5, 3, 2, '839102348223752', 'Yogyakarta', '87237410124', 4000, '2024-06-13 04:35:43', '2024-06-13 04:35:43'),
(42, 'Aditya Gani', 3, 4, 1, '1238401248820012', 'Surabaya', '082847221242', 4000, '2024-06-13 04:45:48', '2024-06-13 04:45:48');

-- --------------------------------------------------------

--
-- Table structure for table `staff_type`
--

CREATE TABLE `staff_type` (
  `staff_type_id` int(10) NOT NULL,
  `staff_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `staff_type`
--

INSERT INTO `staff_type` (`staff_type_id`, `staff_type`) VALUES
(1, 'Reception'),
(2, 'Cleaning'),
(3, 'Security'),
(4, 'Cook'),
(5, 'Waiter');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `username`, `email`, `password`, `created_at`) VALUES
(4, 'admin', 'admin', 'admin@gmail.com', '202cb962ac59075b964b07152d234b70', '2024-05-30 04:03:36');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_complaint`
-- (See below for the actual view)
--
CREATE TABLE `view_complaint` (
`id` int(11)
,`complainant_name` varchar(100)
,`complaint_type` varchar(100)
,`complaint` varchar(200)
,`created_at` timestamp
,`resolve_status` tinyint(1)
,`resolve_date` timestamp
,`budget` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_id_card_type`
-- (See below for the actual view)
--
CREATE TABLE `view_id_card_type` (
`id_card_type_id` int(10)
,`id_card_type` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_log_room`
-- (See below for the actual view)
--
CREATE TABLE `view_log_room` (
`id_log_room` int(11)
,`aktivitas` varchar(10)
,`old_room_type` varchar(11)
,`old_room_no` varchar(10)
,`new_room_type` varchar(11)
,`new_room_no` varchar(10)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_room_roomtype`
-- (See below for the actual view)
--
CREATE TABLE `view_room_roomtype` (
`room_type_id` int(10)
,`room_id` int(10)
,`room_no` varchar(10)
,`status` tinyint(1)
,`check_in_status` tinyint(1)
,`check_out_status` tinyint(1)
,`deleteStatus` tinyint(1)
,`room_type` varchar(100)
,`price` int(10)
,`max_person` int(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_room_type`
-- (See below for the actual view)
--
CREATE TABLE `view_room_type` (
`room_type_id` int(10)
,`room_type` varchar(100)
,`price` int(10)
,`max_person` int(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_shift`
-- (See below for the actual view)
--
CREATE TABLE `view_shift` (
`shift_id` int(10)
,`shift` varchar(100)
,`shift_timing` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_staff_type`
-- (See below for the actual view)
--
CREATE TABLE `view_staff_type` (
`staff_type_id` int(10)
,`staff_type` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure for view `view_complaint`
--
DROP TABLE IF EXISTS `view_complaint`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_complaint`  AS SELECT `complaint`.`id` AS `id`, `complaint`.`complainant_name` AS `complainant_name`, `complaint`.`complaint_type` AS `complaint_type`, `complaint`.`complaint` AS `complaint`, `complaint`.`created_at` AS `created_at`, `complaint`.`resolve_status` AS `resolve_status`, `complaint`.`resolve_date` AS `resolve_date`, `complaint`.`budget` AS `budget` FROM `complaint` ;

-- --------------------------------------------------------

--
-- Structure for view `view_id_card_type`
--
DROP TABLE IF EXISTS `view_id_card_type`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_id_card_type`  AS SELECT `id_card_type`.`id_card_type_id` AS `id_card_type_id`, `id_card_type`.`id_card_type` AS `id_card_type` FROM `id_card_type` ;

-- --------------------------------------------------------

--
-- Structure for view `view_log_room`
--
DROP TABLE IF EXISTS `view_log_room`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_log_room`  AS SELECT `log_room`.`id_log_room` AS `id_log_room`, `log_room`.`aktivitas` AS `aktivitas`, `log_room`.`old_room_type` AS `old_room_type`, `log_room`.`old_room_no` AS `old_room_no`, `log_room`.`new_room_type` AS `new_room_type`, `log_room`.`new_room_no` AS `new_room_no`, `log_room`.`created_at` AS `created_at` FROM `log_room` ;

-- --------------------------------------------------------

--
-- Structure for view `view_room_roomtype`
--
DROP TABLE IF EXISTS `view_room_roomtype`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_room_roomtype`  AS SELECT `room`.`room_type_id` AS `room_type_id`, `room`.`room_id` AS `room_id`, `room`.`room_no` AS `room_no`, `room`.`status` AS `status`, `room`.`check_in_status` AS `check_in_status`, `room`.`check_out_status` AS `check_out_status`, `room`.`deleteStatus` AS `deleteStatus`, `room_type`.`room_type` AS `room_type`, `room_type`.`price` AS `price`, `room_type`.`max_person` AS `max_person` FROM (`room` join `room_type` on(`room`.`room_type_id` = `room_type`.`room_type_id`)) WHERE `room`.`deleteStatus` = 0 ;

-- --------------------------------------------------------

--
-- Structure for view `view_room_type`
--
DROP TABLE IF EXISTS `view_room_type`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_room_type`  AS SELECT `room_type`.`room_type_id` AS `room_type_id`, `room_type`.`room_type` AS `room_type`, `room_type`.`price` AS `price`, `room_type`.`max_person` AS `max_person` FROM `room_type` ;

-- --------------------------------------------------------

--
-- Structure for view `view_shift`
--
DROP TABLE IF EXISTS `view_shift`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_shift`  AS SELECT `shift`.`shift_id` AS `shift_id`, `shift`.`shift` AS `shift`, `shift`.`shift_timing` AS `shift_timing` FROM `shift` ;

-- --------------------------------------------------------

--
-- Structure for view `view_staff_type`
--
DROP TABLE IF EXISTS `view_staff_type`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_staff_type`  AS SELECT `staff_type`.`staff_type_id` AS `staff_type_id`, `staff_type`.`staff_type` AS `staff_type` FROM `staff_type` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `customer_id_type` (`id_card_type_id`);

--
-- Indexes for table `id_card_type`
--
ALTER TABLE `id_card_type`
  ADD PRIMARY KEY (`id_card_type_id`);

--
-- Indexes for table `log_room`
--
ALTER TABLE `log_room`
  ADD PRIMARY KEY (`id_log_room`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `room_type_id` (`room_type_id`);

--
-- Indexes for table `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`);

--
-- Indexes for table `shift`
--
ALTER TABLE `shift`
  ADD PRIMARY KEY (`shift_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `id_card_type` (`id_card_type`),
  ADD KEY `shift_id` (`shift_id`),
  ADD KEY `staff_type_id` (`staff_type_id`);

--
-- Indexes for table `staff_type`
--
ALTER TABLE `staff_type`
  ADD PRIMARY KEY (`staff_type_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `complaint`
--
ALTER TABLE `complaint`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `id_card_type`
--
ALTER TABLE `id_card_type`
  MODIFY `id_card_type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `log_room`
--
ALTER TABLE `log_room`
  MODIFY `id_log_room` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shift`
--
ALTER TABLE `shift`
  MODIFY `shift_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `staff_type`
--
ALTER TABLE `staff_type`
  MODIFY `staff_type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`id_card_type_id`) REFERENCES `id_card_type` (`id_card_type_id`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`id_card_type`) REFERENCES `id_card_type` (`id_card_type_id`),
  ADD CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`shift_id`),
  ADD CONSTRAINT `staff_ibfk_3` FOREIGN KEY (`staff_type_id`) REFERENCES `staff_type` (`staff_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
