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

-- Dumping structure for function bd_proyecto_placa.consultar_mora
DELIMITER //
CREATE FUNCTION `consultar_mora`(id int) RETURNS varchar(12) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE dias_restantes varchar(12);

  SET dias_restantes = 'Sin mora';
  
	SELECT concat(DATEDIFF(CURDATE(), mora_date_create),'') INTO dias_restantes
	FROM tbl_mora WHERE prestamo_id = id;

  RETURN dias_restantes;
END//
DELIMITER ;

-- Dumping structure for procedure bd_proyecto_placa.consutar_placa
DELIMITER //
CREATE PROCEDURE `consutar_placa`(IN placa varchar(7))
BEGIN
  Select v.vehiculo_placa as placa, ma.marca_nombre as marca, mo.modelo_descripcion as modelo,
  v.vehiculo_color as color, v.vehiculo_motor as motor, v.vehiculo_vin,fi.financiera_nombre as nombre, 
  pre.prestamo_id as no_prestamo, cli.cliente_dni as dni,cli.cliente_nombre as nombre, 
  pre.prestamo_estado as estado, pre.prestamo_monto_adeudado as monto, consultar_mora(pre.prestamo_id) as mora
  from tbl_prestamo pre 
  inner join tbl_vehiculo v on v.vehiculo_vin = pre.vehiculo_vin 
  inner join tbl_modelo mo on v.modelo_id = mo.modelo_id
  inner join tbl_marca ma on mo.marca_id = ma.marca_id
  inner join tbl_financiera fi on pre.financiera_rtn = fi.financiera_rtn
  inner join tbl_cliente cli on pre.cliente_dni = cli.cliente_dni
  where v.vehiculo_placa = 'MAT1234';
END//
DELIMITER ;

-- Dumping structure for procedure bd_proyecto_placa.sp_consutar_placa
DELIMITER //
CREATE PROCEDURE `sp_consutar_placa`(IN placa varchar(7))
BEGIN
  Select v.vehiculo_placa as placa, ma.marca_nombre as marca, mo.modelo_descripcion as modelo,
  v.vehiculo_color as color, v.vehiculo_motor as motor, v.vehiculo_vin as vin,fi.financiera_nombre as financiera, 
  pre.prestamo_id as no_prestamo, cli.cliente_dni as dni,cli.cliente_nombre as cliente, 
  pre.prestamo_estado as estado, pre.prestamo_monto_adeudado as montoadeudado, consultar_mora(pre.prestamo_id) as dias_mora
  from tbl_prestamo pre 
  inner join tbl_vehiculo v on v.vehiculo_vin = pre.vehiculo_vin 
  inner join tbl_modelo mo on v.modelo_id = mo.modelo_id
  inner join tbl_marca ma on mo.marca_id = ma.marca_id
  inner join tbl_financiera fi on pre.financiera_rtn = fi.financiera_rtn
  inner join tbl_cliente cli on pre.cliente_dni = cli.cliente_dni
  where v.vehiculo_placa = placa;
END//
DELIMITER ;

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

-- Dumping data for table bd_proyecto_placa.tbl_cliente: ~4 rows (approximately)
INSERT INTO `tbl_cliente` (`cliente_dni`, `cliente_nombre`, `cliente_telefono`, `cliente_direccion`, `cliente_sexo`, `cliente_limite_credito`, `cliente_date_create`, `cliente_date_update`, `cliente_estado`) VALUES
	('0101', 'Fernando Menjivar', '98125463', 'La Ceiba', 'Masculino', '50000', '2023-09-03 19:17:35', '2023-09-03 19:17:35', 'Activo'),
	('0102', 'Maria Castillo', '88741236', 'La Ceiba', 'Femenino', '100000', '2023-09-03 19:18:05', '2023-09-03 19:18:05', 'Activo'),
	('0103', 'Erick Martinez', '87456988', 'SPS', 'Masculino', '70000', '2023-09-03 19:18:38', '2023-09-03 19:18:38', 'Activo'),
	('0104', 'Juan Cuello', '98550022', 'Tegucigalpa', 'Masculino', '150000', '2023-09-03 19:19:32', '2023-09-03 19:19:32', 'Activo'),
	('0105', 'Victor Mendels', '33552496', 'SPS', 'Masculino', '120000', '2023-09-03 19:20:04', '2023-09-03 19:20:04', 'Activo');

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

-- Dumping data for table bd_proyecto_placa.tbl_financiera: ~2 rows (approximately)
INSERT INTO `tbl_financiera` (`financiera_rtn`, `financiera_nombre`, `financiera_descripcion`, `financiera_date_create`, `financiera_date_update`, `financiera_estado`) VALUES
	('0000000001', 'La curacao S.A.', 'La curacao S.A.', '2023-09-03 19:20:58', '2023-09-03 19:20:58', 'Activo'),
	('0000000002', 'Motomundo', 'Motomundo', '2023-09-03 19:23:17', '2023-09-03 19:23:17', 'Activo'),
	('0000000003', 'Elektra', 'Elektra', '2023-09-03 19:23:45', '2023-09-03 19:23:45', 'Activo');

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
INSERT INTO `tbl_marca` (`marca_id`, `marca_nombre`, `marca_date_create`, `marca_date_update`, `marca_estado`) VALUES
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_mora: ~2 rows (approximately)
INSERT INTO `tbl_mora` (`mora_id`, `prestamo_id`, `mora_date_create`, `mora_date_update`, `mora_estado`) VALUES
	(1, 1, '2023-09-01 12:00:00', '2023-09-03 19:52:14', 'Activo'),
	(2, 2, '2023-08-25 12:00:00', '2023-09-03 19:52:38', 'Activo'),
	(3, 5, '2023-08-28 12:00:00', '2023-09-03 19:53:04', 'Activo');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_prestamo: ~4 rows (approximately)
INSERT INTO `tbl_prestamo` (`prestamo_id`, `cliente_dni`, `vehiculo_vin`, `financiera_rtn`, `prestamo_monto_adeudado`, `prestamo_date_create`, `prestamo_date_update`, `prestamo_estado`) VALUES
	(1, '0101', '1234567890', '0000000001', '30000', '2023-09-03 19:24:41', '2023-09-03 19:24:41', 'Activo'),
	(2, '0102', '12456875210', '0000000002', '50000', '2023-09-03 19:25:09', '2023-09-03 19:25:09', 'Activo'),
	(3, '0103', '459875210', '0000000002', '35000', '2023-09-03 19:25:34', '2023-09-03 19:25:34', 'Activo'),
	(4, '0104', '1111111110', '0000000003', '40000', '2023-09-03 19:26:59', '2023-09-03 19:26:59', 'Activo'),
	(5, '0105', '0000000001', '0000000001', '70000', '2023-09-03 19:28:39', '2023-09-03 19:28:39', 'Activo');

-- Dumping structure for table bd_proyecto_placa.tbl_registro
CREATE TABLE IF NOT EXISTS `tbl_registro` (
  `registro_id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `placa` varchar(45) DEFAULT NULL,
  `registro_status` int DEFAULT NULL,
  `registro_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `registro_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `registro_estado` varchar(45) DEFAULT 'Activo',
  PRIMARY KEY (`registro_id`),
  KEY `fk_registro_usuario_idx` (`usuario_id`),
  CONSTRAINT `fk_registro_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `tbl_usuario` (`usuario_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_registro: ~1 rows (approximately)
INSERT INTO `tbl_registro` (`registro_id`, `usuario_id`, `placa`, `registro_status`, `registro_date_create`, `registro_date_update`, `registro_estado`) VALUES
	(1, 1, 'MAT1234', 200, '2023-09-06 19:06:09', '2023-09-06 19:06:09', 'Activo');

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
INSERT INTO `tbl_tipo_vehiculo` (`tipo_vehiculo_id`, `tipo_vehiculo_nombre`, `tipo_vehiculo_date_create`, `tipo_vehiculo_date_update`, `tipo_vehiculo_estado`) VALUES
	(1, 'Turismo', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(2, 'Camioneta', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(3, 'Pickup', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(4, 'Microbus', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo'),
	(5, 'Minivan', '2023-07-23 09:57:37', '2023-07-23 09:57:37', 'Activo');

-- Dumping structure for table bd_proyecto_placa.tbl_usuario
CREATE TABLE IF NOT EXISTS `tbl_usuario` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `usuario_nombre_completo` varchar(100) NOT NULL,
  `usuario_email` varchar(200) NOT NULL,
  `usuario_password` varchar(200) NOT NULL DEFAULT '12345678',
  `usuario_rol` varchar(45) NOT NULL,
  `usuario_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_estado` varchar(45) DEFAULT 'Sin verificar',
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `usuario_email_UNIQUE` (`usuario_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table bd_proyecto_placa.tbl_usuario: ~1 rows (approximately)
INSERT INTO `tbl_usuario` (`usuario_id`, `usuario_nombre_completo`, `usuario_email`, `usuario_password`, `usuario_rol`, `usuario_date_create`, `usuario_date_update`, `usuario_estado`) VALUES
	(1, 'ELMER JOHEL MEJIA', 'elmerjmejia55@gmail.com', '$2a$10$28i8eCoyk57LbnaI4LWqdOY7PK9Y1kK5sgZJt8wxCjwdvx1kKAQ4O', 'Administrador', '2023-09-06 18:30:00', '2023-09-06 18:30:00', 'Sin verificar');

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
