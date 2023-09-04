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

-- Dumping data for table bd_proyecto_placa.tbl_cliente: ~5 rows (approximately)
INSERT INTO `tbl_cliente` (`cliente_dni`, `cliente_nombre`, `cliente_telefono`, `cliente_direccion`, `cliente_sexo`, `cliente_limite_credito`, `cliente_date_create`, `cliente_date_update`, `cliente_estado`) VALUES
	('0101', 'Fernando Menjivar', '98125463', 'La Ceiba', 'Masculino', '50000', '2023-09-03 19:17:35', '2023-09-03 19:17:35', 'Activo'),
	('0102', 'Maria Castillo', '88741236', 'La Ceiba', 'Femenino', '100000', '2023-09-03 19:18:05', '2023-09-03 19:18:05', 'Activo'),
	('0103', 'Erick Martinez', '87456988', 'SPS', 'Masculino', '70000', '2023-09-03 19:18:38', '2023-09-03 19:18:38', 'Activo'),
	('0104', 'Juan Cuello', '98550022', 'Tegucigalpa', 'Masculino', '150000', '2023-09-03 19:19:32', '2023-09-03 19:19:32', 'Activo'),
	('0105', 'Victor Mendels', '33552496', 'SPS', 'Masculino', '120000', '2023-09-03 19:20:04', '2023-09-03 19:20:04', 'Activo');

-- Dumping data for table bd_proyecto_placa.tbl_financiera: ~3 rows (approximately)
INSERT INTO `tbl_financiera` (`financiera_rtn`, `financiera_nombre`, `financiera_descripcion`, `financiera_date_create`, `financiera_date_update`, `financiera_estado`) VALUES
	('0000000001', 'La curacao S.A.', 'La curacao S.A.', '2023-09-03 19:20:58', '2023-09-03 19:20:58', 'Activo'),
	('0000000002', 'Motomundo', 'Motomundo', '2023-09-03 19:23:17', '2023-09-03 19:23:17', 'Activo'),
	('0000000003', 'Elektra', 'Elektra', '2023-09-03 19:23:45', '2023-09-03 19:23:45', 'Activo');

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

-- Dumping data for table bd_proyecto_placa.tbl_mora: ~3 rows (approximately)
INSERT INTO `tbl_mora` (`mora_id`, `prestamo_id`, `mora_date_create`, `mora_date_update`, `mora_estado`) VALUES
	(1, 1, '2023-09-01 12:00:00', '2023-09-03 19:52:14', 'Activo'),
	(2, 2, '2023-08-25 12:00:00', '2023-09-03 19:52:38', 'Activo'),
	(3, 5, '2023-08-28 12:00:00', '2023-09-03 19:53:04', 'Activo');

-- Dumping data for table bd_proyecto_placa.tbl_prestamo: ~5 rows (approximately)
INSERT INTO `tbl_prestamo` (`prestamo_id`, `cliente_dni`, `vehiculo_vin`, `financiera_rtn`, `prestamo_monto_adeudado`, `prestamo_date_create`, `prestamo_date_update`, `prestamo_estado`) VALUES
	(1, '0101', '1234567890', '0000000001', '30000', '2023-09-03 19:24:41', '2023-09-03 19:24:41', 'Activo'),
	(2, '0102', '12456875210', '0000000002', '50000', '2023-09-03 19:25:09', '2023-09-03 19:25:09', 'Activo'),
	(3, '0103', '459875210', '0000000002', '35000', '2023-09-03 19:25:34', '2023-09-03 19:25:34', 'Activo'),
	(4, '0104', '1111111110', '0000000003', '40000', '2023-09-03 19:26:59', '2023-09-03 19:26:59', 'Activo'),
	(5, '0105', '0000000001', '0000000001', '70000', '2023-09-03 19:28:39', '2023-09-03 19:28:39', 'Activo');

-- Dumping data for table bd_proyecto_placa.tbl_tipo_vehiculo: ~5 rows (approximately)
INSERT INTO `tbl_tipo_vehiculo` (`tipo_vehiculo_id`, `tipo_vehiculo_nombre`, `tipo_vehiculo_date_create`, `tipo_vehiculo_date_update`, `tipo_vehiculo_estado`) VALUES
	(1, 'Turismo', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(2, 'Camioneta', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(3, 'Pickup', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(4, 'Microbus', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(5, 'Minivan', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo');

-- Dumping data for table bd_proyecto_placa.tbl_vehiculo: ~5 rows (approximately)
INSERT INTO `tbl_vehiculo` (`vehiculo_vin`, `vehiculo_placa`, `modelo_id`, `vehiculo_color`, `vehiculo_motor`, `vehiculo_date_create`, `vehiculo_date_update`, `vehiculo_estado`) VALUES
	('0000000001', 'BBS1234', 2, 'Negro', 'v8', '2023-09-03 19:27:47', '2023-09-03 19:27:47', 'Activo'),
	('1111111110', 'BBS1123', 1, 'Rojo', 'v6', '2023-09-03 19:26:06', '2023-09-03 19:26:06', 'Activo'),
	('1234567890', 'MAT8512', 1, 'Negro', 'v6', '2023-07-23 10:04:34', '2023-07-23 10:04:34', 'Activo'),
	('12456875210', 'MAT1234', 2, 'Blanco', 'V6', '2023-07-23 10:05:01', '2023-07-23 10:05:01', 'Activo'),
	('459875210', 'BBS1122', 3, 'Rojo', 'v8', '2023-07-23 10:05:38', '2023-07-23 10:05:38', 'Activo');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
