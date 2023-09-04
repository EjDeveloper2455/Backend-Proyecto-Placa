/*Crear procedimiento almacenado para consultar la placa del vehiculo*/

drop PROCEDURE consutar_placa;

DELIMITER //

CREATE PROCEDURE consutar_placa(IN placa varchar(7))
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
END;
//
DELIMITER ;

/*Crear funcion para ver si tiene dia de mora*/

Select consultar_mora(3);

Drop function consultar_mora;

DELIMITER $$
CREATE FUNCTION consultar_mora(id int)
RETURNS varchar(12)
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE dias_restantes varchar(12);

  SET dias_restantes = 'Sin mora';
  
	SELECT concat(DATEDIFF(CURDATE(), mora_date_create),'') INTO dias_restantes
	FROM tbl_mora WHERE prestamo_id = id;

  RETURN dias_restantes;
END;
$$
DELIMITER ;


