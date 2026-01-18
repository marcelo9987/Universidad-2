import {obterXogoPorId} from "./videogames";
import {Game} from "../types/Game";
import {ObjectId} from "mongodb";
import {Review} from "../types/Review";
import {REVIEW_COLLECTION, VIDEOGAME_COLLECTION} from "../utils";
import {getDB} from "../db/db";


export const crearReview = async(userId:string,gameId:string,content:string,rating:number)=>
{
    const xogo :Game= await obterXogoPorId(gameId);

    const review:Review =
        {
            content:content,
            rating:rating,
            author:userId
        };
    const db = getDB();

    const resultadoSubida = await db.collection(REVIEW_COLLECTION).insertOne(review);

    const id:ObjectId = resultadoSubida.insertedId;

    await db.collection(VIDEOGAME_COLLECTION).updateOne({_id:new ObjectId(gameId)},
        {
            $addToSet : {reviews:id}
        })

    return await db.collection<Review>(REVIEW_COLLECTION).findOne({_id:id});

}