import {IResolvers} from "@graphql-tools/utils";
import {comprarRopaUsuario, logarUsuario, registrarUsuario} from "../collections/users";
import {User} from "../types/User";
import {signToken} from "../auth";
import {Clothing} from "../types/Clothing";
import {
    insertarPrendaSinId,
    obtenerPrendaPorId,
    obtenerPrendasPorIDs,
    obtenerTodasLasPrendas
} from "../collections/clothes";


export const resolvers: IResolvers =
    {
        Query:
            {
                me: async (_, __, ctxt) =>
                {
                    if (!ctxt.user)
                    {
                        throw new Error("No autenticado!");
                    }

                    return ctxt.user;
                },
                clothing: async (_, {id}, ___): Promise<Clothing> =>
                {
                    return await obtenerPrendaPorId(id);
                },
                clothes: async (_, {page, pageSize}, ___) :Promise<Array<Clothing>> =>
                {
                    return obtenerTodasLasPrendas();
                }
            },
        Mutation:
            {
                register: async (_, {email, password}, ___): Promise<string> =>
                {


                    const usuarioNuevo: User = await registrarUsuario(email, password);
                    if (!usuarioNuevo._id)
                    {
                        throw new Error("ERROR! La inserción no ha ocurrido de forma correcta.");
                    }
                    return signToken(usuarioNuevo._id.toString());
                },

                login: async (_, {email, password}, ___) =>
                {
                    return logarUsuario(email, password);
                },
                addClothing: async (_, {name, size, color, price}, {contexto}): Promise<Clothing> =>
                {

                    if (!contexto)
                    {
                        throw new Error("No pasarás!");
                    }
                    const clothing: Clothing =
                        {
                            name: name,
                            size: size,
                            color: color,
                            price: price
                        };

                    return await insertarPrendaSinId(clothing);
                },
                buyClothing: async(_,{id}, ctxt):Promise<User> =>
                {
                    console.log(ctxt)
                    return await comprarRopaUsuario(id,ctxt.user._id)
                }
            },
        User:
            {
                clothes: async (parent, __, ___) =>
                {
                    if (!parent)
                    {
                        throw new Error("Autentica pls");
                    }
                    return (await obtenerPrendasPorIDs(parent.clothes))
                }
            }
    };