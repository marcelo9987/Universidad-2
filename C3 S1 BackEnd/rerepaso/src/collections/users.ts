import {getDB} from "../db/db";
import {CLOTHES_COLLECTION, K_SALT_NUM, USER_COLLECTION} from "../utils";
import {User} from "../types/User";
import {Db, ObjectId} from "mongodb";
import bcrypt from "bcryptjs";
import {signToken} from "../auth";
import {Clothing} from "../types/Clothing";


const obtenerUsuarioPorId = async(id: string):Promise<User>=>
{
    const db = getDB();
    const usuarioRecuperado :User | null=await db.collection<User>(USER_COLLECTION).findOne({_id:new ObjectId(id)});
    if(!usuarioRecuperado)
    {
        throw new Error("Usuario no encontrado!");
    }
    return usuarioRecuperado
};
export const registrarUsuario = async(email:string, password: string) =>
{
    const db = getDB();

    if(await existeUsuarioPorEmail(email))
    {
        throw new Error("El email ya ha sido registrado previamente");
    }


    const nuevaConstrasenha : string  = await bcrypt.hash(password, K_SALT_NUM);

    const usuarioAInsertar = {
        email:email
        , password:nuevaConstrasenha
        , clothes: []
    }

    const resultadoInserccion = await db.collection(USER_COLLECTION).insertOne(usuarioAInsertar);
    const usuarioInsertado : User =  await obtenerUsuarioPorId(resultadoInserccion.insertedId.toString());
    return usuarioInsertado;
}

const existeUsuarioPorID:(id:ObjectId) => Promise<boolean> = async(id:ObjectId):Promise<boolean> =>
{
    const db:Db = getDB();
    return typeof (await db.collection(USER_COLLECTION).findOne({_id:id}))!==null;
}

const existeUsuarioPorEmail:(email:string) => Promise<boolean> = async(email:string):Promise<boolean> =>
{
    const db:Db = getDB();
    const esCierto : boolean =  (await db.collection(USER_COLLECTION).findOne({email}))!==null;
    return esCierto;
}

export const logarUsuario:(email:string, password:string) => Promise<string> = async(email:string, password:string):Promise<string> =>
{
    if(!(await existeUsuarioPorEmail(email)))
    {
        throw new Error ("El usuario que has intentado logear no existe!");
    }

    const db = getDB();

    const usuario = await db.collection(USER_COLLECTION).findOne({email});
    if (!usuario)
    {
        throw new Error("usuario");
    }

    const contrasenhaValida = await bcrypt.compare(password, usuario.password);
    if (!contrasenhaValida)
    {
        throw new Error("contaseña")
    }

    return signToken(usuario._id.toString());

}

export const comprarRopaUsuario: (id_ropa:string, id_usuario:ObjectId)=> Promise<User> =
    async(id_ropa:string, id_usuario:ObjectId): Promise<User> =>
{
    const db:Db = getDB();
    const hayPrenda :Clothing | null = await db.collection<Clothing>(CLOTHES_COLLECTION).findOne({_id:new ObjectId(id_ropa)});

    if(!hayPrenda)
    {
        throw new Error("La prenda no existe");
    }

    const resultado = await db.collection(USER_COLLECTION).updateOne({_id:id_usuario}, {$addToSet: {clothes:id_ropa}})
    return await obtenerUsuarioPorId(id_usuario.toString());
}