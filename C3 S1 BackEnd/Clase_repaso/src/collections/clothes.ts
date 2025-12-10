import {getDB} from "../db/db";
import {CLOTHES_COLLECTION} from "../utils";
import {ObjectId} from "mongodb";


export const getRopa =  async (page?: number, size?: number) =>
{
    const db = getDB();
    page = page || 1;
    size = size || 10;
    return await db.collection(CLOTHES_COLLECTION)
        .find()
        .skip((page - 1) * size)
        .limit(size)
        .toArray();

};

export const getRopaPorID = async (id: string) =>
{
    const db = getDB();
    return await db.collection(CLOTHES_COLLECTION).findOne({_id: new ObjectId(id)});
};

export const crearRopa = async (name: string, size: string, color: string, price: number) =>
{
    const db = getDB();
    const resultado = await db.collection(CLOTHES_COLLECTION).insertOne({
        name,
        size,
        color,
        price
    });
    return await getRopaPorID(resultado.insertedId.toString());
};

export const getRopasPorID = async (ids: Array<string>) =>
{
    const db = getDB();
    const objectIds = ids.map(id => new ObjectId(id));
    return await db.collection(CLOTHES_COLLECTION).find({_id: {$in: objectIds}}).toArray();
}
