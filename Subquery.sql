-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2024 at 05:34 PM
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
-- Database: `subquery`
--

-- --------------------------------------------------------

--
-- Table structure for table `departemen`
--

CREATE TABLE `departemen` (
  `id_dept` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `id_p` varchar(10) DEFAULT NULL,
  `manajer_nik` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departemen`
--

INSERT INTO `departemen` (`id_dept`, `nama`, `id_p`, `manajer_nik`) VALUES
('D01', 'Produksi', 'P02', 'N01'),
('D02', 'Marketing', 'P01', 'N03'),
('D03', 'RnD', 'P02', NULL),
('D04', 'Logistik', 'P02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kantor`
--

CREATE TABLE `kantor` (
  `id_p` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kantor`
--

INSERT INTO `kantor` (`id_p`, `nama`, `alamat`) VALUES
('P01', 'Kantor Pusat', ''),
('P02', 'Cabang Bekasi', '');

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `nik` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `id_dept` varchar(10) DEFAULT NULL,
  `sup_nik` varchar(10) DEFAULT NULL,
  `gaji_pokok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`nik`, `nama`, `id_dept`, `sup_nik`, `gaji_pokok`) VALUES
('N01', 'Ari', 'D01', NULL, 2000000),
('N02', 'Dina', 'D01', NULL, 2500000),
('N03', 'Rika', 'D03', NULL, 2400000),
('N04', 'Ratih', 'D01', 'N01', 3000000),
('N05', 'Riko', 'D01', 'N01', 2800000),
('N06', 'Dani', 'D02', NULL, 2100000),
('N07', 'Anis', 'D02', 'N06', 5000000),
('N08', 'Dika', 'D02', 'N06', 4000000),
('N09', 'Raka', 'D03', 'N06', 2000000);

-- --------------------------------------------------------

--
-- Table structure for table `karyawan_proyek`
--

CREATE TABLE `karyawan_proyek` (
  `id_proj` varchar(10) NOT NULL,
  `nik` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan_proyek`
--

INSERT INTO `karyawan_proyek` (`id_proj`, `nik`) VALUES
('PJ01', 'N01'),
('PJ01', 'N02'),
('PJ01', 'N03'),
('PJ01', 'N04'),
('PJ01', 'N05'),
('PJ01', 'N07'),
('PJ01', 'N08'),
('PJ02', 'N01'),
('PJ02', 'N03'),
('PJ02', 'N05'),
('PJ03', 'N03'),
('PJ03', 'N07'),
('PJ03', 'N08');

-- --------------------------------------------------------

--
-- Table structure for table `proyek`
--

CREATE TABLE `proyek` (
  `id_proj` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_selesai` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proyek`
--

INSERT INTO `proyek` (`id_proj`, `nama`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
('PJ01', 'A', '2019-01-10', '2019-03-10', 1),
('PJ02', 'B', '2019-02-15', '2019-04-10', 1),
('PJ03', 'C', '2019-03-21', '2019-05-10', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departemen`
--
ALTER TABLE `departemen`
  ADD PRIMARY KEY (`id_dept`),
  ADD KEY `id_p` (`id_p`);

--
-- Indexes for table `kantor`
--
ALTER TABLE `kantor`
  ADD PRIMARY KEY (`id_p`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`nik`),
  ADD KEY `id_dept` (`id_dept`),
  ADD KEY `sup_nik` (`sup_nik`);

--
-- Indexes for table `karyawan_proyek`
--
ALTER TABLE `karyawan_proyek`
  ADD PRIMARY KEY (`id_proj`,`nik`),
  ADD KEY `nik` (`nik`);

--
-- Indexes for table `proyek`
--
ALTER TABLE `proyek`
  ADD PRIMARY KEY (`id_proj`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `departemen`
--
ALTER TABLE `departemen`
  ADD CONSTRAINT `departemen_ibfk_1` FOREIGN KEY (`id_p`) REFERENCES `kantor` (`id_p`);

--
-- Constraints for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `karyawan_ibfk_1` FOREIGN KEY (`id_dept`) REFERENCES `departemen` (`id_dept`),
  ADD CONSTRAINT `karyawan_ibfk_2` FOREIGN KEY (`sup_nik`) REFERENCES `karyawan` (`nik`);

--
-- Constraints for table `karyawan_proyek`
--
ALTER TABLE `karyawan_proyek`
  ADD CONSTRAINT `karyawan_proyek_ibfk_1` FOREIGN KEY (`id_proj`) REFERENCES `proyek` (`id_proj`),
  ADD CONSTRAINT `karyawan_proyek_ibfk_2` FOREIGN KEY (`nik`) REFERENCES `karyawan` (`nik`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;