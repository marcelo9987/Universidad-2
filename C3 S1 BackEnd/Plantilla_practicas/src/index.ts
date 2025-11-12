import express from "express";
import { conectarMongoDB } from "./mongo";
import rutasAuth from "./routes/auth";
import rutasPatata from "./routes/rutas"
import dotenv from "dotenv";

const PUERTO: number = 3000;

dotenv.config();

conectarMongoDB();

const app = express();
app.use(express.json());
app.use("/auth", rutasAuth);
app.use("/patata", rutasPatata);

app.listen(PUERTO, () => console.log("API en marcha!🎉 Puerto:", PUERTO));