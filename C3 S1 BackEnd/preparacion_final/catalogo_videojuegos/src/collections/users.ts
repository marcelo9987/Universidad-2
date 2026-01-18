import {getDB} from "../db/db";
import bcrypt from "bcryptjs";
import {USER_COLLECTION} from "../utils";
import {obterXogoPorId} from "./videogames";
import {Game} from "../types/Game";
import {ObjectId} from "mongodb";
import {User} from "../types/User";

export const createUser = async (username:string, email: string, password: string) =>
{
    const db = getDB();

    const contrasenhaEncriptada = await bcrypt.hash(password, 10);

    const resultadoRegistro = await db.collection(USER_COLLECTION).insertOne({
        email: email,
        username:username,
        password: contrasenhaEncriptada,
        library: []

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

export const obterUsuarioPorId=async (id:string):Promise<User> =>
{
    console.log("id:",id)
    const usuario:User | null = await getDB().collection<User>(USER_COLLECTION).findOne({_id:new ObjectId(id)});
    if(!usuario)
    {
        throw new Error("Usuario non atopado");
    }
    return usuario
}



export const usuarioCompraVideojuegoId= async (id_usuario:string,id:string) =>
{
    const xogo: Game|null = await obterXogoPorId(id);

    const db = getDB();

    await db.collection(USER_COLLECTION).updateOne({_id:new ObjectId(id_usuario)},
        {
            $addToSet : {library:id}
        })

    const novoUsuario:User = await obterUsuarioPorId(id_usuario);

    return novoUsuario;

}
