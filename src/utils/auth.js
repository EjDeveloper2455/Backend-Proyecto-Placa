import { json } from 'express';
import {getConnection} from '../database/database'
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const SECRET_KEY = 'APIPROYECTOPLACAGENERICKEY';

//Middelware para verificar la autenticacion del token
const authenticate = async (req, res, next) => {
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
        const user = jwt.verify(token, SECRET_KEY);
        
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
        var {email,password} = req.body;
        email = email.trim();
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
            const user = {"id":result[0].id,"email": result[0].email,"rol": result[0].rol,
            "nombre": result[0].nombre,"estado":result[0].estado};
            const payload = user;
            const token = jwt.sign(payload, SECRET_KEY);
            console.log(user);
            res.json({user,token});
        }
    }catch(err){
        console.log(err);
        res.status(500).send("login: Hubo un error: " + err);
    }
}

const restablecerVerificar = async(req, res) =>{
    try{
        var {id,password} = req.body;
        const salt = await bcrypt.genSalt(10);
        password = await bcrypt.hash(password, salt);
        const connection = await getConnection();
        const result = await connection.query("UPDATE `tbl_usuario` SET `usuario_password` = ?, `usuario_estado` = 'Verificado' WHERE (`usuario_id` = ?); ",[password,id]);
        if(result){
            const result = await connection.query("Select usuario_id as id, usuario_nombre_completo as nombre, "+
        "usuario_email as email,usuario_password as pass, usuario_rol as rol, usuario_estado as estado "+
         "from tbl_usuario where usuario_id = ?;",[id]);
         if(result.length>0){
            const user = {id: id,email: result[0].email,nombre: result[0].nombre,role: result[0].rol,estado: result[0].estado};
            const payload = user;
            const token = jwt.sign(payload, SECRET_KEY);
            res.json({user,token});
         }else res.status(401).send('Ha ocurrido un error en el servidor');
            
        }else res.status(401).send('Ha ocurrido un error en el servidor');
    }catch(err){
        console.log(err);
        res.status(500).send(err.message);
    }
}

const verifyToken = async(req, res)=>{
    try{
        const {token} = req.params;
        //Se decodifica el token
        const user = jwt.verify(token, SECRET_KEY);

        /*Se establece la conexion y consulta para verificar que el usuario 
        que se llega exista en la base de datos*/
        const connection = await getConnection();
         const userData = await connection.query("Select *"+
          "from tbl_usuario where usuario_id = ?;",[user.id]);
          console.log(userData);

        if(userData.length>0){
            res.send('Token válido');
        }else{
            res.status(401).send('No tienes permiso para realizar esta operación');
            return;
        }
    }catch(err){
        console.log("Error al verificar "+err);
        res.status(401).send('Token Inválido');
        return;
    }
    
};
const decodedToken = async(req, res)=>{
    try{
        const {token} = req.params;
        //Se decodifica el token
        const user = jwt.verify(token, SECRET_KEY);
        console.log(user);

        /*Se establece la conexion y consulta para verificar que el usuario 
        que se llega exista en la base de datos*/
        const connection = await getConnection();
        const result = await connection.query("Select usuario_id as id, usuario_nombre_completo as nombre, "+
        "usuario_email as email,usuario_password as pass, usuario_rol as rol, usuario_estado as estado "+
         "from tbl_usuario where usuario_id = ?;",[user.id]);
         console.log(result);
        if(result.length>0){
            res.json({user});
        }else{
            
            res.status(401).send('No tienes permiso para realizar esta operación');
            return;
        }
    }catch(err){
        console.log("Error al decodificar "+err);
        res.status(401).send('Token Inválido');
        return;
    }
    
};

export const methods = {
    signUp,login,authenticate,verifyToken,decodedToken,restablecerVerificar
}