import express from "express";
import {connectMongoDB} from "./mongo";
import enrutadorPersonas from "./routes"
import dotenv from "dotenv";

dotenv.config();

connectMongoDB();

const app = express();
app.use(express.json());
app.use("/api/personas",enrutadorPersonas)
//RUTAS
//FIN RUTAS

app.listen(3000,()=>"API iniciada");

