import {IResolvers} from "@graphql-tools/utils";
import {obtenerBaseDeDatos} from "../db/mongo";
import {ObjectId} from "mongodb";

const nombreColeccion = "Videojuegos";

export const resolvers: IResolvers = {
    Query: {
        videoGames: async () =>
        {
            const db = obtenerBaseDeDatos();
            return db.collection(nombreColeccion).find().toArray();
        },

        videoGame: async (_, {id}) =>
        {
            const db = obtenerBaseDeDatos();
            return db.collection(nombreColeccion).findOne({_id: new ObjectId(id)});
        }
    },

    Mutation: {
        addVideoGame: async (_, {
            name,
            platform,
            date
        }) =>
        {
            const db = obtenerBaseDeDatos();
            const result = await db.collection(nombreColeccion).insertOne({
                name,
                platform,
                date
            });
            return {
                _id: result.insertedId,
                name,
                platform,
                date
            };
        }
    }
};