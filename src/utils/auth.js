import { json } from 'express';
import {getConnection} from '../database/database'
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const SECRET_KEY = 'APIPROYECTOPLACAGENERICKEY';

//Middelware para verificar la autenticacion del token
exports.authenticate = async (req, res, next) => {
    //Se verifica que se llegue un token de autenticacion
    const authHeader = req.headers.authorization;
    if(!authHeader){
        res.status(401).send('El Token es necesario para esta operación');
        return;
    }
    //Se verifica que el token que llega sea del tipo Bearer Token
    const [type, token] = authHeader.split(' ');
    if(type !== 'Bearer'){
        res.status(401).send('Tipo de Autorizacion no valida');
        return;
    }
    
    try{
        //Se decodifica el token
        const decoded = jwt.verify(token, SECRET_KEY);
        
        const {user} = decoded;

        /*Se establece la conexion y consulta para verificar que el usuario 
        que se llega exista en la base de datos*/
        const connection = await getConnection();
         const userData = await connection.query("Select usuario_id as id, usuario_nombre_completo as nombre, "+
         "usuario_email as email,usuario_password as pass, usuario_rol as rol, usuario_estado as estado "+
          "from tbl_usuario where usuario_id = ?;",[user.id]);

        if(userData[0].length>0){
            next();
        }else{
            res.status(401).send('No tienes permiso para realizar esta operación');
            return;
        }
    }catch(err){
        res.status(401).send('Token Inválido');
        return;
    }
}

const signUp = async (req,res) =>{
    try{
        var {nombre,email,password,rol} = req.body;
        nombre = nombre.toUpperCase();
        const salt = await bcrypt.genSalt(10);
        password = await bcrypt.hash(password, salt);
        const connection = await getConnection();
        const result = await connection.query("INSERT INTO `tbl_usuario` (usuario_nombre_completo,`usuario_email`, `usuario_password`, `usuario_rol`) VALUES (?,?, ?, ?); ",[nombre,email,password,rol]);
        if(result){
            const id = result.insertId;
            const payload = {id: id,email: email,nombre: nombre,role: rol};
            
            res.json({id,email,nombre,rol});
        }
    }catch(err){
        console.log(err);
        res.status(500).send(err.message);
    }
};


const login = async(req, res) =>{
    try{
        const {email,password} = req.body;
        const connection = await getConnection();
        const result = await connection.query("Select usuario_id as id, usuario_nombre_completo as nombre, "+
        "usuario_email as email,usuario_password as pass, usuario_rol as rol, usuario_estado as estado "+
         "from tbl_usuario where usuario_email = ?;",[email]);
        if(result.length == 0){
            res.status(401).send('Credenciales incorrecta');
            return;
        }
        
        const isMatch = await bcrypt.compare(password, result[0].pass);
        if(!isMatch){
            res.status(401).send('Credenciales incorrecta');
        }else{
            const user = {"id":result[0].id,"Email": result[0].email,"Rol": result[0].rol,
            "Nombre": result[0].nombre};
            const token = jwt.sign(user, SECRET_KEY);
            console.log(token);
            res.json({user,token});
        }
    }catch(err){
        console.log(err);
        res.status(500).send("login: Hubo un error: " + err);
    }
}

export const methods = {
    signUp,login
}