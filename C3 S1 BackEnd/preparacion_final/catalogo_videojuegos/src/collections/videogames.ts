import {Game} from "../types/Game";
import {getDB} from "../db/db";
import {VIDEOGAME_COLLECTION} from "../utils";
import {ObjectId} from "mongodb";

export const crearVideogame =
    async (
        title: string,
        price: number,
        genre: string,
        developerId: string,
        description?: string,
        releaseYear ?: number
    ):Promise<Game> =>
    {
        const xogoNovo =
            {
                title: title,
                ...(description? {description}:null),
                price: price,
                ...(releaseYear? {releaseYear}:null),
                genre: genre,
                developer: developerId,
                reviews:[]
            }

        const db= getDB();

        const resultado_push = await db.collection(VIDEOGAME_COLLECTION).insertOne(xogoNovo);
        if(resultado_push===null)
        {
            throw new Error("Algo foi mal na creación do desarrollador")
        }

        const id = resultado_push.insertedId;

        const xogoObtido = await db.collection<Game>(VIDEOGAME_COLLECTION).findOne({_id: id});
        if(!xogoObtido)
        {
            throw new Error("O desenvolvedor non insertouse con éxito");
        }

        return xogoObtido;
    };

export const buscarXogosDoDesarrollador= async (id:string):Promise<Array<Game>> =>
{
    if(!id)
    {
        throw new Error("O id do desarrollador non pode ser nulo");
    }

    const db = getDB();

    const xogosAtopados = await db.collection<Game>(VIDEOGAME_COLLECTION).find({developer: id}).toArray();
    return xogosAtopados;
}

export const obterCatalogoCompleto = async(page:number|null,pageSize:number|null)=>
{
    const db = getDB();
    page=page||1;
    pageSize=pageSize||10;
    return await db.collection<Game>(VIDEOGAME_COLLECTION).find().skip((page-1)*pageSize).limit(pageSize).toArray();
}

export const obterXogoPorId = async(id:string):Promise<Game> =>
{
    const xogo:Game|null =  await getDB().collection<Game>(VIDEOGAME_COLLECTION).findOne({_id:new ObjectId(id)});
    if(!xogo)
    {
        throw new Error("Xogo non atopado");
    }
    return xogo;
}

export const buscarXogosPorIDs = async (ids:Array<string>):Promise<Array<Game>> =>
{
    return await getDB().collection<Game>(VIDEOGAME_COLLECTION).find({_id: {$in:ids.map(data=>new ObjectId(data))}}).toArray();
}

