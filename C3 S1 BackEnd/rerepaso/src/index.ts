import {connectToMongo} from "./db/db";
import {ApolloServer} from "apollo-server";
import {typeDefs} from "./graphql/schema";
import {resolvers} from "./graphql/resolvers";
import {getUserFromToken} from "./auth";
import {User} from "./types/User";


const start = async () =>
{
    await connectToMongo();
    const server = new ApolloServer({
        typeDefs,
        resolvers,
        context: async ({req}) =>
        {
            const token = req.headers.authorization || "";
            const user = token ? await getUserFromToken(token) : null;
            return {user};
        }
    })

    await server.listen({port: 4020});
    console.log('Servidor iniciado en http://localhost:4020');
}

start().catch(err =>
{
    console.error('Error al iniciar el servidor:', err);
});
