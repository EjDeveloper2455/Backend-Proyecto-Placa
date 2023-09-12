const getTemplate = (destinatario,codigo) => {
    return `
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>

        .encabezado{
            width: 100%;
            height: auto;
            background-color: rgb(32, 37, 42);
            color: white;
            text-align: center;
            padding: 10px;
        }
        h1, h2, p,h3{
            font-family: "Google Sans",Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
        }

        .cuerpo{
            padding: 30px;
        }

        .code{
            text-align: center
        }
        
        .code h2{
            color: rgb(32, 37, 42);;
            font-size: 45px;
        }
        
        .encabezado img{
            width: 20%;
            
        }
    </style>
</head>
<body>
    <div class="contenedor_verificar">
        <div class="encabezado">
            
            <img src="https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/recursos/logo-fastcar.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjkxMTE2MDEyNTQwLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL3JlY3Vyc29zLy9sb2dvLWZhc3RjYXIucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoibG9nby1mYXN0Y2FyLnBuZyIsImlhdCI6MTY5MTExNjAxMn0.hZ8xRdpsvKI7rpHX5tRk_8RGcXXxzAsw5rYg05imsB8" alt="" srcset="">
            
        </div>
        <div class="cuerpo">
            <h1>Alquileres Fastcart</h1>
            <h2>Verifica tu direccion de correo electrónico</h2>
            <p>Hola <b>"${destinatario}"</b>, Estás casi listo para empezar.</p>
            <p>Para completar la creación de su cuenta, solo necesitamos verificar su dirección de correo electrónico:</p>
            <p>Copie el código de verificación y peguelo en el campo de texto indicado para verificar su correo electrónico </p>
            <div class="code">
                <h3>Código de verificación</h3>
                <h2>${codigo}</h2>
                <p>(Este código es válido durante 10 minutos)</p>
            </div>
            
        </div>
    </div>
</body>
    `;
}
const getTemplate2 = (destinatario,titulo,mensaje) => {
    return `
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>

        .encabezado{
            width: 100%;
            height: auto;
            background-color: rgb(32, 37, 42);
            color: white;
            text-align: center;
            padding: 10px;
        }
        h1, h2, p,h3{
            font-family: "Google Sans",Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
        }

        .cuerpo{
            padding: 30px;
        }

        .code{
            text-align: center
        }
        
        .code h2{
            color: rgb(32, 37, 42);;
            font-size: 45px;
        }
        
        .encabezado img{
            width: 20%;
            
        }
    </style>
</head>
<body>
    <div class="contenedor_verificar">
        <div class="encabezado">
            
            <img src="https://storage.googleapis.com/project-ej-1471f.appspot.com/imagenes/recursos/logo-fastcar.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRlIjoxNjkxMTE2MDEyNTQwLCJkaXJlY3RvcnlVcmwiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vcHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImRpcmVjdG9yeSI6ImltYWdlbmVzL3JlY3Vyc29zLy9sb2dvLWZhc3RjYXIucG5nIiwiYnVja2V0VXJsIjoicHJvamVjdC1lai0xNDcxZi5hcHBzcG90LmNvbSIsImZpbGVOYW1lIjoibG9nby1mYXN0Y2FyLnBuZyIsImlhdCI6MTY5MTExNjAxMn0.hZ8xRdpsvKI7rpHX5tRk_8RGcXXxzAsw5rYg05imsB8" alt="" srcset="">
            
        </div>
        <div class="cuerpo">
            <h1>Alquileres Fastcart</h1>
            <h2>${titulo}</h2>
            <p>Hola <b>"${destinatario}"</b>,</p>
            <p>${mensaje}</p>
            
        </div>
    </div>
</body>
    `;
}


export const methods = {
    getTemplate,getTemplate2
}