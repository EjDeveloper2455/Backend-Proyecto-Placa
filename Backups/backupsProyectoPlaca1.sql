-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for bd_proyecto_placa
CREATE DATABASE IF NOT EXISTS `bd_proyecto_placa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_proyecto_placa`;

-- Dumping structure for table bd_proyecto_placa.tbl_cliente
CREATE TABLE IF NOT EXISTS `tbl_cliente` (
  `cliente_dni` varchar(45) NOT NULL,
  `cliente_nombre` varchar(45) DEFAULT NULL,
  `cliente_telefono` varchar(45) DEFAULT NULL,
  `cliente_direccion` text,
  `cliente_sexo` varchar(45) DEFAULT NULL,
  `cliente_limite_credito` varchar(45) DEFAULT NULL,
  `cliente_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cliente_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`cliente_dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_cliente: ~0 rows (approximately)

-- Dumping structure for table bd_proyecto_placa.tbl_financiera
CREATE TABLE IF NOT EXISTS `tbl_financiera` (
  `financiera_rtn` varchar(45) NOT NULL,
  `financiera_nombre` varchar(45) DEFAULT NULL,
  `financiera_descripcion` text,
  `financiera_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `financiera_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `financiera_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`financiera_rtn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_financiera: ~0 rows (approximately)

-- Dumping structure for table bd_proyecto_placa.tbl_marca
CREATE TABLE IF NOT EXISTS `tbl_marca` (
  `marca_id` int NOT NULL AUTO_INCREMENT,
  `marca_nombre` varchar(45) DEFAULT NULL,
  `marca_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `marca_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `marca_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`marca_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_marca: ~2 rows (approximately)
REPLACE INTO `tbl_marca` (`marca_id`, `marca_nombre`, `marca_date_create`, `marca_date_update`, `marca_estado`) VALUES
	(1, 'Toyota', '2023-07-23 09:50:32', '2023-07-23 09:50:32', 'Activo'),
	(2, 'Ford', '2023-07-23 09:50:40', '2023-07-23 09:50:40', 'Activo');

-- Dumping structure for table bd_proyecto_placa.tbl_modelo
CREATE TABLE IF NOT EXISTS `tbl_modelo` (
  `modelo_id` int NOT NULL AUTO_INCREMENT,
  `modelo_descripcion` varchar(45) DEFAULT NULL,
  `marca_id` int NOT NULL,
  `tipo_vehiculo_id` int NOT NULL,
  `modelo_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `modelo_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modelo_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`modelo_id`),
  KEY `fk_modelo_marca_idx` (`marca_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_modelo: ~10 rows (approximately)
REPLACE INTO `tbl_modelo` (`modelo_id`, `modelo_descripcion`, `marca_id`, `tipo_vehiculo_id`, `modelo_date_create`, `modelo_date_update`, `modelo_estado`) VALUES
	(1, 'Corolla', 1, 1, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(2, 'Prado', 1, 2, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(3, 'Escape 2016', 2, 2, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(4, 'Hilux', 1, 3, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(5, 'Camry', 1, 1, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(6, 'Ranger', 2, 3, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(7, 'Everest', 2, 2, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(8, 'Explorer', 2, 2, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(9, 'Hiace', 1, 4, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo'),
	(10, 'Nombre prueba', 2, 1, '2023-07-23 10:03:50', '2023-07-23 10:03:50', 'Activo');

-- Dumping structure for table bd_proyecto_placa.tbl_mora
CREATE TABLE IF NOT EXISTS `tbl_mora` (
  `mora_id` int NOT NULL AUTO_INCREMENT,
  `prestamo_id` int NOT NULL,
  `mora_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `mora_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mora_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`mora_id`),
  KEY `fk_prestamo_idx` (`prestamo_id`),
  CONSTRAINT `fk_prestamo` FOREIGN KEY (`prestamo_id`) REFERENCES `tbl_prestamo` (`prestamo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_mora: ~0 rows (approximately)

-- Dumping structure for table bd_proyecto_placa.tbl_prestamo
CREATE TABLE IF NOT EXISTS `tbl_prestamo` (
  `prestamo_id` int NOT NULL AUTO_INCREMENT,
  `cliente_dni` varchar(45) NOT NULL,
  `vehiculo_vin` varchar(45) NOT NULL,
  `financiera_rtn` varchar(45) NOT NULL,
  `prestamo_monto_adeudado` varchar(45) DEFAULT NULL,
  `prestamo_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `prestamo_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `prestamo_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`prestamo_id`),
  KEY `fk_prestamo_cliente_idx` (`cliente_dni`),
  KEY `fk_prestamo_vehiculo_idx` (`vehiculo_vin`),
  KEY `fk_prestamo_financiera_idx` (`financiera_rtn`),
  CONSTRAINT `fk_prestamo_cliente` FOREIGN KEY (`cliente_dni`) REFERENCES `tbl_cliente` (`cliente_dni`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_prestamo_financiera` FOREIGN KEY (`financiera_rtn`) REFERENCES `tbl_financiera` (`financiera_rtn`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_prestamo_vehiculo` FOREIGN KEY (`vehiculo_vin`) REFERENCES `tbl_vehiculo` (`vehiculo_vin`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_prestamo: ~0 rows (approximately)

-- Dumping structure for table bd_proyecto_placa.tbl_tipo_vehiculo
CREATE TABLE IF NOT EXISTS `tbl_tipo_vehiculo` (
  `tipo_vehiculo_id` int NOT NULL AUTO_INCREMENT,
  `tipo_vehiculo_nombre` varchar(45) DEFAULT NULL,
  `tipo_vehiculo_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipo_vehiculo_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tipo_vehiculo_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`tipo_vehiculo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_tipo_vehiculo: ~5 rows (approximately)
REPLACE INTO `tbl_tipo_vehiculo` (`tipo_vehiculo_id`, `tipo_vehiculo_nombre`, `tipo_vehiculo_date_create`, `tipo_vehiculo_date_update`, `tipo_vehiculo_estado`) VALUES
	(1, 'Turismo', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(2, 'Camioneta', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(3, 'Pickup', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(4, 'Microbus', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(5, 'Minivan', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo');

-- Dumping structure for table bd_proyecto_placa.tbl_vehiculo
CREATE TABLE IF NOT EXISTS `tbl_vehiculo` (
  `vehiculo_vin` varchar(45) NOT NULL,
  `vehiculo_placa` varchar(45) NOT NULL,
  `modelo_id` int DEFAULT NULL,
  `vehiculo_color` varchar(45) DEFAULT NULL,
  `vehiculo_motor` varchar(45) DEFAULT NULL,
  `vehiculo_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `vehiculo_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `vehiculo_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`vehiculo_vin`),
  UNIQUE KEY `vehiculo_placa_UNIQUE` (`vehiculo_placa`),
  KEY `fk_vehiculo_modelo_idx` (`modelo_id`),
  CONSTRAINT `fk_vehiculo_modelo` FOREIGN KEY (`modelo_id`) REFERENCES `tbl_modelo` (`modelo_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_vehiculo: ~2 rows (approximately)
REPLACE INTO `tbl_vehiculo` (`vehiculo_vin`, `vehiculo_placa`, `modelo_id`, `vehiculo_color`, `vehiculo_motor`, `vehiculo_date_create`, `vehiculo_date_update`, `vehiculo_estado`) VALUES
	('1234567890', 'MAT8512', 1, 'Negro', 'v6', '2023-07-23 10:04:34', '2023-07-23 10:04:34', 'Activo'),
	('12456875210', 'MAT1234', 2, 'Blanco', 'V6', '2023-07-23 10:05:01', '2023-07-23 10:05:01', 'Activo'),
	('459875210', 'BBS1122', 3, 'Rojo', 'v8', '2023-07-23 10:05:38', '2023-07-23 10:05:38', 'Activo');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
