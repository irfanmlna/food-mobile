-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2024 at 05:04 AM
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
-- Database: `db_food`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_makanan`
--

CREATE TABLE `tb_makanan` (
  `id` int(11) NOT NULL,
  `nama_food` varchar(250) NOT NULL,
  `keterangan` varchar(250) NOT NULL,
  `gambar_food` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_makanan`
--

INSERT INTO `tb_makanan` (`id`, `nama_food`, `keterangan`, `gambar_food`) VALUES
(1, 'Dendeng Balado', 'RP. 59999\r\n\r\nBahan-bahan\r\n500 gr daging lembu\r\n13 buah cabe merah keriting\r\n5 buah cabe rawit ijo\r\n5 siung bawang merah\r\n5 siung bawang putih\r\n1 lembar daun pandan\r\n1/2 sdt kaldu jamur\r\n1/2 sdt garam\r\n1/2 sdt gula pasir\r\n1 buah jeruk nipis\r\n500 ml Mi', 'gambar1.jpg'),
(2, 'Rica Rica Ayam', 'RP. 29999\r\n\r\nBahan-bahan\r\n1/2 ekor ayam\r\n1 ikat kemangi\r\n8 lembar daun jeruk\r\n2 lembar daun salam\r\n1 sereh geprek\r\nLengkuas geprek\r\nulek / blender\r\n16 cabe setan\r\n8 cabe merah\r\n9 bawang merah\r\n5 bawang putih\r\nGula,garam, royko, micin', 'gambar2.jpg'),
(3, 'Soto Padang', 'RP. 59999\r\n\r\nbahan-bahan\r\n500 gr daging sapi\r\nSecukupnya air utk rebusan daging\r\nSecukupnya garam dan kaldu sapi\r\nBumbu halus\r\n10 buah bawang merah\r\n5 siung bawang putih\r\n1 ruas kunyit\r\n1 ruas jahe\r\n1 ruas lengkuas\r\nBumbu aromatik\r\n2 batang serai\r\n1 ', 'gambar3.jpg'),
(4, 'Bakso Sapi Asli', 'RP. 59999\r\n\r\nBahan-bahan\r\n500 gr daging sapi giling halus\r\n1 sdm penuh bawang merah goreng\r\n2 sdm penuh bawang putih goreng\r\n1/2 sdt baking powder\r\n2 sdt garam\r\n1 sdt kaldu bubuk\r\n1 sdt merica bubuk\r\n4 sdm penuh tepung sagu\r\n1 putih telur\r\n120 gr es ', 'gambar4.jpg'),
(5, 'Sate Kambing Goreng', 'RP. 59999\r\n\r\nBahan-bahan\r\n500 g daging kambing, potong dadu\r\n200 ml air kelapa\r\nHaluskan\r\n1 sdt ketumbar\r\n4 btr kemiri\r\n10 btr bawang merah\r\n5 btr bawang putih\r\n1 lembar daun salam, serai, lengkuas', 'gambar5.jpg'),
(6, 'Soto Madura Spesial', 'RP. 59999\r\n\r\nBahan-bahan\r\n1/2 Kg Daging sapi dan Jando\r\nSecukupnya Air putih bersih\r\n2 Lembar Daun Salam\r\n2 Lembar Daun Jeruk\r\n1 Batang Serai Geprek\r\nSecukupnya Garam\r\nSecukupnya Kaldu bubuk (non msg)\r\n1 Sdt Lada Putih Bubuk (opsional jika dirasa kur', 'gambar6.jpg'),
(7, 'Pepes Ikan Layang-layang', 'RP. 59999\r\n\r\nBahan-bahan\r\n1 kg ikan layang-layang\r\n10 siung bawang putih\r\n2 butir kemiri\r\n10 buah cabe rawit (versi pedas sedang)\r\n1/4 kg cabe merah buang bijinya\r\n1/2 kg tomat (campur yang muda dan tua)\r\n10 buah belimbing wuluh (boleh skip)\r\nsecukup', 'gambar7.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tb_order`
--

CREATE TABLE `tb_order` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_food` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_order`
--

INSERT INTO `tb_order` (`id`, `id_user`, `id_food`) VALUES
(1, 1, 1),
(5, 1, 2),
(6, 2, 2),
(7, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id`, `username`, `email`, `address`, `password`) VALUES
(1, 'irfan', 'irfan@gmail.com', 'komp. indah no 12', '202cb962ac59075b964b07152d234b70'),
(2, 'budi', 'budi@gmail.com', 'padang', '202cb962ac59075b964b07152d234b70');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_makanan`
--
ALTER TABLE `tb_makanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_order`
--
ALTER TABLE `tb_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food` (`id_food`),
  ADD KEY `user` (`id_user`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_makanan`
--
ALTER TABLE `tb_makanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tb_order`
--
ALTER TABLE `tb_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_order`
--
ALTER TABLE `tb_order`
  ADD CONSTRAINT `food` FOREIGN KEY (`id_food`) REFERENCES `tb_makanan` (`id`),
  ADD CONSTRAINT `user` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
