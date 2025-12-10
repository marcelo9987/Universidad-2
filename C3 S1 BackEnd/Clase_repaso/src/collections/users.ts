import {getDB} from "../db/db";
import bcrypt from "bcryptjs";
import {USER_COLLECTION} from "../utils";
import {getRopaPorID} from "./clothes";
import {ObjectId} from "mongodb";

export const createUser = async (email: string, password: string) =>
{
    const db = getDB();

    const contrasenhaEncriptada = await bcrypt.hash(password, 10);

    const resultadoRegistro = await db.collection(USER_COLLECTION).insertOne({
        email: email,
        password: contrasenhaEncriptada,
        clothes: []
    });

    return resultadoRegistro.insertedId.toString();

}


export const validateUser = async (email: string, password: string) =>
{
    const db = getDB();

    const usuario = await db.collection(USER_COLLECTION).findOne({email});
    if (!usuario)
    {
        return null;
    }

    const contrasenhaValida = await bcrypt.compare(password, usuario.password);
    if (!contrasenhaValida)
    {
        return null;
    }

    return usuario;

}


export const comprarRopa = async (idRopa: string, idUsuario:string) =>
{
    const db = getDB();

    const ropaAnhadir = await getRopaPorID(idRopa);
    if (!ropaAnhadir)
    {
        throw new Error('Ropa no encontrada');
    }

    await db.collection(USER_COLLECTION).updateOne(
        {_id: new ObjectId(idUsuario)},
        {$addToSet: {clothes: idRopa}}
    );

    const usuarioActualizado = await db.collection(USER_COLLECTION).findOne({_id: new ObjectId(idUsuario)});
    return usuarioActualizado;

}
