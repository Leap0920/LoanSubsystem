-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 02, 2025 at 11:40 PM
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
-- Database: `loan_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `loan_applications`
--

CREATE TABLE `loan_applications` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `monthly_salary` decimal(10,2) DEFAULT NULL,
  `user_email` varchar(255) NOT NULL,
  `loan_type` varchar(50) DEFAULT NULL,
  `loan_terms` varchar(50) DEFAULT NULL,
  `loan_amount` decimal(12,2) DEFAULT NULL,
  `purpose` text DEFAULT NULL,
  `monthly_payment` decimal(10,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `remarks` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_by` varchar(100) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `next_payment_due` date DEFAULT NULL,
  `rejected_by` varchar(255) DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `rejection_remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_applications`
--

INSERT INTO `loan_applications` (`id`, `full_name`, `account_number`, `contact_number`, `email`, `job`, `monthly_salary`, `user_email`, `loan_type`, `loan_terms`, `loan_amount`, `purpose`, `monthly_payment`, `due_date`, `status`, `remarks`, `file_name`, `created_at`, `approved_by`, `approved_at`, `next_payment_due`, `rejected_by`, `rejected_at`, `rejection_remarks`) VALUES
(24, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', NULL, NULL, 'kurtrealisan@gmail.com', 'Home Loan', '24 Months', 5000.00, '0', NULL, NULL, 'Active', 'sdfsdfsdfsd', 'uploads/the-dark-knight-mixed-art-fvy9jfrmv7np7z0r.jpg', '2025-11-01 17:18:39', 'Jerome Malunes', '2025-11-02 17:55:21', NULL, NULL, NULL, NULL),
(25, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, 'kurtrealisan@gmail.com', 'Home Loan', '12 Months', 60000.00, 'For house building purposes', 5558.07, '2026-11-02', 'Rejected', 'Invalid ID', 'uploads/download.jpg', '2025-11-02 04:00:24', NULL, NULL, NULL, 'Jerome Malunes', '2025-11-02 17:29:08', 'Invalid ID'),
(26, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, '', 'Car Loan', '24 Months', 50000.00, 'For personal car purposes ', 2544.79, '2027-11-02', 'Active', 'Thank You!', 'uploads/download.jpg', '2025-11-02 10:44:49', 'Jerome Malunes', '2025-11-02 17:15:51', NULL, NULL, NULL, NULL),
(27, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, '', 'Home Loan', '24 Months', 7000.00, 'For family house ni Carspeso', 356.27, '2027-11-02', 'Rejected', 'The ID is not valid', 'uploads/images.jpg', '2025-11-02 10:55:26', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, '', 'Personal Loan', '6 Months', 6000.00, 'For study purposes ', 1059.14, '2026-05-02', 'Rejected', 'sffsdfsd', 'uploads/Jespic.jpg', '2025-11-02 12:45:51', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, '', 'Home Loan', '30 Months', 6000.00, 'For housing purposes', 255.78, '2028-05-02', 'Active', 'Thank You!', 'uploads/Jespic.jpg', '2025-11-02 12:47:59', 'Jerome Malunes', '2025-11-02 16:44:48', NULL, NULL, NULL, NULL),
(30, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, '', 'Multi-Purpose Loan', '6 Months', 5000.00, 'For multi purpose only', 882.61, '2026-05-02', 'Approved', 'sdfsdfsd', 'uploads/Jespic.jpg', '2025-11-02 13:38:07', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'Kurt Realisan', '1001234567', '09123456789', 'kurtrealisan@gmail.com', 'Data Analyst', 20000.00, '', 'Multi-Purpose Loan', '6 Months', 7000.00, 'For purposes only', 1235.66, '2026-05-02', 'Active', 'OK', 'uploads/Jespic.jpg', '2025-11-02 17:01:28', 'Jerome Malunes', '2025-11-03 01:04:11', NULL, NULL, NULL, NULL),
(32, 'Clarence Carpeso', '1006789012', '09678901234', 'clarencecarpeso@gmail.com', 'Crossfire Developer', 20000.00, '', 'Car Loan', '6 Months', 10000.00, 'For purposes', 1765.23, '2026-05-02', 'Rejected', 'Invalid ID', 'uploads/Jespic.jpg', '2025-11-02 21:29:52', NULL, NULL, NULL, 'Jerome Malunes', '2025-11-03 05:30:50', 'Invalid ID'),
(33, 'Clarence Carpeso', '1006789012', '09678901234', 'clarencecarpeso@gmail.com', 'Crossfire Developer', 20000.00, '', 'Home Loan', '6 Months', 5000.00, 'For buying house parts', 882.61, '2026-05-02', 'Active', 'Thank you!', 'uploads/Jespic.jpg', '2025-11-02 21:47:34', 'Jerome Malunes', '2025-11-03 05:48:14', '2025-12-03', NULL, NULL, NULL),
(34, 'Clarence Carpeso', '1006789012', '09678901234', 'clarencecarpeso@gmail.com', 'Crossfire Developer', 20000.00, '', 'Multi-Purpose Loan', '6 Months', 7000.00, 'For investment', 1235.66, '2026-05-02', 'Active', 'Thank you for applying loans!! Please pay on the exact time', 'uploads/Jespic.jpg', '2025-11-02 22:24:57', 'Jerome Malunes', '2025-11-03 06:38:36', '2025-12-03', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `loan_applications`
--
ALTER TABLE `loan_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
