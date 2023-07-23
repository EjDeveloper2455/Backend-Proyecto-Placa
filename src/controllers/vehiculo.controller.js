import {getConnection} from '../database/database';

const getVehiculos = async(req,res) =>{
    try {
        const connection = await getConnection();
        const result = await connection.query("SELECT * from tbl_vehiculo;");
        res.json(result);
    } catch (error) {
        console.log(error);
        res.send(error);
    }
}

const saveVehiculo = async(req,res) => {
    try{
        const {vin,sucursal,placa,modelo,costo,color,anio,kilometraje} = req.body;
        const connection = await getConnection();
        const result = await connection.query("INSERT INTO `tbl_vehiculo` (`vehiculo_vin`, `sucursal_id`,"+
        "`vehiculo_placa`,`modelo_id`,`vehiculo_costo_renta`,`color_id`,`vehiculo_anio`,`vehiculo_kilometraje`) "+
        "VALUES (?, ?, ?, ?,?, ?, ?, ?); ",[vin,sucursal,placa,modelo,costo,color,anio,kilometraje]);
        if(result){
            res.send({"mensaje":"Se ha guardado exitosamente","Data":result});
        }
    }catch(err){
        console.log(err);
        res.status(500).send(err.message);
    }
};
export const methods = {
    getVehiculos,saveVehiculo
}