import {getConnection} from '../database/database';

const getRegistroByUser = async(req,res) =>{
    try {
        const {user} = req.params;
        const connection = await getConnection();
        const result = await connection.query("SELECT placa, registro_status as status, "
        +"DATE_FORMAT(registro_date_create, '%Y-%m-%d %h:%i:%s %p') as fecha "+
        "FROM tbl_registro where usuario_id = ?;",[user]);
        console.log(result);
        res.json(result[0]);
    } catch (error) {
        console.log(error);
        res.send(error);
    }
};

const saveRegistro = async(req,res) => {
    try{
        const {usuario,placa,status} = req.body;
        const connection = await getConnection();
        const result = await connection.query("INSERT INTO `tbl_registro` (`usuario_id`, `placa`, `registro_status`) VALUES (?, ?, ?);",[usuario,placa,status]);
        if(result){
            res.send({"mensaje":"Se ha guardado exitosamente","Data":result});
        }else {
            res.status(500).send("Ha ocurrido un error al intentar guardar el registro");
        }
    }catch(err){
        console.log(err);
        res.status(500).send(err.message);
    }
};

export const methods = {
    getRegistroByUser,saveRegistro
};