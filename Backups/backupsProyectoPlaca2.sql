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

-- Dumping data for table bd_proyecto_placa.tbl_cliente: ~0 rows (approximately)

-- Dumping data for table bd_proyecto_placa.tbl_financiera: ~0 rows (approximately)

-- Dumping data for table bd_proyecto_placa.tbl_marca: ~2 rows (approximately)
INSERT INTO `tbl_marca` (`marca_id`, `marca_nombre`, `marca_date_create`, `marca_date_update`, `marca_estado`) VALUES
	(1, 'Toyota', '2023-07-23 09:50:32', '2023-07-23 09:50:32', 'Activo'),
	(2, 'Ford', '2023-07-23 09:50:40', '2023-07-23 09:50:40', 'Activo');

-- Dumping data for table bd_proyecto_placa.tbl_modelo: ~10 rows (approximately)
INSERT INTO `tbl_modelo` (`modelo_id`, `modelo_descripcion`, `marca_id`, `tipo_vehiculo_id`, `modelo_date_create`, `modelo_date_update`, `modelo_estado`) VALUES
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

-- Dumping data for table bd_proyecto_placa.tbl_mora: ~0 rows (approximately)

-- Dumping data for table bd_proyecto_placa.tbl_prestamo: ~0 rows (approximately)

-- Dumping data for table bd_proyecto_placa.tbl_tipo_vehiculo: ~5 rows (approximately)
INSERT INTO `tbl_tipo_vehiculo` (`tipo_vehiculo_id`, `tipo_vehiculo_nombre`, `tipo_vehiculo_date_create`, `tipo_vehiculo_date_update`, `tipo_vehiculo_estado`) VALUES
	(1, 'Turismo', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(2, 'Camioneta', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(3, 'Pickup', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(4, 'Microbus', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(5, 'Minivan', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo');

-- Dumping data for table bd_proyecto_placa.tbl_vehiculo: ~2 rows (approximately)
INSERT INTO `tbl_vehiculo` (`vehiculo_vin`, `vehiculo_placa`, `modelo_id`, `vehiculo_color`, `vehiculo_motor`, `vehiculo_date_create`, `vehiculo_date_update`, `vehiculo_estado`) VALUES
	('1234567890', 'MAT8512', 1, 'Negro', 'v6', '2023-07-23 10:04:34', '2023-07-23 10:04:34', 'Activo'),
	('12456875210', 'MAT1234', 2, 'Blanco', 'V6', '2023-07-23 10:05:01', '2023-07-23 10:05:01', 'Activo'),
	('459875210', 'BBS1122', 3, 'Rojo', 'v8', '2023-07-23 10:05:38', '2023-07-23 10:05:38', 'Activo');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
