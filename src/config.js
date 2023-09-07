import {config} from 'dotenv'
//PASSWORD = dbAppPlaca-123

config();
//console.log(process.env.HOST+" - "+process.env.DATABASE+" - "+process.env.USER+" - "+process.env.PASSWORD);
export default {
    host: process.env.HOST || "",
    database: process.env.DATABASE || "",
    user: "root",
    password: process.env.PASSWORD || ""
}