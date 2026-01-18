import {IResolvers} from "@graphql-tools/utils";
import {createUser, obterUsuarioPorId, usuarioCompraVideojuegoId, validateUser} from "../collections/users";
import {signToken} from "../auth";
import {getDB} from "../db/db";
import {ObjectId} from "mongodb";
import {crearDeveloper, obterDeveloperPorId} from "../collections/developers";
import {
    buscarXogosDoDesarrollador,
    buscarXogosPorIDs,
    crearVideogame,
    obterCatalogoCompleto
} from "../collections/videogames";
import {Developer} from "../types/Developer";
import {DEVELOPER_COLLECTION, REVIEW_COLLECTION} from "../utils";
import {Game} from "../types/Game";
import {User} from "../types/User";
import {crearReview} from "../collections/reviews";

const checkContext = (contexto: any, razon: string) =>
{
    if (!contexto.user)
    {
        throw new Error("Error, tienes que estar logueado para: " + razon);
    }
};

export const resolvers: IResolvers =
    {
        Game: {
            developer: async (parent, __, ___) =>
            {
                const db = getDB();
                const id = parent.developer;
                if (!id)
                {
                    throw new Error("tu tia");
                }
                return db.collection<Developer>(DEVELOPER_COLLECTION).findOne({_id: new ObjectId(id)});
            },
            reviews: async(parent:Game,__,___) =>
            {
                const db = getDB();
                if(!parent.reviews)
                {
                    parent.reviews=[]
                }
                const oids= parent.reviews.map((id:string)=>new ObjectId(id))
                return await db.collection(REVIEW_COLLECTION).find({_id:{$in:oids}}).toArray()
            },
        },
        Developer:
        {
            games: async(parent) =>
            {
                if(!parent._id)
                {
                    throw new Error("Erro ó buscar o  id do desarrollador no encadenado do videoxogo")
                }
                // console.log("BUSCANDO DEV:",parent._id);
                return buscarXogosDoDesarrollador(parent._id.toString());
            }
        },
        User:
            {
                library: async(parent:any) =>
                {

                    if(!parent.library)
                    {
                        return [];
                    }

                    return buscarXogosPorIDs(parent.library);
                }
            },
        Review:
            {
                author: async(parent)=>
                {
                    return obterUsuarioPorId(parent.author)
                }

            },
        Query: {
            me: async (_, __, {user}) =>
            {
                if (!user)
                {
                    throw new Error('No autenticado');
                }
                return {
                    _id: user._id.toString(),
                    ...user
                };
            },

            getGames:async (_, {page, pageSize},___): Promise<Array<Game>> =>
            {
                return await obterCatalogoCompleto(page, pageSize);
            },
            getDeveloper: async(_, {id}):Promise<Developer> =>
            {

                return obterDeveloperPorId(id);
            }
        },


        Mutation: {
            signup: async (_, {username, email, password}) =>
            {
                const idUsuarioCreado = await createUser(username, email, password);
                return signToken(idUsuarioCreado);
            },
            login: async (_, {email, password}) =>
            {
                const usuario = await validateUser(email, password);
                if (!usuario)
                {
                    throw new Error('Usuario no encontrado o contraseña incorrecta');
                }

                return signToken(usuario._id.toString());
            },
            createDeveloper: async (_, {name, country, foundedYear}, contexto) =>
            {
                checkContext(contexto, "crear unha desarrolladora.");

                return crearDeveloper(name, country, foundedYear);

            },
            createGame: async (_, {title, description, price, releaseYear, genre, developerId}, contexto) =>
            {
                checkContext(contexto, "crear un videoxogo.");
                return crearVideogame(title, price, genre, developerId, description, releaseYear);
            },
            addToLibrary: async(_, {gameId}, contexto): Promise<User> =>
            {
                checkContext(contexto, "engadir un videoxogo á túa libraría.");
                const usuarioSalida : User  = await usuarioCompraVideojuegoId(contexto.user._id.toString(),gameId);
                return usuarioSalida;
            },
            addReview: async(_,{gameId,content, rating}, context)=>
            {
                checkContext(context,"engadir unha reseña.");
                return await crearReview (context.user._id.toString(),gameId,content,rating);
            },
        }
    };