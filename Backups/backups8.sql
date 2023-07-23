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


-- Dumping database structure for bd_ej_soft
CREATE DATABASE IF NOT EXISTS `bd_ej_soft` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_ej_soft`;

-- Dumping structure for procedure bd_ej_soft.sp_login
DELIMITER //
CREATE PROCEDURE `sp_login`(in email varchar(45))
BEGIN
	Select u.usuario_email as email,usuario_rol as rol ,u.usuario_password as `password`,
    e.empleado_dni as DNI, concat(e.empleado_nombre,' ',e.empleado_apellido) as nombre,
    DATE_ADD(NOW(), INTERVAL 30 MINUTE) as expiracion,
    e.empleado_url_foto as foto from tbl_usuario u
    inner join tbl_empleado_usuario eu on eu.usuario_email = u.usuario_email
    inner join tbl_empleado e on e.empleado_dni = eu.empleado_dni
    where u.usuario_email = email 
    and u.usuario_estado = 'Activo' and e.empleado_estado = 'Activo';
END//
DELIMITER ;

-- Dumping structure for procedure bd_ej_soft.sp_login_cliente
DELIMITER //
CREATE PROCEDURE `sp_login_cliente`(in email varchar(200))
BEGIN
	Select u.usuario_cliente_email as email,u.usuario_cliente_rol as rol ,
    u.usuario_cliente_password as `password`,
    c.cliente_id as ID, c.cliente_nombre as nombre,
    DATE_ADD(NOW(), INTERVAL 30 MINUTE) as expiracion from tbl_usuario_cliente u
    inner join tbl_cliente_user cu on cu.usuario_cliente_email = u.usuario_cliente_email
    inner join tbl_cliente c on c.cliente_id = cu.cliente_id
    where u.usuario_cliente_email = email 
    and u.usuario_cliente_estado = 'Activo' and c.cliente_estado = 'Activo';
END//
DELIMITER ;

-- Dumping structure for table bd_ej_soft.tbl_ciudad
CREATE TABLE IF NOT EXISTS `tbl_ciudad` (
  `ciudad_id` int NOT NULL AUTO_INCREMENT,
  `ciudad_nombre` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ciudad_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `ciudad_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ciudad_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`ciudad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_ciudad: ~3 rows (approximately)
REPLACE INTO `tbl_ciudad` (`ciudad_id`, `ciudad_nombre`, `ciudad_date_create`, `ciudad_date_update`, `ciudad_estado`) VALUES
	(1, 'San Pedro Sula', '2023-07-17 20:57:38', '2023-07-17 20:57:38', 'Activo'),
	(2, 'La Ceiba', '2023-07-17 20:57:38', '2023-07-17 20:57:38', 'Activo'),
	(3, 'Tegucigalpa', '2023-07-17 20:57:38', '2023-07-17 20:57:38', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_cliente
CREATE TABLE IF NOT EXISTS `tbl_cliente` (
  `cliente_id` int NOT NULL AUTO_INCREMENT,
  `cliente_nombre` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cliente_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cliente_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`cliente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_cliente: ~1 rows (approximately)
REPLACE INTO `tbl_cliente` (`cliente_id`, `cliente_nombre`, `cliente_date_create`, `cliente_date_update`, `cliente_estado`) VALUES
	(1, 'Cliente Web Generico', '2023-07-19 12:51:45', '2023-07-19 12:51:45', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_cliente_user
CREATE TABLE IF NOT EXISTS `tbl_cliente_user` (
  `usuario_cliente_email` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `cliente_id` int NOT NULL,
  PRIMARY KEY (`usuario_cliente_email`,`cliente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_cliente_user: ~1 rows (approximately)
REPLACE INTO `tbl_cliente_user` (`usuario_cliente_email`, `cliente_id`) VALUES
	('ClienteWeb', 1);

-- Dumping structure for table bd_ej_soft.tbl_computadora
CREATE TABLE IF NOT EXISTS `tbl_computadora` (
  `computadora_ip` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `sucursal_id` int NOT NULL,
  `computadora_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `computadora_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `computadora_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`computadora_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_computadora: ~2 rows (approximately)
REPLACE INTO `tbl_computadora` (`computadora_ip`, `sucursal_id`, `computadora_date_create`, `computadora_date_update`, `computadora_estado`) VALUES
	('123456789', 5, '2023-07-18 21:55:59', '2023-07-18 21:56:43', 'Activo'),
	('192.168.112.1', 5, '2023-07-19 01:31:21', '2023-07-19 01:31:21', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_empleado
CREATE TABLE IF NOT EXISTS `tbl_empleado` (
  `empleado_dni` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `empleado_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `empleado_apellido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `empleado_sexo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cargo_id` int DEFAULT NULL,
  `departamento_id` int DEFAULT NULL,
  `empleado_url_foto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `empleado_create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `empleado_update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `empleado_estado` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Activo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_empleado: 1 rows
/*!40000 ALTER TABLE `tbl_empleado` DISABLE KEYS */;
REPLACE INTO `tbl_empleado` (`empleado_dni`, `empleado_nombre`, `empleado_apellido`, `empleado_sexo`, `cargo_id`, `departamento_id`, `empleado_url_foto`, `empleado_create_date`, `empleado_update_date`, `empleado_estado`) VALUES
	('0413199700796', 'ELMER JOHEL', 'MEJIA LEIVA', 'Masculino', 1, 1, 'default.png', '2023-05-22 20:18:41', '2023-05-22 20:18:41', 'Activo');
/*!40000 ALTER TABLE `tbl_empleado` ENABLE KEYS */;

-- Dumping structure for table bd_ej_soft.tbl_empleado_usuario
CREATE TABLE IF NOT EXISTS `tbl_empleado_usuario` (
  `usuario_email` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `empleado_dni` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`usuario_email`,`empleado_dni`),
  CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario_email`) REFERENCES `tbl_usuario` (`usuario_email`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_empleado_usuario: ~1 rows (approximately)
REPLACE INTO `tbl_empleado_usuario` (`usuario_email`, `empleado_dni`) VALUES
	('Elmer', '0413199700796');

-- Dumping structure for table bd_ej_soft.tbl_imagen_vehiculo
CREATE TABLE IF NOT EXISTS `tbl_imagen_vehiculo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vehiculo_vin` varchar(17) COLLATE utf8mb4_general_ci NOT NULL,
  `ruta` text COLLATE utf8mb4_general_ci,
  `date_create` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'now()',
  `date_update` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP',
  `estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_imagen_vehiculo: ~0 rows (approximately)

-- Dumping structure for table bd_ej_soft.tbl_marca
CREATE TABLE IF NOT EXISTS `tbl_marca` (
  `marca_id` int NOT NULL AUTO_INCREMENT,
  `marca_nombre` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `marca_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `marca_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `marca_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`marca_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_marca: ~2 rows (approximately)
REPLACE INTO `tbl_marca` (`marca_id`, `marca_nombre`, `marca_date_create`, `marca_date_update`, `marca_estado`) VALUES
	(1, 'Toyota', '2023-07-04 22:00:00', '2023-07-04 22:00:00', 'Activo'),
	(2, 'Ford', '2023-07-04 22:00:54', '2023-07-04 22:00:54', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_modelo
CREATE TABLE IF NOT EXISTS `tbl_modelo` (
  `modelo_id` int NOT NULL AUTO_INCREMENT,
  `modelo_descripcion` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `marca_id` int NOT NULL,
  `tipo_vehiculo_id` int DEFAULT NULL,
  `modelo_url_imagen` text COLLATE utf8mb4_general_ci,
  `modelo_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `modelo_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modelo_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`modelo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_modelo: ~9 rows (approximately)
REPLACE INTO `tbl_modelo` (`modelo_id`, `modelo_descripcion`, `marca_id`, `tipo_vehiculo_id`, `modelo_url_imagen`, `modelo_date_create`, `modelo_date_update`, `modelo_estado`) VALUES
	(1, 'Corolla', 1, 1, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689641131035_1.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQxMTMyNTk2LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDExMzEwMzVfMS5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQxMTMxMDM1XzEucG5nIiwiaWF0IjoxNjg5NjQxMTMyfQ.rTljdJ__UT0FBZHH0RGDE0QeLjBLIuvv5rIWk4U_i5w', '2023-07-15 19:39:02', '2023-07-17 18:45:32', 'Activo'),
	(2, 'Prado', 1, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689637440821_2.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjM3NDYwODc4LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2Mzc0NDA4MjFfMi5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjM3NDQwODIxXzIucG5nIiwiaWF0IjoxNjg5NjM3NDYwfQ.5xjNXTeCd8YDi1SVmVDWdXbkBQocrceZyRO3v3TpYpc', '2023-07-16 14:21:50', '2023-07-17 18:42:13', 'Activo'),
	(3, 'Escape 2016', 2, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689735579621_3.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NzM1NjA1ODczLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk3MzU1Nzk2MjFfMy5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NzM1NTc5NjIxXzMucG5nIiwiaWF0IjoxNjg5NzM1NjA1fQ.MYV0cLYA1r567DS3Xlsc4BoTNIL6ccODN77pdoWvLTE', '2023-07-16 15:19:50', '2023-07-18 21:00:05', 'Activo'),
	(4, 'Hilux', 1, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689640976815_4.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQwOTkxMTQ1LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDA5NzY4MTVfNC5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQwOTc2ODE1XzQucG5nIiwiaWF0IjoxNjg5NjQwOTkxfQ.Siwyc0-ZcYUi9_ggfeLfJqJ9k56Su7ZVyMS9HB7BooE', '2023-07-16 19:17:49', '2023-07-17 21:09:43', 'Activo'),
	(5, 'Camry', 1, 1, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689641257855_5.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQxMjYwNDExLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDEyNTc4NTVfNS5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQxMjU3ODU1XzUucG5nIiwiaWF0IjoxNjg5NjQxMjYwfQ.WwHc_lro0d5ST9NPB6-P3U7ouhASPf-BKaMb2_7epnA', '2023-07-16 19:44:38', '2023-07-17 18:47:40', 'Activo'),
	(6, 'Ranger', 2, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689641304958_6.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQxMzEwMjA0LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDEzMDQ5NThfNi5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQxMzA0OTU4XzYucG5nIiwiaWF0IjoxNjg5NjQxMzEwfQ.k-i3uXBnKYdoWSfKpGAU2Lcez2-sfw75qbL-sae9ZMk', '2023-07-16 21:53:22', '2023-07-17 18:48:30', 'Activo'),
	(7, 'Everest', 2, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689641339434_7.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQxMzU0OTg2LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDEzMzk0MzRfNy5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQxMzM5NDM0XzcucG5nIiwiaWF0IjoxNjg5NjQxMzU0fQ.Qe7vhJOoJBLgENQbWRqFnJjc8mKqlWSXunGa8XhB7Ck', '2023-07-16 23:07:22', '2023-07-17 18:49:14', 'Activo'),
	(8, 'Explorer', 2, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689641943459_8.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQxOTQ3ODIyLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDE5NDM0NTlfOC5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQxOTQzNDU5XzgucG5nIiwiaWF0IjoxNjg5NjQxOTQ3fQ.dj5XfoCPr_kMIMI8yOuuBvm1UfDLKh6y-IsRYhqaMoU', '2023-07-17 18:58:27', '2023-07-17 18:59:07', 'Activo'),
	(9, 'Hiace', 1, 4, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1689649982156_9.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NjQ5OTk4Njg4LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE2ODk2NDk5ODIxNTZfOS5wbmciLCJidWNrZXRVcmwiOiJwcm9qZWN0LWVqLTE0NzFmLmFwcHNwb3QuY29tIiwiZmlsZU5hbWUiOiIxNjg5NjQ5OTgyMTU2XzkucG5nIiwiaWF0IjoxNjg5NjQ5OTk4fQ.08daICLt1vf13RI1F6QGXVLmrYOx2hj9K3Z70NHi8BA', '2023-07-17 21:13:01', '2023-07-17 21:13:18', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_modelo_imagen
CREATE TABLE IF NOT EXISTS `tbl_modelo_imagen` (
  `modelo_imagen_id` int NOT NULL AUTO_INCREMENT,
  `modelo_id` int NOT NULL,
  `modelo_imagen_ruta` text COLLATE utf8mb4_general_ci,
  `modelo_imagen_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `modelo_imagen_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modelo_imagen_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`modelo_imagen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_modelo_imagen: ~14 rows (approximately)
REPLACE INTO `tbl_modelo_imagen` (`modelo_imagen_id`, `modelo_id`, `modelo_imagen_ruta`, `modelo_imagen_date_create`, `modelo_imagen_date_update`, `modelo_imagen_estado`) VALUES
	(1, 1, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/1.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NDczMDY3NDkzLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzEucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiMS5wbmciLCJpYXQiOjE2ODk0NzMwNjd9.6D4Ht9DxK73m4Nnj6udIUcF-dLsHuyVPQv5KiKr84cY', '2023-07-15 19:57:11', '2023-07-15 20:04:27', 'Activo'),
	(2, 1, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/2.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NDczMzE3NTQxLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzIuanBnIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiMi5qcGciLCJpYXQiOjE2ODk0NzMzMTd9.mGexMSQ4yFzx6sH9Rv-0BmdpmohdXcrrFoH1LBmEh8A', '2023-07-15 20:07:48', '2023-07-15 20:08:37', 'Activo'),
	(3, 1, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/3.webp?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NDczNjE1MjQxLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzMud2VicCIsImJ1Y2tldFVybCI6InByb2plY3QtZWotMTQ3MWYuYXBwc3BvdC5jb20iLCJmaWxlTmFtZSI6IjMud2VicCIsImlhdCI6MTY4OTQ3MzYxNX0.Ql7cti9x6iiBySxWgN1Wz3qZ0dzHF6IMGr0r3v1Zrzw', '2023-07-15 20:12:47', '2023-07-15 20:13:35', 'Activo'),
	(4, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/4.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTU2NzAwNjc0LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzQucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiNC5wbmciLCJpYXQiOjE2ODk1NTY3MDB9.V6clZD0cNo2Ez0EbWrOw8-644sUU7qyYZuZ7lRm3vpw', '2023-07-16 14:21:50', '2023-07-16 19:18:20', 'Activo'),
	(5, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/5.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTU4Mzk2ODMwLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzUucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiNS5wbmciLCJpYXQiOjE2ODk1NTgzOTZ9.VZD9YaZbj91w5Oom3ihgfZ5kIRk5IVIXkE8kn7UKE3Q', '2023-07-16 14:22:04', '2023-07-16 19:46:36', 'Activo'),
	(6, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/6.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTY2Mjc1NDUyLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzYucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiNi5wbmciLCJpYXQiOjE2ODk1NjYyNzV9.5jqmMPBUlNeDrK500dOhtIFZn-Hx5li8U2vHn4u67_0', '2023-07-16 14:22:06', '2023-07-16 21:57:55', 'Activo'),
	(7, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/7.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTM4OTMxMDY4LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzcucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiNy5wbmciLCJpYXQiOjE2ODk1Mzg5MzF9.aisJVwe-F-br7WxcB_rJK5oiVtqOMDTz9mlDCrdUnNg', '2023-07-16 14:22:08', '2023-07-16 14:22:11', 'Activo'),
	(8, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/8.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTM4OTMzNTA3LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzgucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiOC5wbmciLCJpYXQiOjE2ODk1Mzg5MzN9.rx-h_4rOWTGQ9s1AEOij1KTHK1G-IwloKFy9k_1GL1g', '2023-07-16 14:22:11', '2023-07-16 14:22:13', 'Activo'),
	(9, 2, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/9.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTM4OTM1NjQzLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzkucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoiOS5wbmciLCJpYXQiOjE2ODk1Mzg5MzV9.DyFineyyACPClW0dNn3Pq6p90whOLV7Z8a7N6wpl7N0', '2023-07-16 14:22:13', '2023-07-16 14:22:15', 'Activo'),
	(10, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/10.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTQyNDA1MzYxLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzEwLnBuZyIsImJ1Y2tldFVybCI6InByb2plY3QtZWotMTQ3MWYuYXBwc3BvdC5jb20iLCJmaWxlTmFtZSI6IjEwLnBuZyIsImlhdCI6MTY4OTU0MjQwNX0.KiPkAymK5wDcGDaVgDC6BIepM06Bl1hN0DeGQle8Hks', '2023-07-16 15:19:50', '2023-07-16 15:20:05', 'Activo'),
	(11, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/11.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTQyNDA3OTgyLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzExLnBuZyIsImJ1Y2tldFVybCI6InByb2plY3QtZWotMTQ3MWYuYXBwc3BvdC5jb20iLCJmaWxlTmFtZSI6IjExLnBuZyIsImlhdCI6MTY4OTU0MjQwN30.BDkb7et_G-RGeOPBuvDtlf93CnBlNxl3TKnk84DImlc', '2023-07-16 15:20:05', '2023-07-16 15:20:07', 'Activo'),
	(12, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/12.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTQyNDEwMjU3LCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzEyLnBuZyIsImJ1Y2tldFVybCI6InByb2plY3QtZWotMTQ3MWYuYXBwc3BvdC5jb20iLCJmaWxlTmFtZSI6IjEyLnBuZyIsImlhdCI6MTY4OTU0MjQxMH0.BlLPFc_U-_eebH_5xc-7_jy4L-rJcnN7x9Hq5Dv65SY', '2023-07-16 15:20:07', '2023-07-16 15:20:10', 'Activo'),
	(13, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/13.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTQyNDEyMjIyLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzEzLnBuZyIsImJ1Y2tldFVybCI6InByb2plY3QtZWotMTQ3MWYuYXBwc3BvdC5jb20iLCJmaWxlTmFtZSI6IjEzLnBuZyIsImlhdCI6MTY4OTU0MjQxMn0.K9yU16PsZ2cLWQGDfRQdI-QlR5RdGmK1vvnzAS621dQ', '2023-07-16 15:20:10', '2023-07-16 15:20:12', 'Activo'),
	(14, 3, 'https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/modelos/14.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjg5NTQyNDEzODgzLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL21vZGVsb3MvLzE0LnBuZyIsImJ1Y2tldFVybCI6InByb2plY3QtZWotMTQ3MWYuYXBwc3BvdC5jb20iLCJmaWxlTmFtZSI6IjE0LnBuZyIsImlhdCI6MTY4OTU0MjQxM30.soGHncSMsI9pgUwf7w-oFuxO2Z5mgmqg3HPhtArPlcM', '2023-07-16 15:20:12', '2023-07-16 15:20:13', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_parte_vehiculo
CREATE TABLE IF NOT EXISTS `tbl_parte_vehiculo` (
  `parte_vehiculo_id` int NOT NULL AUTO_INCREMENT,
  `vehiculo_vin` varchar(17) COLLATE utf8mb4_general_ci NOT NULL,
  `parte_vehiculo_descripcion` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parte_vehiculo_costo` decimal(9,2) DEFAULT NULL,
  `parte_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `parte_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tbl_parte_vehiculo_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`parte_vehiculo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_parte_vehiculo: ~0 rows (approximately)

-- Dumping structure for table bd_ej_soft.tbl_seguro
CREATE TABLE IF NOT EXISTS `tbl_seguro` (
  `seguro_id` int NOT NULL AUTO_INCREMENT,
  `seguro_tipo` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seguro_empresa` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `seguro_monto_total` decimal(9,2) DEFAULT NULL,
  `seguro_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `seguro_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `seguro_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`seguro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_seguro: ~0 rows (approximately)

-- Dumping structure for table bd_ej_soft.tbl_slider
CREATE TABLE IF NOT EXISTS `tbl_slider` (
  `slider_id` int NOT NULL,
  `slider_texto` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `slider_ruta_imagen` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `slider_prioridad` int DEFAULT NULL,
  `slider_estado` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_slider: 0 rows
/*!40000 ALTER TABLE `tbl_slider` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_slider` ENABLE KEYS */;

-- Dumping structure for table bd_ej_soft.tbl_solicitud
CREATE TABLE IF NOT EXISTS `tbl_solicitud` (
  `solicitud_id` int NOT NULL AUTO_INCREMENT,
  `vehiculo_vin` varchar(17) COLLATE utf8mb4_general_ci NOT NULL,
  `cliente_id` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `solicitud_dni_cliente` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `solicitu_licencia_cliente` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `solicitud_tipo_seguro` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `solicitud_poliza` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `solicitud_empresa_aseguradora` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `solicutud_proceso` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `solicitud_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `solicitud_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `solicitud_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`solicitud_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_solicitud: ~0 rows (approximately)

-- Dumping structure for table bd_ej_soft.tbl_sucursal
CREATE TABLE IF NOT EXISTS `tbl_sucursal` (
  `sucursal_id` int NOT NULL AUTO_INCREMENT,
  `sucursal_descripcion` text COLLATE utf8mb4_general_ci,
  `ciudad_id` int NOT NULL,
  `sucusarl_direccion` text COLLATE utf8mb4_general_ci,
  `sucursal_telefono` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sucursal_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `sucursal_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sucursal_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`sucursal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_sucursal: ~3 rows (approximately)
REPLACE INTO `tbl_sucursal` (`sucursal_id`, `sucursal_descripcion`, `ciudad_id`, `sucusarl_direccion`, `sucursal_telefono`, `sucursal_date_create`, `sucursal_date_update`, `sucursal_estado`) VALUES
	(4, 'Oficina central', 3, 'Col. Miraflores', '87966512', '2023-07-17 21:00:53', '2023-07-17 21:00:53', 'Activo'),
	(5, 'Oficina central', 2, 'Col. La Barra', '97541232', '2023-07-17 21:00:53', '2023-07-17 21:00:53', 'Activo'),
	(6, 'Oficina central', 1, 'Barrio el centro', '33606772', '2023-07-17 21:00:53', '2023-07-17 21:00:53', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_tipo_vehiculo
CREATE TABLE IF NOT EXISTS `tbl_tipo_vehiculo` (
  `tipo_vehiculo_id` int NOT NULL AUTO_INCREMENT,
  `tipo_vehiculo_descripcion` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`tipo_vehiculo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_tipo_vehiculo: ~5 rows (approximately)
REPLACE INTO `tbl_tipo_vehiculo` (`tipo_vehiculo_id`, `tipo_vehiculo_descripcion`) VALUES
	(1, 'Turismo'),
	(2, 'Camioneta'),
	(3, 'Pickup'),
	(4, 'Microbus'),
	(5, 'Minivan');

-- Dumping structure for table bd_ej_soft.tbl_usuario
CREATE TABLE IF NOT EXISTS `tbl_usuario` (
  `usuario_email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_password` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `usuario_rol` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `usuario_create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario_update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_estado` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Activo',
  PRIMARY KEY (`usuario_email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_usuario: 2 rows
/*!40000 ALTER TABLE `tbl_usuario` DISABLE KEYS */;
REPLACE INTO `tbl_usuario` (`usuario_email`, `usuario_password`, `usuario_rol`, `usuario_create_date`, `usuario_update_date`, `usuario_estado`) VALUES
	('Danny', '$2a$10$HGwCJPp65XsBFTopdhYx0OdGDXomnRU0XDkbMWvGrUPc5akqPnM3y', 'Gerente', '2023-05-20 22:05:18', '2023-05-20 22:05:18', 'Activo'),
	('Elmer', '$2a$10$wiI.D1u8rnbxlsQ5scxHkeaM867G.wT2LSIZNa/VJ18sbs2CmIFnG', 'Administrador', '2023-05-20 22:04:35', '2023-05-20 22:04:35', 'Activo');
/*!40000 ALTER TABLE `tbl_usuario` ENABLE KEYS */;

-- Dumping structure for table bd_ej_soft.tbl_usuario_cliente
CREATE TABLE IF NOT EXISTS `tbl_usuario_cliente` (
  `usuario_cliente_email` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_cliente_password` varchar(400) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `usuario_cliente_rol` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `usuario_cliente_create_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario_cliente_update_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_cliente_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`usuario_cliente_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_usuario_cliente: ~1 rows (approximately)
REPLACE INTO `tbl_usuario_cliente` (`usuario_cliente_email`, `usuario_cliente_password`, `usuario_cliente_rol`, `usuario_cliente_create_date`, `usuario_cliente_update_date`, `usuario_cliente_estado`) VALUES
	('ClienteWeb', '$2a$10$r4PqtL/w48zp.PdCzKu9EurMO8bfUPonQTjsAXxIfn3fAdf5UV9V6', 'Cliente', '2023-07-19 12:55:12', '2023-07-19 12:55:12', 'Activo');

-- Dumping structure for table bd_ej_soft.tbl_vehiculo
CREATE TABLE IF NOT EXISTS `tbl_vehiculo` (
  `vehiculo_vin` varchar(17) COLLATE utf8mb4_general_ci NOT NULL,
  `sucursal_id` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vehiculo_placa` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `modelo_id` int NOT NULL,
  `vehiculo_costo_renta` decimal(9,2) DEFAULT NULL,
  `vehiculo_color` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vehiculo_anio` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vehiculo_kilometraje` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vehiculo_date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `vehiculo_date_update` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `vehiculo_estado` varchar(45) COLLATE utf8mb4_general_ci DEFAULT 'Activo',
  PRIMARY KEY (`vehiculo_vin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bd_ej_soft.tbl_vehiculo: ~0 rows (approximately)

-- Dumping structure for function bd_ej_soft.verificar_expiracion
DELIMITER //
CREATE FUNCTION `verificar_expiracion`(fecha DATETIME) RETURNS int
    DETERMINISTIC
BEGIN
  DECLARE resultado INTEGER;
  
  IF now() <= fecha THEN
    SET resultado = 1;
  ELSE
    SET resultado = 0;
  END IF;
  
  RETURN resultado;
END//
DELIMITER ;

-- Dumping structure for view bd_ej_soft.view_modelo
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_modelo` (
	`marca` VARCHAR(45) NULL COLLATE 'utf8mb4_general_ci',
	`modelo` VARCHAR(100) NULL COLLATE 'utf8mb4_general_ci',
	`tipo` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`imagen` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`id` INT(10) NOT NULL,
	`idMarca` INT(10) NOT NULL,
	`idTipo` INT(10) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view bd_ej_soft.view_sucursal
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_sucursal` (
	`ciudad` VARCHAR(45) NULL COLLATE 'utf8mb4_general_ci',
	`sucursal` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`id` INT(10) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view bd_ej_soft.view_modelo
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_modelo`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_modelo` AS select `marca`.`marca_nombre` AS `marca`,`m`.`modelo_descripcion` AS `modelo`,`t`.`tipo_vehiculo_descripcion` AS `tipo`,`m`.`modelo_url_imagen` AS `imagen`,`m`.`modelo_id` AS `id`,`m`.`marca_id` AS `idMarca`,`t`.`tipo_vehiculo_id` AS `idTipo` from ((`tbl_modelo` `m` join `tbl_marca` `marca` on((`marca`.`marca_id` = `m`.`marca_id`))) join `tbl_tipo_vehiculo` `t` on((`t`.`tipo_vehiculo_id` = `m`.`tipo_vehiculo_id`))) where ((`m`.`modelo_estado` = 'Activo') and (`marca`.`marca_estado` = 'Activo')) order by `marca`.`marca_id`;

-- Dumping structure for view bd_ej_soft.view_sucursal
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_sucursal`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_sucursal` AS select `c`.`ciudad_nombre` AS `ciudad`,`s`.`sucursal_descripcion` AS `sucursal`,`s`.`sucursal_id` AS `id` from (`tbl_sucursal` `s` join `tbl_ciudad` `c` on((`c`.`ciudad_id` = `s`.`ciudad_id`))) order by `s`.`sucursal_id`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
