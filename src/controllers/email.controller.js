import { createTransport } from 'nodemailer';
import {getConnection} from '../database/database';
import {methods as template} from './../html/verificarTemplate';

// Configura el transporte de correo electrónico
const transporter = createTransport({
  service: 'Gmail',
  auth: {
    user: 'alquileresfastcar55@gmail.com', // Reemplaza con tu dirección de correo electrónico
    pass: 'ylhtdvhqojxvrqcn' // Reemplaza con tu contraseña de correo electrónico
  },tls: {
    rejectUnauthorized: false
  }
});

const generarCodigo = () =>{
  var cadena = "";
  for (let i = 0; i < 6; i++) {
    cadena += Math.round(Math.random() * (9 - 0) + 0)+"";
  }
  return cadena;
}

const verificarEmail = async(req,res) =>{
  try {
    const {codigo,destinatario} = req.params;
    const connection = await getConnection();
    const result = await connection.query("SELECT id from tbl_codigo where codigo = ? "+
    "and destinatario = ? and DATE_ADD(fecha, INTERVAL 10 MINUTE) > now();",[codigo,destinatario]);
    console.log(result.length);
    var respuesta = {"res":"no"}
    if(result.length > 0)respuesta.res = 'ok';
     res.json(respuesta);
  } catch (error) {
    res.status(500).send(error);
  }
  
};

const enviarConfirmacion = async(req,res) =>{
  const {destinatario} = req.body;
  
  var sigue = true;
  var random = '';

  const connection = await getConnection();
  while(sigue){
    random = generarCodigo();
    const result = await connection.query("SELECT id from tbl_codigo where codigo = ?;",[random]);
    if(result.length == 0)sigue = false;
  }
  const resultInsert = await connection.query("INSERT INTO `tbl_codigo` (`codigo`,`destinatario`) VALUES (?,?); ",[random,destinatario]);
  const enviar = await sendEmail(destinatario,"Verificación del correo electrónico de tu cuenta de Alquileres Fastcar",
  "Su correo de verificacion es: "+random,template.getTemplate(destinatario,random));
  var respuesta = {"res":"Se envio correctamente"}
  res.json(respuesta);
}

const enviarEmail = async(req,res) =>{
  try{
    const {destinatario,titulo,mensaje} = req.body;

    const enviar = await sendEmail(destinatario,titulo,mensaje,template.getTemplate2(destinatario,titulo,mensaje));
    var respuesta = {"res":"Se envio correctamente"}
    res.json(respuesta);
  }catch(error){
    res.status(500).send("No se envio el mensaje");
  }
}

const sendEmail = async(destinatario,titulo,mensaje,plantilla) =>{
    const mailOptions = {
    from: 'Alquileres Fastcar', // Reemplaza con tu dirección de correo electrónico
    to: destinatario, // Reemplaza con la dirección de correo electrónico del destinatario
    subject: titulo,
    text: mensaje,
    html: plantilla
    };

    // Envía el correo electrónico
    transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
        console.log('Error al enviar el correo:', error);
        return 'Error al enviar el correo:'+ error;
    } else {
        return "Correo enviado correctamente "+info.response;
    }
    });
}

export const methods = {
    sendEmail,enviarConfirmacion,verificarEmail,enviarEmail
}


