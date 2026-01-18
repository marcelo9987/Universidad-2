import {Clothing} from "../types/Clothing";
import {Db, ObjectId} from "mongodb";
import {getDB} from "../db/db";
import {CLOTHES_COLLECTION} from "../utils";

export const insertarPrendaSinId: (clothing: Clothing) => Promise<Clothing> = async (clothing:Clothing):Promise<Clothing> =>
{
    if(!clothing)
    {
        throw new Error("EEEPA! no me has mandado la prenda a subir!");
    }

    const db:Db = getDB();
    const nuevaPrendaId = await db.collection(CLOTHES_COLLECTION).insertOne(clothing);

    const prendaSubida = await db.collection<Clothing>(CLOTHES_COLLECTION).findOne({_id:nuevaPrendaId.insertedId});
    if(!prendaSubida)
    {
        throw new Error("Fallo en la inserción!");
    }
    return prendaSubida;
}

export const obtenerPrendaPorId :(id:string)=> Promise<Clothing> = async(id:string):Promise<Clothing> =>
{
    if (!id)
    {
        throw new Error("Ey, necesito que la id sea una cadena como mínimo");
    }

    const db :Db = getDB();

    const resultadoConsulta : Clothing | null= await db.collection<Clothing>(CLOTHES_COLLECTION).findOne({_id:new ObjectId(id)});
    if(!resultadoConsulta)
    {
        throw new Error("La prenda que buscas no está en nuestros almacenes");
    }

    return resultadoConsulta;
}

export const obtenerPrendasPorIDs :(ids:Array<string>)=>Promise<Array<Clothing>> = async(ids:Array<string>):Promise<Array<Clothing>> =>
{
    if (!ids)
    {
        throw new Error("Ey, necesito que las ids sean válidas");
    }

    const arrOIDs:Array<ObjectId> = ids.map((oid:string)=>new ObjectId(oid))
    const db:Db = getDB();
    const prendas: Array<Clothing> = await db.collection<Clothing>(CLOTHES_COLLECTION).find({_id:{$in:arrOIDs}}).toArray();
    return prendas;
}
export const obtenerTodasLasPrendas:() => Promise<Array<Clothing>> = async():Promise<Array<Clothing>> =>
{
    return await getDB().collection<Clothing>(CLOTHES_COLLECTION).find().toArray();
}
