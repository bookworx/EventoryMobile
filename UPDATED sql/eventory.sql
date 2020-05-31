-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2020 at 03:51 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client`
--

CREATE TABLE `tbl_client` (
  `clientID` int(200) NOT NULL,
  `userPhoto` varchar(200) DEFAULT NULL,
  `userPhone` varchar(12) DEFAULT NULL,
  `userAddress` varchar(100) DEFAULT NULL,
  `userGender` varchar(6) DEFAULT NULL,
  `accountID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_favorites`
--

CREATE TABLE `tbl_favorites` (
  `favoriteID` int(10) NOT NULL,
  `dateAdded` date NOT NULL,
  `clientID` int(11) NOT NULL,
  `supplierID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier`
--

CREATE TABLE `tbl_supplier` (
  `supplierID` int(10) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `supplierPhone` varchar(12) DEFAULT NULL,
  `supplierAddress` varchar(50) DEFAULT NULL,
  `supplierCategory` varchar(20) DEFAULT NULL,
  `supplierRate` int(8) DEFAULT NULL,
  `supplierYears` int(2) DEFAULT NULL,
  `supplierBio` varchar(200) DEFAULT NULL,
  `isFavorite` tinyint(1) DEFAULT NULL,
  `accountID` int(11) NOT NULL,
  `supplierFacebook` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`supplierID`, `image`, `supplierPhone`, `supplierAddress`, `supplierCategory`, `supplierRate`, `supplierYears`, `supplierBio`, `isFavorite`, `accountID`, `supplierFacebook`) VALUES
(2, NULL, '09203521547', 'Bulua', 'Photographer', 5000, 5, 'Gwapo na bata', NULL, 2, 'facebook.com/neolamperouge'),
(3, 'assets/cm4.jpeg', '09067954506', 'Bulua', 'Videographer', 5000, 5, 'char2 lang', NULL, 3, 'facebook.com/dalejung');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_useraccounts`
--

CREATE TABLE `tbl_useraccounts` (
  `accountID` int(10) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 NOT NULL,
  `password` varchar(50) CHARACTER SET latin1 NOT NULL,
  `accountType` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_useraccounts`
--

INSERT INTO `tbl_useraccounts` (`accountID`, `fullName`, `email`, `password`, `accountType`) VALUES
(2, 'Neo Haos', 'neo@gmail.com', '123123', 'I am Supplier'),
(20, 'Dale', 'dale@gmail.com', '123123', 'I am Supplier'),
(21, 'Mitch', 'mitch@gmail.com', '123123', 'I am Client');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_client`
--
ALTER TABLE `tbl_client`
  ADD PRIMARY KEY (`clientID`),
  ADD KEY `accountID` (`accountID`);

--
-- Indexes for table `tbl_favorites`
--
ALTER TABLE `tbl_favorites`
  ADD PRIMARY KEY (`favoriteID`),
  ADD KEY `supplierID` (`supplierID`),
  ADD KEY `clientID` (`clientID`);

--
-- Indexes for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  ADD PRIMARY KEY (`supplierID`),
  ADD KEY `accountID` (`accountID`);

--
-- Indexes for table `tbl_useraccounts`
--
ALTER TABLE `tbl_useraccounts`
  ADD PRIMARY KEY (`accountID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_client`
--
ALTER TABLE `tbl_client`
  MODIFY `clientID` int(200) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_favorites`
--
ALTER TABLE `tbl_favorites`
  MODIFY `favoriteID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  MODIFY `supplierID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `tbl_useraccounts`
--
ALTER TABLE `tbl_useraccounts`
  MODIFY `accountID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
