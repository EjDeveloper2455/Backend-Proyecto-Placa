import express from 'express';
import morgan from 'morgan';
import vehiculoRoutes from './routes/vehiculo.routes';

const app = express();


app.set('port',8080);

//Middlewares
app.use(morgan('dev'));
app.use(express.json());
//Rutes
app.use("/api/vehiculo/",vehiculoRoutes);
app.get("/api/confirm/",(req,res)=>{
    res.send("El servidor esta corriendo");
});


export default app;