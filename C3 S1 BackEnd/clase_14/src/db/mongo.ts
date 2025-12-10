import {Db, MongoClient} from "mongodb";
import dotenv from "dotenv";

dotenv.config();

let client: MongoClient;

let bbbdd: Db;

const dbName = "VideoGames";

export const conectarBaseDeDatos = async () =>
{
    try
    {
        const mongoUrl = `mongodb+srv://${process.env.USER_MONGO}:${process.env.USER_PASSWORD}@${process.env.MONGO_CLUSTER}.irzyluw.mongodb.net/?appName=${process.env.MONGO_APP_NAME}`;
        client = new MongoClient(mongoUrl);
        await client.connect();
        bbbdd = client.db(dbName);
        console.log("Has conseguido conectarte a la base de datos " + dbName);

    }
    catch (err)
    {
        console.error("Error al conectar con la base de datos: ", err);
    }
};

export const obtenerBaseDeDatos = (): Db => bbbdd;

export const cerrarConexionBaseDeDatos = async (): Promise<void> =>
{

    try
    {
        client && await client.close();
    }
    catch (err)
    {
        console.error("Error al cerrar la conexión: ", err);
    }
};