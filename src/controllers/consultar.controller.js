import {getConnection} from '../database/database';

const getConsulta = async(req,res) =>{
    try {
        const {placa} = req.params;
        const connection = await getConnection();
        const result = await connection.query("call sp_consutar_placa(?);",[placa]);
        console.log(result);
        res.json(result[0]);
    } catch (error) {
        console.log(error);
        res.send(error);
    }
}

export const methods = {
    getConsulta
}