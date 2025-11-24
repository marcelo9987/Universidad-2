import {obtenerDB} from "../mongo";
import {ObjectId} from "mongodb";
import { IResolvers } from "@graphql-tools/utils";


export const resolvers:IResolvers = {
    Query:
    {
        videoGames : async () =>
        {
            const db = obtenerDB();
            return await db.collection("videoGames").find().toArray();
        },
        videoGame : async (_, {id}) =>
            {
                const db = obtenerDB();
                return await db.collection("videoGames").findOne({_id: new ObjectId(id});
            }

    }
    , Mutation:
        {
            addVideoGame: async (_,{name,platform,date}) =>
            {
                const db = obtenerDB();
                const newVideoGame = {
                    name,
                    platform,
                    date
                };
                const result = await db.collection("videoGames").insertOne(newVideoGame);
                return {
                    _id: result.insertedId,
                    ...newVideoGame
                }
        }
}