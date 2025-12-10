import {IResolvers} from "@graphql-tools/utils";
import {comprarRopa, createUser, validateUser} from "../collections/users";
import {signToken} from "../auth";
import {crearRopa, getRopa, getRopaPorID, getRopasPorID} from "../collections/clothes";
import {getDB} from "../db/db";

export const resolvers: IResolvers =
    {
        Query: {
            clothes:async(_,{page,size})=>
            {
                return await getRopa(page,size);
            },
            clothing:async(_,{id})=>
            {
                return await getRopaPorID(id);
            },
            me:async(_,__,{user}) =>
            {
                if(!user)
                {
                    throw new Error('No autenticado');
                }
                return {
                    _id: user._id.toString(),
                    ...user
                }
            }
        },


        User:{
            clothes: async (parent) =>
            {
                return await getRopasPorID(parent.clothes);
            }
        },

        Mutation: {
            register: async (_, {email, password}) =>
            {
                const idUsuarioCreado = await createUser(email, password);
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
            addClothing: async (_,{name,size,color,price}, {user}) =>
            {
                if(!user)
                {
                    throw new Error('No autenticado');
                }
                const resultado = await crearRopa(name,size,color,price);
                return resultado;
            },
            buyClothing: async (_,{id}, {user}) =>
            {
                if(!user)
                {
                    throw new Error('No autenticado');
                }
                return await comprarRopa(id, user._id)
            }
        }
    };