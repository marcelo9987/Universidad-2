import {Developer} from "../types/Developer";
import {getDB} from "../db/db";
import {DEVELOPER_COLLECTION} from "../utils";
import {ObjectId} from "mongodb";
import {buscarXogosDoDesarrollador} from "./videogames";


export const crearDeveloper = async (name: string, country?: string, foundedYear?: number): Promise<Developer> =>
{

    const developerCreado=
    {
        name: name,
        ...(country ? {country} : {}),
        ...(typeof foundedYear === "number" ? {foundedYear} : {})
    };

    const db= getDB();

    const resultado_push = await db.collection(DEVELOPER_COLLECTION).insertOne(developerCreado);
    if(resultado_push===null)
    {
        throw new Error("Algo foi mal na creación do desarrollador")
    }

    const id = resultado_push.insertedId;

     const desenvolvedorObtido = await db.collection<Developer>(DEVELOPER_COLLECTION).findOne({_id: id});
     if(!desenvolvedorObtido)
     {
         throw new Error("O desenvolvedor non insertouse con éxito");
     }

     return desenvolvedorObtido;

}

export const obterDeveloperPorId = async (id:string):Promise<Developer> =>
{
    const db= getDB();

    const developerObtido : Developer|null = await db.collection<Developer>(DEVELOPER_COLLECTION).findOne({_id: new ObjectId(id)});
    if(!developerObtido)
    {
        throw new Error("O developer solicitado non foi atopado");
    }
    return developerObtido;
}