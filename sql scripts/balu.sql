-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2014 at 09:27 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `balu`
--

-- --------------------------------------------------------

--
-- Table structure for table `item_category`
--

CREATE TABLE IF NOT EXISTS `item_category` (
  `category_id` int(20) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `sub_category_id` int(20) NOT NULL DEFAULT '0',
  `sub_category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`sub_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item_info`
--

CREATE TABLE IF NOT EXISTS `item_info` (
  `item_id` int(20) NOT NULL DEFAULT '0',
  `item_name` varchar(50) NOT NULL,
  `item_image_1` blob,
  `item_image_2` blob,
  `item_image_3` blob,
  `renter_id` int(20) DEFAULT NULL,
  `category_id` int(20) NOT NULL,
  `sub_category_id` int(20) DEFAULT NULL,
  `location_id` int(20) DEFAULT NULL,
  `description` varchar(50) NOT NULL,
  `manufacturer_id` int(20) DEFAULT NULL,
  `manufacturing_date` date NOT NULL,
  `rent_amount` int(7) NOT NULL,
  `rent_status` varchar(20) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `renter_id` (`renter_id`),
  KEY `sub_category_id` (`sub_category_id`),
  KEY `location_id` (`location_id`),
  KEY `manufacturer_id` (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item_manufacturer`
--

CREATE TABLE IF NOT EXISTS `item_manufacturer` (
  `manufacturer_id` int(20) NOT NULL DEFAULT '0',
  `manufacturer_name` varchar(50) NOT NULL,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int(20) NOT NULL DEFAULT '0',
  `city_name` varchar(20) NOT NULL,
  `state_name` varchar(20) NOT NULL,
  `country_name` varchar(20) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE IF NOT EXISTS `notification` (
  `rr_id` int(20) NOT NULL DEFAULT '0',
  `product_id` int(20) DEFAULT NULL,
  `payer_id` int(20) DEFAULT NULL,
  `rent_amount` int(7) NOT NULL,
  `rent_unit` varchar(5) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `payment_mode` varchar(20) NOT NULL,
  `shipping_mode` varchar(20) NOT NULL,
  PRIMARY KEY (`rr_id`),
  KEY `product_id` (`product_id`),
  KEY `payer_id` (`payer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `contact` int(12) NOT NULL,
  `email` varchar(40) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `street_name` varchar(20) NOT NULL,
  `locality` varchar(20) NOT NULL,
  `location_id` int(20) DEFAULT NULL,
  `pincode` int(10) NOT NULL,
  `photo` blob,
  PRIMARY KEY (`user_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item_info`
--
ALTER TABLE `item_info`
  ADD CONSTRAINT `item_info_ibfk_1` FOREIGN KEY (`renter_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `item_info_ibfk_2` FOREIGN KEY (`sub_category_id`) REFERENCES `item_category` (`sub_category_id`),
  ADD CONSTRAINT `item_info_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `item_info_ibfk_4` FOREIGN KEY (`manufacturer_id`) REFERENCES `item_manufacturer` (`manufacturer_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `item_info` (`item_id`),
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`payer_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
